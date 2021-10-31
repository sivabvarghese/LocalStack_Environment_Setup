provider "aws" {
  region                      = "us-east-1"
  access_key                  = "foobar"
  secret_key                  = "foobar"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    s3 = "http://localhost:4566"
    lambda = "http://localhost:4566"
    sns  = "http://localhost:4566"
  }
}

terraform {
  backend "local" {
  }
}

resource "aws_sns_topic" "test_sns_topic" {
  name = "test-sns-topic-dev"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "test-lambda-dev"
  s3_bucket = "__local__"
  s3_key = var.test_lambda_source_directory
  handler = "index.handler"
  runtime = "nodejs12.x"
  role = "fake_role"

  environment {
    variables = {
      XYZ_API_ACCESS_KEY = var.XYZ_API_ACCESS_KEY
    }
  }
}

resource "aws_sns_topic_subscription" "invoke_with_sns" {
  topic_arn = aws_sns_topic.test_sns_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda_function.arn
}
