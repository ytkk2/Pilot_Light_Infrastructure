resource "aws_instance" "web_instance" {
  count           = var.instance_count
  ami             = "ami-0f9fe1d9214628296"
  instance_type   = "t3.micro"
  subnet_id       = var.subnets[0]
  security_groups = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo dfn -y update
              sudo dfn -y install docker
              sudo systemctl enable docker
              sudo systemctl start docker
              sudo docker run -p80:80 -d -v /home/ssm-user/wordpress:/var/www/html --restart always wordpress
              EOF

  tags = {
    Name = "web-instance-${count.index}"
  }
}

resource "aws_launch_configuration" "web_lc" {
  name_prefix     = "web-lc-"
  image_id        = "ami-0f9fe1d9214628296"
  instance_type   = "t3.micro"
  security_groups = [var.security_group_id]

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.web_lc.id
  min_size             = 2
  max_size             = 4
  desired_capacity     = var.instance_count
  vpc_zone_identifier  = var.subnets
}
