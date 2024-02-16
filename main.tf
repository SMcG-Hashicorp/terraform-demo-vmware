provider "vsphere" {
  user                 = "vsphere\\Administrator"
  password             = "VMware1!"
  vsphere_server       = "vCenter67.vSphere.Lab"
  allow_unverified_ssl = true
}
#provider "vsphere" {
#  user                 = var.vsphere_user
# password             = var.vsphere_password
#vsphere_server       = var.vsphere_server
#allow_unverified_ssl = true
#}
data "vsphere_datacenter" "datacenter" {
  name = "VM-Lab"
}
data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = ""
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
resource "vsphere_virtual_machine" "vm" {
  name             = "foo"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  memory           = 1024
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
}
module "virtual-machine" {
  source  = "app.terraform.io/hashidemos/virtual-machine/vsphere"
  version = "1.0.1"

  app_name    = "ninjas-skunkworks-nginx"
  description = "a skunkworks project"
  environment = var.environment
  owner       = "008103"
  # num_cpus  = "4"
  # memory    = "8192"
  # disk_size = "100"
}
variable "environment" {}
output "name" { value = module.virtual-machine.name }
output "http_ip" { value = module.virtual-machine.http_addr }
output "ssh_ip" { value = module.virtual-machine.ssh_addr }
