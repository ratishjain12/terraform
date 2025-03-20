output "instance_public_ip" {
  description = "The public IP address of the nginx server"
  value = aws_instance.nginx-server.public_ip
}

output "instance_url"{
  description = "The URL of the nginx server"
  value = "http://${aws_instance.nginx-server.public_ip}"
}