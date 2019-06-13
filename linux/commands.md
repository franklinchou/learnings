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
