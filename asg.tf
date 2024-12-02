resource "aws_autoscaling_group" "asg" {
  name = "asg"

  max_size         = 3
  min_size         = 1
  desired_capacity = 2

  vpc_zone_identifier = [aws_subnet.pub_sub_1.id, aws_subnet.pub_sub_2.id]
  health_check_type   = "EC2"
  target_group_arns   = [aws_lb_target_group.my_tg.arn]

  launch_template {
    id      = aws_launch_template.instance_template.id
    version = aws_launch_template.instance_template.latest_version
  }
}