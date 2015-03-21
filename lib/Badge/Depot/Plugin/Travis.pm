use strict;
use warnings;

package Badge::Depot::Plugin::Travis;

use Moose;
use namespace::autoclean;
use Types::Standard qw/Str HashRef/;
use Path::Tiny;
use JSON::MaybeXS 'decode_json';
with 'Badge::Depot';

# VERSION
# ABSTRACT: Travis plugin for Badge::Depot

has user => (
    is => 'ro',
    isa => Str,
    lazy => 1,
    default => sub {
        my $self = shift;
        if($self->has_meta) {
            return $self->_meta->{'username'} if exists $self->_meta->{'username'};
        }
    },
);
has repo => (
    is => 'ro',
    isa => Str,
    lazy => 1,
    default => sub {
        my $self = shift;
        if($self->has_meta) {
            return $self->_meta->{'repo'} if exists $self->_meta->{'repo'};
        }
    },
);
has branch => (
    is => 'ro',
    isa => Str,
    default => 'master',
);
has _meta => (
    is => 'ro',
    isa => HashRef,
    predicate => 'has_meta',
    builder => '_build_meta',
);

sub _build_meta {
    my $self = shift;

    return if !path('META.json')->exists;

    my $json = path('META.json')->slurp_utf8;
    my $data = decode_json($json);

    return if !exists $data->{'resources'}{'repository'}{'web'};

    my $repository = $data->{'resources'}{'repository'}{'web'};
    return if $repository !~ m{^https://(?:www\.)?github\.com/([^/]+)/(.*)(?:\.git)?$};

    return {
        username => $1,
        repo => $2,
    };
}

sub BUILD {
    my $self = shift;
    $self->link_url(sprintf 'https://travis-ci.org/%s/%s', $self->user, $self->repo);
    $self->image_url(sprintf 'https://api.travis-ci.org/%s/%s.svg?branch=%s', $self->user, $self->repo, $self->branch);
    $self->image_alt('Travis status');
}

1;

__END__

=pod

=head1 SYNOPSIS

    use Badge::Depot::Plugin::Travis;

    my $badge = Badge::Depot::Plugin::Travis->new(user => 'my_name', repo => 'the_repo', branch => 'master');

    print $badge->to_html;
    # prints '<a href="https://travis-ci.org/my_name/my_repo"><img src="https://api.travis-ci.org/my_name/my_repo.svg?branch=master" /></a>'

=head1 DESCRIPTION

Create a L<Travis|https://travis-ci.org> badge for a github repository.

This class consumes the L<Badge::Depot> role.

=head1 ATTRIBUTES

The C<user> and C<repo> attributes are required or optional, depending on your configuration. It looks for the C<resources/repository/web> setting in C<META.json>:

=for :list
* If C<META.json> doesn't exist in the dist root, C<user> and C<repo> are required.
* If C<resources/repository/web> doesn't exist (or is not a github url), C<user> and C<repo> are required.

=head2 user

Github username.

=head2 repo

Github repository.

=head2 branch

Github branch. Optional, C<master> by default.

=head1 SEE ALSO

=for :list
* L<Badge::Depot>

=cut
