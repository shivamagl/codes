provider "aws" {
  region     = "${var.region}"
}

resource "aws_security_group" "scalemonks-testing-sg" {
        name = "scalemonks-${var.environment}-sg"
        description = "Allow Traffic"
        vpc_id = "vpc-8a1627ec"
        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
}

resource "aws_instance" "testing" {
        ami = "ami-841f46ff"
        instance_type = "t2.micro"
        vpc_security_group_ids = ["${aws_security_group.scalemonks-testing-sg.id}"]
        availability_zone = "us-east-1c"
        subnet_id = "subnet-d99382f4"
        associate_public_ip_address = "true"
        iam_instance_profile = "Terraform-role"
        tags {
                Name = "terraform-${var.environment}"
                Environment = "${var.environment}"
        }
        key_name = "poc"
        provisioner "file" {
          source      = "/home/ubuntu/terraform-code/deploy.sh"
          destination = "/tmp/deploy.sh"


       connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key  = "${file("poc.pem")}"
        }
        }

       provisioner "remote-exec" {
       inline = [
       "chmod +x /tmp/deploy.sh",
       "/tmp/deploy.sh",
      ]

       connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key  = "${file("poc.pem")}"
        }
        
      }
      
}
