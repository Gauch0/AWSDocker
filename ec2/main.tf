
resource "aws_instance" "matias-master" {
    ami = "ami-04505e74c0741db8d"
    instance_type = var.instance_type
    subnet_id = data.terraform_remote_state.matiasvpc.outputs.public-subnet
    key_name = var.key
    vpc_security_group_ids = [aws_security_group.allow_ssh_2.id]
    user_data = file("./scripts/userdata.sh")
    tags = {
      Name = "EC2-MATIAS-MASTER"
    }
}

resource "aws_security_group" "allow_ssh_2" {
    name = "Allow_ssh LinuxMatias"
    description = "Allows SSH inbound traffic"
    vpc_id = data.terraform_remote_state.matiasvpc.outputs.vpc-id

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

    // FOR MYSQL

    ingress {
        description = "MYSQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // FOR API
    ingress {
      description = "API"
      from_port = 3000
      to_port = 3000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description = "UI"
      from_port = 8000
      to_port = 8000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }

    tags = {
      Name = "Allow SSH 2"
    }

}