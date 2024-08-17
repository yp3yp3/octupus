variable "number_of_instance" {
  description = "The number of instance in subnets to create in the default VPC"
  type        = number
  default     = 2
}
variable "domain" {
  type        = string
  default     = "yp3yp3.online"
}
variable "domain_zone_exist" {
  type        = bool
  default     = true
}
variable "environment_name" {
  description = "production or other"
  type        = string
  default     = "production"
}
