resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.cluster_name
}

resource "aws_ecs_service" "ecs-service" {
  name             = var.service_name
  cluster          = aws_ecs_cluster.ecs-cluster.id
  task_definition  = aws_ecs_task_definition.ecs-task-definition.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  network_configuration {
    subnets = var.subnets
    security_groups = [
      "sg-53a75422",
      aws_security_group.ecs-security_group.id
    ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                   = "ecs-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"


  container_definitions = <<EOL
[
  {
    "name": "nginx",
    "image": "nginx:1.14",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOL
}

resource "aws_security_group" "ecs-security_group" {
  name        = "ecs-sg"
  description = "sg for ecs"
  vpc_id      = var.vpc_id

  ingress {
    description = ""
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
