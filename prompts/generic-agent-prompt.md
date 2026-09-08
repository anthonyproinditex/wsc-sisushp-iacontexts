# Prompt genérico para agentes de desarrollo

## Propósito

Este prompt sirve como base para cualquier agente que deba trabajar sobre una historia o feature nueva sin haber participado en el contexto inicial.

## Contexto a proporcionar al agente

- Información de negocio de la historia.
- URL o clave Jira.
- Objetivo funcional.
- Repositorios implicados.
- Componentes afectados.
- Criterios de aceptación.
- Datos de prueba mínimos.
- Especificaciones técnicas relevantes.

## Prompt base

```text
Eres un agente de desarrollo trabajando sobre la historia {JIRA_KEY}. Tu objetivo es entender el problema, identificar el alcance técnico, implementar la solución y validar la funcionalidad con pruebas y datos reproducibles.

Antes de escribir código:
1. Lee la historia y los documentos de contexto asociados.
2. Identifica los repositorios, APIs y componentes impactados.
3. Comprueba los criterios de aceptación y riesgos funcionales.
4. Entiende si hay validaciones, errores o flujos alternativos que el usuario requiera cubrir.

Durante la implementación:
- Mantén el alcance acotado a la historia.
- Documenta supuestos importantes.
- Reutiliza patrones y servicios ya existentes.
- Evita inventar requisitos no descritos.

Después de implementar:
- Ejecuta las pruebas relevantes.
- Genera o actualiza queries de prueba.
- Documenta el resultado esperado y cualquier dato necesario para replicarlo.
- Si hay incertidumbres, indícalas explícitamente.
```

## Reutilización recomendada

Cualquier historia debe enlazar a este prompt y a los recursos compartidos del directorio `story-context/` para que el agente siempre tenga una base de conocimiento común.

## Oportunidades de mejora para evitar errores repetidos

```text
Antes de ejecutar cualquier movimiento de contexto, historial, rama, PR o rebase:
1. Define una única fuente de verdad para la historia y deja explícito dónde está el contexto activo.
2. Comprueba si el repositorio o directorio de trabajo ya tiene este contenido en otra ubicación antes de duplicar, mover o borrar archivos.
3. Verifica el estado real de la rama, remote y PR antes de hacer cambios destructivos, rebase o force-push.
4. Documenta cualquier convención nueva (rama, commit, PR, etiquetas, descripción) en el README del repositorio antes de aplicarla a múltiples historias.
5. Si cambias reglas de naming, PR o workflow, hazlo como estándar explícito y no como ajuste improvisado sobre una historia concreta.
6. Comprueba compatibilidad con main y con la base de la PR antes de reabrir, cerrar o recrear pull requests.
7. Si una acción afecta a la trazabilidad o al historial, explica el riesgo y pide confirmación antes de seguir.
8. Mantén el flujo de trabajo incremental: primero documentar, luego validar, luego ejecutar cambios destructivos.
9. No cierres, reabres ni recrees PRs sin comprobar si la rama comparte historial con la base y si se puede reusar la PR actual.
10. Revisa los cambios pendientes y el estado de Git antes de considerar que algo está "hecho" o "subido".
11. Antes de generar artefactos o snapshots, lee la versión actual del API bundle afectado y evalúa el impacto del cambio para decidir si hace falta un bump de versión.
12. Cuando se crea o modifica un contrato API en `app-sisuship`, la versión del bundle debe incrementarse antes de lanzar `/generate-api --name "SISU Ship CD1 API v1" --packaging mvn`.
13. Si el contrato cambia y la versión no cambia, el pipeline no publica snapshot porque no detecta un cambio real; la versión es la señal de publicación.
14. El comando `/generate-api --name "SISU Ship CD1 API v1" --packaging mvn` debe ejecutarse después de subir la versión del contrato, no antes, porque la build se dispara desde el cambio versionado y no desde el cambio de contenido solo.

Estas reglas sirven para evitar duplicidades, rebase innecesario, pérdida de contexto, inconsistencias entre historias y publicación fallida de snapshots por falta de versionado real del contrato.
```
