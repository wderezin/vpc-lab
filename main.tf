
module "tags" {
  source           = "./tags"
  name             = "apples"
  owner            = "Walter"
  cost-center      = "fruit"
  environment      = "dev"
  compliance       = "no-compliance"
  data-sensitivity = "not"
  exposure         = "public"
  extras = {
    project = "alpha"
  }
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


module "tags-2" {
  source           = "./tags"
  name             = "oranges"
  owner            = "Walter"
  business-product = "apples"
  cost-center      = "fruit"
  environment      = "dev"
  compliance       = "no-compliance"
  data-sensitivity = "not"
  exposure         = "public"
  extras = {
    project = "alpha"
  }
}

module "vpc-2" {
  source = "./vpc"

  tags = module.tags-2
}

module "app-2" {
  source = "./app"

  public_subnet_ids = module.vpc-2.public_subnet_ids
  #  public_subnet_ids = [for subnet in values(module.vpc-1.subnets["public"][*]) : subnet.id]

  tags   = module.tags-2
  vpc_id = module.vpc-2.vpc.id
}

module "cluster" {
  source = "./cluster"

  zone_id  = "Z08709213723G4EY0QRSL" # From the AWS Console
  hostname = "fruits"
  lb_names = [module.app-1.website_hostname, module.app-2.website_hostname]
}
