# README
simple packer example to create an ubuntu 16 template vm on vsphere

with provisioner scripts to install:
* open-vm tools
* docker
* consul

## Steps
1. Export your vCenter Server password as the `VCENTER_PASSWORD` environment variable. On some operating systems you can copy the password to your clipboard and use pbpaste like so:
```
export VCENTER_PASSWORD=`pbpaste`
```
2. Run `packer build ubuntu-16-template.json`
