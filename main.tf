module "virtual-machine" {
  source  = "app.terraform.io/hashidemos/virtual-machine/vsphere"
  version = "0.2.0"

  app_name    = "ninjas-skunkworks-nginx"
  description = "a skunkworks project"
  environment = var.environment
  owner       = "008103"

  # num_cpus  = "2"
  # memory    = "2048"
  # disk_size = "20"
}

variable "environment" {}

output "name" { value = module.virtual-machine.name }
output "ssh_ip" { value = module.virtual-machine.ssh_addr }