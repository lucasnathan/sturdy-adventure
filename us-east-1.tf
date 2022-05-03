resource "aws_instance" "iot-sensors" {
  count         = "${terraform.workspace}" == "us-east-1" ? 3 : 0
  provider      = aws.virginia
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  tags = {
    Name = "iot-${count.index}"
  }
}

resource "aws_instance" "fog" {
  count         = "${terraform.workspace}" == "us-east-1" ? 1 : 0
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  tags = {
    Name = "logstash"
  }
}
