data "aws_ami" "LinuxMatias" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "EC2-MATIAS-MASTER" {
    ami = data.aws_ami.LinuxMatias.id
    instance_type = var.instance_type
    subnet_id = data.terraform_remote_state.vpc.outputs.private-subnet
    key_name = var.key
    vpc_security_group_ids = [aws_security_group.allow_ssh_2.id]
    tags = {
      Name = "EC2-MATIAS"
    }
}

resource "aws_security_group" "allow_ssh_2" {
    name = "Allow_ssh LinuxMatias"
    description = "Allows SSH inbound traffic"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc-id

    ingress {
        description = "SSH FROM VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::0/0"]
    }

    ingress {
        description = "HTTP FROM VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    // FOR DOCKER SWARM

    ingress {
        description = "DOCKER SWARM"
        from_port = 2377
        to_port = 2377
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "DOCKER SWARM"
        from_port = 7946
        to_port = 7946
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "DOCKER SWARM"
        from_port = 7946
        to_port = 7946
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "DOCKER SWARM"
        from_port = 4789
        to_port = 4789
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // FOR K8S

    ingress {
        description = "K8S"
        from_port = 6443
        to_port = 6443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "K8S"
        from_port = 10248
        to_port = 10248
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "Allow SSH 2"
    }

}