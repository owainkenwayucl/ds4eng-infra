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
  name      = "cloud-config-${random_id.secret.hex}"
  namespace = var.namespace

  user_data = templatefile("cloud-init.tmpl.yml", {
      public_key_openssh = data.harvester_ssh_key.mysshkey.public_key
    })
}
resource "harvester_virtualmachine" "loginvm" {
  
  count = 1

  name                 = "${var.username}-login-${format("%02d", count.index + 1)}"
  namespace            = var.namespace
  restart_after_update = true

  description = "Cluster Login Node"

  cpu    = 2 
  memory = "8Gi"

  efi         = true
  secure_boot = false

  run_strategy    = "RerunOnFailure"
  hostname        = "${var.username}-login-${format("%02d", count.index + 1)}"
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
    user_data_secret_name = harvester_cloudinit_secret.cloud-config.name
  }
}

resource "harvester_virtualmachine" "mgmtvm" {
  
  count = 1

  name                 = "${var.username}-mgmt-${format("%02d", count.index + 1)}"
  namespace            = var.namespace
  restart_after_update = true

  description = "Cluster Head Node"

  cpu    = 1 
  memory = "8Gi"

  efi         = true
  secure_boot = false

  run_strategy    = "RerunOnFailure"
  hostname        = "${var.username}-mgmt-${format("%02d", count.index + 1)}"
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
    user_data_secret_name = harvester_cloudinit_secret.cloud-config.name
  }
}

resource "harvester_virtualmachine" "workervm" {
  
  count = var.vm_count

  name                 = "${var.username}-worker-${format("%02d", count.index + 1)}"
  namespace            = var.namespace
  restart_after_update = true

  description = "Cluster Compute Node"

  cpu    = 2
  memory = "8Gi"

  efi         = true
  secure_boot = false

  run_strategy    = "RerunOnFailure"
  hostname        = "${var.username}-worker-${format("%02d", count.index + 1)}"
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
    user_data_secret_name = harvester_cloudinit_secret.cloud-config.name
  }
}