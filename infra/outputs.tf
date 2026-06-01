output "public_ip" {
  value = aws_instance.polyglot_vm.public_ip
}

output "public_dns" {
  value = aws_instance.polyglot_vm.public_dns
}