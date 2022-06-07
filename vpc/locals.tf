# All local variable definitions
# Only local variables are used in resources and data

locals {
  name = var.name == null ? var.owner : var.name

  tags = {
    Name : local.name
    Owner : var.owner
    CostCenter : "network"
  }
}