-- ============================================
-- SCRIPT DE IMPORTACIÓN CSV - MÓDULO 1
-- Sistema de Gestión de Reservas
-- ============================================

-- CATÁLOGOS (Tablas sin dependencias)

-- 01. TipoTelefono
COPY gestion_reserva.TipoTelefono(id_tipo_telefono, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/01_tipo_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 02. EspecialidadEmpleado
COPY gestion_reserva.EspecialidadEmpleado(id_especialidad_empleado, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/02_especialidad_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 03. EstadoContrato
COPY gestion_reserva.EstadoContrato(id_estado_contrato, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/03_estado_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 04. EstadoContenedor
COPY gestion_reserva.EstadoContenedor(id_estado_contenedor, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/04_estado_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 05. TipoContenedor
COPY gestion_reserva.TipoContenedor(id_tipo_contenedor, codigo, nombre, costo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/05_tipo_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 06. EstadoEmbarcacion
COPY gestion_reserva.EstadoEmbarcacion(id_estado_embarcacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/06_estado_embarcacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 07. EstadoOperacion
COPY gestion_reserva.EstadoOperacion(id_estado_operacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/07_estado_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 08. EstadoReserva
COPY gestion_reserva.EstadoReserva(id_estado_reserva, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/08_estado_reserva.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- 09. Contrato
COPY gestion_reserva.Contrato(id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/09_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 10. Empleado
COPY gestion_reserva.Empleado(id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad, id_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/10_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 11. EmpleadoTelefono
COPY gestion_reserva.EmpleadoTelefono(id_empleado_telefono, id_empleado, telefono, id_tipo_telefono)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/11_empleado_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 12. AgenteReservas
COPY gestion_reserva.AgenteReservas(id_agente_reservas, id_empleado)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/12_agente_reservas.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 13. Cliente
COPY gestion_reserva.Cliente(id_cliente, ruc, razon_social, direccion, email)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/13_cliente.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 14. ClienteTelefono
COPY gestion_reserva.ClienteTelefono(id_cliente_telefono, id_cliente, telefono, id_tipo_telefono)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/14_cliente_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 15. AtencionCliente
COPY gestion_reserva.AtencionCliente(id_atencion_cliente, id_cliente, id_agente_reservas, fecha_atencion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/15_atencion_cliente.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 16. Contenedor
COPY gestion_reserva.Contenedor(id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/16_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 17. ContenedorMercancia
COPY gestion_reserva.ContenedorMercancia(id_contenedor_mercancia, id_contenedor, tipo_mercancia)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/17_contenedor_mercancia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 18. Buque
COPY gestion_reserva.Buque(id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/18_buque.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 19. Certificacion
COPY gestion_reserva.Certificacion(id_certificacion, nombre, descripcion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/19_certificacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 20. CertificacionBuque
COPY gestion_reserva.CertificacionBuque(id_certificacion_buque, id_buque, id_certificacion, fecha_emision, fecha_vencimiento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/20_certificacion_buque.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 21. Ruta
COPY gestion_reserva.Ruta(id_ruta, codigo, origen, destino, duracion, tarifa)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/21_ruta.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 22. Operacion
COPY gestion_reserva.Operacion(id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/22_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 23. OperacionTerrestre
COPY gestion_reserva.OperacionTerrestre(id_operacion_terrestre, id_operacion, codigo, costo_operacion_terrestre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/23_operacion_terrestre.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 24. OperacionMaritima
COPY gestion_reserva.OperacionMaritima(id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, porcentaje_trayecto, id_buque)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/24_operacion_maritima.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 25. Reserva
COPY gestion_reserva.Reserva(id_reserva, codigo, fecha_registro, id_estado_reserva, pago_total, ruc_cliente, id_agente_reservas, matricula_buque, id_ruta)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/25_reserva.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

-- 26. ReservaContenedor
COPY gestion_reserva.ReservaContenedor(id_reserva_contenedor, id_reserva, id_contenedor, fecha_asignacion, cantidad)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/26_reserva_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 27. ReservaOperacionMaritima
COPY gestion_reserva.ReservaOperacionMaritima(id_reserva_operacion_maritima, id_reserva, id_operacion_maritima, fecha_vinculacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/27_reserva_operacion_maritima.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 28. ReservaOperacionTerrestre
COPY gestion_reserva.ReservaOperacionTerrestre(id_reserva_operacion_terrestre, id_reserva, id_operacion_terrestre, fecha_vinculacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_1/28_reserva_operacion_terrestre.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- VERIFICACIÓN
-- ============================================

SELECT 'TipoTelefono' AS tabla, COUNT(*) AS registros FROM gestion_reserva.TipoTelefono
UNION ALL
SELECT 'Empleado', COUNT(*) FROM gestion_reserva.Empleado
UNION ALL
SELECT 'Cliente', COUNT(*) FROM gestion_reserva.Cliente
UNION ALL
SELECT 'AgenteReservas', COUNT(*) FROM gestion_reserva.AgenteReservas
UNION ALL
SELECT 'Contenedor', COUNT(*) FROM gestion_reserva.Contenedor
UNION ALL
SELECT 'Buque', COUNT(*) FROM gestion_reserva.Buque
UNION ALL
SELECT 'Ruta', COUNT(*) FROM gestion_reserva.Ruta
UNION ALL
SELECT 'Operacion', COUNT(*) FROM gestion_reserva.Operacion
UNION ALL
SELECT 'Reserva', COUNT(*) FROM gestion_reserva.Reserva
UNION ALL
SELECT 'ReservaContenedor', COUNT(*) FROM gestion_reserva.ReservaContenedor
ORDER BY tabla;

-- ============================================
-- FIN DEL SCRIPT DE IMPORTACIÓN
-- ============================================