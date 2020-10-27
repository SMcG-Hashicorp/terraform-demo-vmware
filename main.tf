terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "hashidemos"
    workspaces {
      name = "a-demo-vmware-TEST"
    }
  }
}

module "virtual-machine" {
  source  = "app.terraform.io/hashidemos/virtual-machine/vsphere"
  version = "0.0.3"

  app_name    = "ninjas-skunkworks-nginx"
  description = "a skunkworks project"
  environment = var.environment
  owner       = "008103"
  #vm_image    = "nginxdemos/hello:latest"

}

variable "environment" { default = "test" }

output "ip" { value = module.virtual-machine.vm_ip }

# cpu / ram
# disk size

