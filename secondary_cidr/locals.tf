locals {
  secondary_subnets_map = { for subnet in var.secondary_subnets : subnet => subnet }
}

