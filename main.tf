
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
  #  public_subnet_ids = [for subnet in values(module.vpc-1.subnets["public"][*]) : subnet.id]

  tags   = module.tags
  vpc_id = module.vpc-1.vpc.id
}
