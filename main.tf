module "virtual-machine" {
  source  = "app.terraform.io/hashidemos/virtual-machine/vsphere"
  version = "1.0.1"

  app_name    = "ninjas-skunkworks-nginx"
  description = "a skunkworks project"
  environment = var.environment
  owner       = "008103"

  num_cpus  = "4" 
  # memory    = "2048"
  # disk_size = "20"
}

variable "environment" {}

output "name" { value = module.virtual-machine.name }
output "http_ip" { value = module.virtual-machine.http_addr }
output "ssh_ip" { value = module.virtual-machine.ssh_addr }
