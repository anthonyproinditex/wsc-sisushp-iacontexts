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

## Modificación del flujo `/v1/transfer/all-items`

Se debe adaptar el endpoint de consulta de todos los items abordado en la tarea previa para incluir estas validaciones.

## Reglas técnicas a considerar

- Reutilizar los endpoints y lambdas existentes cuando corresponda.
- Añadir la variable `type: "TRUCK"` para activar la validación del caso concreto.
- La validación debe devolver reglas por tipo de incompatibilidad.
- Deben existir mensajes claros para cada caso: rutas, volumen, finalizado, estado del destino y ETD.

## Riesgos o dudas técnicas

Existe una duda funcional sobre qué ocurre si se siguen asignando pallets al camión de origen mientras la operación de traspaso está en curso. Esta condición afecta al comportamiento correcto en la tarea relacionada.

## Observación para agentes

Este documento no sustituye la intención de negocio; su objetivo es describir el punto de entrada técnico que probablemente habrá que tocar. Para entender el comportamiento esperado, debe combinarse con `context.md` y `tests.md`.
