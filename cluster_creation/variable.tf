variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" # Replace with your desired region
}

variable "aws_profile" {
  description = "AWS profile name"
  type        = string
  default     = "default" # Replace with your AWS profile name
}



variable "vpc_name" {
  description = "Name for the AWS VPC"
  type        = string
  default     = "Test-VPC" # You can change the default value if needed
}


variable "vpc-cidr" {
  default     = "10.14.0.0/16"
  description = "VPC CIDR Block"
  type        = string
}


# Define a variable for IGW name
variable "igw_name" {
  description = "Name for the Internet Gateway"
  type        = string
  default     = "Test-IGW"
}


variable "public-subnet-1-cidr" {
  default     = "10.14.1.0/24"
  description = "Public Subnet 1 CIDR Block"
  type        = string
}


variable "public-subnet-2-cidr" {
  default     = "10.14.2.0/24"
  description = "Public Subnet 2 CIDR Block"
  type        = string
}


variable "private-subnet-1-cidr" {
  default     = "10.14.3.0/24"
  description = "Private Subnet 1 CIDR Block"
  type        = string
}


variable "private-subnet-2-cidr" {
  default     = "10.14.4.0/24"
  description = "Private Subnet 2 CIDR Block"
  type        = string
}

variable "cluster_version" {
    default = "1.25"
    description = "The EKS Cluster Version"
    type = string
}


variable "cluster_name" {
  description = "Name of the AWS EKS cluster"
  type        = string
  default     = "test-cluster"  # Set the default cluster name if needed
}


variable "node_group_name" {
  description = "Name of the AWS EKS node group"
  type        = string
  default     = "test-cluster-ng"  # Set the default node group name if needed
}

# variable "secondary_subnet" {}

variable "desired_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 1
}

variable "min_size" {
  type    = number
  default = 1
}

variable "instance_types" {
  description = "List of EC2 instance types for the node group"
  type        = list(string)
  default     = ["t2.small"]
}


# Define variables
variable "kubernetes_namespace" {
  description = "The Kubernetes namespace for the service account"
  type        = string
  default     = "default" # You can change the default value
}

variable "service_account_name" {
  description = "The name of the Kubernetes service account"
  type        = string
  default     = "example-service-account" # You can change the default value
}

variable "node_group" {}

variable "availability_zones" {
  description = "List of Availability Zones for subnets"
  type        = string
  default     = "us-east-1a" # Replace with your desired AZs
}
