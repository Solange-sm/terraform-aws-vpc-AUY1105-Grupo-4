# ==============================================================================
# Módulo de Red - Evaluación Parcial 2
# Archivo: versions.tf
# ==============================================================================
terraform {
  required_version = ">= 1.14.8, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

