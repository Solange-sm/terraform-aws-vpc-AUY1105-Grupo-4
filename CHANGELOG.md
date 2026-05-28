# Asegurarse de documentar todos los cambios realizados sobre el proyecto.

# Changelog
Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto se adhiere a las buenas prácticas de versionado y revisión de código mediante Pull Requests.

## [Unreleased] - En desarrollo

### Añadido / Modificado / Solucionado

**Pull Request #3 (Versión de Ejemplo Funcional y Documentación del Módulo VPC)**
- **Autoras:** Solange y Mary
- **Cambios:**
  - **Módulo VPC:** Creación del directorio `vpc_module/` con la estructura requerida por la evaluación: `main.tf`, `variables.tf`, `outputs.tf` y `versions.tf`.
  - **Módulo VPC:** Implementación de la VPC principal con CIDR parametrizable y habilitación de DNS hostnames/support.
  - **Módulo VPC:** Creación de subredes públicas y privadas parametrizadas por variables.
  - **Módulo VPC:** Implementación de Internet Gateway, NAT Gateway, tablas de rutas y asociaciones de rutas.
  - **Módulo VPC:** Configuración del Security Group del cómputo con SSH restringido por IP autorizada (`mi_ip_acceso`) y salida controlada.
  - **Outputs del módulo:** Exposición de `vpc_id`, `public_subnet_ids`, `private_subnet_ids` y `security_group_id`.
  - **Ejemplos:** Creación de la carpeta `examples/` con un `main.tf` funcional para probar el módulo de redes de forma aislada.
  - **Ejemplos:** Creación de `examples/README.md` con explicación del propósito del ejemplo y pasos básicos de ejecución.
  - **Documentación:** Actualización del `README.md` raíz para describir el objetivo del repositorio y el uso del módulo.
  - **Versionado:** Actualización de `versions.tf` con versión requerida de Terraform y proveedor AWS compatible con el módulo.
  - **Seguridad:** Parametrización obligatoria de `mi_ip_acceso` para evitar exposición pública del acceso SSH.
  - **Validación:** Inclusión de excepciones documentadas para hallazgos esperables de Checkov en entornos de laboratorio cuando aplica.


**Pull Request #2 (Ajustes de Seguridad, Calidad y Validación del Módulo VPC)**
- **Autoras:** Solange y Mary
- **Cambios:**
- **Seguridad (Checkov):** Corrección de hallazgos relacionados con la exposición pública del Security Group y la asociación de recursos del módulo.
  - **Seguridad (Checkov):** Documentación de excepciones justificadas para reglas aplicables al entorno de AWS Academy.
  - **Calidad:** Refinamiento de nombres de recursos y tags siguiendo la nomenclatura estándar del proyecto.
  - **Documentación:** Mejora de descripciones en `variables.tf` y `outputs.tf` para facilitar la reutilización del módulo.
  - **Módulo VPC:** Consolidación del módulo como componente reutilizable e independiente para ser consumido por el repositorio principal.
  - **Ejemplos:** Ajuste del ejemplo funcional para que refleje un consumo realista del módulo con variables obligatorias y outputs verificables.


**Pull Request #1 (Inicialización del Repositorio Módulo VPC)**
- **Autoras:** Solange y Mary
- **Cambios:**
  - **Repositorio:** Inicialización del repositorio base para almacenar el módulo de redes de la evaluación parcial 2.
  - **Repositorio:** Creación de la rama principal y configuración inicial del proyecto.
  - **Repositorio:** Creación del archivo `.gitignore` para excluir archivos temporales, estados de Terraform, planes, claves privadas y artefactos de Checkov.
  - **Repositorio:** Creación del archivo `CHANGELOG.md` para documentar todos los cambios realizados sobre el proyecto.
  - **Repositorio:** Creación del `README.md` raíz con objetivo general, propósito del módulo e instrucciones básicas de uso.

---

### Pendiente de Implementar (Próximos pasos a registrar)

**Versión Inicial del Módulo VPC**
- Crear y publicar el release tag `v1.0.0` cuando el módulo quede estable y funcional.
- Asociar el tag con el commit final validado.
- Registrar en el release una descripción breve de los cambios incluidos en la versión inicial.
- Verificar que el ejemplo funcional en `examples/` ejecute correctamente con `terraform init`, `plan` y `apply`.
