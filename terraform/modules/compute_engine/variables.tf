variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type of the instance"
  type        = string
}

variable "zone" {
  description = "Zone of the instance"
  type        = string
}

variable "tags" {
  description = "Tags of the instance"
  type        = list(string)
}

variable "hostname" {
  description = "Hostname of the instance"
  type        = string
  default     = ""
}

variable "enable_display" {
  description = "Enable display of the instance"
  type        = bool
  default     = false
}

variable "disk_type" {
  description = "Type of boot disk for the instance"
  type        = string
}

variable "disk_image" {
  description = "Image name of boot disk for the instance"
  type        = string
}

variable "disk_size" {
  description = "Size of boot disk for the instance"
  type        = string
}

variable "network" {
  description = "Network of the instance"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork of the instance"
  type        = string
}

variable "startup_script" {
  description = "Startup script per-instance (list)"
  type        = list(string)
  default     = []
}

variable "service_account_email" {
  description = "Service account email of the instance"
  type        = string
  default     = ""
}

variable "internal_ip" {
  description = "List of internal IP addresses"
  type        = list(string)
  default     = []
}

variable "global_ip" {
  description = "List of global IP addresses"
  type        = list(string)
  default     = []
}

variable "enable_oslogin" {
  description = "Enable oslogin of the instance"
  type        = bool
}

variable "attached_disk_ids" {
  description = "List of disk ids to attach to the instance"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Description of the instance"
  type        = string
  default     = ""
}

variable "provisioning_model" {
  description = "Provisioning model of the instance"
  type        = string
  default     = "STANDARD"
}

variable "preemptible" {
  description = "Preemptible of the instance"
  type        = bool
  default     = false
}

variable "automatic_restart" {
  description = "Automatic restart of the instance"
  type        = bool
  default     = false
}

variable "instance_count" {
  description = "The number of instances"
  type        = number
  default     = 1
}

variable "pj_name" {
  description = "Project name for templates"
  type        = string
  default     = ""
}
