output "load_balancer_dns_name" {
  value = module.LB.load_balancer_dns_name 
}

output "domain_adress" {
  value = module.dns.domain_adress
}