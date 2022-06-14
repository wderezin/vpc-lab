
resource "aws_autoscaling_group" "app" {
  name = local.all_tags["name"]

  min_size         = 2
  max_size         = 5
  desired_capacity = 2

  //  Trigger refresh when template changes
  instance_refresh {
    strategy = "Rolling"
  }

  vpc_zone_identifier = local.public_subnet_ids
  health_check_type   = "ELB"
  target_group_arns   = [aws_lb_target_group.front_end.arn]

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

  lifecycle {
    ignore_changes = [desired_capacity] # [ load_balancers, target_group_arns]
  }

}
