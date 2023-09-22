# Terraform AWS EKS Cluster with Self-Managed Nodes

## Introduction

This Terraform project automates the deployment of an Amazon Elastic Kubernetes Service (EKS) cluster with self-managed nodes in AWS. The infrastructure is organized into modular Terraform modules for easy customization and management.

## Prerequisites

Before you begin, ensure that you have the following prerequisites:

- **AWS Account**: You need an AWS account with appropriate permissions.
- **Terraform Installed**: Make sure you have Terraform installed on your local machine.
- **AWS CLI Installed and Configured**: Ensure that the AWS CLI is installed and configured with the necessary AWS credentials.

## Input Variables

### `cluster_creation` Module

The following input variables can be customized for the `cluster_creation` module to configure the AWS EKS cluster and related resources:

- `aws_region` (string): AWS region for deployment.
- `aws_profile` (string): AWS CLI profile name.
- `vpc_name` (string): Name for the AWS VPC.
- `vpc_cidr` (string): VPC CIDR block.
- `igw_name` (string): Name for the Internet Gateway.
- `public_subnet_1_cidr` (string): Public Subnet 1 CIDR block.
- `public_subnet_2_cidr` (string): Public Subnet 2 CIDR block.
- `private_subnet_1_cidr` (string): Private Subnet 1 CIDR block.
- `private_subnet_2_cidr` (string): Private Subnet 2 CIDR block.
- `cluster_version` (string): EKS cluster version.
- `cluster_name` (string): Name of the AWS EKS cluster.
- `node_group_name` (string): Name of the EKS node group.
- `desired_size` (number): Desired capacity of the node Auto Scaling Group.
- `max_size` (number): Maximum size of the node Auto Scaling Group.
- `min_size` (number): Minimum size of the node Auto Scaling Group.
- `node_instance_type` (string): Instance type for EKS nodes.
- `node_volume_size` (number): Volume size for EKS nodes.
- `subnets` (list): List of subnets.
- `vpc_id` (string): VPC ID.
- `api_server_endpoint` (string): API server endpoint.
- `cluster_ca` (string): Cluster certificate authority.

### `self-managed-node` Module

The following input variables can be customized for the `self-managed-node` module to configure self-managed EKS nodes:

- `aws_region` (string): AWS region for deployment.
- `aws_profile` (string): AWS CLI profile name.
- `template_path` (string): Path to the CloudFormation template file.
- `stack_name` (string): Name of the CloudFormation stack.
- `cluster_name` (string): Name of the AWS EKS cluster.
- `cluster_security_group` (string): Security group for the cluster.
- `key_name` (string): Name of the SSH key pair used for EC2 instances.
- `desired_capacity` (number): Desired capacity of the node Auto Scaling Group.
- `max_size` (number): Maximum size of the node Auto Scaling Group.
- `min_size` (number): Minimum size of the node Auto Scaling Group.
- `node_group_name` (string): Name of the EKS node group.
- `node_image_id` (string): Custom image ID for EC2 instances, if needed.
- `node_image_id_ssm_param` (string): SSM parameter for getting the node image ID.
- `disable_imds_v1` (bool): Whether to disable IMDSv1 on EC2 instances.
- `node_instance_type` (string): Instance type for EKS nodes.
- `node_volume_size` (number): Volume size for EKS nodes.
- `subnets` (list): List of subnets.
- `vpc_id` (string): VPC ID.
- `api_server_endpoint` (string): API server endpoint.
- `cluster_ca` (string): Cluster certificate authority.

## Module Structure

The Terraform configuration is organized into modules, making it modular and maintainable:

- `cluster_creation`: Creates the AWS VPC, EKS cluster, and associated resources.
- `self-managed-node`: Deploys self-managed nodes in the EKS cluster.

## Module Usage

To use these modules, follow these steps:

1. Clone this repository to your local machine:

   ```shell
   git clone -b cluster-and-self-managed-node-creation https://github.com/nirmata/terraform-eks.git
   cd terraform-eks
   ```

2. Use a Terraform configuration file (e.g., `main.tf`) and include

 the necessary module blocks. For example:

   ```hcl
   module "cluster_creation" {
     source = "./cluster_creation"
     node_group = module.self-managed-node
   }

   module "self-managed-node" {
     source = "./self-managed-node/"
     cluster_name = module.cluster_creation.cluster_name
     aws_region = module.cluster_creation.aws_region
     aws_profile = module.cluster_creation.aws_profile
     cluster_security_group = module.cluster_creation.cluster_security_group
     vpc_id = module.cluster_creation.vpc_id
     subnets = module.cluster_creation.subnets
     api_server_endpoint = module.cluster_creation.api_server_endpoint
     cluster_ca  = module.cluster_creation.cluster_ca
   }
   ```

3. Customize the input variables as needed.

4. Initialize Terraform:

   ```shell
   terraform init
   ```

5. Go to the `cluster_creation` module and update the `variables.tf` file accordingly.

6. Go to the `self-managed-node` module and update the `variables.tf` file accordingly. Variables such as `cluster_name`, `cluster_security_group`, `subnets`, `vpc_id`, `api_server_endpoint`, and `cluster_ca` can be kept empty.

7. Apply the Terraform configuration:

   ```shell
   terraform apply
   ```

8. Follow the prompts to review and confirm the changes.

9. Once the Terraform provisioning is complete, your EKS cluster with self-managed nodes is ready.

## Verification

After deployment, verify the infrastructure by checking the AWS Management Console or using AWS CLI commands to ensure it matches your desired configuration.

