# ==============================================================================
# Ejemplo de Implementación Básica - Módulo VPC
# ==============================================================================

# Nota: Este código es solo para fines de demostración. 
# En un entorno real, los valores se ajustan según la topología de red requerida.

module "vpc_basica" {
    # Apunta a la raíz del repositorio local
    source = "../vpc_module"
    
    # Parámetro obligatorio de seguridad
    mi_ip_acceso = "200.12.34.56/32"

    # Parámetros opcionales para la personalización de la red de pruebas
    vpc_cidr             = "10.1.0.0/16"
    public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
    private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
    
    # Etiquetado estándar para el entorno de pruebas
    environment          = "AUY1105-test"
}

# Outputs del Ejemplo para Validar la Entrega 
output "ejemplo_vpc_id" {
    description = "ID de la VPC generada en el ejemplo"
    value       = module.vpc_basica.vpc_id
}

output "ejemplo_subredes_publicas" {
    description = "Lista de IDs de las subredes públicas mapeadas"
    value       = module.vpc_basica.public_subnet_ids
}

output "ejemplo_security_group_id" {
    description = "ID del Security Group perimetral configurado"
    value       = module.vpc_basica.security_group_id
}