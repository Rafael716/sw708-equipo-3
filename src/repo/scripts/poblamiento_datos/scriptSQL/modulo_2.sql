-- ============================================
-- SCRIPT DE IMPORTACION CSV - PERSONAL Y TRIPULACION
-- Sistema de Gestion del Personal y Tripulacion
-- ============================================

-- CATALOGOS (Tablas sin dependencias)

-- 01. EspecialidadEmpleado
COPY personal_tripulacion.EspecialidadEmpleado(id_especialidad_empleado, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/01_especialidad_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 02. EstatusNavegacion
COPY personal_tripulacion.EstatusNavegacion(id_estatus_navegacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/02_estatus_navegacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 03. RolUsuario
COPY personal_tripulacion.RolUsuario(id_rol_usuario, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/03_rol_usuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 04. EstadoOperacion
COPY personal_tripulacion.EstadoOperacion(id_estado_operacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/04_estado_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 05. EstadoEmbarcacion
COPY personal_tripulacion.EstadoEmbarcacion(id_estado_embarcacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/05_estado_embarcacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 06. EstadoContrato
COPY personal_tripulacion.EstadoContrato(id_estado_contrato, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/06_estado_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 07. Certificacion
COPY personal_tripulacion.Certificacion(id_certificacion, nombre, descripcion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/07_certificacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- 08. Contrato
COPY personal_tripulacion.Contrato(id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/08_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 09. Empleado
COPY personal_tripulacion.Empleado(id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, anios_experiencia, id_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/09_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 10. Usuario
COPY personal_tripulacion.Usuario(id_usuario, correo_electronico, contrasena, id_rol_usuario, id_empleado)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/10_usuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 11. Buque
COPY personal_tripulacion.Buque(id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/11_buque.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 12. Operacion
COPY personal_tripulacion.Operacion(id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/12_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 13. OperacionMaritima
COPY personal_tripulacion.OperacionMaritima(id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, id_estatus_navegacion, porcentaje_trayecto, id_buque)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/13_operacion_maritima.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 14. Tripulante
COPY personal_tripulacion.Tripulante(id_tripulante, id_empleado, disponibilidad, nacionalidad)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/14_tripulante.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

-- 15. UsuarioOperacion
COPY personal_tripulacion.UsuarioOperacion(id_usuario_operacion, id_usuario, id_operacion, fecha_asignacion, rol_en_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/15_usuario_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 16. CertificacionEmpleado
COPY personal_tripulacion.CertificacionEmpleado(id_certificacion_empleado, id_empleado, id_certificacion, fecha_emision, fecha_vencimiento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/16_certificacion_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 17. BuqueTripulante
COPY personal_tripulacion.BuqueTripulante(id_buque_tripulante, id_buque, id_tripulante, fecha_asignacion, hora_asignacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_2/17_buque_tripulante.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- VERIFICACION
-- ============================================

SELECT 'EspecialidadEmpleado' AS tabla, COUNT(*) AS registros FROM personal_tripulacion.EspecialidadEmpleado
UNION ALL
SELECT 'EstatusNavegacion', COUNT(*) FROM personal_tripulacion.EstatusNavegacion
UNION ALL
SELECT 'RolUsuario', COUNT(*) FROM personal_tripulacion.RolUsuario
UNION ALL
SELECT 'EstadoOperacion', COUNT(*) FROM personal_tripulacion.EstadoOperacion
UNION ALL
SELECT 'EstadoEmbarcacion', COUNT(*) FROM personal_tripulacion.EstadoEmbarcacion
UNION ALL
SELECT 'EstadoContrato', COUNT(*) FROM personal_tripulacion.EstadoContrato
UNION ALL
SELECT 'Certificacion', COUNT(*) FROM personal_tripulacion.Certificacion
UNION ALL
SELECT 'Contrato', COUNT(*) FROM personal_tripulacion.Contrato
UNION ALL
SELECT 'Empleado', COUNT(*) FROM personal_tripulacion.Empleado
UNION ALL
SELECT 'Usuario', COUNT(*) FROM personal_tripulacion.Usuario
UNION ALL
SELECT 'Buque', COUNT(*) FROM personal_tripulacion.Buque
UNION ALL
SELECT 'Operacion', COUNT(*) FROM personal_tripulacion.Operacion
UNION ALL
SELECT 'OperacionMaritima', COUNT(*) FROM personal_tripulacion.OperacionMaritima
UNION ALL
SELECT 'Tripulante', COUNT(*) FROM personal_tripulacion.Tripulante
UNION ALL
SELECT 'UsuarioOperacion', COUNT(*) FROM personal_tripulacion.UsuarioOperacion
UNION ALL
SELECT 'CertificacionEmpleado', COUNT(*) FROM personal_tripulacion.CertificacionEmpleado
UNION ALL
SELECT 'BuqueTripulante', COUNT(*) FROM personal_tripulacion.BuqueTripulante
ORDER BY tabla;

-- ============================================
-- FIN DEL SCRIPT DE IMPORTACION
-- ============================================