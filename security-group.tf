resource "aws_security_group" "web_elb" {
  name        = "${var.project_name}-web-for-elb"
  description = "Allow web all traffic"
  vpc_id      = module.vpc.vpc_id

  tags = var.tags
}

resource "aws_security_group" "web_ec2" {
  name        = "${var.project_name}-web-for-ec2"
  description = "Allow web traffic from security groups of elb"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow access from elb security groups"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.web_elb.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}


resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web_elb.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.web_elb.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# FOR SECURITY: If someone want to SSH access, please manualy change CIDR block in AWS console
resource "aws_security_group" "remote_access" {
  name_prefix = "${var.project_name}-remote-access"
  description = "Allow remote SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}
