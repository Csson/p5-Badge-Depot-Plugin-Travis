# NAME

Badge::Depot::Plugin::Travis - Travis plugin for Badge::Depot

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.10+-blue.svg" alt="Requires Perl 5.10+" />
    <a href="https://travis-ci.org/Csson/p5-Badge-Depot-Plugin-Travis"><img src="https://api.travis-ci.org/Csson/p5-Badge-Depot-Plugin-Travis.svg?branch=master" alt="Travis status" /></a>
    <a href="http://cpants.cpanauthors.org/dist/Badge-Depot-Plugin-Travis-0.0203"><img src="https://badgedepot.code301.com/badge/kwalitee/Badge-Depot-Plugin-Travis/0.0203" alt="Distribution kwalitee" /></a>
    <a href="http://matrix.cpantesters.org/?dist=Badge-Depot-Plugin-Travis%200.0203"><img src="https://badgedepot.code301.com/badge/cpantesters/Badge-Depot-Plugin-Travis/0.0203" alt="CPAN Testers result" /></a>
    <img src="https://img.shields.io/badge/coverage-67.3%-red.svg" alt="coverage 67.3%" />
    </p>
</div>

# VERSION

Version 0.0203, released 2016-04-09.

# SYNOPSIS

    use Badge::Depot::Plugin::Travis;

    my $badge = Badge::Depot::Plugin::Travis->new(user => 'my_name', repo => 'the_repo', branch => 'master');

    print $badge->to_html;
    # prints '<a href="https://travis-ci.org/my_name/my_repo"><img src="https://api.travis-ci.org/my_name/my_repo.svg?branch=master" /></a>'

# DESCRIPTION

Create a [Travis](https://travis-ci.org) badge for a github repository.

This class consumes the [Badge::Depot](https://metacpan.org/pod/Badge::Depot) role.

# ATTRIBUTES

The `user` and `repo` attributes are required or optional, depending on your configuration. It looks for the `resources/repository/web` setting in `META.json`:

- If `META.json` doesn't exist in the dist root, `user` and `repo` are required.
- If `resources/repository/web` doesn't exist (or is not a github url), `user` and `repo` are required.

## user

Github username.

## repo

Github repository.

## branch

Github branch. Optional, `master` by default.

# SEE ALSO

- [Badge::Depot](https://metacpan.org/pod/Badge::Depot)

# SOURCE

[https://github.com/Csson/p5-Badge-Depot-Plugin-Travis](https://github.com/Csson/p5-Badge-Depot-Plugin-Travis)

# HOMEPAGE

[https://metacpan.org/release/Badge-Depot-Plugin-Travis](https://metacpan.org/release/Badge-Depot-Plugin-Travis)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
