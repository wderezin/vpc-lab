# Module outputs to be used by other modules

output "public_subnet_ids" {
  value = [aws_subnet.public-a.id, aws_subnet.public-b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private-a.id, aws_subnet.private-b.id]
}

output "vpc" {
  value = aws_vpc.main
}

output "public_subnets" {
  value = [aws_subnet.public-a, aws_subnet.public-b]
}

output "private_subnets" {
  value = [aws_subnet.private-a, aws_subnet.private-b]
}

output "subnets" {
  value = {
    public = {
      "a" : aws_subnet.public-a
      "b" : aws_subnet.public-b
    }
    private = {
      "a" : aws_subnet.private-a
      "b" : aws_subnet.private-b
    }
  }
}
