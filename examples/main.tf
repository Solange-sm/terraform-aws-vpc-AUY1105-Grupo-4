# ==============================================================================
# Evaluación Parcial 2 - Infraestructura como Código II (AUY1105)
# Ejemplo Funcional de Implementación del Módulo de VPC
# ==============================================================================

# 1. Configuración de Requisitos de Versión 
terraform {
  required_version = "1.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.40.0"
    }
  }
}

# 2. Configuración del Proveedor
provider "aws" {
  region = "us-east-1"
}

# 3. Llamada de Ejemplo al Módulo de Redes
module "vpc_redes_ejemplo" {
  
  source = "../vpc_module"

  # Parámetro obligatorio: Dirección IP pública para el acceso SSH restringido
  mi_ip_acceso = "200.12.34.56/32"

  # Parámetros opcionales (Personalización de rangos si se desea sobrescribir el default)
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  
  # Etiquetado estándar para el entorno de pruebas
  environment          = "AUY1105-appiac-ejemplo"
}

# 4. Outputs del Ejemplo para Validar la Entrega 
output "ejemplo_vpc_id" {
  description = "ID de la VPC generada en el ejemplo"
  value       = module.vpc_redes_ejemplo.vpc_id
}

output "ejemplo_subredes_publicas" {
  description = "Lista de IDs de las subredes públicas mapeadas"
  value       = module.vpc_redes_ejemplo.public_subnet_ids
}

output "ejemplo_security_group_id" {
  description = "ID del Security Group perimetral configurado"
  value       = module.vpc_redes_ejemplo.security_group_id
}