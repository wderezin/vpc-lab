
resource "aws_launch_template" "app" {
  name     = local.all_tags["name"]
  image_id = data.aws_ami.app-ami.id

  instance_type = "t3a.micro"

  update_default_version = true
  #  vpc_security_group_ids = [aws_security_group.lb-app.id]

  // filebase64
  user_data = filebase64("${path.module}/user-data.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.lb-app.id, aws_security_group.ssh.id]
  }

  # Advanced Monitoring Metrics
  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.all_tags
  }
}

resource "aws_security_group" "ssh" {
  name   = "${local.all_tags["name"]}-ssh"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
