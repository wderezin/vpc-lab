
resource "aws_autoscaling_group" "app" {
  name = local.all_tags["name"]

  min_size = 1
  max_size = 5

  vpc_zone_identifier = local.public_subnet_ids

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy                 = "lowest-price"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.app.id
        version            = aws_launch_template.app.latest_version
        // version            = "$Latest"
      }
      override {
        instance_type = "t3a.${local.instance_size}"
      }
      override {
        instance_type = "t3.${local.instance_size}"
      }
      override {
        instance_type = "t2.${local.instance_size}"
      }
    }
  }

}
