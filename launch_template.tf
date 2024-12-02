resource "aws_launch_template" "instance_template" {
  name = "instance-template"

  image_id      = "ami-0df435f331839b2d6"
  instance_type = "t2.micro"
  key_name      = "ec2-key"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_lb.id]
  }

  user_data = filebase64("user-data.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "demo"
    }
  }
}