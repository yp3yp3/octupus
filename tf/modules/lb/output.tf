output "load_balancer_dns_name" {
  value = aws_lb.load_balancer.dns_name
}
output "zone_id" {
  value = aws_lb.load_balancer.zone_id
}