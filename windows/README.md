# Using Powershell

## Batch rename files

- `ls | Rename-Item -NewName {"000_" + $_.Name}` Prepend "000_" for all files in the directory. 