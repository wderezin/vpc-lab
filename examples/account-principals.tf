
locals {

  account_num = [
    "1111111111",
    "2222222222",
    "3333333333"
  ]

  account_arns = [ for num in local.account_num : "arn:aws:iam::${num}:root" ]

  account_map = { for num in local.account_num : num =>  "arn:aws:iam::${num}:root" }

}

output arns {
  value = local.account_arns
}

output map {
  value = local.account_map
}
