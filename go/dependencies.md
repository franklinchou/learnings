# Go dependencies

Dependencies in golang are managed by specifying the `$GOPATH` environment variable.
This will tell the compiler what directory to search for dependencies in.

`setenv` (see [here](https://github.com/franklinchou/setenv)) supports setting project-specific
environment variables like`$GOPATH`. Once `$GOPATH` is set, dependencies can be installed by issuing: ???

When using GoLand, `$GOPATH` is set from Settings > Go > GoPath.
