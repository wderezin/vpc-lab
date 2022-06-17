# Lambda IAM Role

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "${local.lambda_name}-${data.aws_region.current.name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  tags               = local.tags
}

#data "aws_iam_policy_document"  lambda_access_policy {
##  Read the Gateway Load Balancer Endpoints
#
#}
#
#resource "aws_iam_role_policy" lambda_access_policy {
#  name = "Access-Policy"
#  role = aws_iam_role.lambda.id
#  policy = data.aws_iam_policy_document.lambda_access_policy.json
#}

data "aws_iam_policy_document" lambda_core_policy {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = [
      "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.lambda_name}:*"
    ]
  }
}

resource "aws_iam_role_policy" lambda_access_policy {
  name = "Core-Policy"
  role = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda_core_policy.json
}
