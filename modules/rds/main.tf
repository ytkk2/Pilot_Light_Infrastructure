resource "aws_db_instance" "mariadb" {
  identifier        = "tokyo-db01"
  engine            = "mariadb"
  engine_version    = "10.6.14"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.security_group_id]


  username            = "admin"
  password            = "password"
  db_name = "wordpress"
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids
}
