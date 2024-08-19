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
variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
   validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium"], var.instance_type)
    error_message = "The instance type must be one of 't2.micro', 't2.small', 't2.medium'."
  }
}