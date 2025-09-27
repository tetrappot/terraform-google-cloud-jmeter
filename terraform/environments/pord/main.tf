module "vpc" {
  source       = "../../modules/vpc"
  vpc_name     = "stress-test-asia-ne1-prod"
  routing_mode = "REGIONAL"
  subnet_works = {
    "subnet1" = {
      name                     = "stress-test-asia-ne1-prod-subnet-1"
      ip_cidr_range            = "10.0.0.0/16"
      region                   = "asia-northeast1"
      private_ip_google_access = true
    }
  }
  ip_number = local.instance_count + 1 #master + slave
}

module "host_compute_engine" {
  source                = "../../modules/compute_engine"
  instance_name         = "master-server"
  machine_type          = "f1-micro" #"n2-standard-4"
  zone                  = "asia-northeast1-b"
  tags                  = ["stress-test-vm"]
  disk_type             = "pd-standard"
  disk_size             = 10
  disk_image            = "ubuntu-os-cloud/ubuntu-2204-lts"
  enable_display        = false
  network               = module.vpc.vpc_name
  subnetwork            = module.vpc.subnetwork_id["subnet1"]
  enable_oslogin        = false
  service_account_email = ""
  global_ip             = [module.vpc.ip_address[0]]
  internal_ip           = [module.vpc.internal_ip_address[0]]
  startup_script = [templatefile("./host_server_script.tpl", {
    remote_server_internal_ip_list = join(",", [for i in range(local.instance_count) : "${module.vpc.internal_ip_address[i]}:${26000 + i}"])
    pj_name                        = local.pj_name
  })]
}

module "compute_engine" {
  instance_count        = local.instance_count
  source                = "../../modules/compute_engine"
  instance_name         = "slave-group"
  machine_type          = "f1-micro" #"c2-standard-30"
  zone                  = "asia-northeast1-b"
  provisioning_model    = "SPOT"
  tags                  = ["stress-test-vm"]
  disk_type             = "pd-standard"
  disk_size             = 10
  disk_image            = "ubuntu-os-cloud/ubuntu-2204-lts"
  enable_display        = false
  network               = module.vpc.vpc_name
  subnetwork            = module.vpc.subnetwork_id["subnet1"]
  enable_oslogin        = false
  service_account_email = ""
  preemptible           = true
  global_ip             = module.vpc.ip_address
  internal_ip           = module.vpc.internal_ip_address
  pj_name               = local.pj_name
}
