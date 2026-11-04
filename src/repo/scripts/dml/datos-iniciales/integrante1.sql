-- ============================================
-- SCRIPT DE POBLACIÓN DE DATOS
-- SCHEMA: gestion_reserva
-- ============================================

-- ============================================
-- TABLAS DE DOMINIO (LOOKUP TABLES)
-- ============================================

-- TipoTelefono
INSERT INTO gestion_reserva.TipoTelefono (id_tipo_telefono, nombre) VALUES
(gen_random_uuid(), 'Móvil'),
(gen_random_uuid(), 'Fijo'),
(gen_random_uuid(), 'Casa'),
(gen_random_uuid(), 'Emergencia');

-- EspecialidadEmpleado
INSERT INTO gestion_reserva.EspecialidadEmpleado (id_especialidad_empleado, nombre) VALUES
(gen_random_uuid(), 'Agente de Reservas'),
(gen_random_uuid(), 'Supervisor'),
(gen_random_uuid(), 'Administrativo'),
(gen_random_uuid(), 'Operario'),
(gen_random_uuid(), 'Gerente');

-- EstadoContrato
INSERT INTO gestion_reserva.EstadoContrato (id_estado_contrato, nombre) VALUES
(gen_random_uuid(), 'Activo'),
(gen_random_uuid(), 'Vigente'),
(gen_random_uuid(), 'Suspendido'),
(gen_random_uuid(), 'Cancelado'),
(gen_random_uuid(), 'Vencido');

-- EstadoContenedor
INSERT INTO gestion_reserva.EstadoContenedor (id_estado_contenedor, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En tránsito'),
(gen_random_uuid(), 'Entregado'),
(gen_random_uuid(), 'En mantenimiento');


-- TipoContenedor
INSERT INTO gestion_reserva.TipoContenedor (id_tipo_contenedor, codigo, nombre, costo) VALUES
---Contenedores de Carga Seca---
(gen_random_uuid(), 'T-001', '20'' Standard', 2500.00),
(gen_random_uuid(), 'T-002', '40'' Standard', 3100.00),
(gen_random_uuid(), 'T-003', '40'' Standard High Cube', 3300.00),
(gen_random_uuid(), 'T-004', '45'' Standard High Cube', 3600.00),
---Contenedores de Carga Especial---
(gen_random_uuid(), 'T-005', '20'' Flatrack', 3700.00),
(gen_random_uuid(), 'T-006', '40'' Flatrack High Cube', 4200.00),
(gen_random_uuid(), 'T-007', '40'' Platform', 4300.00),
(gen_random_uuid(), 'T-008', '20'' Open Top', 3400.00),
(gen_random_uuid(), 'T-009', '20'' Open Top High Cube', 3600.00),
(gen_random_uuid(), 'T-010', '40'' Open Top', 3900.00),
(gen_random_uuid(), 'T-011', '40'' Open Top High Cube', 4100.00),
(gen_random_uuid(), 'T-012', '20'' Hardtop', 4000.00),
(gen_random_uuid(), 'T-013', '40'' Hardtop', 4300.00),
(gen_random_uuid(), 'T-014', '40'' Hardtop High Cube', 4500.00),
---Contenedores Refrigerados---
(gen_random_uuid(), 'T-015', '20'' Reefer', 5200.00),
(gen_random_uuid(), 'T-016', '40'' Reefer High Cube', 5800.00);


-- EstadoEmbarcacion
INSERT INTO gestion_reserva.EstadoEmbarcacion (id_estado_embarcacion, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En operación'),
(gen_random_uuid(), 'Mantenimiento'),
(gen_random_uuid(), 'Fuera de servicio'),
(gen_random_uuid(), 'En reparación');

-- EstadoOperacion
INSERT INTO gestion_reserva.EstadoOperacion (id_estado_operacion, nombre) VALUES
(gen_random_uuid(), 'En Planificación'),
(gen_random_uuid(), 'Completada'),
(gen_random_uuid(), 'Cancelada'),
(gen_random_uuid(), 'En Progreso'),
(gen_random_uuid(), 'En Espera');

-- EstadoReserva
INSERT INTO gestion_reserva.EstadoReserva (id_estado_reserva, nombre) VALUES
(gen_random_uuid(), 'Confirmada'),
(gen_random_uuid(), 'Activa'),
(gen_random_uuid(), 'Finalizada'),
(gen_random_uuid(), 'Cancelada');

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- Contrato
INSERT INTO gestion_reserva.Contrato (id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato) VALUES
(gen_random_uuid(), '2024-01-15', '2026-01-15', (SELECT id_estado_contrato FROM gestion_reserva.EstadoContrato WHERE nombre = 'Activo')),
(gen_random_uuid(), '2024-03-20', '2025-03-20', (SELECT id_estado_contrato FROM gestion_reserva.EstadoContrato WHERE nombre = 'Cancelado')),
(gen_random_uuid(), '2023-06-10', '2025-06-10', (SELECT id_estado_contrato FROM gestion_reserva.EstadoContrato WHERE nombre = 'Suspendido')),
(gen_random_uuid(), '2024-08-05', '2026-08-05', (SELECT id_estado_contrato FROM gestion_reserva.EstadoContrato WHERE nombre = 'Activo')),
(gen_random_uuid(), '2023-12-01', '2024-12-01', (SELECT id_estado_contrato FROM gestion_reserva.EstadoContrato WHERE nombre = 'Vencido')),
(gen_random_uuid(), '2024-09-15', '2026-09-15', (SELECT id_estado_contrato FROM gestion_reserva.EstadoContrato WHERE nombre = 'Activo'));

-- Empleado
INSERT INTO gestion_reserva.Empleado (id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad, id_contrato) VALUES
(gen_random_uuid(), 'EMP-001', '12345678', 'Juan', 'Pérez García', 'Av. Marina 123, San Miguel', (SELECT id_especialidad_empleado FROM gestion_reserva.EspecialidadEmpleado WHERE nombre = 'Agente de Reservas'), (SELECT id_contrato FROM gestion_reserva.Contrato ORDER BY fecha_emision LIMIT 1 OFFSET 0)),
(gen_random_uuid(), 'EMP-002', '23456789', 'María', 'López Torres', 'Jr. Los Pinos 456, Miraflores', (SELECT id_especialidad_empleado FROM gestion_reserva.EspecialidadEmpleado WHERE nombre = 'Supervisor'), (SELECT id_contrato FROM gestion_reserva.Contrato ORDER BY fecha_emision LIMIT 1 OFFSET 1)),
(gen_random_uuid(), 'EMP-003', '34567890', 'Carlos', 'Ramírez Silva', 'Calle Las Flores 789, Surco', (SELECT id_especialidad_empleado FROM gestion_reserva.EspecialidadEmpleado WHERE nombre = 'Administrativo'), (SELECT id_contrato FROM gestion_reserva.Contrato ORDER BY fecha_emision LIMIT 1 OFFSET 2)),
(gen_random_uuid(), 'EMP-004', '45678901', 'Ana', 'Fernández Ruiz', 'Av. Colonial 234, Callao', (SELECT id_especialidad_empleado FROM gestion_reserva.EspecialidadEmpleado WHERE nombre = 'Agente de Reservas'), (SELECT id_contrato FROM gestion_reserva.Contrato ORDER BY fecha_emision LIMIT 1 OFFSET 3)),
(gen_random_uuid(), 'EMP-005', '56789012', 'Luis', 'Mendoza Castro', 'Jr. Comercio 567, Breña', (SELECT id_especialidad_empleado FROM gestion_reserva.EspecialidadEmpleado WHERE nombre = 'Operario'), (SELECT id_contrato FROM gestion_reserva.Contrato ORDER BY fecha_emision LIMIT 1 OFFSET 4)),
(gen_random_uuid(), 'EMP-006', '67890123', 'Rosa', 'Vargas Morales', 'Av. Arequipa 890, Lince', (SELECT id_especialidad_empleado FROM gestion_reserva.EspecialidadEmpleado WHERE nombre = 'Gerente'), (SELECT id_contrato FROM gestion_reserva.Contrato ORDER BY fecha_emision LIMIT 1 OFFSET 5));

-- EmpleadoTelefono
INSERT INTO gestion_reserva.EmpleadoTelefono (id_empleado_telefono, id_empleado, telefono, id_tipo_telefono) VALUES
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-001'), '987654321', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-001'), '014567890', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Casa')),
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-002'), '998765432', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-003'), '965432109', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-004'), '987123456', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-005'), '014123456', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil'));

-- AgenteReservas
INSERT INTO gestion_reserva.AgenteReservas (id_agente_reservas, id_empleado) VALUES
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-001')),
(gen_random_uuid(), (SELECT id_empleado FROM gestion_reserva.Empleado WHERE codigo = 'EMP-004'));

-- Cliente
INSERT INTO gestion_reserva.Cliente (id_cliente, ruc, razon_social, direccion, email) VALUES
(gen_random_uuid(), '20481234567', 'Exportadora del Pacífico SAC', 'Av. Colonial 456, Callao', 'contacto@expacifico.com'),
(gen_random_uuid(), '20567891234', 'Importaciones Globales EIRL', 'Jr. Comercio 789, Lima', 'ventas@impglobales.pe'),
(gen_random_uuid(), '20654321098', 'Logística Marina del Sur SA', 'Calle Los Navieros 234, Miraflores', 'info@logmarina.com'),
(gen_random_uuid(), '20789456123', 'Comercial Andina SAC', 'Av. Arequipa 567, San Isidro', 'contacto@comandina.pe'),
(gen_random_uuid(), '20876543210', 'Transportes Marítimos del Perú SA', 'Av. La Marina 890, San Miguel', 'info@tramarperu.com'),
(gen_random_uuid(), '20912345678', 'Grupo Exportador del Norte SRL', 'Jr. Libertad 123, Trujillo', 'ventas@expnorte.pe');

-- ClienteTelefono
INSERT INTO gestion_reserva.ClienteTelefono (id_cliente_telefono, id_cliente, telefono, id_tipo_telefono) VALUES
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20481234567'), '014651234', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Fijo')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20481234567'), '987123456', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20567891234'), '982307088', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20567891234'), '014785432', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Casa')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20654321098'), '902937564', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20654321098'), '902125385', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Emergencia')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20789456123'), '998765432', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20789456123'), '012376587', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Fijo')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20876543210'), '946375859', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20876543210'), '014567890', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Casa')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20912345678'), '905736128', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Móvil')),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20912345678'), '987321546', (SELECT id_tipo_telefono FROM gestion_reserva.TipoTelefono WHERE nombre = 'Emergencia'));

-- AtencionCliente
INSERT INTO gestion_reserva.AtencionCliente (id_atencion_cliente, id_cliente, id_agente_reservas, fecha_atencion) VALUES
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20481234567'), (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 0), '2025-01-15 09:30:00'),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20567891234'), (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 1), '2025-01-16 10:45:00'),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20654321098'), (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 1), '2025-01-17 14:20:00'),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20789456123'), (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 0), '2025-01-18 11:00:00'),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20876543210'), (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 0), '2025-01-19 15:30:00'),
(gen_random_uuid(), (SELECT id_cliente FROM gestion_reserva.Cliente WHERE ruc = '20912345678'), (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 1), '2025-01-20 16:45:00');

-- Contenedor
INSERT INTO gestion_reserva.Contenedor (id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor) VALUES
(gen_random_uuid(), 'CONT-001', 2200.50, 28500.00, '20x8x8.5 ft', (SELECT id_estado_contenedor FROM gestion_reserva.EstadoContenedor WHERE nombre = 'Disponible'), (SELECT id_tipo_contenedor FROM gestion_reserva.TipoContenedor WHERE codigo = 'T-001')),
(gen_random_uuid(), 'CONT-002', 3800.75, 28800.00, '40x8x8.5 ft', (SELECT id_estado_contenedor FROM gestion_reserva.EstadoContenedor WHERE nombre = 'En tránsito'), (SELECT id_tipo_contenedor FROM gestion_reserva.TipoContenedor WHERE codigo = 'T-002')),
(gen_random_uuid(), 'CONT-003', 2500.00, 25000.00, '20x8x8.5 ft', (SELECT id_estado_contenedor FROM gestion_reserva.EstadoContenedor WHERE nombre = 'Disponible'), (SELECT id_tipo_contenedor FROM gestion_reserva.TipoContenedor WHERE codigo = 'T-003')),
(gen_random_uuid(), 'CONT-004', 4200.00, 26500.00, '40x8x9.5 ft', (SELECT id_estado_contenedor FROM gestion_reserva.EstadoContenedor WHERE nombre = 'En tránsito'), (SELECT id_tipo_contenedor FROM gestion_reserva.TipoContenedor WHERE codigo = 'T-004')),
(gen_random_uuid(), 'CONT-005', 2100.00, 27500.00, '20x8x8.5 ft', (SELECT id_estado_contenedor FROM gestion_reserva.EstadoContenedor WHERE nombre = 'En mantenimiento'), (SELECT id_tipo_contenedor FROM gestion_reserva.TipoContenedor WHERE codigo = 'T-005')),
(gen_random_uuid(), 'CONT-006', 3900.00, 45000.00, '40x8x8.5 ft', (SELECT id_estado_contenedor FROM gestion_reserva.EstadoContenedor WHERE nombre = 'Disponible'), (SELECT id_tipo_contenedor FROM gestion_reserva.TipoContenedor WHERE codigo = 'T-006'));

-- ContenedorMercancia
INSERT INTO gestion_reserva.ContenedorMercancia (id_contenedor_mercancia, id_contenedor, tipo_mercancia) VALUES
(gen_random_uuid(), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-001'), 'Electrónicos'),
(gen_random_uuid(), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-002'), 'Textiles'),
(gen_random_uuid(), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-003'), 'Alimentos Congelados'),
(gen_random_uuid(), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-004'), 'Productos Farmacéuticos'),
(gen_random_uuid(), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-005'), 'Maquinaria Industrial'),
(gen_random_uuid(), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-006'), 'Vehículos');

-- Buque
INSERT INTO gestion_reserva.Buque (id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual) VALUES
(gen_random_uuid(), 'IMO-9347438', 'Hapag Spirit', 12000, (SELECT id_estado_embarcacion FROM gestion_reserva.EstadoEmbarcacion WHERE nombre = 'En operación'), 150000.00, '12.0464°S 77.1428°W'),
(gen_random_uuid(), 'IMO-9256741', 'Maersk Callao', 18000, (SELECT id_estado_embarcacion FROM gestion_reserva.EstadoEmbarcacion WHERE nombre = 'Disponible'), 220000.00, '12.0500°S 77.1450°W'),
(gen_random_uuid(), 'IMO-9183456', 'CMA CGM Lima', 14500, (SELECT id_estado_embarcacion FROM gestion_reserva.EstadoEmbarcacion WHERE nombre = 'En operación'), 180000.00, '8.9824°N 79.5199°W'),
(gen_random_uuid(), 'IMO-9428765', 'MSC Pacifico', 16000, (SELECT id_estado_embarcacion FROM gestion_reserva.EstadoEmbarcacion WHERE nombre = 'Mantenimiento'), 195000.00, '5.0892°S 81.1144°W'),
(gen_random_uuid(), 'IMO-9512389', 'Evergreen Peru', 13000, (SELECT id_estado_embarcacion FROM gestion_reserva.EstadoEmbarcacion WHERE nombre = 'Mantenimiento'), 165000.00, '12.0464°S 77.1428°W'),
(gen_random_uuid(), 'IMO-9634521', 'Cosco Andes', 17500, (SELECT id_estado_embarcacion FROM gestion_reserva.EstadoEmbarcacion WHERE nombre = 'En operación'), 210000.00, '33.0472°S 71.6127°W');

-- Certificacion
INSERT INTO gestion_reserva.Certificacion (id_certificacion, nombre, descripcion) VALUES
(gen_random_uuid(), 'STCW Basic Safety', 'Certificación básica de seguridad marítima según convenio STCW'),
(gen_random_uuid(), 'ISM Code Compliance', 'Cumplimiento del Código Internacional de Gestión de Seguridad'),
(gen_random_uuid(), 'ISPS Security', 'Certificado de Protección de Buques e Instalaciones Portuarias'),
(gen_random_uuid(), 'MARPOL Environmental', 'Certificación de prevención de contaminación marina'),
(gen_random_uuid(), 'Load Line Certificate', 'Certificado de línea de carga internacional'),
(gen_random_uuid(), 'Class Certificate', 'Certificado de clasificación de sociedades clasificadoras');

-- CertificacionBuque
INSERT INTO gestion_reserva.CertificacionBuque (id_certificacion_buque, id_buque, id_certificacion, fecha_emision, fecha_vencimiento) VALUES
(gen_random_uuid(), (SELECT id_buque FROM gestion_reserva.Buque WHERE matricula = 'IMO-9347438'), (SELECT id_certificacion FROM gestion_reserva.Certificacion WHERE nombre = 'STCW Basic Safety'), '2023-06-15', '2028-06-15'),
(gen_random_uuid(), (SELECT id_buque FROM gestion_reserva.Buque WHERE matricula = 'IMO-9256741'), (SELECT id_certificacion FROM gestion_reserva.Certificacion WHERE nombre = 'ISM Code Compliance'), '2024-01-10', '2027-01-10'),
(gen_random_uuid(), (SELECT id_buque FROM gestion_reserva.Buque WHERE matricula = 'IMO-9183456'), (SELECT id_certificacion FROM gestion_reserva.Certificacion WHERE nombre = 'ISPS Security'), '2023-09-20', '2028-09-20'),
(gen_random_uuid(), (SELECT id_buque FROM gestion_reserva.Buque WHERE matricula = 'IMO-9428765'), (SELECT id_certificacion FROM gestion_reserva.Certificacion WHERE nombre = 'MARPOL Environmental'), '2024-03-15', '2029-03-15'),
(gen_random_uuid(), (SELECT id_buque FROM gestion_reserva.Buque WHERE matricula = 'IMO-9512389'), (SELECT id_certificacion FROM gestion_reserva.Certificacion WHERE nombre = 'Load Line Certificate'), '2023-11-05', '2028-11-05'),
(gen_random_uuid(), (SELECT id_buque FROM gestion_reserva.Buque WHERE matricula = 'IMO-9634521'), (SELECT id_certificacion FROM gestion_reserva.Certificacion WHERE nombre = 'Class Certificate'), '2024-02-28', '2028-02-28');

-- Ruta
INSERT INTO gestion_reserva.Ruta (id_ruta, codigo, origen, destino, duracion, tarifa) VALUES
(gen_random_uuid(), 'RUT-001', 'Puerto del Callao, Perú', 'Puerto de Hamburgo, Alemania', 35, 8500.00),
(gen_random_uuid(), 'RUT-002', 'Puerto del Callao, Perú', 'Puerto de Los Angeles, USA', 18, 6200.00),
(gen_random_uuid(), 'RUT-003', 'Puerto de Paita, Perú', 'Puerto de Shanghái, China', 42, 9800.00),
(gen_random_uuid(), 'RUT-004', 'Puerto del Callao, Perú', 'Puerto de Valparaíso, Chile', 8, 2500.00),
(gen_random_uuid(), 'RUT-005', 'Puerto del Callao, Perú', 'Puerto de Manzanillo, México', 12, 4800.00),
(gen_random_uuid(), 'RUT-006', 'Puerto de Paita, Perú', 'Puerto de Miami, USA', 15, 5500.00);

-- Operacion (12 operaciones: 6 terrestres + 6 marítimas)
INSERT INTO gestion_reserva.Operacion (id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion) VALUES
(gen_random_uuid(), 'OP-2025-001', '2025-01-15 08:00:00', '2025-01-15 18:00:00', (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'Completada')),
(gen_random_uuid(), 'OP-2025-002', '2025-01-18 10:00:00', NULL, (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'En Progreso')),
(gen_random_uuid(), 'OP-2025-003', '2025-01-20 14:00:00', '2025-01-20 20:00:00', (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'En Espera')),
(gen_random_uuid(), 'OP-2025-004', '2025-01-22 09:00:00', NULL, (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'En Progreso')),
(gen_random_uuid(), 'OP-2025-005', '2025-01-25 07:00:00', NULL, (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'Cancelada')),
(gen_random_uuid(), 'OP-2025-006', '2025-01-28 11:00:00', '2025-01-28 19:00:00', (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'Completada')),
(gen_random_uuid(), 'OP-2025-007', '2025-01-10 08:00:00', '2025-02-15 18:00:00', (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'Completada')),
(gen_random_uuid(), 'OP-2025-008', '2025-01-16 09:00:00', NULL, (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'En Progreso')),
(gen_random_uuid(), 'OP-2025-009', '2025-01-20 07:00:00', NULL, (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'En Progreso')),
(gen_random_uuid(), 'OP-2025-010', '2025-01-25 10:00:00', NULL, (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'Cancelada')),
(gen_random_uuid(), 'OP-2025-011', '2025-02-01 06:00:00', NULL, (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'En Progreso')),
(gen_random_uuid(), 'OP-2025-012', '2025-02-05 08:00:00', '2025-03-10 16:00:00', (SELECT id_estado_operacion FROM gestion_reserva.EstadoOperacion WHERE nombre = 'Completada'));

-- OperacionTerrestre (6 operaciones terrestres)
INSERT INTO gestion_reserva.OperacionTerrestre (id_operacion_terrestre, id_operacion, codigo, costo_operacion_terrestre) VALUES
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-001'), 'OT-2025-001', 850.00),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-002'), 'OT-2025-002', 720.50),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-003'), 'OT-2025-003', 950.00),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-004'), 'OT-2025-004', 680.75),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-005'), 'OT-2025-005', 1100.00),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-006'), 'OT-2025-006', 820.25);

-- OperacionMaritima (6 operaciones marítimas)
INSERT INTO gestion_reserva.OperacionMaritima 
(id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, porcentaje_trayecto, id_buque) VALUES
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-007'), 'OM-2025-001', 200, 80.50, (SELECT id_buque FROM gestion_reserva.Buque WHERE nombre = 'Hapag Spirit')),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-008'), 'OM-2025-002', 180, 65.00, (SELECT id_buque FROM gestion_reserva.Buque WHERE nombre = 'Maersk Callao')),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-009'), 'OM-2025-003', 210, 90.20, (SELECT id_buque FROM gestion_reserva.Buque WHERE nombre = 'CMA CGM Lima')),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-010'), 'OM-2025-004', 190, 45.00, (SELECT id_buque FROM gestion_reserva.Buque WHERE nombre = 'MSC Pacifico')),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-011'), 'OM-2025-005', 220, 70.00, (SELECT id_buque FROM gestion_reserva.Buque WHERE nombre = 'Evergreen Peru')),
(gen_random_uuid(), (SELECT id_operacion FROM gestion_reserva.Operacion WHERE codigo = 'OP-2025-012'), 'OM-2025-006', 250, 95.50, (SELECT id_buque FROM gestion_reserva.Buque WHERE nombre = 'Cosco Andes'));

-- Reserva
INSERT INTO gestion_reserva.Reserva (id_reserva, codigo, fecha_registro, id_estado_reserva, pago_total, ruc_cliente, id_agente_reservas, matricula_buque, id_ruta) VALUES
(gen_random_uuid(), 'RES-001', '2025-01-10', (SELECT id_estado_reserva FROM gestion_reserva.EstadoReserva WHERE nombre = 'Confirmada'), 15500.00, '20481234567', (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 0), 'IMO-9347438', (SELECT id_ruta FROM gestion_reserva.Ruta WHERE codigo = 'RUT-001')),
(gen_random_uuid(), 'RES-002', '2025-01-15', (SELECT id_estado_reserva FROM gestion_reserva.EstadoReserva WHERE nombre = 'Activa'), 18200.00, '20567891234', (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 1), 'IMO-9256741', (SELECT id_ruta FROM gestion_reserva.Ruta WHERE codigo = 'RUT-002')),
(gen_random_uuid(), 'RES-003', '2025-01-18', (SELECT id_estado_reserva FROM gestion_reserva.EstadoReserva WHERE nombre = 'Finalizada'), 22500.00, '20654321098', (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 0), 'IMO-9183456', (SELECT id_ruta FROM gestion_reserva.Ruta WHERE codigo = 'RUT-003')),
(gen_random_uuid(), 'RES-004', '2025-01-20', (SELECT id_estado_reserva FROM gestion_reserva.EstadoReserva WHERE nombre = 'Cancelada'), 8500.00, '20789456123', (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 0), 'IMO-9428765', (SELECT id_ruta FROM gestion_reserva.Ruta WHERE codigo = 'RUT-004')),
(gen_random_uuid(), 'RES-005', '2025-01-22', (SELECT id_estado_reserva FROM gestion_reserva.EstadoReserva WHERE nombre = 'Activa'), 12800.00, '20876543210', (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 1), 'IMO-9512389', (SELECT id_ruta FROM gestion_reserva.Ruta WHERE codigo = 'RUT-005')),
(gen_random_uuid(), 'RES-006', '2025-01-25', (SELECT id_estado_reserva FROM gestion_reserva.EstadoReserva WHERE nombre = 'Activa'), 16750.00, '20912345678', (SELECT id_agente_reservas FROM gestion_reserva.AgenteReservas LIMIT 1 OFFSET 1), 'IMO-9634521', (SELECT id_ruta FROM gestion_reserva.Ruta WHERE codigo = 'RUT-006'));

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

-- ReservaContenedor
INSERT INTO gestion_reserva.ReservaContenedor (id_reserva_contenedor, id_reserva, id_contenedor, fecha_asignacion, cantidad) VALUES
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-001'), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-001'), '2025-01-10', 2),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-002'), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-002'), '2025-01-15', 1),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-003'), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-003'), '2025-01-18', 3),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-004'), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-004'), '2025-01-20', 1),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-005'), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-005'), '2025-01-22', 2),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-006'), (SELECT id_contenedor FROM gestion_reserva.Contenedor WHERE codigo = 'CONT-006'), '2025-01-25', 1);

-- ReservaOperacionMaritima
INSERT INTO gestion_reserva.ReservaOperacionMaritima (id_reserva_operacion_maritima, id_reserva, id_operacion_maritima, fecha_vinculacion) VALUES
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-001'), (SELECT id_operacion_maritima FROM gestion_reserva.OperacionMaritima WHERE codigo = 'OM-2025-001'), '2025-01-10'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-002'), (SELECT id_operacion_maritima FROM gestion_reserva.OperacionMaritima WHERE codigo = 'OM-2025-002'), '2025-01-15'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-003'), (SELECT id_operacion_maritima FROM gestion_reserva.OperacionMaritima WHERE codigo = 'OM-2025-003'), '2025-01-18'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-004'), (SELECT id_operacion_maritima FROM gestion_reserva.OperacionMaritima WHERE codigo = 'OM-2025-004'), '2025-01-20'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-005'), (SELECT id_operacion_maritima FROM gestion_reserva.OperacionMaritima WHERE codigo = 'OM-2025-005'), '2025-01-22'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-006'), (SELECT id_operacion_maritima FROM gestion_reserva.OperacionMaritima WHERE codigo = 'OM-2025-006'), '2025-01-25');

-- ReservaOperacionTerrestre
INSERT INTO gestion_reserva.ReservaOperacionTerrestre (id_reserva_operacion_terrestre, id_reserva, id_operacion_terrestre, fecha_vinculacion) VALUES
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-001'), (SELECT id_operacion_terrestre FROM gestion_reserva.OperacionTerrestre WHERE codigo = 'OT-2025-003'), '2025-01-10'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-002'), (SELECT id_operacion_terrestre FROM gestion_reserva.OperacionTerrestre WHERE codigo = 'OT-2025-004'), '2025-01-15'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-003'), (SELECT id_operacion_terrestre FROM gestion_reserva.OperacionTerrestre WHERE codigo = 'OT-2025-001'), '2025-01-18'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-004'), (SELECT id_operacion_terrestre FROM gestion_reserva.OperacionTerrestre WHERE codigo = 'OT-2025-005'), '2025-01-20'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-005'), (SELECT id_operacion_terrestre FROM gestion_reserva.OperacionTerrestre WHERE codigo = 'OT-2025-006'), '2025-01-22'),
(gen_random_uuid(), (SELECT id_reserva FROM gestion_reserva.Reserva WHERE codigo = 'RES-006'), (SELECT id_operacion_terrestre FROM gestion_reserva.OperacionTerrestre WHERE codigo = 'OT-2025-002'), '2025-01-25');

-- ============================================
-- FIN DEL SCRIPT DE POBLACIÓN
-- ============================================