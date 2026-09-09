# TDD plan: SISUSHIP-3474

## Objetivo

Definir una suite TDD **clara, trazable y ejecutable** para la validación de traspasos entre camiones en el endpoint:

- `POST /v1/transfer/validate`
- request `type = "TRUCK"`

La suite debe guiar implementación incremental (Red → Green → Refactor) y garantizar que el backend devuelve reglas de incompatibilidad, no solo un booleano.

## Alcance activo de esta iteración

Se cubre únicamente el punto 1 del RF técnico:

- validación de compatibilidad en `transfer/validate` para `TRUCK`.

Quedan fuera de esta iteración (stand by):

- `POST /v1/transfer/truck/search`
- cambios en `/v1/transfer/all-items` (dependencia SISUSHIP-3473).

## Convención de organización

La historia se estructura en **6 validaciones principales**. Los casos TDD se agrupan por validación para facilitar implementación y trazabilidad:

1. Planificación incompatible (incluye tienda sin ruta)
2. Volumen insuficiente destino
3. Origen finalizado
4. Destino cerrado
5. ETD destino en pasado
6. Orden incompatible

> Nota de interpretación: en Jira aparece el título “Camión destino finalizado”, pero la descripción y criterios hablan de **camión origen finalizado**. Para TDD se toma **origen finalizado** como fuente funcional.

## Matriz TDD por validación

| Validación | Caso TDD | Objetivo del test | Resultado esperado mínimo |
|---|---|---|---|
| V1 Planificación incompatible | `when_destination_has_different_planification_expect_warning` | Detectar diferencias de planificación origen/destino | `isCompatible=false`, `incompatibilityLevel=PARTIAL`, regla `ROUTES-LOCATIONS` inválida, `commonCriteria` con rutas impactadas |
| V1 Planificación incompatible | `when_origin_store_has_no_route_expect_warning` | Cubrir caso especial de tienda sin ruta asociada | Warning de planificación + evidencia de tienda sin ruta (en `commonCriteria`/parámetros de regla) |
| V2 Volumen insuficiente | `when_destination_volume_is_insufficient_expect_warning` | Detectar sobrecapacidad en destino | Regla `VOLUME` inválida + mensaje de volumen excedido + confirmación requerida |
| V3 Origen finalizado | `when_origin_truck_is_finalized_expect_open_option` | Avisar estado finalizado y permitir reapertura del origen | Regla `FINALIZED` inválida + marca/indicio funcional de opción de reapertura |
| V4 Destino cerrado | `when_destination_truck_is_closed_expect_warning` | Bloquear reapertura directa de destino | Warning de cerrado + indicación de proceso habitual (sin reapertura directa) |
| V5 ETD pasada | `when_etd_is_in_past_expect_warning` | Informar ETD vencida manteniendo continuidad del flujo | Warning informativo + continuidad condicionada a confirmación |
| V6 Orden incompatible | `when_order_is_incompatible_expect_warning` | Reportar incompatibilidad de orden | Regla de orden inválida + mensaje específico |

## Diseño de pruebas (nivel backend)

### Suite principal de caso de uso

- Clase objetivo: `TransferValidateTruckUseCaseTest`
- Método bajo prueba: `validateTruck(UUID originId, UUID destinationId, int dcgCode)`
- Enfoque: tests unitarios por validación con dobles de repositorio.

### Estructura esperada

- Agrupación por método con `@Nested class ValidateTruck`.
- Naming `when_{condición}_expect_{resultado}`.
- Patrón AAA en cada test.
- Primer objetivo: dejar cada caso en rojo por **ausencia de comportamiento**, no por errores de compilación.

## Contrato de respuesta que debe sostener TDD

Cada caso de validación debe contribuir a que el contrato final incluya:

- `isCompatible`
- `incompatibilityLevel`
- `commonCriteria`
- `rules[]` con al menos:
  - `name`
  - `valid`
  - `message`
  - `param` cuando aplique

## Estrategia de ejecución Red → Green → Refactor (por validación)

Para cada validación `Vn`:

1. **Red**
   - Escribir o ajustar el/los tests del bloque `Vn`.
   - Ejecutar prueba focalizada del caso.
   - Confirmar fallo por comportamiento esperado no implementado.

2. **Green**
   - Implementar la lógica mínima para pasar solo `Vn`.
   - Re-ejecutar prueba focalizada.
   - Mantener sin regresiones en validaciones ya cerradas.

3. **Refactor**
   - Limpiar duplicaciones (reglas, mensajes, construcción de respuesta).
   - Mantener semántica funcional intacta.

## Orden de implementación comprometido

1. **V1 Planificación incompatible** (incluye tienda sin ruta)
2. V2 Volumen insuficiente
3. V3 Origen finalizado
4. V4 Destino cerrado
5. V5 ETD en pasado
6. V6 Orden incompatible

## Criterio de cierre de la fase TDD

Se considera cerrada la fase de diseño TDD cuando:

- Las 6 validaciones principales están documentadas con sus casos.
- Cada caso tiene resultado esperado mínimo verificable.
- El orden de implementación incremental está definido.
- Existe trazabilidad explícita entre historia funcional y casos de prueba.
