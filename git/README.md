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

Git pull fetches updates from `origin` and _merges_ them into the target (local) branch.
It does _not_ create a new branch.

Or, from the local branch that is out of sync, issue:

```
git fetch origin
git reset --hard origin/<branch>
git clean -f -d
```

`git checkout -b <branch> origin/<branch>` 
^ This command does _not_ fetch updates from `origin`. It creates a new local branch that tracks
the `origin/<branch>` on _local_.


## Git add all except

```
git add -u
git reset -- <item-to-remove>
```

## Set up new local branch to track remote
```
git branch --track <local> origin/<remote>
```


## Git merge

```
git merge <branch> --strategy-option ours # I don't care what's in remote
git merge <branch> --strategy-option theirs # I don't care what's in local
```
