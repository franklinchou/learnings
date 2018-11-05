# Problem
Disabling the Nvidia GeForce GTX 1050 graphics card on Dell XPS 15 (9560) in Nvidia XServer settings (Nvidia Prime) causes Ubuntu 16.04 to fail to boot to graphical interface.

_Reproduce_: PRIME Profiles > Select "Intel (Power Saving Mode)"

Package | Version
--------|---------
`nvidia-prime` | 0.8.2 amd64
`nvidia-settings` | 389.90-0ubuntu0.16.04.1 amd64
`nvidia-384*` | 389.90-0ubuntu0.16.04.1 amd64

# Solution
1. Boot to recovery mode (hold Shift after Dell splash screen)
2. Remove and reinstall the above packages
3. Reboot
