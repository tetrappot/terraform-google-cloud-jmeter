output "vpc_name" {
  value = google_compute_network.vpc.name
}
output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}
output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "subnetwork_id" {
  value = {
   for subnet_name in keys(var.subnet_works) : subnet_name => google_compute_subnetwork.subnet[subnet_name].id
  }
}

output "ip_address" {
  value = google_compute_address.default[*].address
}

output "internal_ip_address" {
  value = google_compute_address.intarnal[*].address
}
