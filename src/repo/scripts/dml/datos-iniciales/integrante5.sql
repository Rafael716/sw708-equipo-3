-- ============================================
-- DML: monitoreo
-- Sistema de Monitoreo de Entrega
-- Script de inserción de datos de prueba
-- ============================================

-- ============================================
-- TABLAS DE DOMINIO (LOOKUP TABLES)
-- ============================================

-- Estados de Operación
INSERT INTO monitoreo.EstadoOperacion (id_estado_operacion, nombre) VALUES
(gen_random_uuid(), 'Pendiente'),
(gen_random_uuid(), 'En curso'),
(gen_random_uuid(), 'Completada'),
(gen_random_uuid(), 'Cancelada');

-- Especialidades de Empleado
INSERT INTO monitoreo.EspecialidadEmpleado (id_especialidad_empleado, nombre) VALUES
(gen_random_uuid(), 'Supervisor'),
(gen_random_uuid(), 'Operario'),
(gen_random_uuid(), 'Administrativo'),
(gen_random_uuid(), 'Técnico'),
(gen_random_uuid(), 'Gerente');

-- Estados de Contenedor
INSERT INTO monitoreo.EstadoContenedor (id_estado_contenedor, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En tránsito'),
(gen_random_uuid(), 'Entregado'),
(gen_random_uuid(), 'En mantenimiento'),
(gen_random_uuid(), 'No disponible');

-- Estados de Entrega
INSERT INTO monitoreo.EstadoEntrega (id_estado_entrega, nombre) VALUES
(gen_random_uuid(), 'Programada'),
(gen_random_uuid(), 'En tránsito'),
(gen_random_uuid(), 'Completada'),
(gen_random_uuid(), 'Fallida');

-- Tipos de Sensor
INSERT INTO monitoreo.TipoSensor (id_tipo_sensor, nombre) VALUES
(gen_random_uuid(), 'Temperatura'),
(gen_random_uuid(), 'Humedad'),
(gen_random_uuid(), 'Vibración'),
(gen_random_uuid(), 'GPS'),
(gen_random_uuid(), 'Apertura');

-- Roles de Sensor
INSERT INTO monitoreo.RolSensor (id_rol_sensor, nombre) VALUES
(gen_random_uuid(), 'Monitoreo'),
(gen_random_uuid(), 'Control'),
(gen_random_uuid(), 'Alerta'),
(gen_random_uuid(), 'Registro');

-- Tipos de Notificación
INSERT INTO monitoreo.TipoNotificacion (id_tipo_notificacion, nombre) VALUES
(gen_random_uuid(), 'Alerta'),
(gen_random_uuid(), 'Advertencia'),
(gen_random_uuid(), 'Información'),
(gen_random_uuid(), 'Crítica');

-- Tipos de Incidencia
INSERT INTO monitoreo.TipoIncidencia (id_tipo_incidencia, nombre) VALUES
(gen_random_uuid(), 'Seguridad'),
(gen_random_uuid(), 'Operacional'),
(gen_random_uuid(), 'Ambiental'),
(gen_random_uuid(), 'Administrativa');

-- Estados de Incidencia
INSERT INTO monitoreo.EstadoIncidencia (id_estado_incidencia, nombre) VALUES
(gen_random_uuid(), 'Reportada'),
(gen_random_uuid(), 'En investigación'),
(gen_random_uuid(), 'Resuelta'),
(gen_random_uuid(), 'Cerrada');

-- Estados de Embarcación
INSERT INTO monitoreo.EstadoEmbarcacion (id_estado_embarcacion, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En operación'),
(gen_random_uuid(), 'Mantenimiento'),
(gen_random_uuid(), 'Fuera de servicio');

-- Tipos de Vehículo
INSERT INTO monitoreo.TipoVehiculo (id_tipo_vehiculo, nombre) VALUES
(gen_random_uuid(), 'Camión rígido'),
(gen_random_uuid(), 'Tracto camión'),
(gen_random_uuid(), 'Furgón'),
(gen_random_uuid(), 'Camión cisterna');

-- Estados de Vehículo
INSERT INTO monitoreo.EstadoVehiculo (id_estado_vehiculo, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En ruta'),
(gen_random_uuid(), 'Mantenimiento'),
(gen_random_uuid(), 'Fuera de servicio');

-- Roles de Usuario
INSERT INTO monitoreo.RolUsuario (id_rol_usuario, nombre) VALUES
(gen_random_uuid(), 'Administrador'),
(gen_random_uuid(), 'Inspector'),
(gen_random_uuid(), 'Coordinador'),
(gen_random_uuid(), 'Operador'),
(gen_random_uuid(), 'Consultor');

-- Tipos de Activo
INSERT INTO monitoreo.TipoActivo (id_tipo_activo, nombre) VALUES
(gen_random_uuid(), 'Vehículo'),
(gen_random_uuid(), 'Equipo portuario'),
(gen_random_uuid(), 'Maquinaria');

-- Estados de Activo
INSERT INTO monitoreo.EstadoActivo (id_estado_activo, nombre) VALUES
(gen_random_uuid(), 'Operativo'),
(gen_random_uuid(), 'Mantenimiento'),
(gen_random_uuid(), 'Inactivo'),
(gen_random_uuid(), 'Reparación');

-- Tipos de Documento
INSERT INTO monitoreo.TipoDocumento (id_tipo_documento, nombre) VALUES
(gen_random_uuid(), 'Bill of Lading'),
(gen_random_uuid(), 'Manifiesto'),
(gen_random_uuid(), 'Certificado sanitario'),
(gen_random_uuid(), 'DUA'),
(gen_random_uuid(), 'Packing List');

-- Tipos de Contenedor
INSERT INTO monitoreo.TipoContenedor (id_tipo_contenedor, codigo, nombre, costo) VALUES
(gen_random_uuid(), 'TC-001', 'Estándar 20 pies', 2500.00),
(gen_random_uuid(), 'TC-002', 'Estándar 40 pies', 3500.00),
(gen_random_uuid(), 'TC-003', 'Refrigerado 20 pies', 4500.00),
(gen_random_uuid(), 'TC-004', 'Refrigerado 40 pies', 6000.00),
(gen_random_uuid(), 'TC-005', 'Open Top 20 pies', 3000.00),
(gen_random_uuid(), 'TC-006', 'Tank Container', 5500.00);

-- Estados de Contrato
INSERT INTO monitoreo.EstadoContrato (id_estado_contrato, nombre) VALUES
(gen_random_uuid(), 'Activo'),
(gen_random_uuid(), 'Vigente'),
(gen_random_uuid(), 'Suspendido'),
(gen_random_uuid(), 'Cancelado');

-- Tipos de Teléfono
INSERT INTO monitoreo.TipoTelefono (id_tipo_telefono, nombre) VALUES
(gen_random_uuid(), 'Móvil'),
(gen_random_uuid(), 'Fijo'),
(gen_random_uuid(), 'Satelital'),
(gen_random_uuid(), 'VoIP');

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- Contratos
INSERT INTO monitoreo.Contrato (id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato) VALUES
(gen_random_uuid(), '2024-01-15', '2025-01-15', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-03-20', '2025-03-20', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-05-10', '2025-05-10', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-07-01', '2025-07-01', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-08-15', '2025-08-15', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-09-01', '2025-09-01', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-10-10', '2025-10-10', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-11-05', '2025-11-05', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2024-12-01', '2025-12-01', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid(), '2025-01-20', '2026-01-20', (SELECT id_estado_contrato FROM monitoreo.EstadoContrato WHERE nombre = 'Vigente'));

-- Empleados
INSERT INTO monitoreo.Empleado (id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato) VALUES
(gen_random_uuid(), 'EMP-001', '12345678', 'Juan', 'Pérez García', 'Av. Marina 123, Callao', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Gerente'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-01-15')),
(gen_random_uuid(), 'EMP-002', '23456789', 'María', 'López Rodríguez', 'Jr. Lima 456, Lima', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Supervisor'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-03-20')),
(gen_random_uuid(), 'EMP-003', '34567890', 'Carlos', 'Sánchez Torres', 'Av. Grau 789, Callao', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Técnico'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-05-10')),
(gen_random_uuid(), 'EMP-004', '45678901', 'Ana', 'Martínez Flores', 'Calle Real 321, Lima', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Operario'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-07-01')),
(gen_random_uuid(), 'EMP-005', '56789012', 'Luis', 'González Vega', 'Av. Colonial 654, Lima', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Operario'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-08-15')),
(gen_random_uuid(), 'EMP-006', '67890123', 'Carmen', 'Ramírez Castro', 'Jr. Unión 987, Callao', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Administrativo'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-09-01')),
(gen_random_uuid(), 'EMP-007', '78901234', 'Pedro', 'Díaz Morales', 'Av. Benavides 147, Lima', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Técnico'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-10-10')),
(gen_random_uuid(), 'EMP-008', '89012345', 'Rosa', 'Fernández Silva', 'Calle Los Pinos 258, Callao', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Operario'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-11-05')),
(gen_random_uuid(), 'EMP-009', '90123456', 'Jorge', 'Torres Mendoza', 'Av. Arequipa 369, Lima', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Supervisor'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2024-12-01')),
(gen_random_uuid(), 'EMP-010', '01234567', 'Elena', 'Vargas Quispe', 'Jr. Tacna 741, Callao', 
    (SELECT id_especialidad_empleado FROM monitoreo.EspecialidadEmpleado WHERE nombre = 'Técnico'),
    (SELECT id_contrato FROM monitoreo.Contrato WHERE fecha_emision = '2025-01-20'));

-- Teléfonos de Empleados
INSERT INTO monitoreo.EmpleadoTelefono (id_empleado_telefono, id_empleado, telefono, id_tipo_telefono) VALUES
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-001'), '987654321', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-001'), '014567890', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Fijo')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-002'), '998765432', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-003'), '976543210', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-003'), '014123456', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Fijo')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-004'), '965432109', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-005'), '954321098', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-006'), '943210987', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-007'), '932109876', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-008'), '921098765', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-009'), '910987654', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-010'), '909876543', 
    (SELECT id_tipo_telefono FROM monitoreo.TipoTelefono WHERE nombre = 'Móvil'));

-- Operadores
INSERT INTO monitoreo.Operador (id_operador, id_empleado, turno, zona_monitoreo) VALUES
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-002'), 'Mañana', 'Zona Norte - Terminal Callao'),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-004'), 'Tarde', 'Zona Sur - Almacén Central'),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-005'), 'Noche', 'Zona Norte - Terminal Callao'),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-008'), 'Mañana', 'Zona Este - Puerto del Callao'),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-009'), 'Tarde', 'Zona Oeste - Depósito Lima');

-- Usuarios
INSERT INTO monitoreo.Usuario (id_usuario, id_empleado, correo_electronico, contrasena, id_rol_usuario) VALUES
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-001'), 'juan.perez@logistica.com', 
    '$2y$10$abcdefghijklmnopqrstuvwxyz1234567890', (SELECT id_rol_usuario FROM monitoreo.RolUsuario WHERE nombre = 'Administrador')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-002'), 'maria.lopez@logistica.com', 
    '$2y$10$bcdefghijklmnopqrstuvwxyz12345678901', (SELECT id_rol_usuario FROM monitoreo.RolUsuario WHERE nombre = 'Operador')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-003'), 'carlos.sanchez@logistica.com', 
    '$2y$10$cdefghijklmnopqrstuvwxyz123456789012', (SELECT id_rol_usuario FROM monitoreo.RolUsuario WHERE nombre = 'Inspector')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-006'), 'carmen.ramirez@logistica.com', 
    '$2y$10$defghijklmnopqrstuvwxyz1234567890123', (SELECT id_rol_usuario FROM monitoreo.RolUsuario WHERE nombre = 'Coordinador')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-007'), 'pedro.diaz@logistica.com', 
    '$2y$10$efghijklmnopqrstuvwxyz12345678901234', (SELECT id_rol_usuario FROM monitoreo.RolUsuario WHERE nombre = 'Inspector')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-009'), 'jorge.torres@logistica.com', 
    '$2y$10$fghijklmnopqrstuvwxyz123456789012345', (SELECT id_rol_usuario FROM monitoreo.RolUsuario WHERE nombre = 'Operador')),
(gen_random_uuid(), (SELECT id_empleado FROM monitoreo.Empleado WHERE codigo = 'EMP-010'), 'elena.vargas@logistica.com', 
    '$2y$10$ghijklmnopqrstuvwxyz1234567890123456', (SELECT id_rol_usuario FROM monitoreo.RolUsuario WHERE nombre = 'Consultor'));

-- Contenedores
INSERT INTO monitoreo.Contenedor (id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor) VALUES
(gen_random_uuid(), 'CONT-001', 2500.50, 28000.00, '20x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'Disponible'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-001')),
(gen_random_uuid(), 'CONT-002', 3200.75, 28000.00, '20x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'En tránsito'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-001')),
(gen_random_uuid(), 'CONT-003', 4100.00, 26500.00, '40x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'En tránsito'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-002')),
(gen_random_uuid(), 'CONT-004', 3500.25, 26500.00, '40x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'Disponible'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-002')),
(gen_random_uuid(), 'CONT-005', 5200.00, 27400.00, '20x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'En tránsito'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-003')),
(gen_random_uuid(), 'CONT-006', 2800.50, 28000.00, '20x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'Disponible'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-001')),
(gen_random_uuid(), 'CONT-007', 4800.75, 26500.00, '40x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'Entregado'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-002')),
(gen_random_uuid(), 'CONT-008', 6100.00, 27400.00, '40x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'Disponible'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-004')),
(gen_random_uuid(), 'CONT-009', 3300.25, 28000.00, '20x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'En mantenimiento'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-005')),
(gen_random_uuid(), 'CONT-010', 4500.00, 21000.00, '20x8x8.5', 
    (SELECT id_estado_contenedor FROM monitoreo.EstadoContenedor WHERE nombre = 'Disponible'),
    (SELECT id_tipo_contenedor FROM monitoreo.TipoContenedor WHERE codigo = 'TC-006'));

-- Documentación
INSERT INTO monitoreo.Documentacion (id_documentacion, codigo, nombre, fecha_emision, id_tipo_documento) VALUES
(gen_random_uuid(), 'DOC-001', 'Bill of Lading - Envío Asia', '2025-09-15', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'Bill of Lading')),
(gen_random_uuid(), 'DOC-002', 'Manifiesto de Carga MV Pacific', '2025-09-16', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'Manifiesto')),
(gen_random_uuid(), 'DOC-003', 'Certificado Sanitario - Alimentos', '2025-09-17', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'Certificado sanitario')),
(gen_random_uuid(), 'DOC-004', 'DUA - Importación Electrónicos', '2025-09-18', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'DUA')),
(gen_random_uuid(), 'DOC-005', 'Packing List - Textiles', '2025-09-19', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'Packing List')),
(gen_random_uuid(), 'DOC-006', 'Bill of Lading - Envío Europa', '2025-09-20', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'Bill of Lading')),
(gen_random_uuid(), 'DOC-007', 'Certificado Sanitario - Medicinas', '2025-09-21', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'Certificado sanitario')),
(gen_random_uuid(), 'DOC-008', 'DUA - Importación Maquinaria', '2025-09-22', 
    (SELECT id_tipo_documento FROM monitoreo.TipoDocumento WHERE nombre = 'DUA'));

-- Documentación de Contenedores
INSERT INTO monitoreo.DocumentacionContenedor (id_documentacion_contenedor, id_documentacion, id_contenedor) VALUES
(gen_random_uuid(), 
    (SELECT id_documentacion FROM monitoreo.Documentacion WHERE codigo = 'DOC-001'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002')),
(gen_random_uuid(), 
    (SELECT id_documentacion FROM monitoreo.Documentacion WHERE codigo = 'DOC-002'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003')),
(gen_random_uuid(), 
    (SELECT id_documentacion FROM monitoreo.Documentacion WHERE codigo = 'DOC-003'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005')),
(gen_random_uuid(), 
    (SELECT id_documentacion FROM monitoreo.Documentacion WHERE codigo = 'DOC-004'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-007'));

-- Sensores
INSERT INTO monitoreo.Sensor (id_sensor, codigo, nombre, id_tipo_sensor, id_rol_sensor, id_contenedor) VALUES
-- Sensores Contenedor 1
(gen_random_uuid(), 'SENS-001', 'Sensor Temp Container 001', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Temperatura'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Monitoreo'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-001')),
(gen_random_uuid(), 'SENS-002', 'Sensor Hum Container 001', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Humedad'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Monitoreo'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-001')),
(gen_random_uuid(), 'SENS-003', 'Sensor GPS Container 001', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'GPS'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Alerta'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-001')),
-- Sensores Contenedor 2
(gen_random_uuid(), 'SENS-004', 'Sensor Temp Container 002', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Temperatura'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Monitoreo'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002')),
(gen_random_uuid(), 'SENS-005', 'Sensor Vibración Container 002', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Vibración'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Control'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002')),
(gen_random_uuid(), 'SENS-006', 'Sensor GPS Container 002', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'GPS'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Alerta'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002')),
-- Sensores Contenedor 3
(gen_random_uuid(), 'SENS-007', 'Sensor Temp Container 003', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Temperatura'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Monitoreo'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003')),
(gen_random_uuid(), 'SENS-008', 'Sensor Apertura Container 003', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Apertura'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Alerta'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003')),
(gen_random_uuid(), 'SENS-009', 'Sensor GPS Container 003', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'GPS'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Monitoreo'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003')),
-- Sensores Contenedor 5
(gen_random_uuid(), 'SENS-010', 'Sensor Temp Container 005', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Temperatura'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Monitoreo'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005')),
(gen_random_uuid(), 'SENS-011', 'Sensor Hum Container 005', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'Humedad'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Control'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005')),
(gen_random_uuid(), 'SENS-012', 'Sensor GPS Container 005', 
    (SELECT id_tipo_sensor FROM monitoreo.TipoSensor WHERE nombre = 'GPS'),
    (SELECT id_rol_sensor FROM monitoreo.RolSensor WHERE nombre = 'Alerta'),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005'));

-- Importadores
INSERT INTO monitoreo.Importador (id_importador, codigo, ruc, razon_social) VALUES
(gen_random_uuid(), 'IMP-001', '20123456789', 'Importadora del Pacífico S.A.C.'),
(gen_random_uuid(), 'IMP-002', '20234567890', 'Comercial Andina S.R.L.'),
(gen_random_uuid(), 'IMP-003', '20345678901', 'Distribuidora Global Peru S.A.'),
(gen_random_uuid(), 'IMP-004', '20456789012', 'Tech Import Solutions E.I.R.L.'),
(gen_random_uuid(), 'IMP-005', '20567890123', 'Alimentos Internacionales S.A.C.'),
(gen_random_uuid(), 'IMP-006', '20678901234', 'Textiles del Sur S.A.'),
(gen_random_uuid(), 'IMP-007', '20789012345', 'Maquinarias Industriales Peru S.R.L.');

-- Direcciones de Importadores
INSERT INTO monitoreo.ImportadorDireccion (id_direccion, id_importador, direccion, tipo, principal) VALUES
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-001'), 
    'Av. Argentina 2847, Callao', 'Fiscal', TRUE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-001'), 
    'Jr. Comercio 156, Lima Centro', 'Comercial', FALSE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-002'), 
    'Calle Los Cedros 389, San Isidro', 'Fiscal', TRUE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-003'), 
    'Av. Javier Prado 5250, La Molina', 'Fiscal', TRUE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-003'), 
    'Av. Universitaria 1245, Los Olivos', 'Almacén', FALSE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-004'), 
    'Jr. Lampa 847, Lima Centro', 'Fiscal', TRUE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-005'), 
    'Av. Colonial 1523, Callao', 'Fiscal', TRUE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-006'), 
    'Calle Las Begonias 475, San Isidro', 'Fiscal', TRUE),
(gen_random_uuid(), (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-007'), 
    'Av. Venezuela 1890, Lima', 'Fiscal', TRUE);

-- Activos
INSERT INTO monitoreo.Activo (id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion) VALUES
(gen_random_uuid(), 'ACT-001', 'Camión Mercedes Benz Actros', 
    (SELECT id_tipo_activo FROM monitoreo.TipoActivo WHERE nombre = 'Vehículo'),
    (SELECT id_estado_activo FROM monitoreo.EstadoActivo WHERE nombre = 'Operativo'), 
    'Terminal Norte Callao'),
(gen_random_uuid(), 'ACT-002', 'Camión Volvo FH16', 
    (SELECT id_tipo_activo FROM monitoreo.TipoActivo WHERE nombre = 'Vehículo'),
    (SELECT id_estado_activo FROM monitoreo.EstadoActivo WHERE nombre = 'Operativo'), 
    'Terminal Sur Callao'),
(gen_random_uuid(), 'ACT-003', 'Tracto Scania R500', 
    (SELECT id_tipo_activo FROM monitoreo.TipoActivo WHERE nombre = 'Vehículo'),
    (SELECT id_estado_activo FROM monitoreo.EstadoActivo WHERE nombre = 'Mantenimiento'), 
    'Taller Central'),
(gen_random_uuid(), 'ACT-004', 'Camión Freightliner Cascadia', 
    (SELECT id_tipo_activo FROM monitoreo.TipoActivo WHERE nombre = 'Vehículo'),
    (SELECT id_estado_activo FROM monitoreo.EstadoActivo WHERE nombre = 'Operativo'), 
    'Depósito Lima'),
(gen_random_uuid(), 'ACT-005', 'Grúa Portuaria Liebherr', 
    (SELECT id_tipo_activo FROM monitoreo.TipoActivo WHERE nombre = 'Equipo portuario'),
    (SELECT id_estado_activo FROM monitoreo.EstadoActivo WHERE nombre = 'Operativo'), 
    'Puerto del Callao'),
(gen_random_uuid(), 'ACT-006', 'Montacargas Toyota 8FD25', 
    (SELECT id_tipo_activo FROM monitoreo.TipoActivo WHERE nombre = 'Equipo portuario'),
    (SELECT id_estado_activo FROM monitoreo.EstadoActivo WHERE nombre = 'Operativo'), 
    'Almacén Central');

-- Vehículos
INSERT INTO monitoreo.Vehiculo (id_vehiculo, id_activo, placa, capacidad_ton, id_tipo_vehiculo, id_estado_vehiculo) VALUES
(gen_random_uuid(), (SELECT id_activo FROM monitoreo.Activo WHERE codigo = 'ACT-001'), 'ABC-123', 25.50,
    (SELECT id_tipo_vehiculo FROM monitoreo.TipoVehiculo WHERE nombre = 'Tracto camión'),
    (SELECT id_estado_vehiculo FROM monitoreo.EstadoVehiculo WHERE nombre = 'Disponible')),
(gen_random_uuid(), (SELECT id_activo FROM monitoreo.Activo WHERE codigo = 'ACT-002'), 'DEF-456', 28.00,
    (SELECT id_tipo_vehiculo FROM monitoreo.TipoVehiculo WHERE nombre = 'Tracto camión'),
    (SELECT id_estado_vehiculo FROM monitoreo.EstadoVehiculo WHERE nombre = 'Disponible')),
(gen_random_uuid(), (SELECT id_activo FROM monitoreo.Activo WHERE codigo = 'ACT-003'), 'GHI-789', 30.00,
    (SELECT id_tipo_vehiculo FROM monitoreo.TipoVehiculo WHERE nombre = 'Tracto camión'),
    (SELECT id_estado_vehiculo FROM monitoreo.EstadoVehiculo WHERE nombre = 'Mantenimiento')),
(gen_random_uuid(), (SELECT id_activo FROM monitoreo.Activo WHERE codigo = 'ACT-004'), 'JKL-012', 26.50,
    (SELECT id_tipo_vehiculo FROM monitoreo.TipoVehiculo WHERE nombre = 'Camión rígido'),
    (SELECT id_estado_vehiculo FROM monitoreo.EstadoVehiculo WHERE nombre = 'Disponible'));

-- Buques
INSERT INTO monitoreo.Buque (id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual) VALUES
(gen_random_uuid(), 'IMO-9347438', 'MV Hapag Spirit', 12000, 
    (SELECT id_estado_embarcacion FROM monitoreo.EstadoEmbarcacion WHERE nombre = 'En operación'), 
    150000.00, '-12.046374, -77.042793'),
(gen_random_uuid(), 'IMO-8765432', 'MSC Pacific Star', 15000, 
    (SELECT id_estado_embarcacion FROM monitoreo.EstadoEmbarcacion WHERE nombre = 'Disponible'), 
    180000.00, '-11.923456, -77.134567'),
(gen_random_uuid(), 'IMO-7654321', 'CMA CGM Andes', 10000, 
    (SELECT id_estado_embarcacion FROM monitoreo.EstadoEmbarcacion WHERE nombre = 'En operación'), 
    135000.00, '-12.156789, -77.245678'),
(gen_random_uuid(), 'IMO-6543210', 'Maersk Lima', 14000, 
    (SELECT id_estado_embarcacion FROM monitoreo.EstadoEmbarcacion WHERE nombre = 'Disponible'), 
    165000.00, NULL);

-- Operaciones
INSERT INTO monitoreo.Operacion (id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion) VALUES
(gen_random_uuid(), 'OP-2025-001', '2025-09-20 08:00:00', '2025-09-25 18:00:00', 
    (SELECT id_estado_operacion FROM monitoreo.EstadoOperacion WHERE nombre = 'Completada')),
(gen_random_uuid(), 'OP-2025-002', '2025-09-22 10:00:00', NULL, 
    (SELECT id_estado_operacion FROM monitoreo.EstadoOperacion WHERE nombre = 'En curso')),
(gen_random_uuid(), 'OP-2025-003', '2025-09-24 14:00:00', NULL, 
    (SELECT id_estado_operacion FROM monitoreo.EstadoOperacion WHERE nombre = 'En curso')),
(gen_random_uuid(), 'OP-2025-004', '2025-09-26 09:00:00', NULL, 
    (SELECT id_estado_operacion FROM monitoreo.EstadoOperacion WHERE nombre = 'En curso')),
(gen_random_uuid(), 'OP-2025-005', '2025-09-28 07:00:00', '2025-10-02 16:00:00', 
    (SELECT id_estado_operacion FROM monitoreo.EstadoOperacion WHERE nombre = 'Completada')),
(gen_random_uuid(), 'OP-2025-006', '2025-10-01 11:00:00', NULL, 
    (SELECT id_estado_operacion FROM monitoreo.EstadoOperacion WHERE nombre = 'En curso'));

-- Operaciones de Monitoreo
INSERT INTO monitoreo.OperacionMonitoreo (id_operacion_monitoreo, id_operacion) VALUES
(gen_random_uuid(), (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-002')),
(gen_random_uuid(), (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-003')),
(gen_random_uuid(), (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-004')),
(gen_random_uuid(), (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-006'));

-- Reportes
INSERT INTO monitoreo.Reporte (id_reporte, codigo, fecha_reporte, detalle) VALUES
(gen_random_uuid(), 'REP-MON-001', '2025-09-22', 'Reporte diario de monitoreo - Contenedores en tránsito zona norte'),
(gen_random_uuid(), 'REP-MON-002', '2025-09-23', 'Reporte de alertas de temperatura - Contenedores refrigerados'),
(gen_random_uuid(), 'REP-MON-003', '2025-09-24', 'Reporte de tracking GPS - Ruta Lima-Callao'),
(gen_random_uuid(), 'REP-MON-004', '2025-09-25', 'Reporte semanal consolidado de operaciones'),
(gen_random_uuid(), 'REP-MON-005', '2025-09-26', 'Reporte de incidencias menores - Vibraciones detectadas');

-- Notificaciones
INSERT INTO monitoreo.Notificacion (id_notificacion, codigo, id_tipo_notificacion, fecha_hora, valor, id_sensor, id_reporte) VALUES
(gen_random_uuid(), 'NOT-001', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Advertencia'),
    '2025-09-22 14:30:00', 25.50,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-001'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-001')),
(gen_random_uuid(), 'NOT-002', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Alerta'),
    '2025-09-22 15:45:00', 28.30,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-004'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-001')),
(gen_random_uuid(), 'NOT-003', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Información'),
    '2025-09-23 09:15:00', 65.20,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-002'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-002')),
(gen_random_uuid(), 'NOT-004', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Crítica'),
    '2025-09-23 11:30:00', 32.50,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-010'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-002')),
(gen_random_uuid(), 'NOT-005', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Advertencia'),
    '2025-09-24 10:00:00', 2.80,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-005'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-003')),
(gen_random_uuid(), 'NOT-006', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Información'),
    '2025-09-24 16:20:00', 22.10,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-007'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-003')),
(gen_random_uuid(), 'NOT-007', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Alerta'),
    '2025-09-25 08:45:00', 70.50,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-011'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-004')),
(gen_random_uuid(), 'NOT-008', 
    (SELECT id_tipo_notificacion FROM monitoreo.TipoNotificacion WHERE nombre = 'Advertencia'),
    '2025-09-26 13:10:00', 3.20,
    (SELECT id_sensor FROM monitoreo.Sensor WHERE codigo = 'SENS-005'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-005'));

-- Incidencias
INSERT INTO monitoreo.Incidencia (id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_estado_incidencia, id_operacion, id_usuario) VALUES
(gen_random_uuid(), 'INC-001', 
    (SELECT id_tipo_incidencia FROM monitoreo.TipoIncidencia WHERE nombre = 'Operacional'),
    'Vibración excesiva detectada en contenedor durante transporte terrestre', 2, 
    '2025-09-22 15:30:00',
    (SELECT id_estado_incidencia FROM monitoreo.EstadoIncidencia WHERE nombre = 'Resuelta'),
    (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-002'),
    (SELECT id_usuario FROM monitoreo.Usuario WHERE correo_electronico = 'carlos.sanchez@logistica.com')),
(gen_random_uuid(), 'INC-002', 
    (SELECT id_tipo_incidencia FROM monitoreo.TipoIncidencia WHERE nombre = 'Ambiental'),
    'Temperatura fuera de rango en contenedor refrigerado', 4, 
    '2025-09-23 11:45:00',
    (SELECT id_estado_incidencia FROM monitoreo.EstadoIncidencia WHERE nombre = 'En investigación'),
    (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-003'),
    (SELECT id_usuario FROM monitoreo.Usuario WHERE correo_electronico = 'pedro.diaz@logistica.com')),
(gen_random_uuid(), 'INC-003', 
    (SELECT id_tipo_incidencia FROM monitoreo.TipoIncidencia WHERE nombre = 'Seguridad'),
    'Apertura no autorizada detectada en contenedor', 5, 
    '2025-09-24 09:20:00',
    (SELECT id_estado_incidencia FROM monitoreo.EstadoIncidencia WHERE nombre = 'En investigación'),
    (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-004'),
    (SELECT id_usuario FROM monitoreo.Usuario WHERE correo_electronico = 'carlos.sanchez@logistica.com')),
(gen_random_uuid(), 'INC-004', 
    (SELECT id_tipo_incidencia FROM monitoreo.TipoIncidencia WHERE nombre = 'Operacional'),
    'Retraso en ruta por congestión vehicular', 2, 
    '2025-09-25 14:00:00',
    (SELECT id_estado_incidencia FROM monitoreo.EstadoIncidencia WHERE nombre = 'Cerrada'),
    (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-002'),
    (SELECT id_usuario FROM monitoreo.Usuario WHERE correo_electronico = 'jorge.torres@logistica.com')),
(gen_random_uuid(), 'INC-005', 
    (SELECT id_tipo_incidencia FROM monitoreo.TipoIncidencia WHERE nombre = 'Administrativa'),
    'Documentación incompleta en punto de control', 3, 
    '2025-09-26 10:30:00',
    (SELECT id_estado_incidencia FROM monitoreo.EstadoIncidencia WHERE nombre = 'Reportada'),
    (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-006'),
    (SELECT id_usuario FROM monitoreo.Usuario WHERE correo_electronico = 'maria.lopez@logistica.com'));

-- Relación Incidencia-Reporte
INSERT INTO monitoreo.IncidenciaReporte (id_incidencia_reporte, id_incidencia, id_reporte) VALUES
(gen_random_uuid(), 
    (SELECT id_incidencia FROM monitoreo.Incidencia WHERE codigo = 'INC-001'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-001')),
(gen_random_uuid(), 
    (SELECT id_incidencia FROM monitoreo.Incidencia WHERE codigo = 'INC-001'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-005')),
(gen_random_uuid(), 
    (SELECT id_incidencia FROM monitoreo.Incidencia WHERE codigo = 'INC-002'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-002')),
(gen_random_uuid(), 
    (SELECT id_incidencia FROM monitoreo.Incidencia WHERE codigo = 'INC-002'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-004')),
(gen_random_uuid(), 
    (SELECT id_incidencia FROM monitoreo.Incidencia WHERE codigo = 'INC-003'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-003')),
(gen_random_uuid(), 
    (SELECT id_incidencia FROM monitoreo.Incidencia WHERE codigo = 'INC-004'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-004')),
(gen_random_uuid(), 
    (SELECT id_incidencia FROM monitoreo.Incidencia WHERE codigo = 'INC-005'),
    (SELECT id_reporte FROM monitoreo.Reporte WHERE codigo = 'REP-MON-004'));

-- Entregas
INSERT INTO monitoreo.Entrega (id_entrega, codigo, id_estado_entrega, fecha_entrega, lugar_entrega, id_contenedor, id_importador) VALUES
(gen_random_uuid(), 'ENT-001', 
    (SELECT id_estado_entrega FROM monitoreo.EstadoEntrega WHERE nombre = 'Completada'),
    '2025-09-25', 'Almacén Central - Av. Argentina, Callao',
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-007'),
    (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-001')),
(gen_random_uuid(), 'ENT-002', 
    (SELECT id_estado_entrega FROM monitoreo.EstadoEntrega WHERE nombre = 'En tránsito'),
    '2025-09-28', 'Depósito San Isidro - Calle Los Cedros 389',
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'),
    (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-002')),
(gen_random_uuid(), 'ENT-003', 
    (SELECT id_estado_entrega FROM monitoreo.EstadoEntrega WHERE nombre = 'En tránsito'),
    '2025-09-29', 'Terminal La Molina - Av. Javier Prado 5250',
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003'),
    (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-003')),
(gen_random_uuid(), 'ENT-004', 
    (SELECT id_estado_entrega FROM monitoreo.EstadoEntrega WHERE nombre = 'Programada'),
    '2025-10-01', 'Oficina Central - Jr. Lampa 847, Lima',
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005'),
    (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-004')),
(gen_random_uuid(), 'ENT-005', 
    (SELECT id_estado_entrega FROM monitoreo.EstadoEntrega WHERE nombre = 'Programada'),
    '2025-10-02', 'Almacén Callao - Av. Colonial 1523',
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'),
    (SELECT id_importador FROM monitoreo.Importador WHERE codigo = 'IMP-005'));

-- Posiciones de Contenedores
INSERT INTO monitoreo.PosicionContenedor (id_posicion, id_contenedor, latitud, longitud, fecha_hora) VALUES
-- Contenedor CONT-002
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'), 
    -12.046374, -77.042793, '2025-09-22 08:00:00'),
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'), 
    -12.056789, -77.052345, '2025-09-22 10:30:00'),
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'), 
    -12.067234, -77.062891, '2025-09-22 13:00:00'),
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'), 
    -12.077890, -77.073456, '2025-09-22 15:30:00'),
-- Contenedor CONT-003
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003'), 
    -12.046374, -77.042793, '2025-09-24 09:00:00'),
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003'), 
    -12.086543, -77.083012, '2025-09-24 11:00:00'),
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003'), 
    -12.096789, -77.093567, '2025-09-24 13:30:00'),
-- Contenedor CONT-005
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005'), 
    -12.046374, -77.042793, '2025-09-26 07:00:00'),
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005'), 
    -12.106234, -77.104123, '2025-09-26 09:30:00'),
(gen_random_uuid(), (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005'), 
    -12.116890, -77.114678, '2025-09-26 12:00:00');

-- Posiciones de Vehículos
INSERT INTO monitoreo.PosicionVehiculo (id_posicion, id_vehiculo, latitud, longitud, fecha_hora) VALUES
-- Vehículo placa ABC-123
(gen_random_uuid(), (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'ABC-123'), 
    -12.046374, -77.042793, '2025-09-22 08:00:00'),
(gen_random_uuid(), (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'ABC-123'), 
    -12.056789, -77.052345, '2025-09-22 10:30:00'),
(gen_random_uuid(), (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'ABC-123'), 
    -12.067234, -77.062891, '2025-09-22 13:00:00'),
-- Vehículo placa DEF-456
(gen_random_uuid(), (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'DEF-456'), 
    -12.046374, -77.042793, '2025-09-24 09:00:00'),
(gen_random_uuid(), (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'DEF-456'), 
    -12.086543, -77.083012, '2025-09-24 11:00:00'),
(gen_random_uuid(), (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'DEF-456'), 
    -12.096789, -77.093567, '2025-09-24 13:30:00');

-- Posiciones de Buques
INSERT INTO monitoreo.PosicionBuque (id_posicion, id_buque, latitud, longitud, fecha_hora) VALUES
-- MV Hapag Spirit
(gen_random_uuid(), (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-9347438'), 
    -12.046374, -77.042793, '2025-09-20 06:00:00'),
(gen_random_uuid(), (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-9347438'), 
    -12.036789, -77.032345, '2025-09-20 12:00:00'),
(gen_random_uuid(), (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-9347438'), 
    -12.026234, -77.022891, '2025-09-20 18:00:00'),
-- CMA CGM Andes
(gen_random_uuid(), (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-7654321'), 
    -12.156789, -77.245678, '2025-09-24 08:00:00'),
(gen_random_uuid(), (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-7654321'), 
    -12.146543, -77.235012, '2025-09-24 14:00:00'),
(gen_random_uuid(), (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-7654321'), 
    -12.136890, -77.224567, '2025-09-24 20:00:00');

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

-- Operación Monitoreo - Vehículo
INSERT INTO monitoreo.OperacionMonitoreoVehiculo (id_operacion_monitoreo_vehiculo, id_operacion_monitoreo, id_vehiculo, fecha_operacion) VALUES
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-002')),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'ABC-123'),
    '2025-09-22'),
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-003')),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'DEF-456'),
    '2025-09-24'),
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-004')),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'ABC-123'),
    '2025-09-26'),
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-006')),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'DEF-456'),
    '2025-10-01');

-- Operación Monitoreo - Buque
INSERT INTO monitoreo.OperacionMonitoreoBuque (id_operacion_monitoreo_buque, id_operacion_monitoreo, id_buque, fecha_operacion) VALUES
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-002')),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-9347438'),
    '2025-09-22'),
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-003')),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-7654321'),
    '2025-09-24'),
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-004')),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-9347438'),
    '2025-09-26'),
(gen_random_uuid(),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-006')),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-6543210'),
    '2025-10-01');

-- Contenedor - Vehículo
INSERT INTO monitoreo.ContenedorVehiculo (id_contenedor_vehiculo, id_contenedor, id_vehiculo, fecha_asignacion, fecha_transporte) VALUES
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'ABC-123'),
    '2025-09-21', '2025-09-22'),
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003'),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'DEF-456'),
    '2025-09-23', '2025-09-24'),
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005'),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'ABC-123'),
    '2025-09-25', '2025-09-26'),
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'),
    (SELECT id_vehiculo FROM monitoreo.Vehiculo WHERE placa = 'DEF-456'),
    '2025-09-30', '2025-10-01');

-- Contenedor - Buque
INSERT INTO monitoreo.ContenedorBuque (id_contenedor_buque, id_contenedor, id_buque, fecha_asignacion, fecha_transporte) VALUES
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-002'),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-9347438'),
    '2025-09-18', '2025-09-20'),
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-003'),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-7654321'),
    '2025-09-20', '2025-09-22'),
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-005'),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-9347438'),
    '2025-09-22', '2025-09-24'),
(gen_random_uuid(),
    (SELECT id_contenedor FROM monitoreo.Contenedor WHERE codigo = 'CONT-007'),
    (SELECT id_buque FROM monitoreo.Buque WHERE matricula = 'IMO-6543210'),
    '2025-09-25', '2025-09-27');

-- Operador - Operación Monitoreo
INSERT INTO monitoreo.OperadorOperacionMonitoreo (id_operador_operacion_monitoreo, id_operador, id_operacion_monitoreo, fecha_realizacion) VALUES
(gen_random_uuid(),
    (SELECT o.id_operador FROM monitoreo.Operador o 
     JOIN monitoreo.Empleado e ON o.id_empleado = e.id_empleado 
     WHERE e.codigo = 'EMP-002'),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-002')),
    '2025-09-22'),
(gen_random_uuid(),
    (SELECT o.id_operador FROM monitoreo.Operador o 
     JOIN monitoreo.Empleado e ON o.id_empleado = e.id_empleado 
     WHERE e.codigo = 'EMP-004'),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-003')),
    '2025-09-24'),
(gen_random_uuid(),
    (SELECT o.id_operador FROM monitoreo.Operador o 
     JOIN monitoreo.Empleado e ON o.id_empleado = e.id_empleado 
     WHERE e.codigo = 'EMP-002'),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-004')),
    '2025-09-26'),
(gen_random_uuid(),
    (SELECT o.id_operador FROM monitoreo.Operador o 
     JOIN monitoreo.Empleado e ON o.id_empleado = e.id_empleado 
     WHERE e.codigo = 'EMP-005'),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-004')),
    '2025-09-26'),
(gen_random_uuid(),
    (SELECT o.id_operador FROM monitoreo.Operador o 
     JOIN monitoreo.Empleado e ON o.id_empleado = e.id_empleado 
     WHERE e.codigo = 'EMP-004'),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-006')),
    '2025-10-01'),
(gen_random_uuid(),
    (SELECT o.id_operador FROM monitoreo.Operador o 
     JOIN monitoreo.Empleado e ON o.id_empleado = e.id_empleado 
     WHERE e.codigo = 'EMP-008'),
    (SELECT id_operacion_monitoreo FROM monitoreo.OperacionMonitoreo 
     WHERE id_operacion = (SELECT id_operacion FROM monitoreo.Operacion WHERE codigo = 'OP-2025-006')),
    '2025-10-01');