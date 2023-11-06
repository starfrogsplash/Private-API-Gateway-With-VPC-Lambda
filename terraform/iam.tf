# Create a new IAM role for the Lambda function
resource "aws_iam_role" "lambda_exec_role" {
  name = "hello-lambda-exec-role"

  permissions_boundary = var.custom_policy_arn

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the IAM role that allows the Lambda function to be invoked
resource "aws_iam_role_policy_attachment" "lambda_exec_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec_role.name
}

data "aws_iam_policy_document" "api-restrict" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["${aws_api_gateway_rest_api.example.execution_arn}/*/*/*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = [var.ip_address]
    }
  }
}

# data "aws_iam_policy_document" "api-restrict-b" {
#   statement {
#     effect = "Allow"
#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#     actions   = ["execute-api:Invoke"]
#     resources = ["${aws_api_gateway_rest_api.example.execution_arn}/*/*/*"]
#   }

#   statement {
#     effect = "Deny"
#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#     actions   = ["execute-api:Invoke"]
#     resources = ["${aws_api_gateway_rest_api.example.execution_arn}/*/*/*"]

#     condition {
#       test     = "NotIpAddress"
#       variable = "aws:SourceIp"
#       values   = [var.ip_address]
#     }
#   }
# }

resource "aws_api_gateway_rest_api_policy" "custom_policy" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  policy      = data.aws_iam_policy_document.api-restrict.json
}
