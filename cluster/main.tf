# terraform resources heredata 
# If you need to scale to multiple files
# Option 1: Create main-category.tf such as main-vpc.tf
# Option 2: Create category.tf such as vpc.tf

resource "aws_route53_record" "glb" {
  for_each = toset(local.lb_names)

  zone_id = local.zone_id
  name    = local.hostname
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = each.key
  records        = [each.key]
}
