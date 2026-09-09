# Test plan: SISUSHIP-3474

## Objetivo

Validar que la historia cumple los criterios funcionales y técnicos para traspasos entre camiones en el backend, y que la respuesta del endpoint de validación refleja correctamente los avisos y reglas de incompatibilidad.

## Alcance activo de pruebas

Cobertura activa en esta iteración:

- `POST /v1/transfer/validate`
- request `type = "TRUCK"`

Fuera de alcance (stand by en esta iteración):

- `POST /v1/transfer/truck/search`
- integración funcional con `/v1/transfer/all-items`.

## Casos de prueba funcionales organizados por validaciones principales

### Validación 1: Planificación incompatible (rutas/tiendas)

#### TC-01: planificación incompatible

**Escenario**: seleccionar como destino un camión que no tiene todas las tiendas del origen.

**Resultado esperado**:
- Se muestra un warning de planificación incompatible.
- Se indica que el camión destino no tiene la misma planificación.
- Se listan las rutas que se van a añadir.
- Se solicita confirmación explícita del usuario.

#### TC-02: tienda sin ruta asociada

**Escenario**: alguna tienda del origen no tiene ruta asociada.

**Resultado esperado**:
- El aviso incluye la mención de tiendas sin ruta asignada.
- Se muestran las rutas que se añadirán al destino.

### Validación 2: Volumen insuficiente en camión destino

#### TC-03: volumen excedido

**Escenario**: la cantidad a traspasar supera la capacidad disponible del destino.

**Resultado esperado**:
- Se muestra un aviso de volumen excedido.
- Se informa del exceso.
- Se solicita confirmación antes de continuar.

### Validación 3: Camión origen finalizado

#### TC-04: origen finalizado

**Escenario**: el camión origen está finalizado.

**Resultado esperado**:
- Se indica que el camión está finalizado.
- Se ofrece la opción de reabrirlo directamente desde el aviso.

### Validación 4: Camión destino cerrado

#### TC-05: destino cerrado

**Escenario**: el camión destino está cerrado.

**Resultado esperado**:
- Se muestra un aviso informativo.
- No se ofrece opción de reapertura desde el aviso.
- Se informa de que se debe reabrir por el proceso habitual.

### Validación 5: ETD del camión destino en el pasado

#### TC-06: ETD en pasado

**Escenario**: la ETD del destino es anterior al momento de la operación.

**Resultado esperado**:
- Se muestra un aviso informativo.
- El sistema permite continuar tras confirmación del usuario.

### Validación 6: Orden incompatible

#### TC-07: orden incompatible

**Escenario**: el destino presenta una incompatibilidad de orden.

**Resultado esperado**:
- Se muestra un aviso de orden incompatible.
- El sistema refleja esta condición en el resultado de validación.

## Casos de prueba técnicos

### TC-08: validación /v1/transfer/validate

**Entrada**:
```json
{
  "originId": "e212904d-bc9c-4929-9020-7f744281c2c5",
  "destinationId": "e212904d-bc9c-4929-9020-7f744281c2c5",
  "type": "TRUCK"
}
```

**Validación**:
- La respuesta incluye `isCompatible`.
- La respuesta incluye `incompatibilityLevel`.
- La respuesta incluye `commonCriteria` y `rules`.
- Cada regla tiene `name`, `valid` y `message`.
- Cuando aplique, cada regla puede incluir `param` con detalle de contexto.

### TC-09: coherencia de nivel de incompatibilidad

**Escenario**: ejecutar validaciones con al menos un warning activo.

**Validación**:
- `isCompatible = false` cuando exista alguna regla invalidante.
- `incompatibilityLevel` se informa de forma consistente con el tipo de incompatibilidad.

### TC-10: trazabilidad de reglas por validación

**Escenario**: disparar cada una de las 6 validaciones principales.

**Validación**:
- Se devuelve al menos una regla representativa por validación activa.
- El mensaje de cada regla es claro y accionable para el usuario.

## Criterios de validación general

- La respuesta del backend es consistente con las regla de negocio.
- Los mensajes de usuario son claros y accionables.
- Las validaciones en la API devuelven reglas de incompatibilidad, no solo un booleano.
- La operación requiere confirmación del usuario en los casos previstos.

## Mapeo recomendado a casos TDD de implementación

Para mantener trazabilidad con el código de tests unitarios:

- TC-01 ↔ `when_destination_has_different_planification_expect_warning`
- TC-02 ↔ `when_origin_store_has_no_route_expect_warning`
- TC-03 ↔ `when_destination_volume_is_insufficient_expect_warning`
- TC-04 ↔ `when_origin_truck_is_finalized_expect_open_option`
- TC-05 ↔ `when_destination_truck_is_closed_expect_warning`
- TC-06 ↔ `when_etd_is_in_past_expect_warning`
- TC-07 ↔ `when_order_is_incompatible_expect_warning`

## Observación para agentes

Esta lista contiene los escenarios clave del alcance activo. Si cambia el refinamiento funcional o se reactiva alcance en stand by, se debe actualizar este documento y su correspondencia con el plan TDD antes de implementar.
