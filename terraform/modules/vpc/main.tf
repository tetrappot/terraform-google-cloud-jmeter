resource "google_compute_network" "vpc" {
  name                     = var.vpc_name
  auto_create_subnetworks  = false
  routing_mode             = var.routing_mode
  mtu                      = 1460
  enable_ula_internal_ipv6 = false
}

#tfsec:ignore:google-compute-enable-vpc-flow-logs
resource "google_compute_subnetwork" "subnet" {
  for_each                 = var.subnet_works
  name                     = each.value["name"]
  ip_cidr_range            = each.value["ip_cidr_range"]
  network                  = google_compute_network.vpc.id
  region                   = each.value["region"]
  private_ip_google_access = each.value["private_ip_google_access"]
}

resource "google_compute_address" "default" {
  count        = var.ip_number
  name         = "stress-test-vm-global-ip${count.index}"
  address_type = "EXTERNAL"
}

resource "google_compute_address" "intarnal" {
  count        = var.ip_number
  name         = "stress-test-vm-intarnal-ip${count.index}"
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.subnet["subnet1"].id
  region       = "asia-northeast1"
}

resource "google_compute_firewall" "default" {
  name    = "stress-test-vm-allow-tcp"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "26000", "26001", "25000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["stress-test-vm"]
}
