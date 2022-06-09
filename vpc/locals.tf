# All local variable definitions
# Only local variables are used in resources and data

locals {
  name = var.tags.all_tags["name"]

  tags = var.tags.all_tags

  public_subnet_ids = toset([aws_subnet.public-a.id, aws_subnet.public-b.id])
}
