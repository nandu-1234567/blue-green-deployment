resource "aws_db_subnet_group" "strapi" {
    name       = "strapi-db-subnet-group-10"
    subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "strapi" {
    identifier        = "strapi-db-10"
    engine            = "postgres"
    engine_version    = "15"
    instance_class    = "db.t3.micro"
    allocated_storage = 20

    username = "strapiadmin"
    password = var.db_password

    db_name = "strapi"

    skip_final_snapshot = true
    publicly_accessible = true

    vpc_security_group_ids = [var.rds_sg_id]
    db_subnet_group_name   = aws_db_subnet_group.strapi.name
}