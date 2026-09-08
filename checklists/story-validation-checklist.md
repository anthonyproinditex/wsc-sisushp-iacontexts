# Story validation checklist

## Validación funcional

- [ ] El flujo principal funciona.
- [ ] Los casos alternativos se gestionan correctamente.
- [ ] Las validaciones de negocio se ejecutan con el contexto correcto.
- [ ] Los errores son claros y consistentes.
- [ ] No hay regresiones en casos relacionados.

## Validación técnica

- [ ] El endpoint o caso de uso responde con el formato esperado.
- [ ] Los contratos de entrada/salida se mantienen.
- [ ] Se reutiliza lógica o endpoints ya existentes cuando es correcto.
- [ ] No hay cambios inesperados fuera del alcance.

## Validación de datos

- [ ] Las queries de inserción dejan el escenario reproducible.
- [ ] Las queries de validación comprueban el resultado esperado.
- [ ] La limpieza elimina los datos creados para la prueba.

## Documentación

- [ ] La historia queda entendible por un agente sin contexto previo.
- [ ] El README de la historia referencia los recursos compartidos.
- [ ] El detalle técnico, los tests y los datos de prueba están en línea.
