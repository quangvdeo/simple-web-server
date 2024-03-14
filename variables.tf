variable "region" {}
variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}
variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "ec2_instance_type" {}
variable "ec2_key_name" {}