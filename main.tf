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