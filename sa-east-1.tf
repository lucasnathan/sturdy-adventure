resource "aws_instance" "cloud" {
  count         = "${terraform.workspace}" == "sa-east-1" ? 1 : 0
  provider      = aws.saopaulo
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  tags = {
    Name = "elasticsearch"
  }
}