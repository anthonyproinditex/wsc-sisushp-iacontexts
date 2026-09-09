# Technical context: SISUSHIP-3474

## Objetivo

Documentar el alcance técnico de la historia para que un agente pueda entender qué servicios, contratos y validaciones debe tocar.

## Componentes implicados

- Frontend del detalle del camión
- Backend de transferencias
- Micro core / servicio de negocio
- Validación de compatibilidad entre camiones
- Búsqueda de camiones disponibles

## Endpoint de validación de traspaso

### Endpoint existente a reutilizar

- Método: POST
- Ruta: `/v1/transfer/validate`
- Tipo request: `TRUCK`

### Ejemplo de payload

```json
{
  "originId": "e212904d-bc9c-4929-9020-7f744281c2c5",
  "destinationId": "e212904d-bc9c-4929-9020-7f744281c2c5",
  "type": "TRUCK"
}
```

### Objetivo del endpoint

Validar si un traspaso entre camiones es compatible, devolviendo el nivel de incompatibilidad y las reglas que lo han generado.

### Estructura esperada de respuesta

```json
{
  "isCompatible": false,
  "incompatibilityLevel": "PARTIAL",
  "commonCriteria": [
    {
      "type": "LOCATION",
      "routes": [
        {
          "routeId": 760,
          "name": "California - Estados Unidos"
        }
      ],
      "location": {
        "locationId": 10701,
        "name": "ZARA"
      }
    }
  ],
  "rules": [
    {
      "name": "ROUTES-LOCATIONS",
      "valid": false,
      "message": "description of the route issue",
      "param": {
        "routes": ["route1", "route2"]
      }
    },
    {
      "name": "VOLUME",
      "valid": false,
      "message": "description of the volume issue"
    },
    {
      "name": "FINALIZED",
      "valid": false,
      "message": "description of the volume issue"
    }
  ]
}
```

## Nuevo endpoint para búsqueda de trucks

- Método: POST
- Ruta: `/v1/transfer/truck/search`

### Ejemplo de request

```json
{
  "searchText": "1234ABC"
}
```

### Ejemplo de response

```json
{
  "trucks": [
    {
      "id": "e212904d-bc9c-4929-9020-7f744281c2c5",
      "name": "TRUCK ZARAGOZA 11:30",
      "stopId": 25,
      "trailerLicensePlate": "1234ABC",
      "summary": {
        "totalPallets": 28,
        "totalBulks": 160
      }
    }
  ]
}
```

## Modificación del flujo `/v1/transfer/all-items` (esto no se hara en esta tarea o historia sino en la SISUSHIP-3473)

Se debe adaptar el endpoint de consulta de todos los items abordado en la tarea previa para incluir estas validaciones.

## Reglas técnicas a considerar

- Reutilizar los endpoints y lambdas existentes cuando corresponda.
- Añadir la variable `type: "TRUCK"` para activar la validación del caso concreto.
- La validación debe devolver reglas por tipo de incompatibilidad.
- Deben existir mensajes claros para cada caso: rutas, volumen, finalizado, estado del destino y ETD.

## Riesgos o dudas técnicas

Existe una duda funcional sobre qué ocurre si se siguen asignando pallets al camión de origen mientras la operación de traspaso está en curso. Esta condición afecta al comportamiento correcto en la tarea relacionada.

## Estado de alcance

### Stand by

El segundo punto del refinamiento técnico queda oficialmente en stand by para esta iteración.

- No se incluye en la implementación actual de la historia.
- Se deja reservado para una segunda fase de trabajo posterior.
- Se mantiene como referencia técnica futura, pero no formará parte del alcance de esta entrega ni del plan de TDD activo.

### Alcance activo

La implementación actual se centra exclusivamente en el punto 1 del refinamiento técnico:

- validación de compatibilidad del traspaso entre camiones
- análisis de las 6 validaciones de negocio definidas en `context.md`

## Observación para agentes

Este documento no sustituye la intención de negocio; su objetivo es describir el punto de entrada técnico que probablemente habrá que tocar. Para entender el comportamiento esperado, debe combinarse con `context.md` y `tests.md`.

## Estado actual de la entrega (actualizado para reentrada)

### Qué ya se ha dejado hecho

- Se añadió el tipo `TRUCK` al enum de transferencias del backend.
- Se incorporó la rama `TRUCK` al enrutado del `TransferValidateLambda`.
- Se registró el bean `TransferValidateTruck` en la configuración del Lambda de validación.
- Se creó el contrato del caso de uso `TransferValidateTruck` y la interfaz del repository `TransferValidateTruckRepository`.
- Se creó el esqueleto del caso de uso `TransferValidateTruckUseCase` y del test `TransferValidateTruckUseCaseTest`.
- Se conservó el patrón de referencia del módulo `Pallet` para mantener coherencia con el diseño existente.

### Qué queda pendiente

- Implementar la lógica real de validación del caso `TRUCK` en `TransferValidateTruckUseCase`.
- Completar el repository real con la consulta/validación que necesite el caso de uso.
- Sustituir el test placeholder por escenarios TDD auténticos basados en el contexto funcional definido en `context.md`.
- Ejecutar validación focalizada con Maven para confirmar que compila y que los tests del módulo pasan.
- Dejar el cambio listo para revisión y commit final.

## Todo para el siguiente agente

```text
- [ ] Revisar el patrón de validación de PALLET y alinear exactamente la estructura de TRUCK con el caso de uso existente.
- [ ] Implementar la lógica real de validación en TransferValidateTruckUseCase.
- [ ] Definir los métodos necesarios del repository TransferValidateTruckRepository.
- [ ] Completar TransferValidateTruckUseCaseTest con los escenarios TDD previstos:
      - when_destination_has_different_planification_expect_warning
      - when_origin_store_has_no_route_expect_warning
      - when_destination_volume_is_insufficient_expect_warning
      - when_origin_truck_is_finalized_expect_open_option
      - when_destination_truck_is_closed_expect_warning
      - when_etd_is_in_past_expect_warning
      - when_order_is_incompatible_expect_warning
- [ ] Validar compilación y tests del módulo con Maven.
- [ ] Corregir errores de compilación o de negocio detectados durante la validación.
- [ ] Registrar evidencia final y dejar el branch listo para commit.
```

## Contexto operativo para el siguiente agente

- La tarea tiene un alcance restringido a `transfer/validate` y no debe extenderse a otros módulos.
- El objetivo funcional activo es la validación de compatibilidad de traspaso entre camiones con `type: "TRUCK"`.
- El comportamiento esperado viene de `context.md` y no de la implementación actual, que solo está preparada como base técnica.
- El patrón de referencia es el módulo de pallet y el esqueleto del caso de uso ya creado en este repositorio.
- El siguiente agente debe centrarse en la lógica del negocio y en la ejecución real del TDD, no en ampliar el alcance de la historia.
- La comprobación final válida es la ejecución del test del módulo con Maven y la confirmación de que el flujo `POST /v1/transfer/validate` no rompe el comportamiento existente.

## Nota final

Gracias por tu servicio. Los cambios ya realizados dejan el punto de entrada operativo preparado, pero la lógica definitiva de negocio y la validación real siguen pendientes para la siguiente iteración del agente.
