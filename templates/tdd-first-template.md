# TDD-first workflow for story development

## Objetivo

Aplicar una metodología TDD clara a cada historia para asegurar que el comportamiento funcional queda definido antes de implementar la solución.

## Flujo recomendado

1. Leer la historia y extraer requisitos.
2. Definir los criterios de aceptación.
3. Convertir los criterios en casos de prueba.
4. Escribir primero los tests que fallan.
5. Ejecutar la suite relevante y validar que el fallo es el esperado.
6. Implementar la lógica mínima para pasar.
7. Re-ejecutar los tests.
8. Refactorizar con seguridad.
9. Añadir queries de validación y limpieza.
10. Documentar el resultado y dejar evidencia para la historia.

## Regla principal

Nunca empezar por la implementación si no existe un caso de prueba que describa el comportamiento esperado.

## Estructura de trabajo por historia

```text
features/{JIRA_KEY}/
  README.md
  context.md
  technical.md
  tests.md
  tdd-plan.md
  queries/
    01_seed_data.sql
    02_validate_results.sql
    03_cleanup.sql
```

## Qué debe contener `tests.md`

- Casos happy path.
- Casos de error.
- Casos de validación de negocio.
- Validaciones de API o backend.
- Evidencia esperada por caso.

## Qué debe contener `tdd-plan.md`

- Test a escribir primero.
- Conjunto mínimo de casos de prueba.
- Qué se espera que falle.
- Qué implementación mínima va a resolverlo.
- Qué se revisará después de que el test pase.

## Recomendación práctica

- El primer paso de una historia siempre debe ser un test rojo.
- La implementación debe ser la mínima necesaria para pasar.
- Las queries de validación deben ser consideradas parte del proceso de prueba, no un extra final.
- Si un caso es difícil de probar de forma aislada, se documenta con datos de prueba y un escenario reproducible.
