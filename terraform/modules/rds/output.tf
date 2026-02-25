output "db_host" {
    value = aws_db_instance.strapi.address
}
output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
