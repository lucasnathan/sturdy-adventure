resource "aws_instance" "firewall" {
  count         = var.create_firewall ? 1 : 0
  provider      = "${terraform.workspace}" == "us-east-1" ? aws.virginia : aws.saopaulo
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  tags = {
    Name = "ids"
  }
}