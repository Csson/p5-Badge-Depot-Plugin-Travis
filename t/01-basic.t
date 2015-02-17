use strict;
use warnings;

use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

BEGIN {
	use_ok 'Badge::Depot::Plugin::Travis';
}

my $badge = Badge::Depot::Plugin::Travis->new(user => 'testuser', repo => 'testrepo', branch => 'testbranch');

is $badge->to_html,
   '<a href="https://travis-ci.org/testuser/testrepo"><img src="https://api.travis-ci.org/testuser/testrepo.svg?branch=testbranch" alt="Travis status" /></a>',
   'Correct html';

done_testing;
