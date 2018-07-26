# Git

## Undoing things

### Undoing deletion of an uncommitted file

`git checkout -- <file>`

## Cherry-pick

Pick a specific commit without including the history (contrast with `merge` and `rebase` which apply a history
(multiple commits) to another branch.

`git cherry-pick <commit to apply>`

## Local out of sync with remote

Occurs when a change is made to remote, i.e., through the web UI, and the remote is out of sync with local.

Issue:

```
git pull origin <branch>
```

## Git add all except

```
git add -u
git reset -- <item-to-remove>
```
