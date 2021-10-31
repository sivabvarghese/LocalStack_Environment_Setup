#!/bin/bash

# USAGE
# To run this script, 
#       a.) make sure localstack is up and running in docker
#       b.) run 'export LAMBDA_LOCATION=<absolute path to lambda dir in host>' to set the LAMBDA_LOCATION env var.
#       b.) execute this bash script
#
# NOTE: 
# Instead of specifying variables individually, it might be advisable (specially when dealing with a large number of variables) 
# to setup and maintain a .tfvars file in the same directory and supply it as an arg e.g. terraform apply -var-file="dev-testing.tfvars".
# Ref - https://www.terraform.io/docs/language/values/variables.html#variable-definitions-tfvars-files

# Provision services in localstack
terraform -chdir=provisioners init
terraform -chdir=provisioners apply -var="XYZ_API_ACCESS_KEY=xyz-api-test-access-key" \
-var="test_lambda_source_directory=${LAMBDA_LOCATION}" -auto-approve
