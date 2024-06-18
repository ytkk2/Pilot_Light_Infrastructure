variable "region" {
  default = "ap-northeast-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnets" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "db_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}
