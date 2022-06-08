
resource "aws_launch_template" "app" {
  name     = local.all_tags["name"]
  image_id = data.aws_ami.app-ami.id

  instance_type = "t3a.micro"

  update_default_version = true

  #  network_interfaces {
  #    subnet_id = ""
  #    security_groups = []
  #  }

  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.all_tags
  }

}
