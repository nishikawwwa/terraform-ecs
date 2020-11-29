resource "aws_lb" "ecs_alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
      "sg-53a75422",
      aws_security_group.ecs_security_group_for_alb.id
      ]
  subnets            = var.subnets
}

resource "aws_lb_target_group" "ecs_alb_target_group" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_alb_target_group.arn
  }
}

resource "aws_security_group" "ecs_security_group_for_alb" {
  name        = "alb-sg"
  description = "sg for alb"
  vpc_id      = var.vpc_id

  ingress {
    description = ""
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
