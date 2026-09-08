# Story example: SISUSHIP-3474

## Propósito de este ejemplo

Este directorio es un ejemplo realista de cómo documentar una historia desde el inicio hasta la validación, manteniendo un nivel de detalle útil para que un agente o desarrollador sin contexto pueda entrar a trabajar rápidamente.

## ¿Qué incluye este ejemplo?

- `context.md`: describe la intención de negocio, contexto operativo y requisitos.
- `technical.md`: describe la solución técnica esperada y los puntos de integración.
- `tests.md`: documenta escenarios de validación y pruebas.
- `queries/`: contiene SQL de ejemplo para preparar datos, validar resultados y limpiar el entorno.

## ¿Para qué sirve cada documento?

### `context.md`
Sirve para entender el problema, el usuario, el flujo y los criterios de negocio. Es la base para que el agente comprenda la historia sin depender del Jira solamente.

### `technical.md`
Sirve para entender el alcance técnico: endpoints, dependencias y reglas internas que deben cumplirse. Es la referencia que ayuda a decidir qué código cambiar y qué componentes se ven afectados.

### `tests.md`
Sirve para especificar qué debe validarse y qué resultado se espera. Reduce la ambigüedad y asegura que la implementación se verifique de forma consistente.

### `queries/`
Sirve para reproducir los escenarios de prueba con datos mínimos, validar el resultado posterior y limpiar el entorno después de la ejecución.

## Referencia a recursos compartidos

Este ejemplo sigue la estructura base definida en `story-context/README.md` y usa como referencia los templates y prompts reutilizables de:

- `story-context/templates/story-template.md`
- `story-context/templates/technical-template.md`
- `story-context/templates/tests-template.md`
- `story-context/templates/data-template.md`
- `story-context/prompts/generic-agent-prompt.md`

## Nota para un futuro agente

Si no existiera contexto adicional, este ejemplo debe bastar para entender:
1. qué problema resuelve la historia,
2. qué implementación técnica probablemente requiere,
3. qué pruebas hay que ejecutar,
4. y qué datos mínimos permiten reproducir el comportamiento.
