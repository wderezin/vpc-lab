
module "tags" {
  source           = "./tags"
  name             = "apples"
  owner            = "Walter"
  cost-center      = "fruit"
  environment      = "dev"
  compliance       = "na"
  data-sensitivity = "not"
  exposure         = "public"
}

module "vpc-1" {
  source = "./vpc"

  tags = module.tags
}