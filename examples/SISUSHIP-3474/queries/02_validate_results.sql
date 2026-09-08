-- Escenario: comprobación de resultados de la validación del traspaso entre camiones.
-- Objetivo: confirmar que el destino no tiene la misma planificación, la capacidad es insuficiente y se devuelve el nivel de incompatibilidad.

SELECT
  t.id,
  t.name,
  t.status,
  t.etd,
  t.capacity_volume,
  SUM(b.volume) AS current_volume
FROM truck t
LEFT JOIN bulk b ON b.truck_id = t.id
WHERE t.id IN ('origin-truck-01', 'dest-truck-01')
GROUP BY t.id, t.name, t.status, t.etd, t.capacity_volume;

-- Resultado esperado:
-- - Ambos camiones existen.
-- - El destino tiene menos capacidad disponible que la carga a traspasar.
-- - La planificación no coincide, porque el camión destino no incluye todas las rutas/tiendas del origen.
