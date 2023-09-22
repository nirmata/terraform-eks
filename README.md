## Terraform Module Structure

This repository is organized into two main Terraform modules:

### Cluster Creation Module

The `cluster_creation` module sets up the AWS EKS cluster along with its associated resources. It includes the following configuration files:

- `cluster_creation/main.tf`: Defines the AWS resources required for the EKS cluster.
- `cluster_creation/variables.tf`: Declares input variables for the `cluster_creation` module.
- `cluster_creation/outputs.tf`: Specifies the output values to be used by other modules.

To use this module, follow these steps:

1. Create a directory for your Terraform configurations.

2. Create a `.tf` file (e.g., `main.tf`) in your directory and instantiate the `cluster_creation` module as shown below:

   ```hcl
   module "cluster_creation" {
     source = "./cluster_creation"
     node_group = module.self-managed-node
   }
   ```

3. Customize the variables in your `variables.tf` file or through environment variables.
## Variables for Cluster Creation Module

- **AWS Region:** `aws_region` (Default: `"us-east-1"`)
- **AWS Profile:** `aws_profile` (Default: `"default"`)
- **VPC Name:** `vpc_name` (Default: `"Test-VPC"`)
- **VPC CIDR Block:** `vpc-cidr` (Default: `"10.14.0.0/16"`)
- **Internet Gateway Name:** `igw_name` (Default: `"Test-IGW"`)
- **Cluster Version:** `cluster_version` (Default: `"1.25"`)
- **Cluster Name:** `cluster_name` (Default: `"test-cluster"`)
- **Node Group Name:** `node_group_name` (Default: `"test-cluster-ng"`)
- **Desired Node Group Size:** `desired_size` (Default: `1`)
- **Maximum Node Group Size:** `max_size` (Default: `1`)
- **Minimum Node Group Size:** `min_size` (Default: `1`)
- **Node Instance Types:** `instance_types` (Default: `["t2.small"]`)
- **Kubernetes Namespace:** `kubernetes_namespace` (Default: `"default"`)
- **Service Account Name:** `service_account_name` (Default: `"example-service-account"`)
- **Node Group:** `node_group`

Please adjust these variables to match your AWS and Kubernetes configuration requirements.


### Self-Managed Node Module

The `self-managed-node` module provisions self-managed worker nodes for the EKS cluster. It includes the following configuration files:

- `self-managed-node/main.tf`: Defines the resources required for the self-managed nodes.
- `self-managed-node/variables.tf`: Declares input variables for the `self-managed-node` module.

To use this module, follow these steps:

1. Create a directory for your Terraform configurations.

2. Create a `.tf` file (e.g., `main.tf`) in your directory and instantiate the `self-managed-node` module as shown below:

   ```hcl
   module "self-managed-node" {
     source = "./self-managed-node/"
     cluster_name = module.cluster_creation.cluster_name
     aws_region = module.cluster_creation.aws_region
     aws_profile = module.cluster_creation.aws_profile
     cluster_security_group = module.cluster_creation.cluster_security_group
     vpc_id = module.cluster_creation.vpc_id
     subnets = module.cluster_creation.subnets
     api_server_endpoint = module.cluster_creation.api_server_endpoint
     cluster_ca = module.cluster_creation.cluster_ca
   }
   ```

3. Customize the variables in your `variables.tf` file or through environment variables.
## Variables for Self-Managed Node Module

- **AWS Region:** `aws_region`
- **AWS Profile:** `aws_profile`
- **Template Path:** `template_path` (Default: `"cf-template-for-node-group.yaml"`)
- **Stack Name:** `stack_name` (Default: `"us-stack"`)
- **Cluster Name:** `cluster_name`
- **Cluster Security Group:** `cluster_security_group`
- **SSH Key Name:** `key_name` (Default: `"vikash-east"`)
- **Desired Capacity:** `desired_capacity` (Default: `1`)
- **Max Size:** `max_size` (Default: `2`)
- **Min Size:** `min_size` (Default: `1`)
- **Node Group Name:** `node_group_name` (Default: `"nodeaks"`)
- **Custom Node Image ID:** `node_image_id`
- **Node Image ID SSM Param:** `node_image_id_ssm_param` (Default: `"/aws/service/eks/optimized-ami/1.23/amazon-linux-2/recommended/image_id"`)
- **Disable IMDSv1:** `disable_imds_v1` (Default: `false`)
- **Node Instance Type:** `node_instance_type` (Default: `"t3.medium"`)
- **Node Volume Size:** `node_volume_size` (Default: `20`)
- **Subnets:** `subnets`
- **VPC ID:** `vpc_id`
- **API Server Endpoint:** `api_server_endpoint`
- **Cluster CA:** `cluster_ca`

Please customize these variables to match your AWS and Kubernetes configuration requirements.



```

