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
resource "aws_network_interface" "ec2_private" {
  subnet_id       = module.vpc.private_subnets[0]
  private_ip_list_enabled = true
  private_ip_list = [module.vpc.private_subnets_cidr_blocks[0]]
  security_groups = [aws_security_group.web_ec2.id, aws_security_group.remote_access.id]

}
resource "aws_instance" "web" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "${var.ec2_instance_type}"
    key_name = "${var.ec2_key_name}"
    network_interface {
        network_interface_id = aws_network_interface.ec2_private.id
        device_index         = 0
    }
    tags = var.tags
}