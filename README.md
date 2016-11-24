# xen-baremetal

1. Change "XEN_SRC" in Makefile to refer to the xen source code.

2. Run `make` and copy minios.bin/domain_config to dom0.

3. xm create domain_config. The console log is shown in `xm dmesg`.

To print in debug console, the prerequisite is:

a. xen is compiled with `make verbose=y`

b. dom0 grub is with: loglvl=all guest_loglvl=all sync_console console_to_ring
