# Test plan: SISUSHIP-3474

## Objetivo

Validar que la historia cumple los criterios funcionales y técnicos para traspasos entre camiones, así como que la respuesta del backend y la interfaz reflejan los avisos correctos.

## Casos de prueba funcionales

### TC-01: planificación incompatible

**Escenario**: seleccionar como destino un camión que no tiene todas las tiendas del origen.

**Resultado esperado**:
- Se muestra un warning de planificación incompatible.
- Se indica que el camión destino no tiene la misma planificación.
- Se listan las rutas que se van a añadir.
- Se solicita confirmación explícita del usuario.

### TC-02: tienda sin ruta asociada

**Escenario**: alguna tienda del origen no tiene ruta asociada.

**Resultado esperado**:
- El aviso incluye la mención de tiendas sin ruta asignada.
- Se muestran las rutas que se añadirán al destino.

### TC-03: volumen excedido

**Escenario**: la cantidad a traspasar supera la capacidad disponible del destino.

**Resultado esperado**:
- Se muestra un aviso de volumen excedido.
- Se informa del exceso.
- Se solicita confirmación antes de continuar.

### TC-04: origen finalizado

**Escenario**: el camión origen está finalizado.

**Resultado esperado**:
- Se indica que el camión está finalizado.
- Se ofrece la opción de reabrirlo directamente desde el aviso.

### TC-05: destino cerrado

**Escenario**: el camión destino está cerrado.

**Resultado esperado**:
- Se muestra un aviso informativo.
- No se ofrece opción de reapertura desde el aviso.
- Se informa de que se debe reabrir por el proceso habitual.

### TC-06: ETD en pasado

**Escenario**: la ETD del destino es anterior al momento de la operación.

**Resultado esperado**:
- Se muestra un aviso informativo.
- El sistema permite continuar tras confirmación del usuario.

### TC-07: orden incompatible

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

### TC-09: búsqueda de trucks

**Entrada**:
```json
{
  "searchText": "1234ABC"
}
```

**Validación**:
- Devuelve una lista de camiones con `id`, `name`, `stopId`, `trailerLicensePlate` y `summary`.
- El contenido se ordena y filtra según la lógica del buscador.

## Criterios de validación general

- La respuesta del backend es consistente con las regla de negocio.
- Los mensajes de usuario son claros y accionables.
- Las validaciones en la API devuelven reglas de incompatibilidad, no solo un booleano.
- La operación requiere confirmación del usuario en los casos previstos.

## Observación para agentes

Esta lista contiene los escenarios clave. Si se implementa una nueva validación, debe añadirse aquí con el mismo nivel de detalle para no perder trazabilidad de la historia.
