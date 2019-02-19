## List applications using a port

List the applications using port 80

`lsof -i :80`

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

`echo "*.pdf" >> .gitignore`
