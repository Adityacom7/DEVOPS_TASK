output "cluster_name" {
  value = aws_eks_cluster.devops_cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.devops_cluster.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.devops_cluster.arn
}

output "ecr_repo_url" {
  value = aws_ecr_repository.devops_repo.repository_url
}

output "nodegroup_name" {
  value = aws_eks_node_group.devops_nodes.node_group_name
}
