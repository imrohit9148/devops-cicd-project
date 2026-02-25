provider "aws" {
  region = "ap-south-1"
}

# ---------------- SECURITY GROUP ----------------

resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH and Jenkins"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "K8s API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------------- JENKINS SERVER ----------------

resource "aws_instance" "jenkins" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t3.micro"
  key_name               = "devops"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "jenkins-server"
  }
}

# ---------------- K8S SERVER ----------------

resource "aws_instance" "k8s" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t3.micro"
  key_name               = "devops"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "k8s-server"
  }
}

# ---------------- OUTPUTS ----------------

output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
}

output "k8s_ip" {
  value = aws_instance.k8s.public_ip
}
