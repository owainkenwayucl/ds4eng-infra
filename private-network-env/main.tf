data "harvester_image" "img" {
  display_name = var.img_display_name
  namespace    = "harvester-public"
}

data "harvester_ssh_key" "mysshkey" {
  name      = var.username
  namespace = var.namespace
}

resource "random_id" "secret" {
  byte_length = 5
}

resource "harvester_cloudinit_secret" "cloud-config" {
  count = var.vm_count


  name      = "cloud-config-${random_id.secret.hex}-${count.index}"
  namespace = var.namespace

  user_data = templatefile("cloud-init.tmpl.yml", {
      public_key_openssh = data.harvester_ssh_key.mysshkey.public_key
      host_ip = "${var.ip_block}.${(count.index + 1 + var.ip_offset)}"
      gateway = "${var.ip_block}.1"
    })
}

resource "harvester_cloudinit_secret" "cloud-config-gateway" {

  name      = "cloud-config-gateway-${random_id.secret.hex}"
  namespace = var.namespace

  user_data = templatefile("cloud-init-gateway.tmpl.yml", {
      public_key_openssh = data.harvester_ssh_key.mysshkey.public_key
      host_ip = "${var.ip_block}.${(count.index + 1 + var.ip_offset)}"
      gateway = "${var.ip_block}.1"
    })
}


resource "harvester_virtualmachine" "vm" {
  
  count = var.vm_count

  name                 = "${var.username}-base-${format("%02d", count.index + 1)}-${random_id.secret.hex}"
  namespace            = var.namespace
  restart_after_update = true

  description = "Base VM"

  cpu    = 2
  memory = "16Gi"

  efi         = true
  secure_boot = true

  run_strategy    = "RerunOnFailure"
  hostname        = "${var.username}-base-${format("%02d", count.index + 1)}-${random_id.secret.hex}"
  reserved_memory = "100Mi"
  machine_type    = "q35"

  network_interface {
    name           = "nic-1"
    wait_for_lease = true
    type           = "bridge"
    network_name   = var.network_name
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = "50Gi"
    bus        = "virtio"
    boot_order = 1

    image       = data.harvester_image.img.id
    auto_delete = true
  }

  cloudinit {
    user_data_secret_name = harvester_cloudinit_secret.cloud-config[count.index].name
  }
}

resource "harvester_virtualmachine" "gateway-vm" {
  
  count = 1

  name                 = "${var.username}-gw-${format("%02d", count.index + 1)}-${random_id.secret.hex}"
  namespace            = var.namespace
  restart_after_update = true

  description = "Gateway VM"

  cpu    = 2
  memory = "16Gi"

  efi         = true
  secure_boot = true

  run_strategy    = "RerunOnFailure"
  hostname        = "${var.username}-gw-${format("%02d", count.index + 1)}-${random_id.secret.hex}"
  reserved_memory = "100Mi"
  machine_type    = "q35"

  network_interface {
    name           = "nic-1"
    wait_for_lease = true
    type           = "bridge"
    network_name   = var.network_name
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = "50Gi"
    bus        = "virtio"
    boot_order = 1

    image       = data.harvester_image.img.id
    auto_delete = true
  }

  cloudinit {
    user_data_secret_name = harvester_cloudinit_secret.cloud-config-gateway.name
  }
}
