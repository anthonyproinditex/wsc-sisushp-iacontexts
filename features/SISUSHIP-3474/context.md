# Contexto de la historia: SISUSHIP-3474

## Propósito

Esta historia define la gestión de validaciones durante un traspaso entre camiones dentro del flujo de detalle del camión. El objetivo es avisar al operario cuando existen condiciones que pueden comprometer la operación, permitir tomar decisiones informadas y evitar errores operativos.

## Usuario

Operario del almacén que realiza el traspaso entre camiones.

## Problema de negocio

El flujo de traspaso entre camiones ya tiene un happy path válido, pero no contempla escenarios de riesgo o incompatibilidad que puedan ocurrir cuando se cambia la planificación o la carga del camión destino.

Si el destino no tiene la misma planificación, si la capacidad no es suficiente, si el origen está finalizado, si el destino está cerrado o si la ETD ya ha pasado, el sistema debe avisar al usuario antes de confirmar la operación.

## Objetivo funcional

Cuando se realiza un traspaso entre camiones, el sistema debe evaluar las condiciones de compatibilidad y mostrar avisos claros con el impacto real del traspaso.

## Reglas clave

### 1. Planificación incompatible (rutas/tiendas)

Si el camión destino no tiene todas las tiendas que tiene el camión origen, se debe mostrar un warning previo a la confirmación del traspaso.

Debe indicarse:
- que la planificación no coincide,
- las rutas que se van a añadir al destino como consecuencia del traspaso,
- y que el usuario debe confirmar su decisión.

En el caso de tiendas sin ruta asociada, debe mostrarse igualmente la información relevante aunque no exista ruta.

### 2. Volumen insuficiente en camión destino

Si la mercancía a traspasar supera la capacidad disponible del camión destino, debe mostrarse un aviso de volumen excedido y solicitar confirmación explícita para continuar.

### 3. Camión origen finalizado

Si el camión origen está finalizado, el sistema debe informar del estado y ofrecer la posibilidad de reabrirlo directamente desde el mismo aviso.

### 4. Camión destino cerrado

Si el camión destino está cerrado, se debe avisar al usuario y no permitir reabrirlo desde el aviso. La re apertura debe hacerse mediante el proceso habitual.

### 5. ETD del camión destino en el pasado

Si la ETD del camión destino ya ha pasado, el sistema debe mostrar un aviso informativo, pero permitir continuar si el usuario confirma.

### 6. Orden incompatible

Debe mostrarse un aviso de orden incompatible del camión destino.

## Criterios de aceptación resumidos

- Un destino con distinta planificación muestra un warning previo con rutas a añadir y confirmación.
- Las tiendas sin ruta asociada deben aparecer en el aviso de forma relevante.
- Un destino con capacidad insuficiente muestra aviso de volumen excedido.
- Un camión origen finalizado ofrece re apertura desde la propia notificación.
- Un camión destino cerrado muestra aviso pero no ofrece re apertura directa.
- Un destino con ETD pasada muestra aviso informativo pero permite continuar si el usuario confirma.

## Dependencias técnicas

La historia menciona reutilizar endpoint y lambda del caso de transfer/validate y un nuevo endpoint para buscar camiones.

## Documentación de referencia

- Jira: SISUSHIP-3474
- Contexto relacionado: SISUSHIP-3473
- Responsables: mantenidos en Jira para actualizaciones del equipo.

## Observación para agentes

Este documento es la fuente de contexto funcional. Si se necesita entender el detalle técnico exacto de los endpoints, se debe consultar `technical.md`. Si se necesita validar comportamiento, se debe consultar `tests.md`.
