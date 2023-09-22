#Create VPC
resource "aws_vpc" "testVPC" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = var.vpc_name
  }
}


# Create Internet Gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.testVPC.id

  tags = {
    Name = var.igw_name
  }
}



#Create Public Subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.testVPC.id
  cidr_block              = var.public-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "Public-Subnet-1"
  }
}


#Create Public Subnet 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.testVPC.id
  cidr_block              = var.public-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true


  tags = {
    Name = "Public-Subnet-2"
  }
}


#Create Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.testVPC.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }


  tags = {
    Name = "Public-Route-Table"
  }
}


#Create Association with Public Route table and public subnet 1
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}


#Create Association with Public Route table and public subnet 2
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}


# Create Private Subnet 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.testVPC.id
  cidr_block              = var.private-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false


  tags = {
    Name = "Private-Subnet-1"
  }
}


# Create Private Subnet 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.testVPC.id
  cidr_block              = var.private-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false


  tags = {
    Name = "Private-Subnet-2"
  }
}


# Create EIP for NAT Gateway
resource "aws_eip" "eip-for-nat-gateway" {
  # vpc = true
  domain = "vpc"
  tags = {
    Name = "EIP-for-Test-NAT-Gateway"
  }
}


# Create NAT Gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip-for-nat-gateway.id
  subnet_id     = aws_subnet.public-subnet-1.id


  tags = {
    Name = "Test-Nat-Gateway"
  }
}


# Create Private Route Table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.testVPC.id


  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }


  tags = {
    Name = "Private Route Table"
  }
}


#Create Association with Private Route Table and private subnet 1
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}


#Create Association with Private Route Table and private subnet 2
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

#Create Association with Private Route Table and private subnet 2
# resource "aws_route_table_association" "secondary-subnet-route-table-association" {
#   subnet_id      = var.secondary_subnet[0]
#   # subnet_id = concat(var.secondary_subnet)
#   route_table_id = aws_route_table.private-route-table.id
# }

# NACL Allow all
resource "aws_network_acl" "name" {
  vpc_id = aws_vpc.testVPC.id
  ingress {
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    rule_no    = 100
    from_port  = 0
    to_port    = 0
    action     = "allow"
  }
  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}


# ELB Traffic SG
resource "aws_security_group" "traffic-elb" {
  name        = "allow http and https traffic from elb"
  description = "security group to allow http and https traffic from ELB"
  vpc_id      = aws_vpc.testVPC.id
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "http traffic"
    from_port        = 80
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    to_port          = 80
  }
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "https traffic ip"
    from_port        = 443
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    to_port          = 443
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All Traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    "Name" = "allow-http-https-elb"
  }
}


#VPN security group
resource "aws_security_group" "VPN-sg" {
  name        = "VPN-sg"
  description = "security group for VPN"
  vpc_id      = aws_vpc.testVPC.id
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "http traffic"
    from_port        = 80
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    to_port          = 80
  }
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "https traffic"
    from_port        = 443
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    to_port          = 443
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "VPN port"
    from_port   = 11954
    protocol    = "udp"
    to_port     = 11954
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All Traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    "Name" = "VPN-sg"
  }
}


#EKS CLuster and roles needed


resource "aws_iam_role" "eks-iam-role" {
  name               = "eks-iam-role"
  path               = "/"
  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Principal": {
               "Service": [
                   "lambda.amazonaws.com",
                   "eks.amazonaws.com",
                   "ec2.amazonaws.com",
                   "resources.cloudformation.amazonaws.com"
               ]
           },
           "Action": "sts:AssumeRole"
       }
   ]
}


EOF


}


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.id
}


resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role = aws_iam_role.eks-iam-role.id
}


resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-iam-role.id
}


resource "aws_eks_cluster" "test-cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks-iam-role.arn
  vpc_config {
    # subnet_ids = concat([aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id],var.secondary_subnet)
    subnet_ids = concat([aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id])
  }
  depends_on = [
    aws_iam_role.eks-iam-role,
  ]
}

resource "null_resource" "get_oidc_url" {
  triggers = {
    cluster_id = aws_eks_cluster.test-cluster.id
  }

  provisioner "local-exec" {
    command = <<-EOT
      oidc_url=$(aws eks describe-cluster --name ${self.triggers.cluster_id} --query "cluster.identity.oidc.issuer" --output text)
      echo "eks_oidc_url = \"$oidc_url\"" > terraform.tfvars
    EOT
  }

  depends_on = [aws_eks_cluster.test-cluster]
}


resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates.0.sha1_fingerprint]
  url = aws_eks_cluster.test-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "example_sa_role" {
  name = "example-service-account-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity",
      Effect = "Allow",
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks_oidc.arn
      },
      Condition = {
        StringEquals = {
          "${aws_eks_cluster.test-cluster.identity[0].oidc[0].issuer}:sub" = "system:serviceaccount:${var.kubernetes_namespace}:${var.service_account_name}"
        }
      }
    }]
  })
}



#EKS add-ons
resource "aws_eks_addon" "vpc-cni" {
  addon_name   = "vpc-cni"
  cluster_name = aws_eks_cluster.test-cluster.id
}


resource "aws_eks_addon" "coredns" {
  addon_name   = "coredns"
  cluster_name = aws_eks_cluster.test-cluster.id

  depends_on = [var.node_group]
}


resource "aws_eks_addon" "kube-proxy" {
  addon_name   = "kube-proxy"
  cluster_name = aws_eks_cluster.test-cluster.id
}

resource "aws_iam_role" "workernode-role" {
  name = "workernode-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workernode-role.id
}


resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workernode-role.name
}


resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workernode-role.id
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [aws_eks_cluster.test-cluster]
}
