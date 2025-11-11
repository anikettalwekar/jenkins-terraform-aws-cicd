output "instance_id" {
  value = aws_instance.demo_server.id
}

output "instance_public_ip" {
  value = aws_instance.demo_server.public_ip
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
