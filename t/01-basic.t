use strict;
use warnings;

use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

BEGIN {
    use_ok 'Badge::Depot::Plugin::Travis';
}

my $badge = Badge::Depot::Plugin::Travis->new(user => 'testuser', _meta => { repo => 'testrepo' });

is $badge->to_html,
   '<a href="https://travis-ci.org/testuser/testrepo"><img src="https://api.travis-ci.org/testuser/testrepo.svg?branch=master" alt="Travis status" /></a>',
   'Correct html';

my $badge_nouser = Badge::Depot::Plugin::Travis->new(_meta => { repo => 'testrepo' });

is $badge_nouser->to_html, '', 'Empty html if no user';

my $badge_norepo = Badge::Depot::Plugin::Travis->new(user => 'testuser', _meta => {});

is $badge_norepo->to_html, '', 'Empty html if no repo';

done_testing;
