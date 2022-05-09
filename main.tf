terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12"
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
  provider = aws.virginia
  tags = {
    Name = "iot-${count.index}"
  }
}

resource "aws_instance" "firewall" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  provider = aws.virginia
  tags = {
    Name = "ids"
  }
}

resource "aws_instance" "fog" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  provider = aws.virginia
  tags = {
    Name = "logstash"
  }
}

resource "aws_instance" "cloud" {
  ami           = "ami-0800f9916b7655289"
  instance_type = "t2.micro"
  provider = aws.saopaulo
  tags = {
    Name = "elasticsearch"
  }
}