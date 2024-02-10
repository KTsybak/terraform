#creating vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block 
  
  enable_dns_hostnames = true
  tags = {
    Name="test-vpc-env"
  }
}


resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
tags = {
    Name = "test-internet-gateway"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = var.subnet_count.public
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_cidr
  availability_zone       = var.public_zone
  tags = {
    Name = "test-public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = var.subnet_count.private
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_cidr[count.index]
  availability_zone       = element(var.private_zone, count.index)
  tags = {
    Name = "test-private_subnet-${count.index + 1}"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
      
      cidr_block     = "0.0.0.0/0"
      gateway_id     = aws_internet_gateway.my-igw.id
  
  }
}

resource "aws_route_table_association" "public" {
  count          = var.subnet_count.public
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
  
}
resource "aws_route_table" "private_rt" {
 
  vpc_id  = aws_vpc.my_vpc.id
 
}

resource "aws_route_table_association" "private" {
  count          = var.subnet_count.private
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}
