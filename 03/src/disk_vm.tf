resource "yandex_compute_disk" "disk" {
  count   = var.disk_count
  name       = "${var.disk_name}-${count.index + 1}"
  type       = "network-hdd"
  size       = var.disk_size
}

resource "yandex_compute_instance" "storage" {
  name = var.vm_storage_name
  resources {
        cores           = var.vm_storage_core
        memory          = var.vm_storage_memory
        core_fraction   = var.vm_storage_core_fraction
  }

scheduling_policy {
    preemptible = var.vm_storage_preemptible
  }

network_interface {
  subnet_id = yandex_vpc_subnet.develop.id
  nat       = var.vm_web_nat
  security_group_ids = [
    yandex_vpc_security_group.example.id
    ]
}

boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

dynamic "secondary_disk" {
  for_each = yandex_compute_disk.disk
  content {
    disk_id = secondary_disk.value.id
  }
}

metadata = var.metadata
allow_stopping_for_update = var.allow_stopping
}