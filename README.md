# Secure Home-IP Exclusive AWS REST API Gateway with VPC-Encapsulated Lambda Function

This project illustrates the process of deploying an AWS REST API Gateway that invokes a Lambda function to deliver web page content. The configuration is designed to be exclusively accessible from your home IP, ensuring it remains private and not publicly accessible.

The Lambda function is set to operate within a Virtual Private Cloud (VPC) for enhanced security and control.

## Tech used
AWS, Typescript, Terraform

## Prerequisites
Before you begin, ensure you have the following prerequisites:

Node.js and npm installed on your local machine.
Terraform CLI installed on your local machine.
AWS account credentials properly configured.

## Getting Started

1. Navigate to the my-lambda directory (`./src/hello-lambda`) and Build the Lambda function code : 

```bash
npm install
npm run build
```

2. Initialize Terraform in the terraform directory (`./terraform`):

```bash
terraform init
```

4. Review the Terraform configuration in the terraform directory, including main.tf, variables.tf, and outputs.tf, to ensure it matches your desired AWS setup.

5. Plan the Terraform changes:
```bash
terraform plan
```

6. Apply the Terraform changes to create the Lambda function and associated resources:
```bash
terraform apply
```


7. After successfully applying Terraform, you can invoke the api gateway `hello` endpoint from any browser, terminal etc.

```
{the api gateway url}/hello
```


8. Clean Up: To clean up and delete the resources created by Terraform, run the following command in the terraform directory (`./terraform`):

```bash
terraform destroy
```
