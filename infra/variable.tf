variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "Devops_tas-clusterk"
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  default     = "arn:aws:iam::975050277554:role/AmazonEKSAutoNodeRole"
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS nodes"
  default     = "arn:aws:iam::975050277554:role/adieksnode"
}

variable "subnet_ids" {
  description = "Subnets for the cluster and node group"
  type        = list(string)
  default     = [
    "subnet-041ec962e92eca6ac",
    "subnet-0368a5018ee5dbab9",
    "subnet-00f008188269e4dbf"
  ]
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  default     = "t3.medium"
}

variable "node_min" {
  default = 1
}

variable "node_max" {
  default = 3
}

variable "node_desired" {
  default = 2
}

variable "ecr_repo_name" {
  description = "ECR Repository name"
  default     = "devops-task"
}
