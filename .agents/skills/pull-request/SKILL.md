---
name: pull-request
description: Creates pull request in github
---

Creates pull request with current changes

Commands
- Check current branch: `git branch --show-current`
- Check git status `git status`
- Check current changes `git diff HEAD`

## Instructions
- create new branch if on main
- explore and understand changes
- put all changes in single commit with short descriptive message
- push changes to origin
- creates MR with github MCP

## Pull request description
Every pull request must have a short description of the included changes.

### Changes
Short description of changes

### Example
Changes
- Updated XXX function to return YYY instead of CCC

### Validation
- Included only for code changes
- Should be short and descriptive

#### Example
Validation
- Added new test case verifying that XXX funtion now returns YYY
