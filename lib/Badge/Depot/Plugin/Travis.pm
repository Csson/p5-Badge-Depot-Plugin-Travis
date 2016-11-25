use strict;
use warnings;

package Badge::Depot::Plugin::Travis;

use Moose;
use namespace::autoclean;
use Types::Standard qw/Str HashRef/;
use Path::Tiny;
use JSON::MaybeXS 'decode_json';
with 'Badge::Depot';

# ABSTRACT: Travis plugin for Badge::Depot
# AUTHORITY
our $VERSION = '0.0204';

has user => (
    is => 'ro',
    isa => Str,
    lazy => 1,
    default => sub {
        my $self = shift;
        return $self->_meta->{'username'} if exists $self->_meta->{'username'};
    },
);
has repo => (
    is => 'ro',
    isa => Str,
    lazy => 1,
    default => sub {
        my $self = shift;
        return $self->_meta->{'repo'} if exists $self->_meta->{'repo'};
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
    lazy => 1,
    predicate => 'has_meta',
    builder => '_build_meta',
);

sub _distmeta {
    my $self = shift;

    my $data;

    if ($self->can('has_zilla') && $self->has_zilla) {
        $data = $self->zilla->distmeta;
    }
    else {
        my $path = path('META.json');

        if ($path->exists) {
            my $json = $path->slurp_utf8;
            $data = decode_json($json);
        }
    }

    return $data;
}

sub _build_meta {
    my $self = shift;

    my $data = $self->_distmeta;

    return {} if ref $data ne 'HASH' || !exists $data->{'resources'}{'repository'}{'web'};

    my $repository = $data->{'resources'}{'repository'}{'web'};
    return {} if $repository !~ m{^https://(?:www\.)?github\.com/([^/]+)/(.*)(?:\.git)?$};

    return {
        username => $1,
        repo => $2,
    };
}

sub BUILD {
    my $self = shift;

    my $user = $self->user;
    my $repo = $self->repo;

    if (!$user) {
        $self->log('Could not determine GitHub username');
        return;
    }
    if (!$repo) {
        $self->log('Could not determine GitHub repository');
        return;
    }

    $self->link_url(sprintf 'https://travis-ci.org/%s/%s', $user, $repo);
    $self->image_url(sprintf 'https://api.travis-ci.org/%s/%s.svg?branch=%s', $user, $repo, $self->branch);
    $self->image_alt('Travis status');
}

sub log {
    my $self = shift;
    my $text = shift;

    print "[Badge/Travis] $text\n";
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

The C<user> and C<repo> attributes are required or optional, depending on your configuration. It looks for the C<resources/repository/web> setting in C<< $zilla->distmeta >> and C<META.json>:

=for :list
* With L<Badge::Depot> 0.0104 or later, C<user> and C<repo> may be detected from L<Dist::Zilla/distmeta>.
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
