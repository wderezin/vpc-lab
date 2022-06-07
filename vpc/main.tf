# terraform resources heredata 
# If you need to scale to multiple files
# Option 1: Create main-category.tf such as main-vpc.tf
# Option 2: Create category.tf such as vpc.tf


resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = merge(local.tags, { Name : "${local.name}-vpc" })
}

resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = merge(local.tags, { Name : "${local.name}-public-a" })
}

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"

  tags = merge(local.tags, { Name : "${local.name}-private-a" })
}

resource "aws_subnet" "public-b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2b"

  tags = merge(local.tags, { Name : "${local.name}-public-b" })

}

resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-2b"

  tags = merge(local.tags, { Name : "${local.name}-private-b" })
}