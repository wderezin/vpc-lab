# All local variable definitions
# Only local variables are used in resources and data

locals {
  name             = var.name
  owner            = var.owner
  business-product = var.business-product == null ? local.name : var.business-product
  cost-center      = var.cost-center
  environment      = var.environment
  compliance       = var.compliance
  data-sensitivity = var.data-sensitivity
  exposure         = var.exposure

  all_tags_without_Name = {
    name : local.name
    owner : local.owner
    business-product : local.business-product
    cost-center : local.cost-center
    environment : local.environment
    compliance : local.compliance
    data-sensitivity : local.data-sensitivity
    exposure : local.exposure
  }

  all_tags = merge(local.all_tags_without_Name, {Name: local.name})

}