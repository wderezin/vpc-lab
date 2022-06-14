
locals {
  cidr = "10.0.0.0/22"

  subnet_mask = cidrnetmask(local.cidr)

  newbits = local.mask_table[local.subnet_mask]["newbits"]
  netnum  = local.mask_table[local.subnet_mask]["netnum"]

  mask_table = {
    #  /23
    "255.255.254.0" = { newbits = 5, netnum = 24 }
    # /22
    "255.255.252.0" = { newbits = 6, netnum = 48 }
  }
}

#output "cidr" {
#  value = local.cidr
#}
#
#output "netnum" {
#  value = local.netnum
#}
#
#output "netbits" {
#  value = local.newbits
#}
