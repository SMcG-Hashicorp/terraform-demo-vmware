module "virtual-machine" {
  source  = "app.terraform.io/hashidemos/virtual-machine/vsphere"
  version = "0.2.1"

  app_name    = "ninjas-skunkworks-nginx"
  description = "a skunkworks project"
  environment = var.environment
  owner       = "008103"

  num_cpus  = "6"
}

variable "environment" {}

output "name" { value = module.virtual-machine.name }
output "http_ip" { value = module.virtual-machine.http_addr }
output "ssh_ip" { value = module.virtual-machine.ssh_addr }