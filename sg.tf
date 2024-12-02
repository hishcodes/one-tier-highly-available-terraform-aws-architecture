resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "SG for ALB"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "HTTP from IGW"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ports from ALB to internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "asg_lb" {
  name        = "asg-lb"
  description = "SG for ASG"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow all ports from ASG to internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}