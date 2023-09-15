variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC"
  type        = list(string)
  # default     = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]  # Replace with your desired CIDR blocks
  default     = ["10.1.0.0/24"]  # Replace with your desired CIDR blocks
}

variable "region" {
  default     = "us-east-1"
  description = "This is the region where the resources will be deployed"
  type        = string
}

variable "secondary_subnets" {
  description = "List of secondary subnets to use with ENIConfig"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]  # Replace with the desired Availability Zones in us-east-1
}

variable "kubeconfig" {}


variable "eks_cluster_vpc_config" {
  description = "VPC configuration for the AWS EKS cluster."
}

variable "vpc_id" {}
variable "cluster_name" {}

variable "node_group_name" {
  description = "Name of the AWS EKS node group"
  type        = string
  default     = "test-cluster-ng"  # Set the default node group name if needed
}


variable "instance_types" {
  description = "List of EC2 instance types for the node group"
  type        = list(string)
  default     = ["t2.small"]
}

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

variable "cluster_endpoint" {}