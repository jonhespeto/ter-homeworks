resource "yandex_vpc_network" "develop" {
  name = var.dev_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = "${var.dev_name}-${var.subnets[0].zone}"
  zone           = var.subnets[0].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.subnets[0].cidr]
}