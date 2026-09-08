-- Escenario: preparación base para validación de traspaso entre camiones.
-- Objetivo: crear un origen, un destino, rutas y carga que permitan comprobar incompatibilidades.

-- Ejemplo de base para un escenario realista.
-- Debe adaptarse a la estructura real de la base de datos del proyecto.

INSERT INTO truck (id, name, status, etd, capacity_volume, is_finalized)
VALUES
  ('origin-truck-01', 'TRUCK ORIGEN 1', 'ACTIVE', '2026-09-10T10:00:00Z', 5000, false),
  ('dest-truck-01', 'TRUCK DESTINO 1', 'ACTIVE', '2026-09-10T11:00:00Z', 3000, false);

INSERT INTO truck_route (truck_id, route_id, location_id)
VALUES
  ('origin-truck-01', 760, 10701),
  ('origin-truck-01', 761, 10702),
  ('dest-truck-01', 760, 10701);

INSERT INTO bulk (id, truck_id, volume, status)
VALUES
  ('bulk-001', 'origin-truck-01', 1200, 'READY'),
  ('bulk-002', 'origin-truck-01', 900, 'READY');

SELECT *
FROM truck
WHERE id IN ('origin-truck-01', 'dest-truck-01');
