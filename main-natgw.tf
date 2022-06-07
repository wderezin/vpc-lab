
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "walter"
  }
}

resource "aws_eip" "natgw-a" {
  vpc = true

  depends_on                = [aws_internet_gateway.main]
}

resource "aws_eip" "natgw-b" {
  vpc = true

  depends_on                = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "public-a" {
  allocation_id = aws_eip.natgw-a.id
  subnet_id     = aws_subnet.public-a.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "public-b" {
  allocation_id = aws_eip.natgw-b.id
  subnet_id     = aws_subnet.public-b.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-a.id
  }
}
resource "aws_route_table_association" "private-a" {
    subnet_id = aws_subnet.private-a.id
    route_table_id = aws_route_table.private-a.id
}

resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-b.id
  }
}
resource "aws_route_table_association" "private-b" {
    subnet_id = aws_subnet.private-b.id
    route_table_id = aws_route_table.private-b.id
}