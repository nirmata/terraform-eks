variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" # Replace with your desired region
}

variable "aws_profile" {
  description = "AWS profile name"
  type        = string
  default     = "AWSAdministratorAccess-844333597536" # Replace with your AWS profile name
}

variable "stack_name" {
  description = "Name of the CloudFormation stack"
  type        = string
  default     = "sagar-new-stack" # Replace with your desired stack name
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "test-cluster" # Replace with your EKS cluster name
}

variable "cluster_security_group" {
  description = "Security group ID for the EKS cluster control plane"
  type        = string
  default     = "sg-06d9c85a15b2e4dea" # Replace with your security group ID
}

variable "key_name" {
  description = "Name of the SSH key pair used for EC2 instances"
  type        = string
  default     = "vikash-east" # Replace with your key pair name
}

variable "desired_capacity" {
  description = "Desired capacity of the node Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the node Auto Scaling Group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum size of the node Auto Scaling Group"
  type        = number
  default     = 1
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "nodeaks" # Replace with your node group name
}

variable "node_image_id" {
  description = "Custom image ID for EC2 instances, if needed"
  type        = string
  default     = ""  # Provide your custom image ID if needed
}

variable "node_image_id_ssm_param" {
  description = "SSM parameter for getting the node image ID"
  type        = string
  default     = "/aws/service/eks/optimized-ami/1.23/amazon-linux-2/recommended/image_id"
}

variable "disable_imds_v1" {
  description = "Whether to disable IMDSv1 on EC2 instances"
  type        = bool
  default     = false
}

variable "node_instance_type" {
  description = "Instance type for EKS nodes"
  type        = string
  default     = "t3.medium" # Replace with your desired instance type
}

variable "node_volume_size" {
  description = "Volume size for EKS nodes"
  type        = number
  default     = 20
}

variable "subnets" {
  description = "Comma-separated list of subnet IDs for EKS nodes"
  type        = string
  default     = "subnet-043742ae9f9959f62" # Replace with your subnet IDs
}

variable "vpc_id" {
  description = "ID of the VPC where EKS nodes will be launched"
  type        = string
  default     = "vpc-0502f555ea1cef9e5" # Replace with your VPC ID
}
