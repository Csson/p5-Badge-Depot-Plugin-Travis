use strict;
use warnings;

package Badge::Depot::Plugin::Travis;

use Moose;
use namespace::autoclean;
use Types::Standard qw/Str/;
with 'Badge::Depot';

# VERSION
# ABSTRACT: Travis plugin for Badge::Depot

has user => (
    is => 'ro',
    isa => Str,
    required => 1,
);
has repo => (
    is => 'ro',
    isa => Str,
    required => 1,
);
has branch => (
    is => 'ro',
    isa => Str,
    required => 1,
);

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

All attributes are required.

=head2 user

Github username.

=head2 repo

Github repository.

=head2 branch

Github branch.

=head1 SEE ALSO

=for :list
* L<Badge::Depot>

=cut
