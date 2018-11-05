# Packages

## Snap

Distribute packages on the "linux app store" using `snap`.

For example, to install go-lang issue:

```
sudo snap install --classic --stable go
```

To upgrade a snap, issue:

```
sudo snap refresh --classic --stable go
```

Note: For the purpose of the `--classic` flag, see [here](https://blog.ubuntu.com/2017/01/09/how-to-snap-introducing-classic-confinement).
