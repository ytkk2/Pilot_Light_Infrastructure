resource "aws_vpc" "vpc01" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc01"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc01.id
  cidr_block              = count.index == 0 ? "10.0.1.0/24" : "10.0.2.0/24"
  availability_zone       = count.index == 0 ? "ap-northeast-1a" : "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = count.index == 0 ? "Tokyo_pubnet01" : "Tokyo_pubnet02"
  }
}

resource "aws_subnet" "private_subnet_web" {
  count             = 2
  vpc_id            = aws_vpc.vpc01.id
  cidr_block        = count.index == 0 ? "10.0.11.0/24" : "10.0.12.0/24"
  availability_zone = count.index == 0 ? "ap-northeast-1a" : "ap-northeast-1c"
  tags = {
    Name = count.index == 0 ? "Tokyo_webnet01" : "Tokyo_webnet02"
  }
}

resource "aws_subnet" "private_subnet_db" {
  count             = 2
  vpc_id            = aws_vpc.vpc01.id
  cidr_block        = count.index == 0 ? "10.0.101.0/24" : "10.0.102.0/24"
  availability_zone = count.index == 0 ? "ap-northeast-1a" : "ap-northeast-1c"
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
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_route_association" {
  count          = 2
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
  count  = 2
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = count.index == 0 ? "PrivateRouteTable-ap-northeast-1a" : "PrivateRouteTable-ap-northeast-1c"
  }
}

resource "aws_route" "private_route" {
  count                  = 2
  route_table_id         = aws_route_table.private_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index].id
}

resource "aws_route_table_association" "private_route_association" {
  count          = 4
  subnet_id      = count.index < 2 ? aws_subnet.private_subnet_web[count.index].id : aws_subnet.private_subnet_db[count.index - 2].id
  route_table_id = aws_route_table.private_route_table[count.index % 2].id
}

