# Associate secondary CIDR blocks with the VPC
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr_associations" {
  count   = length(var.secondary_cidr_blocks)
  vpc_id  = var.vpc_id
  cidr_block = var.secondary_cidr_blocks[count.index]
}

# Create subnets within the secondary CIDR blocks for pods
resource "aws_subnet" "secondary_subnet" {
  count = length(var.secondary_cidr_blocks)
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.secondary_cidr_blocks, count.index)
  availability_zone       = element(var.secondary_subnets, count.index)
  map_public_ip_on_launch = false  # Adjust as needed

  tags = {
    Name = "Pod-Subnet-${count.index + 1}"
  }
}


