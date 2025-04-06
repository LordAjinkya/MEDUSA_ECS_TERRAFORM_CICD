output "alb_dns" {
  value = aws_lb.medusa_alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.medusa_postgres.endpoint
}

output "rds_db_name" {
  value = aws_db_instance.medusa_postgres.db_name
}