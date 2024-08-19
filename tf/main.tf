terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name = "nodejs-vpc"
  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, var.number_of_instance)
  public_subnets  = [for i in range(var.number_of_instance) : cidrsubnet("10.0.0.0/20", 8, i)]
  private_subnets = [for i in range(var.number_of_instance) : cidrsubnet("10.0.16.0/20", 8, i)]
  enable_nat_gateway   = true
  enable_dns_hostnames = true
}

resource "aws_security_group" "instances" {
  name = "instances_sg"
  vpc_id = module.vpc.vpc_id
}
resource "aws_security_group_rule" "allow_3000_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id
  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"]
}

resource "aws_instance" "my_app" {
  count = var.number_of_instance
  ami           = "ami-0ae8f15ae66fe8cda"
  instance_type = var.instance_type
  subnet_id = module.vpc.private_subnets[count.index]
  security_groups = [aws_security_group.instances.id]
   user_data = <<-EOF
    #!/bin/bash
    sudo yum install docker -y
    sudo service docker start
    sudo chkconfig docker on
    sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "$(cat <<'END'
    ${file("docker-compose.yaml")}
    END
    )" > docker-compose.yaml
    sudo docker-compose -p nodejs_web_app up -d
  EOF
  tags = {
    Name = "MY_app_${count.index}"
  }
}
locals {
  instances_ids = [for instance in aws_instance.my_app : instance.id]
}

module "LB" {
  source = "./modules/lb"  
  vpc_id = module.vpc.vpc_id
  instances_id = local.instances_ids
  number_of_instance = var.number_of_instance
  subnet_ids = module.vpc.public_subnets
  
}


module "dns" {
  source = "./modules/dns"  
  load_balancer_dns_name = module.LB.load_balancer_dns_name
  load_balancer_zone_id = module.LB.zone_id
  domain = var.domain
  environment_name = var.environment_name
  domain_zone_exist = var.domain_zone_exist

}