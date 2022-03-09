data "aws_ami" "LinuxMatias" {
  most_recent = true
  
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "Ec2-Matias" {
	# get ubuntu AMI id
    ami = data.aws_ami.LinuxMatias.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.private_subnet_1.id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.allow_ssh_2.id]
    tags = {
      Name = "Linux Matias"
    }
}

