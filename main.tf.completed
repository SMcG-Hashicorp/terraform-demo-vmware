module "virtual-machine" {
  source  = "app.terraform.io/hashidemos/virtual-machine/vsphere"
  version = "1.0.1"

  app_name    = var.app_name
  description = var.description
  environment = var.environment
  owner       = var.owner

  vsphere_server    = var.vsphere_server
  vsphere_dc        = var.vsphere_dc
  vsphere_host      = var.vsphere_host
  vsphere_datastore = var.vsphere_datastore
  vsphere_network   = var.vsphere_network

  # num_cpus  = "2"
  # memory    = "2048"
  # disk_size = "20"
}

# module "cisco-router" {
#   source  = "app.terraform.io/hashidemos/cloud-router/vsphere"
#   version = "1.0.1"

#   app_name    = "ninjas-skunkworks-router"
#   description = "a skunkworks project"
#   environment = var.environment
#   owner       = "008103"
# }
