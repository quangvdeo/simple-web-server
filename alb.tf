module "alb_external" {
  source  = "terraform-aws-modules/alb/aws"

  name = "${var.project_name}-alb"

  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.web_elb.id, aws_security_group.remote_access.id]
  internal        = false

  listeners = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      forward = {
        target_group_key = "ec2-instance"
      }
    }
  ]

  target_groups = {
    ec2-instance = {
      name_prefix      = "ec2_web"
      protocol         = "HTTP"
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      target_id        = aws_instance.web.id
      port             = 80
    }
  }


  tags = var.tags
}