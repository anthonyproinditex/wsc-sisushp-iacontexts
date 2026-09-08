# Technical context: {JIRA_KEY}

## Objetivo del documento técnico

Este documento describe la implementación esperada desde el punto de vista del sistema: endpoints, contratos, dependencias y decisiones técnicas relevantes.

## Componentes implicados

- Frontend
- Backend
- Microservicio core
- Base de datos
- Integraciones externas

## Endpoints o casos de uso

### Endpoint 1

- Método: {GET|POST|PUT|PATCH|DELETE}
- Ruta: {ruta}
- Descripción: {qué hace}
- Entrada esperada: {payload y parámetros}
- Salida esperada: {respuesta y formato}
- Validaciones: {reglas de negocio y errores}

## Reglas de negocio técnicas

- Regla 1.
- Regla 2.
- Regla 3.

## Dependencias internas

- Servicios o lambdas que se reutilizan.
- Use cases que deben implementarse o adaptar.
- Contratos asociados.

## Consideraciones de compatibilidad

- Cambios en payloads.
- Impacto en versionado.
- Riesgos de migración o compatibilidad.

## Observaciones para agentes

Este documento sirve para entender la solución técnica, no la intención de negocio. Para el detalle del comportamiento esperado, combinar con `context.md` y `tests.md`.
