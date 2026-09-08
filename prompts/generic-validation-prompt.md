# Prompt genérico para validación

## Propósito

Se usa para comprobar que una implementación cumple la historia: cobertura funcional, validaciones y calidad del resultado.

## Prompt base

```text
Valida que la implementación asociada a la historia {JIRA_KEY} cumple los criterios de aceptación y no introduce regresiones.

Revisa:
1. Que el comportamiento funcional coincide con los requisitos.
2. Que las validaciones y mensajes de error son correctos.
3. Que las querys de prueba cubren los escenarios clave.
4. Que el resultado es reproducible con datos de ejemplo.
5. Que no se han roto casos adyacentes.

Entrega:
- lista de validaciones ejecutadas,
- evidencias comprobadas,
- resultados esperados y obtenidos,
- riesgos o pendientes.
```

## Recomendación

La validación siempre debe ir acompañada de una prueba de datos mínima en SQL o un escenario reproducible si la funcionalidad depende de base de datos o integraciones.
