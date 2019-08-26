# Remove all the files and directories in the current working directory
# Useful when encountering: 
#   "Argument list too long" error

for f in *; do sudo rm -rf "$f"; done
