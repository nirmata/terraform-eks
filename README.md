# Terraform AWS EKS Cluster Configuration

This Terraform project automates the deployment and configuration of an Amazon EKS (Elastic Kubernetes Service) cluster's worker nodes using AWS CloudFormation and updates the `aws-auth` ConfigMap for node role mapping in Kubernetes.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- Terraform installed on your local machine.
- AWS CLI configured with appropriate credentials.
- An existing VPC and subnets in your AWS account.
- A valid EC2 Key Pair for SSH access.

## Usage

1. Clone this repository to your local machine.

2. Modify the `variables.tf` file to set your AWS region, cluster name, and other configuration parameters.

3. Run `terraform init` to initialize the Terraform working directory.

4. Run `terraform apply` to create the nodegroup.


## Clean-Up

To destroy the resources created by this Terraform project, run:

```sh
terraform destroy
```

