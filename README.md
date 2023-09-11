# Terraform EKS Cluster with Custom Secondary CIDR

This repository contains Terraform modules for creating an Amazon Elastic Kubernetes Service (EKS) cluster with custom secondary CIDR blocks. You can use these modules to easily provision an EKS cluster in your AWS environment.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Module Usage](#module-usage)
- [Input Variables](#input-variables)
- [Outputs](#outputs)
- [Example Usage](#example-usage)
- [Module Structure](#module-structure)
- [Authors](#authors)
- [License](#license)

## Prerequisites

Before using these Terraform modules, ensure that you have the following prerequisites in place:

- [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed.
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured with the necessary AWS IAM credentials.
- Basic knowledge of Terraform and AWS.

## Module Usage

To use these modules, follow the steps below:

1. Clone this repository to your local machine.

2. Create a Terraform configuration file (e.g., `main.tf`) and include the necessary module blocks. For example:

   ```hcl
   module "cluster_creation" {
     source = "./cluster_creation"
     secondary_subnet = module.secondary_cidr.secondary_subnet
   }

   module "secondary_cidr" {
     source = "./secondary_cidr"
     cluster_name = module.cluster_creation.cluster_name
     eks_cluster_vpc_config = module.cluster_creation.eks_cluster_vpc_config
     vpc_id = module.cluster_creation.testVPC
   }
   ```

3. Customize the input variables as needed.

4. Initialize Terraform:

   ```bash
   terraform init
   ```

5. Go to cluster_creation module and update the `variable.tf` file accordingly.

6. Go to secondary_cidr module and update the `variable.tf` file accordingly.
   variable "vpc_id" can be kept empty

7. Apply the Terraform configuration:

   ```bash
   terraform apply
   ```

6. Follow the prompts to review and confirm the changes.

7. Once the Terraform provisioning is complete, your EKS cluster with custom secondary CIDR blocks will be ready.

## Input Variables

The following input variables can be customized when using the modules:

- `region` (string): This is the region where the resources will be deployed. Default: "us-east-1"

- `vpc_name` (string): Name for the AWS VPC. Default: "Test-VPC"

- `vpc-cidr` (string): VPC CIDR Block. Default: "10.14.0.0/16"

- `igw_name` (string): Name for the Internet Gateway. Default: "Test-IGW"

- `public-subnet-1-cidr` (string): Public Subnet 1 CIDR Block. Default: "10.14.1.0/24"

- `public-subnet-2-cidr` (string): Public Subnet 2 CIDR Block. Default: "10.14.2.0/24"

- `private-subnet-1-cidr` (string): Private Subnet 1 CIDR Block. Default: "10.14.3.0/24"

- `private-subnet-2-cidr` (string): Private Subnet 2 CIDR Block. Default: "10.14.4.0/24"

- `cluster_version` (string): The EKS Cluster Version. Default: "1.27"

- `cluster_name` (string): Name of the AWS EKS cluster. Default: "test-cluster"

- `node_group_name` (string): Name of the AWS EKS node group. Default: "test-cluster-ng"

- `secondary_subnet`: (No default value specified)

- `desired_size` (number): Number of instances in the node group. Default: 1

- `max_size` (number): Maximum number of instances in the node group. Default: 1

- `min_size` (number): Minimum number of instances in the node group. Default: 1

- `instance_types` (list of strings): List of EC2 instance types for the node group. Default: ["t2.small"]

- `kubernetes_namespace` (string): The Kubernetes namespace for the service account. Default: "default"

- `service_account_name` (string): The name of the Kubernetes service account. Default: "example-service-account"

- `secondary_cidr_blocks` (list of strings): List of secondary CIDR blocks to associate with the VPC. Default: ["10.1.0.0/24"]

- `secondary_subnets` (list of strings): List of secondary subnets to use with ENIConfig. Default: ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]


## Outputs

These modules provide the following outputs:

- `cluster_name`: Name of the created EKS cluster.
- `cluster_endpoint`: Endpoint URL of the EKS cluster.
- `cluster_security_group_id`: ID of the security group associated with the EKS cluster.

## Module Structure

This repository follows the following directory structure:

```
/
├── cluster_creation/
│   ├── main.tf
│   ├── data.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── outputs.tf
├── secondary_cidr/
│   ├── eniconfig.tf
│   ├── locals.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── outputs.tf
├── ...
```

Each module resides in its respective directory and includes a `main.tf`, `variables.tf`, and `outputs.tf` file.

## Authors

- [Vikash Kaushik](https://github.com/vikashkaushik01)

```

