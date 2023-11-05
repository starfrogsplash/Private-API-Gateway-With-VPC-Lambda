variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-1"
}

variable "custom_policy_arn" {
  description = "The ARN of the custom IAM policy."
}