
output "lambda_function_name" {
  value = aws_lambda_function.hello_lambda.function_name
}

output "api_gateway_url" {
  value = aws_api_gateway_deployment.example.invoke_url
}
