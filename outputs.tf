################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_arn
}

output "cluster_name" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_id
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
}

################################################################################
# Private Subnets
################################################################################

output "subnet_ids_starting_with_100" {
  description = "Secondary CIDR Private Subnet IDs for EKS Data Plane"
  value       = compact([for subnet_id, cidr_block in zipmap(module.vpc.private_subnets, module.vpc.private_subnets_cidr_blocks) : substr(cidr_block, 0, 4) == "100." ? subnet_id : null])
}
