resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "medusa"
      image     = "${aws_ecr_repository.medusa_ecr.repository_url}:latest"
      portMappings = [
        {
          containerPort = 9000
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name  = "DATABASE_URL"
          value = "postgres://postgres:postgres@localhost:5432/medusa"
        },
        {
          name  = "REDIS_URL"
          value = "redis://localhost:6379"
        }
      ],
      essential = true
    },
    {
      name  = "postgres"
      image = "postgres:15-alpine",
      portMappings = [
        {
          containerPort = 5432
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name  = "POSTGRES_USER"
          value = "postgres"
        },
        {
          name  = "POSTGRES_PASSWORD"
          value = "postgres"
        },
        {
          name  = "POSTGRES_DB"
          value = "medusa"
        }
      ],
      essential = true
    },
    {
      name  = "redis"
      image = "valkey/valkey:7.2-alpine",
      portMappings = [
        {
          containerPort = 6379
          protocol      = "tcp"
        }
      ],
      essential = true
    }
  ])
}
