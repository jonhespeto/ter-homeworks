resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.vm_db : vm.vm_name => vm }
  name        = each.value.vm_name
  platform_id = each.value.platform

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = each.value.boot_disk.initialize_params.size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  metadata = {
    serial-port-enable = each.value.metadata.serial-port-enable
    ssh-keys =local.ssh-keys
  }

  allow_stopping_for_update = each.value.allow_stopping_for_update
}