use strict;
use warnings;

use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use Badge::Depot::Plugin::Travis;

SKIP: {
    eval "use Test::DZil";
    skip "Missing or broken Test::DZil" if $@;

    Test::DZil->import;

    my $tzil = Builder()->from_config(
        { dist_root => 'missing-FyY3p5cY8aUMb9Ge5nXuCs' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    [ 'MetaResources' => {
                        'repository.type' => 'git',
                        'repository.url' => 'git//github.com/testuser/testrepo.git',
                        'repository.web' => 'https://github.com/testuser/testrepo',
                    } ],
                ),
            },
        },
    );

    my $badge = Badge::Depot::Plugin::Travis->new(zilla => $tzil);

    is $badge->to_html,
       '<a href="https://travis-ci.org/testuser/testrepo"><img src="https://api.travis-ci.org/testuser/testrepo.svg?branch=master" alt="Travis status" /></a>',
       'Correct html with user and repo from zilla';

    $tzil = Builder()->from_config(
        { dist_root => 'missing-FyY3p5cY8aUMb9Ge5nXuCs' },
        { add_files => { 'source/dist.ini' => simple_ini() } },
    );

    $badge = Badge::Depot::Plugin::Travis->new(zilla => $tzil);

    is $badge->to_html,
       '',
       'Empty html if missing repository.web in zilla distmeta';
}

done_testing;
