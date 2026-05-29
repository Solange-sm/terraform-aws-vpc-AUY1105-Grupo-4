# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo. El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/), y este proyecto se adhiere a Versionado Semántico (SemVer).

## [1.0.0] - 2026-05-28

### Added

- Inicialización del módulo de Redes (VPC) desacoplado de la infraestructura monolítica.
- Implementación de la VPC principal con soporte DNS habilitado.
- Creación de dos subredes públicas y dos subredes privadas parametrizadas por CIDR y zona de disponibilidad.
- Implementación de Internet Gateway para conectividad pública.
- Implementación de Elastic IP y NAT Gateway para salida a Internet desde subredes privadas.
- Creación de tablas de ruteo públicas y privadas con sus respectivas asociaciones.
- Implementación de Security Group para recursos de cómputo, con acceso SSH restringido por IP autorizada y acceso HTTP para el servidor web.
- Implementación de Flow Logs para auditoría de tráfico de red en la VPC.
- Configuración de outputs para exponer `vpc_id`, `public_subnet_ids`, `private_subnet_ids` y `security_group_id`.
- Archivos core de Terraform: `main.tf`, `variables.tf`, `outputs.tf` y `versions.tf` completamente parametrizados.
- Variables configurables para `vpc_cidr`, `public_subnet_cidrs`, `private_subnet_cidrs`, `availability_zones`, `mi_ip_acceso` y `environment`.

### Changed

- Reorganización de la lógica de red para permitir reutilización e integración desde el repositorio principal.
- Adaptación del módulo para consumo remoto desde GitHub como dependencia externa.
- Estandarización de nombres y tags de recursos según la convención definida para la evaluación.
- Ajuste de la documentación y parametrización para facilitar la reutilización del módulo en distintos entornos.

### Security

- Restricción del acceso SSH mediante la variable `mi_ip_acceso` en formato CIDR.
- Desactivación de asignación automática de IP pública en las subredes públicas para ajustarse a validaciones de seguridad.
- Restricción del Security Group por defecto de la VPC.
- Habilitación de logs de flujo para fortalecer trazabilidad y auditoría de red.
- Inclusión de excepciones justificadas de Checkov para el acceso HTTP público requerido por la actividad y para la asociación del Security Group desde un módulo externo.

### Fixed

- Corrección de observaciones de análisis estático y seguridad detectadas durante la integración del módulo en el pipeline.
- Ajustes de compatibilidad de versiones de Terraform y provider AWS para ejecución correcta en el entorno de CI/CD.
- Corrección de configuración necesaria para que el módulo funcione con el repositorio principal y sus validaciones automatizadas.
