# terraform-aws-vpc-AUY1105-Grupo-4

Módulo reutilizable de Terraform para aprovisionar infraestructura de red en AWS. Este repositorio corresponde al módulo de redes de la Evaluación Parcial 2 de AUY1105 y está diseñado para ser consumido desde el repositorio principal de la Evaluación Parcial 1.

## Objetivo del repositorio

Este repositorio tiene como objetivo desacoplar la capa de red de la infraestructura principal, permitiendo reutilizar su configuración en distintos entornos y facilitando su integración desde un orquestador central.

## Propósito general del código Terraform

El código Terraform de este repositorio implementa un módulo de red para AWS que crea los componentes necesarios para la base de conectividad de la infraestructura:

- VPC.
- 2 subredes públicas.
- 2 subredes privadas.
- Internet Gateway.
- NAT Gateway con Elastic IP.
- Tablas de ruta públicas y privadas con sus asociaciones.
- Security Group para recursos de cómputo.

Este módulo fue construido para seguir buenas prácticas de modularidad, documentación y reutilización, tal como exige la evaluación.

## Requisitos

- Terraform `1.14.8`.
- Proveedor AWS `~> 6.40.0`.
- Credenciales AWS configuradas con permisos para crear recursos de red.
- Acceso a una cuenta de nube pública.

## Proveedor

- **Proveedor:** AWS
- **Región predeterminada:** `us-east-1`

## Estructura del repositorio

```bash
terraform-aws-vpc-AUY1105-Grupo-4/
├── README.md
├── CHANGELOG.md
├── .gitignore
├── examples/
│   ├── README.md
│   └── main.tf
└── vpc_module/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── versions.tf
```

### Descripción de carpetas y archivos

- `README.md`: documentación principal del repositorio.
- `CHANGELOG.md`: registro de cambios por versión.
- `.gitignore`: exclusión de archivos innecesarios, secretos y artefactos locales.
- `examples/`: ejemplo funcional de uso del módulo.
- `vpc_module/`: definición del módulo Terraform de red.

## Recursos implementados

El módulo define la infraestructura necesaria para la capa de red sobre AWS, considerando los siguientes requisitos técnicos:

- **VPC:** rango CIDR `10.1.0.0/16`.
- **Subredes públicas:** 2 subredes con máscara `/24`.
- **Subredes privadas:** 2 subredes con máscara `/24`.
- **Seguridad:** Security Group con acceso SSH restringido por IP y HTTP abierto.
- **Nomenclatura:** los recursos utilizan un prefijo basado en la variable `environment`.

## Variables principales

El módulo se encuentra parametrizado para facilitar su reutilización. Las variables principales son:

- `vpc_cidr`: rango CIDR de la VPC.
- `public_subnet_cidrs`: lista de CIDR para subredes públicas.
- `private_subnet_cidrs`: lista de CIDR para subredes privadas.
- `availability_zones`: zonas de disponibilidad a utilizar.
- `mi_ip_acceso`: dirección IP pública autorizada para acceso SSH.
- `environment`: prefijo para nombres y etiquetas de los recursos.

## Outputs del módulo

El módulo expone los siguientes outputs para ser utilizados desde el repositorio principal:

- `vpc_id`: ID de la VPC creada.
- `public_subnet_ids`: IDs de las subredes públicas.
- `private_subnet_ids`: IDs de las subredes privadas.
- `security_group_id`: ID del Security Group creado.

## Uso del módulo desde el repositorio principal

Para consumir este módulo desde el repositorio principal, se puede utilizar una referencia remota al repositorio GitHub:

```hcl
module "redes" {
  source = "git::https://github.com/Solange-sm/terraform-aws-vpc-AUY1105-Grupo-4.git//vpc_module?ref=dev-sm"

  mi_ip_acceso = var.mi_ip_acceso
}
```

## Ejemplo de uso con variables adicionales

```hcl
module "redes" {
  source = "git::https://github.com/Solange-sm/terraform-aws-vpc-AUY1105-Grupo-4.git//vpc_module?ref=dev-sm"

  mi_ip_acceso         = var.mi_ip_acceso
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  environment          = "AUY1105-appiac"
}
```

## Instrucciones básicas de uso

### Uso local con example

Desde la carpeta `examples/`, ejecutar:

```bash
terraform init
terraform plan
terraform apply
```

Para eliminar los recursos creados:

```bash
terraform destroy
```

## Consideraciones

- Este repositorio corresponde exclusivamente al módulo de redes.
- El repositorio principal actúa como orquestador central de la infraestructura.
- El módulo de cómputo se implementa en un repositorio separado, tal como indica la evaluación.

## Versionado

Este repositorio utiliza versionado semántico (`MAJOR.MINOR.PATCH`) para registrar la evolución del módulo. Cada cambio relevante debe quedar documentado en `CHANGELOG.md`, y las versiones publicadas deben asociarse a un tag y release en GitHub, por ejemplo `v1.0.0`.

## Documentación adicional

- `examples/README.md`: explicación del objetivo y uso del ejemplo funcional del módulo.
- `CHANGELOG.md`: historial de cambios del repositorio.