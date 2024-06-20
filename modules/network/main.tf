resource "aws_vpc" "vpc01" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc01"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc01.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = count.index == 0 ? "Tokyo_pubnet01" : "Tokyo_pubnet02"
  }
}

resource "aws_subnet" "private_subnet_web" {
  count             = 2
  vpc_id            = aws_vpc.vpc01.id
  cidr_block        = var.private_subnet_web_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = count.index == 0 ? "Tokyo_webnet01" : "Tokyo_webnet02"
  }
}

resource "aws_subnet" "private_subnet_db" {
  count             = 2
  vpc_id            = aws_vpc.vpc01.id
  cidr_block        = var.private_subnet_db_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = count.index == 0 ? "Tokyo_dbnet01" : "Tokyo_dbnet02"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "Tokyo_igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "Tokyo_public_route_table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_route_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_eip" {
  count  = 2
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 2
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = count.index == 0 ? "Tokyo_natgw01" : "Tokyo_natgw02"
  }
}

resource "aws_route_table" "private_route_table" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = count.index == 0 ? "PrivateRouteTable-ap-northeast-1a" : "PrivateRouteTable-ap-northeast-1c"
  }
}

resource "aws_route" "private_route" {
  count                  = length(var.availability_zones)
  route_table_id         = aws_route_table.private_route_table[count.index].id
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index].id
}

resource "aws_route_table_association" "private_route_association" {
  count          = length(var.private_subnet_web_cidrs) + length(var.private_subnet_db_cidrs)
  subnet_id      = count.index < length(var.private_subnet_web_cidrs) ? aws_subnet.private_subnet_web[count.index].id : aws_subnet.private_subnet_db[count.index - length(var.private_subnet_web_cidrs)].id
  route_table_id = aws_route_table.private_route_table[count.index % 2].id
}

