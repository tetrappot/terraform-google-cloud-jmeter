variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
variable "routing_mode" {
  description = "The network routing mode (default: REGIONAL)"
  type        = string
  default     = "REGIONAL"
}
variable "subnet_works" {
  type    = map(map(string))
  default = {}
}

variable "ip_number" {
  description = "The number of IP addresses in the range"
  type        = number
  default     = 1
}