# All local variable definitions
# Only local variables are used in resources and data

locals {

  lambda_name = "Infra-Firewall-MGMT"
  tags = {}

  lambda_zip = "${path.module}/src/lambda.zip"
  lambda_dir = "${path.module}/src/lambda"
}
