
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = local.tags
}

# ***********************************
# *** Internet GateWay for Public ***
# ***********************************

resource "aws_route_table" "public" {
  for_each  = local.public_subnet_ids
  vpc_id    = aws_vpc.main.id
  tags      = local.tags
}

resource "aws_route_table_association" "public" {
  for_each       = local.public_subnet_ids
  subnet_id      = each.key
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route" "public_internet_gateway" {
  for_each               = local.public_subnet_ids
  route_table_id         = aws_route_table.public[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

  timeouts {
    create = "5m"
  }
}

# *******************************
# *** NAT GateWay for Private ***
# *******************************

resource "aws_eip" "natgw-a" {
  vpc = true

  depends_on = [aws_internet_gateway.main]
  tags       = local.tags
}

resource "aws_eip" "natgw-b" {
  vpc        = true
  tags       = local.tags
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "public-a" {
  allocation_id = aws_eip.natgw-a.id
  subnet_id     = aws_subnet.public-a.id

  tags = merge(local.tags, { Name : "${local.name}-gw-public-a" })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "public-b" {
  allocation_id = aws_eip.natgw-b.id
  subnet_id     = aws_subnet.public-b.id
  tags          = merge(local.tags, { Name : "${local.name}-gw-public-b" })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-a.id
  }
}
resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-a.id
}


resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-b.id
  }
}
resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private-b.id
}
