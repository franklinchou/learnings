# Useful \*Nix commands

## Downloading files based on a sequence

```sh
seq -w <start> <end> | \
    awk '{ source = "https://example/source/**.ext"; \
    gsub("\*\*", $1, source); \
    print "wget " source " -P /path/to/destination" }' | \
    bash
```

1. Use `seq` to generate the sequence, replacing `<start>` and `<end>` with the desired start and end, e.g.,
downloading all the files from 1 to 14 with leading 0 padding would be `seq -w 1 14` (the `-w` flag adds leading zeroes)
2. Find and replace the `**` using `gsub`
3. Pipe the result through bash

See also `download.sh`

NOTE! mawk (the awk interpreter that ships with Ubuntu) does not support regex quantifiers (`{}`). 
Some combination of `?`, `+` and `*` can be used instead. See [here](https://unix.stackexchange.com/questions/506119/how-to-specify-regex-quantifiers-with-mawk).

## Using sed to delete lines in a file

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

## Appending characters/string to each line of a file

```
awk '{print $0"<desired_text>"}' RS="\r*\n\r*" <input_file> > <output_file>
```

Without the RS modifier, the desired characters (",,") are appended to their own line between existing lines.
For example, the following appends two commas (",,") to each line of a file:

```
awk '{print $0",,"}' RS="\r*\n\r*" LC_20191231.csv > LC_20191231_cleaned.csv
```


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

## Inspect file contents

1. Inspect only the first `n` lines of a file using: `head -n <lines> <file>`
2. Inspect only the last `n` lines, using: `tail -n <lines> <file>`; `tail` can also operate in "follow mode" which 
watches the text file and prints new lines out to screen where available, "follow mode" can be invoked with:
`tail -f <file>`.

## Unset an environment variable

`unset <variable>`


## Command history
- `history | tail -100 | less` View the last 100 commands
