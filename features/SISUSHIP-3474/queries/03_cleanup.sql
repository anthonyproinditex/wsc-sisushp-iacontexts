-- Escenario: limpieza posterior a validación.
-- Objetivo: dejar el entorno en estado neutro tras ejecutar la prueba de traspaso.

DELETE FROM bulk WHERE truck_id IN ('origin-truck-01', 'dest-truck-01');
DELETE FROM truck_route WHERE truck_id IN ('origin-truck-01', 'dest-truck-01');
DELETE FROM truck WHERE id IN ('origin-truck-01', 'dest-truck-01');
