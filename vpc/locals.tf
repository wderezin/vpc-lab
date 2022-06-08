# All local variable definitions
# Only local variables are used in resources and data

locals {
  name = var.tags.all_tags["name"]

  tags = var.tags.all_tags
}