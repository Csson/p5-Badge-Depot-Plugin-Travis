# NAME

Badge::Depot::Plugin::Travis - Travis plugin for Badge::Depot

# VERSION

Version 0.0001, released 2015-02-18.

# SYNOPSIS

    use Badge::Depot::Plugin::Travis;

    my $badge = Badge::Depot::Plugin::Travis->new(user => 'my_name', repo => 'the_repo', branch => 'master');

    print $badge->to_html;
    # prints '<a href="https://travis-ci.org/my_name/my_repo"><img src="https://api.travis-ci.org/my_name/my_repo.svg?branch=master" /></a>'

# DESCRIPTION

Create a [Travis](https://travis-ci.org) badge for a github repository.

This class consumes the [Badge::Depot](https://metacpan.org/pod/Badge::Depot) role.

# ATTRIBUTES

All attributes are required.

## user

Github username.

## repo

Github repository.

## branch

Github branch.

# SEE ALSO

- [Badge::Depot](https://metacpan.org/pod/Badge::Depot)

# HOMEPAGE

[https://metacpan.org/release/Badge-Depot-Plugin-Travis](https://metacpan.org/release/Badge-Depot-Plugin-Travis)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson <info@code301.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
