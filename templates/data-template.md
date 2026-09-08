# Data and query template

## Objetivo

Centralizar el conjunto de datos mínimos necesarios para reproducir, validar y limpiar un escenario de prueba.

## Tipos de queries

- `01_seed_data.sql`: inserta el estado base necesario.
- `02_validate_results.sql`: consulta los datos resultantes.
- `03_cleanup.sql`: elimina datos generados para dejar el entorno limpio.

## Buenas prácticas

- Usar IDs estables y repetibles.
- Documentar el propósito de cada bloque de SQL.
- Mantener las queries pequeñas y legibles.
- No mezclar validación y limpieza en la misma query.
- Añadir comentarios con el contexto del escenario.

## Estructura sugerida

```sql
-- Escenario: {descripción}
-- Objetivo: {qué comprueba esta query}

INSERT INTO ...;

SELECT ...;

DELETE FROM ...;
```

## Recomendación

Cada historia debe incluir al menos una query de inserción, una de validación y una de limpieza. Esto permite automatizar pruebas, reproducciones manuales y comprobaciones de regresión.
