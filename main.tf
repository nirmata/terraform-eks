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