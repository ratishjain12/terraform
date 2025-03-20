# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

# Create a private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
}

# Modify public subnet to auto-assign public IPs
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.2.0/24"
  tags = {
    Name = "public-subnet"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create a route table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-route-table.id
}