data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "web" {
  count = var.web_count
  depends_on = [yandex_compute_instance.db]

  name        = "${var.vm_web_name}-${count.index+1}"
  platform_id = var.vm_web_platform
  
  resources {
    cores          = var.vms_resources.web.cores
    memory         = var.vms_resources.web.memory
    core_fraction  = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = var.vm_web_disk_size
    }
  }

  metadata = var.metadata

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
    security_group_ids = [
      yandex_vpc_security_group.example.id
      ]
  }

  allow_stopping_for_update = var.allow_stopping
}