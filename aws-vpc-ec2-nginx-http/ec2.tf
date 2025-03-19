resource "aws_instance" "nginx-server" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "nginx-server"
  }
}