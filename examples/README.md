# Ejemplo de uso - Módulo VPC

Este directorio contiene un ejemplo funcional para implementar y validar el módulo de redes de forma aislada.

## Objetivo

Demostrar cómo consumir el módulo Terraform de redes para crear una VPC, subredes públicas y privadas, y un security group reutilizable.

## Prerrequisitos

- Terraform 1.14.8
- Credenciales AWS configuradas
- Región de trabajo: us-east-1

## Variables importantes

- `mi_ip_acceso`: IP pública autorizada para acceso SSH, en formato `X.X.X.X/32`

## Cómo ejecutar este ejemplo

1. Inicializar Terraform:

```bash
terraform init
```

2. Revisar el plan:

```bash
terraform plan
```

3. Aplicar la infraestructura:

```bash
terraform apply
```

## Outputs esperados

- `ejemplo_vpc_id`
- `ejemplo_subredes_publicas`
- `ejemplo_subredes_privadas`
- `ejemplo_security_group_id`

## Nota

La IP `200.12.34.56/32` es solo referencial. Debe reemplazarse por la IP pública real autorizada para el acceso SSH.