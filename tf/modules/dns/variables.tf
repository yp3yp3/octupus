
variable "domain" {
  description = "Domain for website"
  type        = string
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
variable "load_balancer_dns_name" {
    type = string
}
variable "load_balancer_zone_id" {
    type = string
}
