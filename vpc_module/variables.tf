variable "vpc_cidr" {
  description = "Rango CIDR para la VPC principal"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subredes públicas"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subredes privadas"
  type        = list(string)
  default     = ["10.1.3.0/24", "10.1.4.0/24"]
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad a utilizar"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "mi_ip_acceso" {
  description = "Dirección IP pública autorizada para el acceso SSH (Formato: X.X.X.X/32)"
  type        = string
  # Sin default para obligar al orquestador principal a inyectarla por seguridad
}

variable "environment" {
  description = "Prefijo para nomenclatura y tags de los recursos (ej: AUY1105-appiac)"
  type        = string
  default     = "AUY1105-appiac"
}