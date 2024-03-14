data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240207*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
    # Use your AMI here
    # ami           = data.aws_ami.ubuntu.id
    instance_type = "${var.ec2_instance_type}"
    subnet_id     = module.vpc.private_subnets[0]
    vpc_security_group_ids = [aws_security_group.web_ec2.id]
    key_name = "${var.ec2_key_name}"

    tags = var.tags
}