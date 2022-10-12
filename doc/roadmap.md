# Roadmap

Some completed features:

* Post log entries to a namespace via API
  * Headers are captured
* Rough rendering of log entries in a namespace
* namespace create/show
* Some working vue componentry

Ahead:

## Rendering Improvements

* Custom rendering of certain content types
  * syntax highlighting of known syntaxes
  * tree view for JSON, maybe others

## Filter/search features

* ability to search (grep?) within a namespace
* ability to filter based on shape of data (autofilters)

## Performance/benchmark tools

* Ability to measure OPS in various environments

## Basic test coverage of critical parts

## API extensions

* params for identifying source code locations, other project context

## Admin

* web UI?
  * require authentication
* configurable limit for entries per namespace
* IP/host based block lists
* Content filtering

## Authentication?

* optional auth to keep track of namespaces you've created/viewed
* omniauth/device/etc?
