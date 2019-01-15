# Git

## Reverting changes to a single file

 Note: The `--` flag indicates to git that the parameter that follows is a file and not a branch. 

`git checkout -- <file>` If the change is not committed, revert the change to the state that it is on `HEAD`. 

`git checkout <branch> -- <file>` Revert the change to the state that it is on `branch`.

## Reverting changes to a branch

`git revert --hard <branch>` E.g., revert the current branch to the state of the supplied `<branch>`.


## Cherry-pick

Pick a specific commit without including the history (contrast with `merge` and `rebase` which apply a history
(multiple commits) to another branch).

`git cherry-pick <commit to apply>`

## Checking out a remote branch

1. `git checkout -b <branch> origin/<branch>` Create a new local branch that tracks a remote. (Note: This command does _not_ fetch updates from `origin`.)

2. `git branch --track <local> origin/<remote>` Set up new local branch to track remote (with the same name). If a local branch with a _different_ name is desired simply create a new branch set the upstream.

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

## Git add all except

```
git add -u
git reset -- <item-to-remove>
```

## Git merge

```
git merge <branch> --strategy-option ours # I don't care what's in their branch (usually remote)
git merge <branch> --strategy-option theirs # I don't care what's in my branch
```

## Keeping a clean commit history with rebase

Rebase resynchs the changes onto the branch in the order that these changes appeared, 
resulting in a perfectly linear commit history! (See [here](https://www.atlassian.com/git/tutorials/merging-vs-rebasing).)
In contrast, squash and merge simply appends all the changes to the history. The
problem with squash and merge is that it "pollutes" the history with a new "merged 
branch feature into branch master" every time a new commit is added.

```
git checkout <parent-branch>
git pull 
git checkout <feature-branch>
git rebase <parent branch>
```


