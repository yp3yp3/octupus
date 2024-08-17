data "aws_vpc" "default_vpc" {
  default = true
}
variable "vpc_id" {
  description = "id of vpc to create LB"

}
variable "instances_id" {
  description = "list of ec2 instance"
#  default = data.aws_vpc.default_vpc.id
}
variable "number_of_instance" {
  description = "The number of instance in subnets to create in the default VPC"
  type        = number
  default     = 1
}
variable "subnet_ids" {
  type = list(string)  
}