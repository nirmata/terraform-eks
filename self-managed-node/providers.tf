terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

provider "aws" {
  region = var.aws_region  # Use the variable for the desired region
  profile = var.aws_profile  # Use the variable for the AWS profile
}

provider "kubectl" {
  config_path = "~/.kube/config"  
}