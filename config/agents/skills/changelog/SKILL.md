---
name: changelog
description: Update changelog according to source code changes.
disable-model-invocation: true
---

# Changelog

## What is a changelog?

A changelog is a file which contains a curated, chronologically ordered list 
of notable changes for each version of a project.

## Why keep a changelog?

To make it easier for users and contributors to see precisely what notable 
changes have been made between each release (or version) of the project.

## Who needs a changelog?

People do. Whether consumers or developers, the end users of software are 
human beings who care about what's in the software. When the software 
changes, people want to know why and how.

## How to make a good changelog?

### Guiding Principles

- Changelogs are for humans, not machines.
- There should be an entry for every single version.
- The same types of changes should be grouped.
- Versions and sections should be linkable.
- The latest version comes first.
- The release date of each version is displayed.

### Types of changes

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.

## Can changelogs be bad?

Yes. Here are a few ways they can be less than useful.

### Commit log diffs

Using commit log diffs as changelogs is a bad idea: they're full of noise. 
Things like merge commits, commits with obscure titles, documentation changes, 
etc.

The purpose of a commit is to document a step in the evolution of the source 
code. Some projects clean up commits, some don't.

The purpose of a changelog entry is to document the noteworthy difference, 
often across multiple commits, to communicate them clearly to end users.

### Ignoring Deprecations

When people upgrade from one version to another, it should be painfully clear
when something will break. It should be possible to upgrade to a version that 
lists deprecations, remove what's deprecated, then upgrade to the version 
where the deprecations become removals.

If you do nothing else, list deprecations, removals, and any breaking changes 
in your changelog.

### Inconsistent Changes

A changelog which only mentions some of the changes can be as dangerous as not 
having a changelog. While many of the changes may not be relevant - for 
instance, removing a single whitespace may not need to be recorded in all 
instances - any important changes should be mentioned in the changelog. By 
inconsistently applying changes, your users may mistakenly think that the 
changelog is the single source of truth. It ought to be. With great power 
comes great responsibility - having a good changelog means having a 
consistently updated changelog.

## Specification

Semver is used to track versions.

Dates format is `YYYY-MM-DD`.

Changelog file path is `./CHANGELOG.md`. 

## What to do?

Inspect the project commits log.

Identify changes that are not reflected in the changelog file and but must be
reflected.

Update changelog file according to them.
