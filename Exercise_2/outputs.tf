output "vpc_id" {
  value = aws_vpc.udacity-vpc-2.id
}

output "subnet_private_2" {
  value = aws_subnet.udacity-subnet-public-2.id
}

# TODO: Define the output variable for the lambda function.
output "lambda_function_name" {
  description = "Name of the Lambda function."
  value = aws_lambda_function.udacity_lambda.function_name
}
output "lambda_arn" {
  description = "The Amazon Resource Name (ARN) identifying the Lambda function."
  value       = aws_lambda_function.udacity_lambda.arn
}

