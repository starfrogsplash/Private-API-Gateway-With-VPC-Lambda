resource "aws_lambda_function" "hello_lambda" {
  filename         = data.archive_file.lambda_function.output_path
  function_name    = "hello_lambda-function"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "main.handler"
  runtime          = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_function.output_base64sha512

  vpc_config {
    subnet_ids         = [aws_subnet.example.id]
    security_group_ids = [aws_security_group.example.id]
  }
}
