# TDD plan: SISUSHIP-3474

## Objetivo

Definir primero el comportamiento esperado de la validación de traspaso entre camiones para que la implementación quede guiada por casos de prueba reproducibles y verificables.

## Regla de trabajo

Se empezará por escribir las pruebas que describen el comportamiento esperado y se ejecutarán antes de tocar la lógica de negocio.

## Orden recomendado

### 1. Definir el primer bloque de pruebas críticas

Priorizar los casos con mayor riesgo operativo:

- planificacion incompatible
- tienda sin ruta asociada
- volumen excedido
- origen finalizado
- destino cerrado
- ETD en pasado
- orden incompatible

### 2. Convertir criterios funcionales en tests

#### Test 01: when_destination_has_different_planification_expect_warning

- Entrada: origen y destino con distinta planificación.
- Esperado:
  - `isCompatible = false`
  - `incompatibilityLevel` informado
  - reglas con `ROUTES-LOCATIONS` no válida
  - `message` claro sobre rutas a añadir
  - confirmación del usuario requerida

#### Test 02: when_origin_store_has_no_route_expect_warning

- Entrada: al menos una tienda del origen sin ruta asociada.
- Esperado:
  - se identifica la tienda sin ruta
  - se informa en la regla de incompatibilidad
  - el usuario debe poder decidir continuar

#### Test 03: when_destination_volume_is_insufficient_expect_warning

- Entrada: destino sin capacidad para la carga a traspasar.
- Esperado:
  - regla `VOLUME` inválida
  - mensaje de volumen excedido
  - confirmación explícita

#### Test 04: when_origin_truck_is_finalized_expect_open_option

- Entrada: camión origen en estado finalizado.
- Esperado:
  - regla `FINALIZED` no válida
  - aviso con opción de reabrir directamente

#### Test 05: when_destination_truck_is_closed_expect_non_reopen_warning

- Entrada: camión destino cerrado.
- Esperado:
  - aviso informativo
  - no opción directa de reapertura
  - mensaje de proceso habitual

#### Test 06: when_destination_etd_is_in_the_past_expect_info_warning

- Entrada: ETD del destino ya pasada.
- Esperado:
  - aviso informativo
  - el flujo sigue permitiendo confirmación

#### Test 07: when_destination_order_is_incompatible_expect_order_rule

- Entrada: incompatibilidad de orden del destino.
- Esperado:
  - regla de orden no válida
  - mensaje específico del problema

## Estructura de validación API

### Endpoint `/v1/transfer/validate`

Se escribirán pruebas de contrato para verificar que la respuesta contiene al menos:

- `isCompatible`
- `incompatibilityLevel`
- `commonCriteria`
- `rules[]`

Cada regla debe incluir:

- `name`
- `valid`
- `message`

### Endpoint `/v1/transfer/truck/search`

Se define una prueba para comprobar que devuelve:

- `trucks[]`
- `id`
- `name`
- `stopId`
- `trailerLicensePlate`
- `summary`

## Red → Green → Refactor

### Fase Rojo

1. Se escriben los tests de validación de negocio.
2. Se ejecutan y deben fallar porque la lógica aún no existe.
3. Se confirma que el fallo refleja la ausencia de comportamiento requerido.

### Fase Verde

1. Se implementa la lógica mínima para cumplir el comportamiento esperado.
2. Se reejecutan solo los tests objetivo.
3. Se corrigen errores de contrato o reglas de negocio.

### Fase Refactor

1. Se revisa si la lógica está duplicada.
2. Se consolida la estructura de reglas y mensajes.
3. Se mantiene la misma semántica funcional sin cambios de comportamiento.

## Criterios de aceptación para cerrar la historia

- Los avisos de incompatibilidad aparecen en los escenarios esperados.
- Los mensajes son claros y accionables.
- La respuesta de API incluye reglas y no solo un booleano.
- El flujo de confirmación queda definido para escenarios críticos.
- Las pruebas quedan documentadas con evidencia reproducible.

## Siguiente paso concreto

Antes de implementar, se escribirá la suite inicial de pruebas en el repositorio del proyecto y se ejecutará para confirmar el estado rojo. Una vez validado, se implementará la lógica de compatibilidad y se revisará la salida del endpoint.
