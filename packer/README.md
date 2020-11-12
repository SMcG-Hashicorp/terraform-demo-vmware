# README
simple packer example to create an ubuntu 18 template vm on vsphere

with provisioner scripts to install:
* open-vm tools
* docker
* consul

## Steps
Tested on Packer 1.6.5
1. Export your vCenter Server password as the `VCENTER_PASSWORD` environment variable. On some operating systems you can copy the password to your clipboard and use pbpaste like so:
```
export VCENTER_PASSWORD=`pbpaste`
```
2. Run `packer build ubuntu-18-template-packet.json` for Packet datacenter or `packer build ubuntu-18-template-oban.json` for Oban datacenter.
