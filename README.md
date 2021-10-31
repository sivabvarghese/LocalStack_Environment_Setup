## Summary
A simple example of setting up [localstack](https://github.com/localstack/localstack) via docker compose, provisioning an SNS topic and lambda function subscribing to said SNS topic via [terraform](https://www.terraform.io/), and simulating a server event dispatch to SNS topic that triggers the lambda.

This is a very basic setup to showcase how complex workflows depending on AWS services can be tested in local dev machine via provisioning the aws services on localstack. Terraform automation scripts are used for consistency in how resources are provisioned across dev machines as well as any test environments, and to discourage snowflake configurations.

##### Prerequisites
 - [Docker is installed](https://docs.docker.com/get-docker/) and running in dev machine (docker-compose version should be v1.9.0 or higher)
 - AWS CLI is installed (https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
 - Terraform is installed (https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)


##### Steps to run example

1. Run `docker-compose up` to run localstack via the docker-compose.yml file in repo root directory.
2. Once localstack is up and running, open up a new terminal and create an ENV variable LAMBDA_LOCATION with the value of the absolute path to the ./lambda directory (e.g. on macOS, `export LAMBDA_LOCATION=/Users/ted/Dev/node-aws-sns-example/lambda`).
3. Run the `provision-localstack.sh` bash script.
4. Once terraform has completed provisioning the AWS services, run `aws --endpoint-url=http://localhost:4566 sns list-topics` and ensure the TopicArn listed is the same specified in publish-sns-message-test.js (line 10). If not, replace the value in the code file with the provisioned SNS TopicArn.
5. Open up a new terminal and tail the aws log group by running ``aws --endpoint-url=http://localhost:4566 logs tail "/aws/lambda/test-lambda-dev" --follow --format short`.
6. Run `node publish-sns-message-test.js`. This simulates a server dispatching a message to an SNS topic.
7. Console logs from the lambda function should be printed in the terminal where the logs are being tailed (step 5).

*For viewing the ARNs and details of the SNS topic, lambda function, and log groups created in localstack, the following commands can be used:*
 - `aws --endpoint-url=http://localhost:4566 sns list-topics`
 - `aws --endpoint-url=http://localhost:4566 lambda list-functions`
 - `aws --endpoint-url=http://localhost:4566 logs describe-log-groups`
 