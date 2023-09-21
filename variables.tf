variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1" # Replace with your desired region
}

variable "aws_profile" {
  description = "AWS profile name"
  type        = string
  default     = "dev-*****" # Replace with your AWS profile name
}


variable "template_path" {
  description = "Path to the CloudFormation template file"
  type        = string
  default     = "cf-template-for-node-group.yaml"
}


variable "stack_name" {
  description = "Name of the CloudFormation stack"
  type        = string
  default     = "duke-new-stack" # Replace with your desired stack name
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "test-vk-sagar" # Replace with your EKS cluster name
}

variable "cluster_security_group" {
  description = "Security group ID for the EKS cluster control plane"
  type        = string
  default     = "sg-****" # Replace with your security group ID
}

variable "key_name" {
  description = "Name of the SSH key pair used for EC2 instances"
  type        = string
  default     = "***" # Replace with your key pair name
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
  default     = "subnet-***,subnet-***" # Replace with your subnet IDs
}

variable "vpc_id" {
  description = "ID of the VPC where EKS nodes will be launched"
  type        = string
  default     = "vpc-*****" # Replace with your VPC ID
}

variable "api_server_endpoint" {
  description = "The API server endpoint for the EKS cluster"
  type        = string
  default     = "https://*****.sk1.us-west-1.eks.amazonaws.com"
}

variable "cluster_ca" {
  description = "The base64-encoded cluster certificate authority (CA)"
  type        = string
  default     = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJek1Ea3lNVEV3TkRNd04xb1hEVE16TURreE9ERXdORE13TjFvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT1FNCmh2UmxtemtPU3lXa2lmVkpSOGdOL0JweW0vY3Q4MW1Xd0xKRi81em1GUVJTaG92NEFwYWl2OFh2YnNmcUl0Z28KTlI2VExWZ3d1U2ZlcGlnQlp3aXdmSElWMFFLakcwVTlLRWQwY0dJUURpbDdCTFAwS2k1YzhTVk5sT05DTk1scwp5NkhZWWFxcDc0REtoMTVVM2orL2pyVXlMWHdxZUJ3VXVyeDBZaWJkQTRzTkRuOTZGN0RQY2VZVDVOT0dSRnI3CkZNTGkwMlE1cmJzbVV1VUhVV1I2YjRpMGVybjBDMXJmN0xDZnZqVHFlSnlRRzFHR0JNdWhYUEh2T0t1UEZ6czMKSTdoUTFTUzJBNStpM3FtUVNoRE1IRDVhMGRsQkRpNmxaVnZKc3pLMEtZL3FwZXd3eElOL1ltWXJ0enQ0aFhJRwo5S2ZEYnBPTmhoTWdaY0ZNdFlzQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZIUUNOQmlJVXlxUmJOT0ZCWHQ0WGtDL3NoVmRNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSDhyRlNFdCtNV3hmREhSUkJPUwpRK0lLZk5jSFp4N1Z5OWRaRVF6ZFg2ZllYSkxWSGM0ellPcldvcG9XL1hvYVloWmpYWnFtTFlHOHFwVU9yRjY3ClFBY0JwUk4xUjBnaGNCbFErM2ZYaVNCdnI5VXNRQ1JIWUhBanU0NDkrNHBlVHFJTHlacmpQY2ZYNi8yYkJ6dkcKSEFPb1lUeThxOXFaQUU2WEZRZVNLWk42OTIxaUtZQkZnL0VyU0I0VkRIclRrVkVvV0Z0K3pXZEFBVXVUZDZwWgpkbGY4RklyWnduVk05S1RSODdRbTFEUlhKaVNPR2grRVpqWnpjanNQOUdtNll5MktkajdXRkRjVUhwd05ESzN4ClREMmN0WFdndnd*****TBQUUpmcGNqbE***Ib1htU2RzV1JOS20KcVhVPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
}
