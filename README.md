# Terraform AWS EKS Nodegroup Configuration

This Terraform project automates the deployment and configuration of self-managed worker nodes for an existing Amazon EKS (Elastic Kubernetes Service) cluster using AWS CloudFormation. It also updates the `aws-auth` ConfigMap for node role mapping in Kubernetes.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- Terraform installed on your local machine.
- AWS CLI configured with appropriate credentials and the AWS profile with access to the target EKS cluster.
- An existing Amazon EKS cluster.
- An existing VPC and subnets in your AWS account.
- A valid EC2 Key Pair for SSH access.

## Shell Compatibility

This project can be executed in various shell environments, including:
- Git Bash
- Bash Shell
- Zsh Shell

Feel free to use your preferred shell for running Terraform commands.

## Usage

1. Clone this repository to your local machine.
    `git clone -b self-managed-node https://github.com/nirmata/terraform-eks.git`

2. Modify the `variables.tf` file to set your AWS region, node group name, and other configuration parameters. 

3. Run `terraform init` to initialize the Terraform working directory.

4. Run `terraform apply` to create the nodegroup for your existing EKS cluster.

## Clean-Up

To destroy the resources created by this Terraform project, run:

```sh
terraform destroy
```

## Configuration Variables

The following variables can be configured in the `variables.tf` file:

- `aws_region`: The AWS region where the nodegroup will be created.
- `cluster_name`: The name of your existing EKS cluster.
- `key_name`: The name of your EC2 Key Pair for SSH access.
- `desired_capacity`: The desired capacity of the node group.
- `max_size`: The maximum size of the node group.
- `min_size`: The minimum size of the node group.
- `node_group_name`: The name of the EKS node group.
- `node_image_id`: (Optional) The custom image ID for worker nodes.
- `node_image_id_ssm_param`: (Optional) The SSM parameter for the custom image ID.
- `disable_imds_v1`: (Optional) Whether to disable IMDSv1 on worker nodes.
- `node_instance_type`: The EC2 instance type for worker nodes.
- `node_volume_size`: The volume size for worker nodes.
- `subnets`: The IDs of the subnets where worker nodes will be launched.
- `vpc_id`: The ID of the VPC where the EKS cluster is located.
- `api_server_endpoint`: The API server endpoint for the EKS cluster.
- `cluster_ca`: The base64-encoded cluster certificate authority (CA).
- `template_path`: The path to the CloudFormation template file.

Make sure to set these variables according to your AWS environment and requirements. Ensure that the AWS profile used has access to the target EKS cluster.
```

