-- ============================================
-- SCRIPT DE IMPORTACIÓN CSV - MÓDULO 4
-- Sistema de Operaciones Terrestres
-- ============================================

-- CATÁLOGOS (Tablas sin dependencias)

-- 01. EstadoOperacion
COPY operaciones_terrestres.EstadoOperacion(id_estado_operacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/01_estado_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 02. TipoActivo
COPY operaciones_terrestres.TipoActivo(id_tipo_activo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/02_tipo_activo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 03. EstadoActivo
COPY operaciones_terrestres.EstadoActivo(id_estado_activo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/03_estado_activo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 04. TipoVehiculo
COPY operaciones_terrestres.TipoVehiculo(id_tipo_vehiculo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/04_tipo_vehiculo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 05. EstadoVehiculo
COPY operaciones_terrestres.EstadoVehiculo(id_estado_vehiculo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/05_estado_vehiculo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 06. EspecialidadEmpleado
COPY operaciones_terrestres.EspecialidadEmpleado(id_especialidad_empleado, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/06_especialidad_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 07. EstadoContrato
COPY operaciones_terrestres.EstadoContrato(id_estado_contrato, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/07_estado_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 08. TipoTelefono
COPY operaciones_terrestres.TipoTelefono(id_tipo_telefono, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/08_tipo_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 09. TipoIncidencia
COPY operaciones_terrestres.TipoIncidencia(id_tipo_incidencia, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/09_tipo_incidencia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 10. EstadoIncidencia
COPY operaciones_terrestres.EstadoIncidencia(id_estado_incidencia, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/10_estado_incidencia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 11. TipoDocumento
COPY operaciones_terrestres.TipoDocumento(id_tipo_documento, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/11_tipo_documento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 12. TipoReporte
COPY operaciones_terrestres.TipoReporte(id_tipo_reporte, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/12_tipo_reporte.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 13. RolUsuario
COPY operaciones_terrestres.RolUsuario(id_rol_usuario, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/13_rol_usuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- 14. Contrato
COPY operaciones_terrestres.Contrato(id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/14_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 15. Empleado
COPY operaciones_terrestres.Empleado(id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/15_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 16. EmpleadoTelefono
COPY operaciones_terrestres.EmpleadoTelefono(id_empleado_telefono, id_empleado, telefono, id_tipo_telefono)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/16_empleado_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 17. Usuario
COPY operaciones_terrestres.Usuario(id_usuario, id_empleado, correo_electronico, contrasena, id_rol_usuario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/17_usuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 18. Operacion
COPY operaciones_terrestres.Operacion(id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/18_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 19. Ruta
COPY operaciones_terrestres.Ruta(id_ruta, codigo, origen, destino, duracion, tarifa)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/19_ruta.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 20. RutaTerrestre
COPY operaciones_terrestres.RutaTerrestre(id_ruta_terrestre, id_ruta)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/20_ruta_terrestre.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 21. Activo
COPY operaciones_terrestres.Activo(id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/21_activo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 22. Vehiculo
COPY operaciones_terrestres.Vehiculo(id_vehiculo, id_activo, placa, capacidad_ton, id_tipo_vehiculo, id_estado_vehiculo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/22_vehiculo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 23. Conductor
COPY operaciones_terrestres.Conductor(id_conductor, id_empleado, licencia, categoria, disponibilidad)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/23_conductor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 24. OperacionTerrestre
COPY operaciones_terrestres.OperacionTerrestre(id_operacion_terrestre, id_operacion, codigo, id_vehiculo, id_ruta_terrestre, id_conductor, costo_operacion_terrestre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/24_operacion_terrestre.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 25. ChecklistDespacho
COPY operaciones_terrestres.ChecklistDespacho(id_checklist, codigo, observaciones, combustible, frenos, id_operacion_terrestre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/25_checklist_despacho.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 26. Incidencia
COPY operaciones_terrestres.Incidencia(id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_estado_incidencia, id_operacion, id_usuario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/26_incidencia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 27. DocumentacionOperacion
COPY operaciones_terrestres.DocumentacionOperacion(id_documento, codigo, nombre, ruta_archivo, fecha_emision, id_tipo_documento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/27_documentacion_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 28. OperacionDocumento
COPY operaciones_terrestres.OperacionDocumento(id_operacion, id_documento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/28_operacion_documento.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 29. ReporteTransporte
COPY operaciones_terrestres.ReporteTransporte(id_reporte, codigo, id_tipo_reporte, fecha_generado, id_operacion_terrestre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_4/29_reporte_transporte.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- VERIFICACIÓN
-- ============================================

SELECT 'EstadoOperacion' AS tabla, COUNT(*) AS registros FROM operaciones_terrestres.EstadoOperacion
UNION ALL
SELECT 'Empleado', COUNT(*) FROM operaciones_terrestres.Empleado
UNION ALL
SELECT 'Usuario', COUNT(*) FROM operaciones_terrestres.Usuario
UNION ALL
SELECT 'Vehiculo', COUNT(*) FROM operaciones_terrestres.Vehiculo
UNION ALL
SELECT 'Conductor', COUNT(*) FROM operaciones_terrestres.Conductor
UNION ALL
SELECT 'Operacion', COUNT(*) FROM operaciones_terrestres.Operacion
UNION ALL
SELECT 'OperacionTerrestre', COUNT(*) FROM operaciones_terrestres.OperacionTerrestre
UNION ALL
SELECT 'Incidencia', COUNT(*) FROM operaciones_terrestres.Incidencia
ORDER BY tabla;

-- ============================================
-- FIN DEL SCRIPT DE IMPORTACIÓN
-- ============================================