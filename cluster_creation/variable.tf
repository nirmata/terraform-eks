variable "region" {
  default     = "us-east-1"
  description = "This is the region where the resources will be deployed"
  type        = string
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
    default = "1.27"
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

variable "secondary_subnet" {}


