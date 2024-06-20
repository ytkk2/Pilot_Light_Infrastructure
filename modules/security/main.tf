resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "ALB security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ingress_http_port
    to_port     = var.ingress_http_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = var.egress_all_ports
    to_port     = var.egress_all_ports
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "EC2 security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.ingress_http_port
    to_port         = var.ingress_http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = var.egress_all_ports
    to_port     = var.egress_all_ports
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
}


resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Database security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.ingress_db_port
    to_port         = var.ingress_db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
    egress {
    from_port   = var.egress_all_ports
    to_port     = var.egress_all_ports
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
}
