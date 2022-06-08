
module "tags" {
  source           = "./tags"
  name             = "apples"
  owner            = "Walter"
  cost-center      = "fruit"
  environment      = "dev"
  compliance       = "no-compliance"
  data-sensitivity = "not"
  exposure         = "public"
}

module "vpc-1" {
  source = "./vpc"

  tags = module.tags
}

module "app-1" {
  source = "./app"

  public_subnet_ids = module.vpc-1.public_subnet_ids
  tags              = module.tags
}
