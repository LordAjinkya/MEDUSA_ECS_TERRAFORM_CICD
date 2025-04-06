output "alb_dns" {
  value = aws_lb.medusa_alb.dns_name
}
