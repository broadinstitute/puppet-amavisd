# puppet-amavisd

![checks](https://github.com/broadinstitute/puppet-amavisd/workflows/checks/badge.svg?branch=main)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/broadinstitute/amavisd.svg)](https://forge.puppet.com/broadinstitute/amavisd)
[![Puppet Forge](https://img.shields.io/puppetforge/v/broadinstitute/amavisd.svg)](https://forge.puppet.com/broadinstitute/amavisd)
[![Puppet Forge](https://img.shields.io/puppetforge/f/broadinstitute/amavisd.svg)](https://forge.puppet.com/broadinstitute/amavisd)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![codecov](https://codecov.io/gh/broadinstitute/puppet-amavisd/branch/main/graph/badge.svg)](https://codecov.io/gh/broadinstitute/puppet-amavisd)

## Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with amavisd](#setup)
    * [What amavisd affects](#what-amavisd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with amavisd](#beginning-with-amavisd)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

This module is designed to take care of installing and configuring the Amavisd
service.

## Module Description

This module should correctly setup Amavisd on a given host.  This includes:

* Package installation
* Service management
* Configuration managment
* Cron job management
* Signature definition updates
* (Optional) ClamAV management and integration

## Setup

### What amavisd affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with amavisd

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see [http://forge.puppetlabs.com/puppetlabs/firewall](puppetlabs/firewall)).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Changelog

To generate the `CHANGELOG.md`, you will need [Docker][4] and a GitHub personal
access token. We currently use
[github-changelog-generator](https://github.com/github-changelog-generator/github-changelog-generator)
for this purpose. The following should generate the file using information
from GitHub:

```sh
docker run -it --rm \
    -e CHANGELOG_GITHUB_TOKEN='yourtokenhere' \
    -v "$(pwd)":/working \
    -w /working \
    githubchangeloggenerator/github-changelog-generator:latest \
        --verbose \
        --future-release 2.0.0
```

This will generate the log for an upcoming release of `2.0.0` that has not yet been
tagged.

As a note, this repository uses the default labels for formatting the
`CHANGELOG.md`. Label information can be found here:
[Advanced-change-log-generation-examples](https://github.com/github-changelog-generator/github-changelog-generator/wiki/Advanced-change-log-generation-examples#section-options)
