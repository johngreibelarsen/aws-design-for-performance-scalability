provider "aws" {
  region = "${var.AWS_REGION}"  // London
}

resource "aws_vpc" "udacity-vpc-2" {
    cidr_block = "10.2.0.0/16"

    tags = {
        Name = "udacity-vpc-2"
    }
}

# Public subnet
resource "aws_subnet" "udacity-subnet-public-2" {
    vpc_id = "${aws_vpc.udacity-vpc-2.id}"
    cidr_block = "10.2.200.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "${var.AWS_AZ}"
    tags = {
        Name = "udacity-subnet-public-2"
    }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = file("iam/lambda_policy.json")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = file("iam/lambda_assume_role_policy.json")
}

resource "aws_lambda_function" "udacity_lambda" {
  function_name = "greet_lambda"
  s3_bucket     = "udacity-lambda-jgl-bucket"
  s3_key        = "greet_lambda.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "greet_lambda.lambda_handler"
  runtime       = "python3.8"
  tags = {
      Name = "udacity_lambda"
  }
}