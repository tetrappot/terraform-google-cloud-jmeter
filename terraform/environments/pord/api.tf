locals {
  services = toset([
    "compute.googleapis.com",
  ])
}

resource "google_project_service" "this" {
  for_each = local.services
  service  = each.value
  project  = data.google_project.this.id

  disable_on_destroy = false
}

resource "time_sleep" "after_enabling_apis" {
  depends_on      = [google_project_service.this["compute.googleapis.com"]]
  create_duration = "180s"
}

resource "null_resource" "apis_ready" {
  depends_on = [time_sleep.after_enabling_apis]
}

data "google_project" "this" {
}
