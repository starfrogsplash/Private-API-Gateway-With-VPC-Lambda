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