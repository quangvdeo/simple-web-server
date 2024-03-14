# How to
1. You must create new ec2 key pair, and put the name to the variable `ec2_key_name` on file `terraform.auto.tfvars`
   - Please ensure ec2 key pair is created in the region on vars file.
   - Update any variables on this file if you want.
2. Open `ec2.tf` file, un-comment line `19`, update your own AMI or using default `ubuntu AMI` if you want. 
    - Note: Default AMI does not intall any applications( including web server) and running in private subnet so cannot be ssh.
      - If you want to ssh, please change the subnet_id to public, and add more security group rules
3. To running project you need to execute:

```
terraform init
terraform plan
terraform apply
```
4. Run `terraform destroy` when you don't need these resources anymore.