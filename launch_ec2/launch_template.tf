
data "aws_ami" "fw" {
  //  AWS is owner
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = [local.current_ami_name]
  }
}


resource "aws_launch_template" "fw" {
  update_default_version = true

  image_id                = data.aws_ami.fw.id
  instance_type           = local.current_instance_type
  disable_api_termination = true
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {}))

  tag_specifications {
    resource_type = "instance"
    tags          = local.tags
  }
}

resource "aws_security_group" "fw" {
  name   = "fw_palo_alto"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
