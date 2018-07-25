# Git

## Undoing things

### Undoing deletion of an uncommitted file

`git checkout -- <file>`

## Cherry-pick

Pick a specific commit without including the history (contrast with `merge` and `rebase` which apply a history
(multiple commits) to another branch.

`git cherry-pick <commit to apply>`
