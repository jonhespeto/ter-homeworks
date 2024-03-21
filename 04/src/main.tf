module "vpc" {
  source  = "./vpc"
  subnets = var.subnets
}

module "vm-marketing" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.vm_prop.marketing.env_name
  network_id     = module.vpc.network_id.id
  subnet_zones   = var.vm_prop.marketing.subnet_zones
  subnet_ids     = [module.vpc.subnet_id.id]
  instance_name  = var.vm_prop.marketing.inst_name
  instance_count = var.vm_prop.marketing.inst_count
  image_family   = var.vm_prop.marketing.image_family
  public_ip      = var.vm_prop.marketing.pub_ip
  labels         = var.vm_prop.marketing.labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "vm-analytics" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.vm_prop.analytics.env_name
  network_id     = module.vpc.network_id.id
  subnet_zones   = var.vm_prop.analytics.subnet_zones
  subnet_ids     = [module.vpc.subnet_id.id]
  instance_name  = var.vm_prop.analytics.inst_name
  instance_count = var.vm_prop.analytics.inst_count
  image_family   = var.vm_prop.analytics.image_family
  public_ip      = var.vm_prop.analytics.pub_ip
  labels         = var.vm_prop.analytics.labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username       = var.username
    ssh_public_key = jsonencode([file(var.ssh_public_key)])
    packages       = jsonencode(var.packages)
  }
}