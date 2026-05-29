# Módulo Terraform: AWS VPC (Grupo 4)

**Integrantes:** Marysabel Aedo, Solange Milla

## Objetivos y Propósito General
El propósito de este módulo es proveer una arquitectura de red aislada, altamente disponible y segura dentro de Amazon Web Services (AWS). Sigue las mejores prácticas de codificación de Terraform, desacoplando la capa de redes para que sea completamente reutilizable e integrable en distintos entornos de forma independiente.

---

## Recursos Creados por el Módulo
Este módulo automatiza la creación y configuración de los siguientes recursos de infraestructura:
* **VPC:** Red virtual principal parametrizada por bloques CIDR.
* **Subredes:** 2 Subredes Públicas y 2 Subredes Privadas distribuidas en distintas Zonas de Disponibilidad para alta disponibilidad.
* **Internet Gateway (IGW):** Permite la comunicación de salida hacia Internet para los recursos públicos.
* **NAT Gateway:** Configurado con una *Elastic IP (EIP)* para permitir que los recursos en subredes privadas accedan a servicios externos de forma segura sin exponerse.
* **Tablas de Ruteo:** Tablas públicas y privadas con sus respectivas asociaciones y reglas de enrutamiento.
* **Security Groups:** * Un Security Group perimetral para recursos de cómputo (Apertura controlada de puertos 22 y 80 con restricción por IP).
  * Un Default Security Group de la VPC completamente restringido por políticas de Hardening.
* **Flow Logs:** Activados a nivel de VPC para la auditoría, monitoreo y diagnóstico del tráfico de la red.

---

## Parámetros Configurables (Variables)
El módulo se encuentra completamente parametrizado a través de las siguientes variables declaradas en `variables.tf`:

| Variable | Tipo | Descripción | Ejemplo |
| :--- | :--- | :--- | :--- |
| `vpc_cidr` | `string` | Bloque CIDR principal para la delimitación de la VPC. | `"10.1.0.0/16"` |
| `public_subnet_cidrs` | `list(string)` | Lista de bloques CIDR para el direccionamiento de subredes públicas. | `["10.1.1.0/24", "10.1.2.0/24"]` |
| `private_subnet_cidrs` | `list(string)` | Lista de bloques CIDR para el direccionamiento de subredes privadas. | `["10.1.3.0/24", "10.1.4.0/24"]` |
| `availability_zones` | `list(string)` | Zonas de disponibilidad de la región para la distribución de subredes. | `["us-east-1a", "us-east-1b"]` |
| `mi_ip_acceso` | `string` | IP pública autorizada en formato CIDR para accesos administrativos (SSH). | `"200.12.34.56/32"` |
| `environment` | `string` | Prefijo organizativo para nombres y etiquetas estandarizadas de recursos. | `"AUY1105-appiac-ejemplo"` |

---

## Parámetros de Salida (Outputs)
Los siguientes valores son exportados en `outputs.tf` para permitir la integración y consumo por parte de otros módulos independientes o configuraciones de alto nivel:

* `vpc_id`: Identificador único de la VPC generada.
* `public_subnet_ids`: Lista de IDs de las subredes públicas mapeadas.
* `private_subnet_ids`: Lista de IDs de las subredes privadas mapeadas.
* `security_group_id`: ID del grupo de seguridad perimetral configurado.

---

## Ejemplo Práctico de Uso
Tal como se encuentra estructurado en la carpeta `examples/`, el módulo puede ser invocado de forma local o externa mediante el siguiente bloque de configuración:

```hcl
module "vpc_redes_ejemplo" {
  source = "../vpc_module" # Ruta de acceso al directorio del módulo

  # Parámetro obligatorio de seguridad
  mi_ip_acceso = "200.12.34.56/32"

  # Parámetros de personalización de infraestructura
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs =
