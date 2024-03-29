# Useful \*Nix commands

## Finding things in files

* Find all occurrences of foo in all text files within a directory, `grep -R "foo"`
  * Ignore case with the `-i` flag
  * Get the line number of the matching text with the `-n` flag
  * Get four lines before (`-B 4`) and get four lines after (`-A 4`)

## Sending arguments from a file to the interpreter

Use the `xargs` command. (`xargs` takes output from one command and sends it to another command as parameters)

```sh
# given a file with the parameters of a command (each on a separate line)
# send each line as arguments to the command `<command>`
# note that each command takes a uniform number `<number>` of arguments
[[ -f ./<file> ]] && cat ./<file> | xargs -n<number> <command>
```

## Where things are stored:
- `/usr/share/keyrings` global system keyrings
- `/etc/apt/sources.list.d` where source information for external pacakges is stored, run `sudo apt update` after modifying to update the pacakge repository

## Determine total disk usage

- `du -sh ./` Determine total disk usage of the current directory
- `du -h -d1 ./` Determine the total disk usage of all child directories (`-d1` or `--max-depth=1` means direct child directories only (excludes grandchildren, great-grandchildren, etc.))


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


## Using sed 

```sh
sed -i '/What I want to replace/c\What I want to replace it with' ./path/to/file
sed -i '/What I want to */c\What I want to replace it with' ./path/to/file  # wildcard character matching
sed -i '/'[a-f0-9]'\{7\}/c\' ./path/to/file  # use to remove hex commit numbers
sed -i 's/^/* /' ./giant-commit  # use to add a bullet (*<space>) to the beginning of each line

# global replacement of tab indent with <number of spaces>; easy enough 
sed 's/\t/<number of spaces>/g' tab-file.txt > no-tab-file.txt
# same as the above, but in-place (with the input file stored with the .bak extension)
sed -i .bak 's/\t/<number of spaces>/g' input-file.txt 

# Replace the pattern in all files within a given directory
find /my/path -type f | xargs sed -i  's/what I want to replace/what I want to replace with/g'

```

## Adding text to file

Use the `>>` operator to append to file. For example, appending `*.pdf` to `.gitignore`: 

```sh
# Note: single quotes in bash do not perform variable expansion / string interpolation 
echo '*.pdf' >> .gitignore
```

Use the `tee` command to simultaneously print to standard output and the specified file:

```sh
echo 'text to add' | tee output.txt
```


## Appending characters/string to each line of a file

```sh
awk '{print $0"<desired_text>"}' RS="\r*\n\r*" <input_file> > <output_file>
```

Without the RS modifier, the desired characters (",,") are appended to their own line between existing lines.
For example, the following appends two commas (",,") to each line of a file:

```sh
awk '{print $0",,"}' RS="\r*\n\r*" LC_20191231.csv > LC_20191231_cleaned.csv
```


## Count number of * in a file

- Count number of lines: `wc -l <file>`
- Count number of words: `wc -w <file>`
- Counting the number of lines can be paired with `ls`, e.g., to count the number of directories only, `ls -ld . | wc-l`

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

List the applications using port 80 by issuing: `lsof -i :80` (`lsof` is short for list open files)

Note:
- The `-i` flag limits the search to ports opened by network connections.
- May need to use `sudo` becuase many of the processes or devices that `lsof` can report on belong to root or were launched by root. 

## Inspect file contents

1. Inspect only the first `n` lines of a file using: `head -n <lines> <file>`
2. Inspect only the last `n` lines, using: `tail -n <lines> <file>`; `tail` can also operate in "follow mode" which 
watches the text file and prints new lines out to screen where available, "follow mode" can be invoked with:
`tail -f <file>`.

## Unset an environment variable

`unset <variable>`


## Command history
- `history | tail -100 | less` View the last 100 commands
