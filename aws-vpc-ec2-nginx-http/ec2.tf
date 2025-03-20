resource "aws_instance" "nginx-server" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true
  user_data     = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx 
              EOF
  tags = {
    Name = "nginx-server"
  }
}