# Create a new REST API
resource "aws_api_gateway_rest_api" "example" {
  name        = "example-api"
  description = "My REST API for AWS API Gateway"

    endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Create a new resource for the API
resource "aws_api_gateway_resource" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "hello"
}

# Create a new method for the resource
resource "aws_api_gateway_method" "example" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.example.id
  http_method   = "GET"
  authorization = "NONE"
}

# Create a new integration for the method
resource "aws_api_gateway_integration" "example" {
  rest_api_id             = aws_api_gateway_rest_api.example.id
  resource_id             = aws_api_gateway_resource.example.id
  http_method             = aws_api_gateway_method.example.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.hello_lambda.invoke_arn
}

# Create a new stage for the API
resource "aws_api_gateway_stage" "example" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.example.id
  deployment_id = aws_api_gateway_deployment.example.id
}

# Create a new deployment for the API
resource "aws_api_gateway_deployment" "example" {
  depends_on  = [aws_api_gateway_integration.example]
  rest_api_id = aws_api_gateway_rest_api.example.id
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
}