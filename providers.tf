provider "aws" {
  region = var.aws_region  # Use the variable for the desired region
  profile = var.aws_profile  # Use the variable for the AWS profile
}