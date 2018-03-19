# 🐑dolly

> no more sheepishly copying and pasting git urls

<!--[![Build Status](https://travis-ci.org/cfoust/tmux-oakthree.svg?branch=master)](https://travis-ci.org/cfoust/dolly)-->
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## features

* **switch directories quickly**: dolly caches API calls so switching is always
  fast.
* **fuzzy-find repositories from multiple services**: dolly supports GitHub,
  Bitbucket, and GitLab out of the box.
* **clone automatically**: If you haven't cloned the repository in the past,
  dolly does so automatically.

## purpose

The UX around cloning repositories kind of sucks. You constantly have to `cd`
to some common directory, type `git clone` and then paste in whatever URL the
project you're cloning provides. `dolly` makes the process a breeze by
aggregating all of the repositories associated with your account on GitHub,
Bitbucket, and GitLab, then lets you choose one using
[fzf](https://github.com/junegunn/fzf). `dolly` then clones the repo if
necessary and changes to its directory.

## usage

Just type `dolly` in any shell.

## install

not yet
