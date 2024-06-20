variable "instance_count" {
  description = "The number of instances to create"
  type        = number
  default     = 2
}

variable "subnets" {
  description = "List of subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group for the ec2 instance"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the instances"
  type        = string
  default     = "ami-0f9fe1d9214628296"
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t3.micro"
}

variable "user_data_script" {
  description = "User data script for EC2 instances"
  type        = string
  default = <<-EOF
              #!/bin/bash
              sudo dnf -y update
              sudo dnf -y install docker
              sudo systemctl enable docker
              sudo systemctl start docker
              sudo docker run -p 80:80 -d -v /home/ssm-user/wordpress:/var/www/html --restart always wordpress
              EOF
}