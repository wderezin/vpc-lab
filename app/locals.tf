# All local variable definitions
# Only local variables are used in resources and data

locals {
  instance_size = "micro"

  all_tags          = var.tags.all_tags
  public_subnet_ids = var.public_subnet_ids

}
