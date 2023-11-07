resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "MySubnet"
  }
}

resource "aws_security_group" "example" {
  name_prefix = "example-"
  vpc_id      = aws_vpc.example.id
}
