provider "aws" {
  region                  = "ap-south-1"
  profile                 = "terraformprofile"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP_CONNECT"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH_CONNECT"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

output "myoutsgname" {

 	value = aws_security_group.allow_http.name
}

resource "null_resource" "nulllocal1"  {

depends_on = [
    aws_security_group.allow_http
  ]
	provisioner "local-exec" {
	    command = "aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem"
  	}
}

