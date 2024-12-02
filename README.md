# One tier highly available AWS EC2 instances using Terraform

![architectural-diagram](/one-tier-architectural-diagram.png)

This Terraform project uses VPC, subnets, route tables, Internet gateway, security groups for load balancer and autoscale group, application load balancer, autoscale group, and launch template for the same.

The minimum instances is set to 1, desired capacity to 2 and maximum capacity to 3.

The DNS name is printed in the terminal, which opens a web page displaying the internet ip address of respective ec2 instances.

Since we use autoscale group, the unhealthy instances are replaced with a new instance of same launch template.