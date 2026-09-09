# Story context library

Este directorio centraliza la base de conocimiento reutilizable para todas las historias que se desarrollen en el proyecto.

## Objetivo

Proporcionar un marco común para documentar historias, requisitos, pruebas y datos de prueba, de manera que cualquier agente o desarrollador nuevo pueda entender rápidamente:

- el negocio y el problema a resolver,
- el alcance técnico,
- los escenarios de prueba,
- los datos mínimos necesarios para validar la funcionalidad,
- y el conjunto de recursos estándar que se reutilizan entre historias.

## Estructura recomendada

```
story-context/
  README.md
  templates/
    story-template.md
    technical-template.md
    tests-template.md
    data-template.md
  examples/
    SISUSHIP-3474/
      README.md
      context.md
      technical.md
      tests.md
      queries/
        01_seed_data.sql
        02_validate_results.sql
        03_cleanup.sql
  prompts/
    generic-agent-prompt.md
    generic-research-prompt.md
    generic-validation-prompt.md
  checklists/
    story-readiness-checklist.md
    story-validation-checklist.md
```

## Cómo usar este repositorio de contexto

Cada historia nueva debe apoyarse en:

1. Una carpeta dedicada por historia y su clave Jira.
2. Un conjunto mínimo de documentos estandarizados.
3. Queries de prueba reutilizables y autocontenidas.
4. Una referencia explícita desde el README de la historia a los recursos compartidos de este directorio.

## Recursos compartidos

Los siguientes recursos viven aquí para no duplicar conocimiento entre historias:

- `templates/`: plantillas reutilizables para asegurar consistencia de documentación.
- `prompts/`: prompts génicos para investigación, análisis técnico, validación y generación de pruebas.
- `checklists/`: listas de verificación de preparación y validación.
- `examples/`: ejemplos concretos de implementación realista.

## Convención para las historias

Cada historia debe incluir una referencia al contexto compartido. Por ejemplo:

```md
> Este contexto se ha estructurado siguiendo la base de conocimiento de `story-context/`.
> Recursos reutilizables: `story-context/templates/story-template.md`, `story-context/prompts/generic-agent-prompt.md`.
```

## Convenciones globales para todas las historias

Estas reglas aplican a cualquier historia y repositorio del proyecto salvo que exista una excepción explícita por repositorio:

- Rama: `feature/<KEY-JIRA>`
  - Ejemplo: `feature/SISUSHIP-3474`
  - Regla crítica: si ya existe la rama canónica de la historia, no debe crearse otra rama automática por herramientas de soporte, PR helpers o automation. La rama de la historia siempre debe mantenerse consistente con la clave Jira.
- Mensajes de commit: `[<KEY-JIRA>] <descripción corta>`
  - Ejemplo: `[SISUSHIP-3474] update transfer validation contract`
- Título del PR: `[<KEY-JIRA>] <resumen>`
  - Ejemplo: `[SISUSHIP-3474] Align transfer validation contract`
- El PR se crea inicialmente en estado `draft` y solo se marca como listo para revisión cuando está preparado para revisión formal.
- Descripción del PR: debe contener exclusivamente la URL de la historia Jira.
  - Ejemplo: `https://jira.inditex.com/jira/browse/SISUSHIP-3474`
  - No se deben incluir textos extra, explicaciones adicionales ni comentarios de business en la descripción del PR.
- La clave Jira debe mantenerse visible en la rama, el commit y el PR para que cualquier compañero pueda rastrear la historia de forma inmediata.
- Reglas anti-regresión para agentes y asistentes IA:
  - Antes de crear una PR, validar siempre la rama canónica de la historia: `feature/<KEY-JIRA>`.
  - Antes de abrir un PR, validar la base del repositorio objetivo (normalmente `develop`) y la rama de origen.
  - Si una herramienta automática genera una rama con patrón distinto (por ejemplo `feature/GH-2846-...`), se debe cerrar el PR generado y recrearlo desde la rama canónica de la historia.
  - Nunca se debe dejar que un helper de PR o un asistente invente una rama distinta a la de la historia si ya existe la rama válida.
  - El flujo correcto es: rama de historia → commit con clave Jira → PR en draft → cuerpo con URL de Jira → revisión formal.

Esto evita que se creen branches inconsistentes con la trazabilidad de la historia y que se pierda el contexto de la evolución real del trabajo entre repositorios y agentes.

## Excepción específica del proyecto app

Para el repositorio `app-sisuship`, además de las reglas globales, se deben aplicar estas condiciones concretas:

- Crear siempre el PR desde la rama de `stage`/entorno de staging.
- El PR debe incluir, por defecto, las etiquetas `api/preview` y `autopublish/snapshot-binaries`.
- Si el repositorio o el pipeline no dispone de esas etiquetas o las requiere con otro nombre, se deben ajustar siguiendo la política del repositorio, pero sin romper la regla global de la URL de Jira en la descripción del PR.
- Antes de crear o modificar un contrato API, el agente debe evaluar el impacto del cambio: compatibilidad, consumidores y alcance del contrato, y decidir si requiere una versión nueva del contrato.
- Si se crea o modifica un contrato en `app-sisuship`, debe subirse la versión del archivo o archivos del contrato afectados antes de lanzar cualquier generación de artefactos o publicación.
- Si no se detecta un cambio real de versión en el contrato, el pipeline no genera el snapshot aunque se lance la generación del artefacto; la versión es el trigger de publicación.
- El comando `/generate-api --name "SISU Ship CD1 API v1" --packaging mvn` debe entenderse como la invocación del build de artefactos de la API y debe ejecutarse después de subir la versión del contrato, nunca antes.

Esto garantiza que el PR quede alineado con la publicación automática de snapshot y con la trazabilidad de la historia en `app-sisuship`.

## Propósito de cada tipo de recurso

- `templates/`: asegurar que todas las historias tengan el mismo nivel de detalle.
- `prompts/`: acelerar la coordinación con agentes o asistentes IA.
- `checklists/`: evitar errores de cobertura, validación o entrega.
- `examples/`: servir como referencia de estructura y nivel de detalle.

## Recomendación de mantenimiento

- Mantener este directorio actualizado cuando aparezcan nuevos patrones de trabajo.
- No duplicar contexto repetido entre historias; si algo es genérico, debe ir aquí.
- Cada historia debe ser legible sin depender de memoria del equipo.
