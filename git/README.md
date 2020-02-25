# Git

## Reverting changes to a single file

 Note: The `--` flag indicates to git that the parameter that follows is a file and not a branch. 

`git checkout -- <file>` If the change is not committed, revert the change to the state that it is on `HEAD`. 

`git checkout <branch> -- <file>` Revert the change to the state that it is on `branch`.

Tip! When there are a lot of files that need to be committed and a couple that need to be ignored:
- Commit all (`git add *`)
- Then reset the files that should be ignored (`git reset <file>`)

## Removing a file

`git rm <file>` will remove the file _and_ delete it from the local file system

`git rm --cached <file>` will only remove the file from version control

## Renaming a branch

`git branch -m <old> <new>`

## Reverting changes to a branch

`git revert --hard <branch>` E.g., revert the current branch to the state of the supplied `<branch>`.

## Accidentally deleting a branch

If the branch was just deleted, the prompt should indicate: `Deleted branch <name> (was <sha>).`
To restore that branch, just issue: `git checkout -b <name> <sha>`.


## Cherry-pick

Pick a specific commit without including the history (contrast with `merge` and `rebase` which apply a history
(multiple commits) to another branch).

`git cherry-pick <commit to apply>`

## Checking out a remote branch

1. `git checkout -b <branch> origin/<branch>` Create a new local branch that tracks a remote. (Note: This command does _not_ fetch updates from `origin`.)

2. `git branch --track <local> origin/<remote>` Create a new local branch that tracks a remote. Note: This will fail if the
branch name already exists. This will _not_ switch to the newly created branch. To create a local branch tracking a remote
with the same name as the remote issue: `git checkout --track origin/<branch>`. Note! If you get `fatal: <branch> is not a commit and a branch cannot be created from it` this means that the remote you're attempting to track doesn't exist! Check that
there is a remote branch with that name!

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
git clean -f -d  # remove untracked files from local 
```

## Add all except

```
git add -u
git reset -- <item-to-remove>
```

## Merge

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

You can also squash unwanted commits by issuing `git rebase -i HEAD~<n>`, where `n` is the number of commits to 
look back at. 

## Add only files that are already being tracked

```
git add -u
```

## Cleaning up local references to deprecated remote branches

Note that this will not remove references to local branches! (Only removes branches with `origin/*`.)

- `git remote prune origin --dry-run` lists branches that __can__ be deleted/pruned on your local
- `git remote prune origin` actually executes the prune command
