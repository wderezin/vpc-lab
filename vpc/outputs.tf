# Module outputs to be used by other modules

output "public_subnet_ids" {
  value = [aws_subnet.public-a.id, aws_subnet.public-b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private-a.id, aws_subnet.private-b.id]
}
