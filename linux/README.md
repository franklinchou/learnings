# Useful \*Nix commands

## Count number of * in a file

- Count number of lines: `wc -l <file>`
- Count number of words: `wc -w <file>`

## `inotify` watch limit reached

Inotify (inode notify) is a Linux kernel subsystem that acts to extend filesystems to notice changes to the filesystem,
and report those changes to applications. When the number of inotify watches is not enough to monitor all the desired
files to be watched, a inotify watch limit error is thrown.

To see what is using the inotify watches issue:

```
find /proc/*/fd -lname anon_inode:inotify 2>/dev/null |
   cut -d/ -f3 |
   xargs -I '{}' -- ps --no-headers -o '%p %U %c' -p '{}' |
   uniq -c |
   sort -nr
```

Other useful commands:
- `cat /proc/sys/fs/inotify/max_user_watches` - determine the total number of watches (in Ubuntu 18.04, the default is 8194)
- `sudo sysctl fs.inotify.max_user_watches=<WATCHES>` Temporarily increase the number of watches (will reset when the
machine is restarted)



## List applications using a port

List the applications using port 80

`lsof -i :80`

## Inspect files

1. Inspect only the first `n` lines of a file using: `head -n <lines> <file>`
2. Inspect only the last `n` lines, using: `tail -n <lines> <file>`; `tail` can also operate in "follow mode" which 
watches the text file and prints new lines out to screen where available, "follow mode" can be invoked with:
`tail -f <file>`.

## Unset an environment variable

`unset <variable>`

## Using sed

Used to delete lines in a file:

```sh
sed -i '/What I want to replace/c\What I want to replace it with' ./path/to/file
sed -i '/What I want to */c\What I want to replace it with' ./path/to/file  # wildcard character matching
sed -i '/'[a-f0-9]'\{7\}/c\' ./path/to/file  # use to remove hex commit numbers
sed -i 's/^/* /' ./giant-commit  # use to add a bullet (*<space>) to the beginning of each line
```

## Append text to file

Use the `>>` operator to append to file. For example, appending `*.pdf` to `.gitignore`: 

```
echo "*.pdf" >> .gitignore
```

## Screen
- `history | tail -100 | less` View the last 100 commands
