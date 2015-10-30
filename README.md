# puppet_dump

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dump](#setup)
    * [What dump affects](#what-dump-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dump](#beginning-with-dump)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A quick and dirty way of dumping out all in-scope puppet variables and configuration file settings! :D


## Module Description

Supplies resource type `puppet_dump` to print out all of the in-scope variables and `puppet_dump::config` to print out all configuration file settings.

Title is used to indicate the poin the user-code that the resource type was invoked from.

### Beginning with dump

Just install the module and use the resource type in your code where you need to inspect variables.  Internally this uses the notify resource to report the variables to the user.  

Caution:  Will also log variables to console, so be careful if echoing sensitive data.

## Usage

### Variables
```puppet
puppet_dump { "point1": }
```
Print out the in-scope variables

```puppet
puppet_dump { "point2": }
```
Print out the in-scope variables again :D - this will take account of any new variables that have been set.

### Configuration
```puppet
puppet_dump::config { "main": }
```
Print out the configuration file variables by running `puppet config print`.  This is delivered using a `notify` resource so is available via the console reporting.

## Example output

### Variables
```shell
Notice: /Stage[main]/Main/Puppet_dump[point1]/Notify[point1]/message: defined 'message' as '---
aio_agent_build: 1.2.2
aio_agent_version: 1.2.2
architecture: i386
augeas: '{"version"=>"1.4.0"}'
augeasversion: 1.4.0
...
```
Example (truncated) output.  Notice that the title `point1` which identifies the resource that generated the output.

### Configuration

## Limitations

No support, not recommended for sensitive or production environments

## Development

PRs accepted

