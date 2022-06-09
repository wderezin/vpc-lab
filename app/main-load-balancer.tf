
resource "aws_security_group" "lb-app" {
  name   = "${local.all_tags["name"]}-lb-app"
  vpc_id = local.vpc_id

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    #    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }
}

resource "aws_security_group" "public-lb" {
  name = "${local.all_tags["name"]}-public-lb"

  ingress {
    from_port        = 80
    protocol         = "tcp"
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "app-lb" {
  name               = local.all_tags["name"]
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-app.id, aws_security_group.public-lb.id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false

  tags = local.all_tags
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "front_end" {
  name     = local.all_tags["name"]
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}
