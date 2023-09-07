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


# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = "default"
}

provider "kubectl" {
load_config_file = true
}
