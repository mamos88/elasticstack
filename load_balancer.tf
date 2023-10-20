resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elasticsearch-sg.id]
  subnets            = flatten([values(local.subnet_ids)])

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}


resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.elasticsearch-lab-vpc.id
  health_check {
    healthy_threshold   = var.health_check["healthy_threshold"]
    interval            = var.health_check["interval"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    timeout             = var.health_check["timeout"]
    path                = var.health_check["path"]
    port                = var.health_check["port"]
  }
  stickiness {
    type = "lb_cookie"
  }
}
