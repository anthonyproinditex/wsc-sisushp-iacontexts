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

## Convenciones de flujo de PR para app

Para las historias del proyecto `app`, además del flujo de rama y descripción del PR, se deben aplicar estas reglas por defecto:

- Crear siempre el PR en la rama de `stage`/entorno de staging.
- El PR debe incluir las etiquetas `api/preview` y `autopublish/snapshot-binaries`.
- La descripción del PR debe contener exclusivamente la URL de la historia Jira.
  - Ejemplo: `https://jira.inditex.com/jira/browse/SISUSHIP-3474`
- No se deben incluir textos de explicación ni justificación en la descripción del PR.
- Si el repositorio o el pipeline lo requiere, estas etiquetas deben añadirse en el momento de crear el PR o en la primera edición posterior.

Esto garantiza que el PR quede alineado con la publicación automática de snapshot y con la trazabilidad de la historia.

## Propósito de cada tipo de recurso

- `templates/`: asegurar que todas las historias tengan el mismo nivel de detalle.
- `prompts/`: acelerar la coordinación con agentes o asistentes IA.
- `checklists/`: evitar errores de cobertura, validación o entrega.
- `examples/`: servir como referencia de estructura y nivel de detalle.

## Recomendación de mantenimiento

- Mantener este directorio actualizado cuando aparezcan nuevos patrones de trabajo.
- No duplicar contexto repetido entre historias; si algo es genérico, debe ir aquí.
- Cada historia debe ser legible sin depender de memoria del equipo.
