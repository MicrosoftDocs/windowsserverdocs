---
title: Common Git Bash commands for use with GitHub
description: A list of some of the most frequently used commands in Git Bash when working with GitHub. 
author: eross-msft
ms.author: lizross
ms.date: 05/06/2019
---

# Common Git Bash commands

These are some of the most-used commands in Git Bash, based on when you will use them in your content creation and editing process.

## Master branch-related

You must always use master as your base for any new branch.

| Command | Description |
|---------|-------------|
| `git checkout master` | Switch to master from any other branch |
| `git pull upstream master` | Update your local copy of master from the production repo |

## Branch-related

| Command | Description |
|---------|-------------|
| `git branch` | See your existing branches |
| `git checkout -B <name-of-branch>` | Create a new branch |
| `git checkout <name-of-branch>` | Change to another branch |
| `git status` | Check what’s going on in your branch |
| `git branch -D <name-of-branch>` | Delete an existing branch (making sure you’re not in it) |

## Check-in-related (done as a group, in order)

| Command | Description |
|---------|-------------|
| `git add --all` | After you save your work, add it to a branch |
| `git commit -m “public comment, including quotes”` | Commit your changes to your branch |
| `git pull upstream master` | Update your local copy of master from the production repo |
| `git push origin <name-of-branch>` | Push to the remote version of your local branch |