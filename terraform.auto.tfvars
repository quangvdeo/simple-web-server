region="ap-southeast-1"
project_name="challenge2"
vpc_cidr = "10.28.0.0/16"
ec2_key_name="quang-luong-test"
ec2_instance_type="t3.micro"
public_subnets  = ["10.28.0.0/20", "10.28.16.0/20", "10.28.32.0/20"]
private_subnets = ["10.28.48.0/20", "10.28.64.0/20", "10.28.80.0/20"]
tags={
  Project="challenge2"
  Environment="development"
  TerraformManaged="true"
  Author="quang.luong"
}
