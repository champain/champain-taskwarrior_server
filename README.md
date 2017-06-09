[![Build Status](https://api.travis-ci.org/champain/taskwarrior_server.svg?branch=master)](https://travis-ci.org/champain/taskwarrior_server)
# taskwarrior_server

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with taskwarrior_server](#setup)
    * [What taskwarrior_server affects](#what-taskwarrior_server-affects)
    * [Beginning with taskwarrior_server](#beginning-with-taskwarrior_server)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This is a simple, but not as simple as it should be Puppet module for setting
up the taskwarrior server. It's also serving as a bit of a refresher for
CI in Puppet for me.

## Setup

### What taskwarrior_server affects
A few development packages are installed in order to get the build off
the ground. Nothing crazy.


### Beginning with taskwarrior_server

In order to use this module just

```
include ::taskwarrior_server
```

## Usage

In the future, things like

```
class { '::taskwarrior_server':
   param => 'value',
   }
```

will be possible.

## Limitations

Only works on RHEL/CentOS 7.2 right now. Geez.

## Development

Take time to keep the tests up to date, that's what this is for.
