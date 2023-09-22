resource "aws_cloudformation_stack" "example" {
  name = var.stack_name  # Replace with your desired stack name
  template_body = file("${path.module}/${var.template_path}")
  
  # Parameters if your CloudFormation template requires them
  parameters = {
    ClusterName                     = var.cluster_name
    ClusterControlPlaneSecurityGroup = var.cluster_security_group
    KeyName                         = var.key_name
    NodeAutoScalingGroupDesiredCapacity = var.desired_capacity
    NodeAutoScalingGroupMaxSize       = var.max_size
    NodeAutoScalingGroupMinSize       = var.min_size
    NodeGroupName                    = var.node_group_name
    NodeImageId                      = var.node_image_id  # Provide your custom image ID if needed
    NodeImageIdSSMParam              = var.node_image_id_ssm_param
    DisableIMDSv1                   = var.disable_imds_v1
    NodeInstanceType                 = var.node_instance_type
    NodeVolumeSize                   = var.node_volume_size
    # Subnets                          = var.subnets
    Subnets                          = join(", ", var.subnets) 
    VpcId                            = var.vpc_id
    APIServerEndpoint                = var.api_server_endpoint  # Add your API server endpoint variable
    ClusterCA                        = var.cluster_ca  # Add your cluster CA variable
  }

  capabilities = ["CAPABILITY_IAM"]  # Specify capabilities if needed
}


resource "local_file" "aws-auth" {
  filename = "${path.module}/aws-auth-configmap.yaml"
  content = <<-EOT
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: aws-auth
      namespace: kube-system
    data:
      mapRoles: |
        - rolearn: $NODE_ROLE_ARN
          username: system:node:{{EC2PrivateDNSName}}
          groups:
            - system:bootstrappers
            - system:nodes
      mapUsers: ""
  EOT
}




resource "null_resource" "update_aws_auth" {
  depends_on = [aws_cloudformation_stack.example]
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Get the NodeInstanceRole ARN from the AWS CloudFormation output
      NODE_ROLE_ARN=$(aws cloudformation describe-stacks --stack-name ${aws_cloudformation_stack.example.name} --query "Stacks[0].Outputs[?OutputKey=='NodeInstanceRole'].OutputValue" --output text --region ${var.aws_region} --profile ${var.aws_profile})
      echo $NODE_ROLE_ARN

      # Set the current context for kubectl to interact with the EKS cluster
      aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name} --profile ${var.aws_profile}

      # Verify the context has been set
      kubectl config current-context

      kubectl create -f ${path.module}/aws-auth-configmap.yaml


      # Get the current mapRoles and mapUsers configuration and save it to a file
      kubectl get configmap/aws-auth -n kube-system -o jsonpath='{.data.mapRoles}' > current-maproles.yaml
      kubectl get configmap/aws-auth -n kube-system -o jsonpath='{.data.mapUsers}' > current-mapusers.yaml

      # Create a new YAML snippet for the role you want to append
      cat <<EOF >> current-maproles.yaml
- groups:
  - system:bootstrappers
  - system:nodes
  rolearn: $NODE_ROLE_ARN
  username: system:node:{{EC2PrivateDNSName}}
EOF

      # Apply the updated mapRoles configuration using kubectl apply
      kubectl create configmap aws-auth -n kube-system --from-file=mapRoles=current-maproles.yaml,mapUsers=current-mapusers.yaml -o yaml --dry-run=client | kubectl replace -n kube-system -f -

      # Clean up temporary files
      rm current-maproles.yaml current-mapusers.yaml
    EOT
  }
}
