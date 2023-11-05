data "archive_file" "lambda_function" {
    type        = "zip"
    source_dir  = "../src/hello-lambda/dist"
    output_path = "${path.module}/hello-lambda.zip"
}
