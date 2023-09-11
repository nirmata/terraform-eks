resource "kubectl_manifest" "eniconfig" {
  # for_each  = var.
  for_each  = toset(var.secondary_subnets)
  yaml_body = <<-YAML
  apiVersion: crd.k8s.amazonaws.com/v1alpha1
  kind: ENIConfig
  metadata: 
    name: ${each.value}
    namespace: default
  spec: 
    securityGroups: 
      - ${var.eks_cluster_vpc_config[0].cluster_security_group_id}  # Use your cluster security group ID here
    # subnet: ${lookup(local.secondary_subnets_map, each.value, null)}
    subnet: ${each.value}
  YAML
}


resource "null_resource" "enable_custom_networking" {
  provisioner "local-exec" {
    command = "kubectl set env daemonset aws-node -n kube-system AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG=true ENI_CONFIG_LABEL_DEF=topology.kubernetes.io/zone"
  }
}