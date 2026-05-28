output "vpc_id" {
  description = "El ID de la VPC creada"
  value       = aws_vpc.mi_vpc.id
}

output "public_subnet_ids" {
  description = "Lista con los IDs de las subredes públicas creadas"
  value       = [aws_subnet.subnet_publica_1.id, aws_subnet.subnet_publica_2.id]
}

output "private_subnet_ids" {
  description = "Lista con los IDs de las subredes privadas creadas"
  value       = [aws_subnet.subnet_privada_1.id, aws_subnet.subnet_privada_2.id]
}

output "security_group_id" {
  description = "El ID del Security Group configurado para los recursos de cómputo"
  value       = aws_security_group.sg_computo.id
}