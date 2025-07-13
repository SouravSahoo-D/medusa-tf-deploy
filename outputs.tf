output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "service_name" {
  value = aws_ecs_service.medusa_service.name
}

output "ecr_repo_url" {
  value = aws_ecr_repository.medusa_ecr.repository_url
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.medusa_task.arn
}
