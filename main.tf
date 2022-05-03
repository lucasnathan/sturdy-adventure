terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  alias = "virginia"

  region  = "us-east-1"
}

provider "aws" {
  alias           = "saopaulo"

  region          = "sa-east-1"
}

resource "aws_instance" "iot-sensors" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  count = 3

  tags = {
    Name = "iot-${count.index}"
  }
}

resource "aws_instance" "firewall" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"

  tags = {
    Name = "ids"
  }
}

resource "aws_instance" "fog" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  
  tags = {
    Name = "logstash"
  }
}

module "cloud" {
  source            = "./modules/ec2"
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  providers = {
    aws = aws.saopaulo
  }
  tags = {
    Name = "elasticsearch"
  }
}