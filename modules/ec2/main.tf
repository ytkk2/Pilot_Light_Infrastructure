resource "aws_instance" "web_instance" {
  count           = var.instance_count
  ami             = var.instance_count
  instance_type   = var.ami_id
  subnet_id       = element(var.subnets, count.index)
  vpc_security_group_ids = [var.security_group_id]

  user_data = var.user_data_script

  tags = {
    Name = "web-instance-${count.index}"
  }
}

resource "aws_launch_configuration" "web_lc" {
  name_prefix     = "web-lc-"
  image_id        = var.ami_id
  instance_type   = var.instance_type
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
