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

- `cluster_name`: Name of the EKS cluster.
- `eks_cluster_vpc_config`: VPC configuration for the EKS cluster.
- `vpc_id`: ID of the VPC in which the EKS cluster will be created.

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

Feel free to copy and paste this updated README into your GitHub repository, making sure to replace the existing README content with this new version. You can also customize it further if needed.