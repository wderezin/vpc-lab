# All local variable definitions
# Only local variables are used in resources and data

locals {
  name = var.tags.all_tags["name"]

  tags = var.tags.all_tags

  public_subnet_ids = toset([aws_subnet.public-a.id, aws_subnet.public-b.id])

#  transit_gw = local.transit_names[local.region]
#
#  transit_names = {
#    "us-west-1" = "tgw-12"
#    "us-west-2" = "tgw-13"
#    "us-east-1" = "tgw-5"
#  }
}
