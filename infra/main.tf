provider "aws" {
  region = var.region
}

# ECR Repo
resource "aws_ecr_repository" "devops_repo" {
  name = var.ecr_repo_name
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
}

# EKS Cluster
resource "aws_eks_cluster" "devops_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = "1.33"

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

# EKS Node Group
resource "aws_eks_node_group" "devops_nodes" {
  cluster_name    = aws_eks_cluster.devops_cluster.name
  node_group_name = "devops-task-nodes"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_desired
    max_size     = var.node_max
    min_size     = var.node_min
  }

  instance_types = [var.node_instance_type]
  disk_size      = 20

  ami_type = "AL2023_x86_64_STANDARD"
}
