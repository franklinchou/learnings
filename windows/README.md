# Using Powershell

## Batch rename files

- `ls | Rename-Item -NewName {"000_" + $_.Name}` Prepend "000_" for all files in the directory. 
  - `ls *.docx` to list only files with the `.docx` extension
- `ls *.pdf | Rename-Item -NewName {$_.name -replace "Professoinal Services Agreement", "PSA"}` Replace the occurence of "Professional Services Agreement" with "PSA" for all pdf files

## Windows 11 Experience Tweaks
- [Windows 10 Context Menus](https://www.tomshardware.com/how-to/windows-11-classic-context-menus)
- [Windows 10 File Explorer Menus](https://www.tomshardware.com/how-to/restore-windows-10-explorer-windows-11)
