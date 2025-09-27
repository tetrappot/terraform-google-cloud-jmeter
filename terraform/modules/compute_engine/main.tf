resource "google_compute_instance" "instance" {
  count        = var.instance_count
  name         = var.instance_name == "slave-group" ? "${var.instance_name}-${count.index + 1}" : var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags
  hostname     = var.hostname

  boot_disk {
    initialize_params {
      type  = var.disk_type
      size  = var.disk_size
      image = var.disk_image
    }
  }
  dynamic "attached_disk" {
    for_each = var.attached_disk_ids

    content {
      source = attached_disk.value
    }
  }

  scheduling {
    provisioning_model = var.provisioning_model
    preemptible        = var.preemptible
    automatic_restart  = var.automatic_restart
  }

  description    = var.description
  enable_display = var.enable_display

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = length(var.internal_ip) > 0 ? element(var.internal_ip, count.index + 1) : null

    access_config {
      nat_ip = length(var.global_ip) > 0 ? element(var.global_ip, count.index + 1) : null

    }
  }
  metadata_startup_script = length(var.startup_script) > 0 ? element(var.startup_script, count.index) : templatefile("${path.module}/../../environments/pord/start_script.tpl", {
    rmi_port    = 26000 + count.index
    server_host = length(var.internal_ip) > 0 ? element(var.internal_ip, count.index) : ""
    pj_name     = var.pj_name
  })
  metadata = {
    enable-oslogin = var.enable_oslogin
  }

  service_account {
    email  = var.service_account_email == "" ? null : var.service_account_email
    scopes = ["cloud-platform"]
  }
  allow_stopping_for_update = true #NOTE:後からmachine typeなどを変更するために必要

  lifecycle {
    ignore_changes = [
      labels,
      metadata,
      scheduling
    ]
  }
}
