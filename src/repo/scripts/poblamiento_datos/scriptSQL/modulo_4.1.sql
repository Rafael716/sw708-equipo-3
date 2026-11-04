-- ============================================
-- SCRIPT DE IMPORTACION CSV - MODULO 4.1
-- Sistema de Mantenimiento Logistico
-- ============================================

-- CATALOGOS (Tablas sin dependencias)

-- 01. EstadoOperacion
COPY mantenimiento_logistico.EstadoOperacion(id_estado_operacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/01_estado_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 02. EstadoPlan
COPY mantenimiento_logistico.EstadoPlan(id_estado_plan, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/02_estado_plan.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 03. EstadoSolicitud
COPY mantenimiento_logistico.EstadoSolicitud(id_estado_solicitud, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/03_estado_solicitud.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 04. EstadoOrden
COPY mantenimiento_logistico.EstadoOrden(id_estado_orden, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/04_estado_orden.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 05. EstadoTarea
COPY mantenimiento_logistico.EstadoTarea(id_estado_tarea, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/05_estado_tarea.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 06. TipoActivo
COPY mantenimiento_logistico.TipoActivo(id_tipo_activo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/06_tipo_activo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 07. EstadoActivo
COPY mantenimiento_logistico.EstadoActivo(id_estado_activo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/07_estado_activo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 08. TipoMantenimiento
COPY mantenimiento_logistico.TipoMantenimiento(id_tipo_mantenimiento, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/08_tipo_mantenimiento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 09. Prioridad
COPY mantenimiento_logistico.Prioridad(id_prioridad, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/09_prioridad.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 10. EspecialidadEmpleado
COPY mantenimiento_logistico.EspecialidadEmpleado(id_especialidad_empleado, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/10_especialidad_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 11. EstadoContrato
COPY mantenimiento_logistico.EstadoContrato(id_estado_contrato, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/11_estado_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 12. TipoTelefono
COPY mantenimiento_logistico.TipoTelefono(id_tipo_telefono, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/12_tipo_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- 13. Contrato
COPY mantenimiento_logistico.Contrato(id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/13_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 14. Empleado
COPY mantenimiento_logistico.Empleado(id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/14_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 15. EmpleadoTelefono
COPY mantenimiento_logistico.EmpleadoTelefono(id_empleado_telefono, id_empleado, telefono, id_tipo_telefono)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/15_empleado_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 16. Tecnico
COPY mantenimiento_logistico.Tecnico(id_tecnico, id_empleado, especialidad)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/16_tecnico.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 17. ResponsableSolicitud
COPY mantenimiento_logistico.ResponsableSolicitud(id_responsable_solicitud, id_empleado)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/17_responsable_solicitud.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 18. Activo
COPY mantenimiento_logistico.Activo(id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/18_activo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 19. Repuesto
COPY mantenimiento_logistico.Repuesto(id_repuesto, codigo, nombre, stock, stock_minimo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/19_repuesto.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 20. PlanMantenimiento
COPY mantenimiento_logistico.PlanMantenimiento(id_plan_mantenimiento, codigo, id_estado_plan, frecuencia, fecha_inicio, id_activo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/20_plan_mantenimiento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 21. SolicitudMantenimiento
COPY mantenimiento_logistico.SolicitudMantenimiento(id_solicitud_mantenimiento, codigo, descripcion_problema, fecha_solicitud, id_prioridad, id_estado_solicitud, id_responsable_solicitud, id_activo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/21_solicitud_mantenimiento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 22. Operacion
COPY mantenimiento_logistico.Operacion(id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/22_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 23. OperacionMantenimiento
COPY mantenimiento_logistico.OperacionMantenimiento(id_operacion_mantenimiento, id_operacion, id_plan_mantenimiento, id_solicitud_mantenimiento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/23_operacion_mantenimiento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 24. OrdenMantenimiento
COPY mantenimiento_logistico.OrdenMantenimiento(id_orden, codigo, fecha_generada, fecha_programada, fecha_cierre, id_tipo_mantenimiento, id_estado_orden, id_operacion_mantenimiento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/24_orden_mantenimiento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 25. TareaMantenimiento
COPY mantenimiento_logistico.TareaMantenimiento(id_tarea, descripcion, id_estado_tarea, id_orden)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/25_tarea_mantenimiento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

-- 26. OperacionMantenimientoTecnico
COPY mantenimiento_logistico.OperacionMantenimientoTecnico(id_operacion_mantenimiento, id_tecnico, fecha_asignacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/26_operacion_mantenimiento_tecnico.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 27. OperacionMantenimientoRepuesto
COPY mantenimiento_logistico.OperacionMantenimientoRepuesto(id_operacion_mantenimiento, id_repuesto, fecha_uso, cantidad, precio_unitario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4.1/27_operacion_mantenimiento_repuesto.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- VERIFICACION
-- ============================================

SELECT 'EstadoOperacion' AS tabla, COUNT(*) AS registros FROM mantenimiento_logistico.EstadoOperacion
UNION ALL
SELECT 'EstadoPlan', COUNT(*) FROM mantenimiento_logistico.EstadoPlan
UNION ALL
SELECT 'EstadoSolicitud', COUNT(*) FROM mantenimiento_logistico.EstadoSolicitud
UNION ALL
SELECT 'EstadoOrden', COUNT(*) FROM mantenimiento_logistico.EstadoOrden
UNION ALL
SELECT 'EstadoTarea', COUNT(*) FROM mantenimiento_logistico.EstadoTarea
UNION ALL
SELECT 'TipoActivo', COUNT(*) FROM mantenimiento_logistico.TipoActivo
UNION ALL
SELECT 'EstadoActivo', COUNT(*) FROM mantenimiento_logistico.EstadoActivo
UNION ALL
SELECT 'TipoMantenimiento', COUNT(*) FROM mantenimiento_logistico.TipoMantenimiento
UNION ALL
SELECT 'Prioridad', COUNT(*) FROM mantenimiento_logistico.Prioridad
UNION ALL
SELECT 'EspecialidadEmpleado', COUNT(*) FROM mantenimiento_logistico.EspecialidadEmpleado
UNION ALL
SELECT 'EstadoContrato', COUNT(*) FROM mantenimiento_logistico.EstadoContrato
UNION ALL
SELECT 'TipoTelefono', COUNT(*) FROM mantenimiento_logistico.TipoTelefono
UNION ALL
SELECT 'Contrato', COUNT(*) FROM mantenimiento_logistico.Contrato
UNION ALL
SELECT 'Empleado', COUNT(*) FROM mantenimiento_logistico.Empleado
UNION ALL
SELECT 'EmpleadoTelefono', COUNT(*) FROM mantenimiento_logistico.EmpleadoTelefono
UNION ALL
SELECT 'Tecnico', COUNT(*) FROM mantenimiento_logistico.Tecnico
UNION ALL
SELECT 'ResponsableSolicitud', COUNT(*) FROM mantenimiento_logistico.ResponsableSolicitud
UNION ALL
SELECT 'Activo', COUNT(*) FROM mantenimiento_logistico.Activo
UNION ALL
SELECT 'Repuesto', COUNT(*) FROM mantenimiento_logistico.Repuesto
UNION ALL
SELECT 'PlanMantenimiento', COUNT(*) FROM mantenimiento_logistico.PlanMantenimiento
UNION ALL
SELECT 'SolicitudMantenimiento', COUNT(*) FROM mantenimiento_logistico.SolicitudMantenimiento
UNION ALL
SELECT 'Operacion', COUNT(*) FROM mantenimiento_logistico.Operacion
UNION ALL
SELECT 'OperacionMantenimiento', COUNT(*) FROM mantenimiento_logistico.OperacionMantenimiento
UNION ALL
SELECT 'OrdenMantenimiento', COUNT(*) FROM mantenimiento_logistico.OrdenMantenimiento
UNION ALL
SELECT 'TareaMantenimiento', COUNT(*) FROM mantenimiento_logistico.TareaMantenimiento
UNION ALL
SELECT 'OperacionMantenimientoTecnico', COUNT(*) FROM mantenimiento_logistico.OperacionMantenimientoTecnico
UNION ALL
SELECT 'OperacionMantenimientoRepuesto', COUNT(*) FROM mantenimiento_logistico.OperacionMantenimientoRepuesto
ORDER BY tabla;

-- ============================================
-- FIN DEL SCRIPT DE IMPORTACION
-- ============================================