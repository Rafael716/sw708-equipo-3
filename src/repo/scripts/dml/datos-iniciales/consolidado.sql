-- ============================================
-- SCRIPT DML CONSOLIDADO
-- Sistema Integrado de Gestión Logística
-- Datos de Prueba para Todos los Módulos
-- ============================================

-- ============================================
-- SCHEMA: shared - DATOS COMPARTIDOS
-- ============================================

SET search_path TO shared;

-- Roles de Empleado
INSERT INTO RolEmpleado (id_rol_empleado, nombre) VALUES
(1, 'Supervisor'),
(2, 'Operario'),
(3, 'Administrativo'),
(4, 'Técnico'),
(5, 'Gerente'),
(6, 'Agente de Reservas'),
(7, 'Tripulante'),
(8, 'Trabajador Portuario'),
(9, 'Conductor');

-- Roles de Usuario
INSERT INTO RolUsuario (id_rol_usuario, nombre) VALUES
(1, 'Administrador'),
(2, 'Inspector'),
(3, 'Coordinador'),
(4, 'Operador'),
(5, 'Consultor');

-- Estados de Operación
INSERT INTO EstadoOperacion (id_estado_operacion, nombre) VALUES
(1, 'Pendiente'),
(2, 'En curso'),
(3, 'Completada'),
(4, 'Cancelada'),
(5, 'En Espera');

-- Estados de Embarcación
INSERT INTO EstadoEmbarcacion (id_estado_embarcacion, nombre) VALUES
(1, 'Disponible'),
(2, 'En operación'),
(3, 'Mantenimiento'),
(4, 'Fuera de servicio');

-- Estados de Contenedor
INSERT INTO EstadoContenedor (id_estado_contenedor, nombre) VALUES
(1, 'Disponible'),
(2, 'En Tránsito'),
(3, 'Entregado'),
(4, 'En Mantenimiento'),
(5, 'Cargado');

-- Tipos de Contenedor
INSERT INTO TipoContenedor (id_tipo_contenedor, codigo, nombre, costo) VALUES
(1, '20ST', 'Contenedor 20 pies Standard', 2500.00),
(2, '40ST', 'Contenedor 40 pies Standard', 4500.00),
(3, '40HC', 'Contenedor 40 pies High Cube', 5000.00),
(4, '20RF', 'Contenedor 20 pies Refrigerado', 8000.00),
(5, '40RF', 'Contenedor 40 pies Refrigerado', 12000.00);

-- Tipos de Activo
INSERT INTO TipoActivo (id_tipo_activo, nombre) VALUES
(1, 'Equipo portuario'),
(2, 'Vehículo'),
(3, 'Infraestructura'),
(4, 'Herramienta');

-- Estados de Activo
INSERT INTO EstadoActivo (id_estado_activo, nombre) VALUES
(1, 'Operativo'),
(2, 'En mantenimiento'),
(3, 'Fuera de servicio'),
(4, 'Dado de baja');

-- Tipos de Vehículo
INSERT INTO TipoVehiculo (id_tipo_vehiculo, nombre) VALUES
(1, 'Camión rígido'),
(2, 'Tracto camión'),
(3, 'Furgón'),
(4, 'Camión cisterna');

-- Estados de Vehículo
INSERT INTO EstadoVehiculo (id_estado_vehiculo, nombre) VALUES
(1, 'Disponible'),
(2, 'En ruta'),
(3, 'Mantenimiento'),
(4, 'Fuera de servicio');

-- Tipos de Incidencia
INSERT INTO TipoIncidencia (id_tipo_incidencia, nombre) VALUES
(1, 'Seguridad'),
(2, 'Operacional'),
(3, 'Ambiental'),
(4, 'Administrativa');

-- Estados de Incidencia
INSERT INTO EstadoIncidencia (id_estado_incidencia, nombre) VALUES
(1, 'Reportada'),
(2, 'En investigación'),
(3, 'Resuelta'),
(4, 'Cerrada');

-- Tipos de Documento
INSERT INTO TipoDocumento (id_tipo_documento, nombre) VALUES
(1, 'Guía de remisión'),
(2, 'Factura'),
(3, 'Orden de compra'),
(4, 'Certificado'),
(5, 'Manifiesto de carga'),
(6, 'Bill of Lading'),
(7, 'DUA'),
(8, 'Packing List');

-- Prioridades
INSERT INTO Prioridad (id_prioridad, nombre) VALUES
(1, 'Baja'),
(2, 'Media'),
(3, 'Alta'),
(4, 'Urgente'),
(5, 'Crítica');

-- ============================================
-- EMPLEADOS (todos los módulos)
-- ============================================

INSERT INTO Empleado (id_empleado, codigo, dni, nombre, apellido, direccion, id_rol_empleado) VALUES
-- Gerentes y Supervisores (1-10)
(1, 'EMP-001', '12345678', 'Juan', 'Pérez García', 'Av. Marina 123, Callao', 5),
(2, 'EMP-002', '23456789', 'María', 'López Rodríguez', 'Jr. Lima 456, Lima', 1),
(3, 'EMP-003', '34567890', 'Carlos', 'Sánchez Torres', 'Av. Grau 789, Callao', 4),
(4, 'EMP-004', '45678901', 'Ana', 'Martínez Flores', 'Calle Real 321, Lima', 2),
(5, 'EMP-005', '56789012', 'Luis', 'González Vega', 'Av. Colonial 654, Lima', 2),
(6, 'EMP-006', '67890123', 'Carmen', 'Ramírez Castro', 'Jr. Unión 987, Callao', 3),
(7, 'EMP-007', '78901234', 'Pedro', 'Díaz Morales', 'Av. Benavides 147, Lima', 4),
(8, 'EMP-008', '89012345', 'Rosa', 'Fernández Silva', 'Calle Los Pinos 258, Callao', 2),
(9, 'EMP-009', '90123456', 'Jorge', 'Torres Mendoza', 'Av. Arequipa 369, Lima', 1),
(10, 'EMP-010', '01234567', 'Elena', 'Vargas Quispe', 'Jr. Tacna 741, Callao', 4),
-- Agentes de Reservas (11-15)
(11, 'EMP-011', '11223344', 'Sofia', 'Vargas Ruiz', 'Av. Larco 234, Miraflores', 6),
(12, 'EMP-012', '22334455', 'Ricardo', 'Flores Mendoza', 'Jr. Unión 567, Lima', 6),
-- Tripulantes (16-35)
(16, 'EMP-016', '16223344', 'Alberto', 'Navarro Soto', 'Av. Pacífico 234, Callao', 7),
(17, 'EMP-017', '17334455', 'Fernando', 'Morales Cruz', 'Jr. Marina 567, Callao', 7),
(18, 'EMP-018', '18445566', 'Roberto', 'Silva Delgado', 'Calle Océano 890, Callao', 7),
(19, 'EMP-019', '19556677', 'Marcos', 'Guerrero Ramos', 'Av. Grau 1234, Callao', 7),
(20, 'EMP-020', '20667788', 'Diego', 'Campos Rivera', 'Jr. Bolognesi 567, Callao', 7),
(28, 'EMP-028', '28445566', 'Eduardo', 'Castillo Vega', 'Av. Colonial 678, Callao', 7),
(29, 'EMP-029', '29556677', 'Andrés', 'Fuentes Rojas', 'Jr. Comercio 234, Callao', 7),
(30, 'EMP-030', '30667788', 'Luis', 'Paredes Díaz', 'Calle Lima 567, Callao', 7),
(31, 'EMP-031', '31778899', 'Jorge', 'Mendoza Silva', 'Av. Argentina 890, Callao', 7),
(32, 'EMP-032', '32889900', 'Raúl', 'Torres Castro', 'Jr. Puno 123, Callao', 7),
(33, 'EMP-033', '33990011', 'Arturo', 'Ramírez Luna', 'Av. Grau 456, Callao', 7),
(34, 'EMP-034', '34001122', 'Víctor', 'Salazar Pérez', 'Calle Real 789, Callao', 7),
(35, 'EMP-035', '35112233', 'Samuel', 'Gutiérrez Flores', 'Jr. Tacna 321, Callao', 7),
-- Conductores (36-45)
(36, 'EMP-036', '36223344', 'Pedro', 'Quispe Mamani', 'Av. Túpac Amaru 234, Lima', 9),
(37, 'EMP-037', '37334455', 'Miguel', 'Rojas Sánchez', 'Jr. Los Álamos 567, Lima', 9),
(38, 'EMP-038', '38445566', 'César', 'Huamán Pérez', 'Calle Los Pinos 890, Lima', 9),
(39, 'EMP-039', '39556677', 'Luis', 'Flores Vargas', 'Av. Universitaria 123, Lima', 9),
(40, 'EMP-040', '40667788', 'José', 'Mendoza Cruz', 'Jr. Las Camelias 456, Lima', 9),
(41, 'EMP-041', '41778899', 'Mario', 'Castro Díaz', 'Av. Venezuela 789, Lima', 9),
(42, 'EMP-042', '42889900', 'Raúl', 'Soto Ramírez', 'Calle Lima 321, Callao', 9),
(43, 'EMP-043', '43990011', 'Jorge', 'Vega Torres', 'Jr. Arequipa 654, Lima', 9),
(44, 'EMP-044', '44001122', 'Carlos', 'Luna Salazar', 'Av. Brasil 987, Lima', 9),
(45, 'EMP-045', '45112233', 'Roberto', 'Silva Guzmán', 'Calle Real 147, Lima', 9),
-- Administrativos y Coordinadores (46-48)
(46, 'EMP-046', '46223344', 'Ana', 'Morales Ruiz', 'Av. Arequipa 258, Lima', 3),
(47, 'EMP-047', '47334455', 'Patricia', 'López Castro', 'Jr. Cusco 369, Lima', 4),
(48, 'EMP-048', '48445566', 'Rosa', 'González Pérez', 'Av. La Marina 741, Lima', 1),
-- Técnicos de mantenimiento (49-56)
(49, 'EMP-049', '49556677', 'Ricardo', 'Fernández Díaz', 'Av. Industrial 258, Callao', 4),
(50, 'EMP-050', '50667788', 'Andrés', 'Chávez Morales', 'Jr. Técnico 369, Lima', 4),
(51, 'EMP-051', '51778899', 'Julio', 'Paredes Silva', 'Calle Miraflores 147, Lima', 4),
(52, 'EMP-052', '52889900', 'Oscar', 'Gutierrez López', 'Av. República 456, Lima', 4),
(53, 'EMP-053', '53990011', 'Daniel', 'Campos Ruiz', 'Jr. Los Olivos 789, Callao', 4),
(54, 'EMP-054', '54001122', 'Manuel', 'Torres Castro', 'Av. Perú 321, Callao', 4),
(55, 'EMP-055', '55112233', 'Gabriel', 'Ríos Mendoza', 'Calle Industrial 654, Lima', 4),
(56, 'EMP-056', '56223344', 'Héctor', 'Salinas Vega', 'Jr. Progreso 987, Callao', 4),
-- Responsables de solicitud (57-60)
(57, 'EMP-057', '57334455', 'Laura', 'Ramírez Torres', 'Av. Universitaria 741, Lima', 1),
(58, 'EMP-058', '58445566', 'Carmen', 'Soto Flores', 'Jr. Comercio 852, Lima', 1),
(59, 'EMP-059', '59556677', 'Elena', 'Vargas Pérez', 'Calle Real 963, Callao', 3),
(60, 'EMP-060', '60667788', 'Mónica', 'Luna Castro', 'Av. Central 159, Lima', 1);

-- Teléfonos de Empleados
INSERT INTO EmpleadoTelefono (id_empleado, telefono, tipo) VALUES
(1, '987654321', 'Móvil'),
(1, '014567890', 'Fijo'),
(2, '998765432', 'Móvil'),
(3, '976543210', 'Móvil'),
(4, '965432109', 'Móvil'),
(5, '954321098', 'Móvil'),
(6, '943210987', 'Móvil'),
(7, '932109876', 'Móvil'),
(8, '921098765', 'Móvil'),
(9, '910987654', 'Móvil'),
(10, '909876543', 'Móvil'),
(11, '998877665', 'Móvil'),
(12, '987766554', 'Móvil'),
(16, '945678901', 'Móvil'),
(17, '934567890', 'Móvil'),
(18, '923456789', 'Móvil'),
(19, '912345678', 'Móvil'),
(20, '901234567', 'Móvil'),
(28, '990011223', 'Móvil'),
(29, '989900112', 'Móvil'),
(30, '978899001', 'Móvil'),
(31, '967788990', 'Móvil'),
(32, '956677889', 'Móvil'),
(33, '945566778', 'Móvil'),
(34, '934455667', 'Móvil'),
(35, '923344556', 'Móvil'),
(36, '912233445', 'Móvil'),
(37, '923344556', 'Móvil'),
(38, '934455667', 'Móvil'),
(39, '945566778', 'Móvil'),
(40, '956677889', 'Móvil'),
(41, '967788990', 'Móvil'),
(42, '978899001', 'Móvil'),
(43, '989900112', 'Móvil'),
(44, '990011223', 'Móvil'),
(45, '901122334', 'Móvil'),
(46, '912344567', 'Móvil'),
(46, '014789523', 'Fijo'),
(47, '923455678', 'Móvil'),
(48, '934566789', 'Móvil'),
(49, '945667788', 'Móvil'),
(50, '956778899', 'Móvil'),
(51, '967889900', 'Móvil'),
(52, '978990011', 'Móvil'),
(53, '989001122', 'Móvil'),
(54, '990112233', 'Móvil'),
(55, '901223344', 'Móvil'),
(56, '912334455', 'Móvil'),
(57, '923445566', 'Móvil'),
(57, '014852963', 'Fijo'),
(58, '934556677', 'Móvil'),
(59, '945667788', 'Móvil'),
(60, '956778899', 'Móvil');

-- Usuarios
INSERT INTO Usuario (id_usuario, id_empleado, correo_electronico, contrasena, id_rol_usuario) VALUES
(1, 1, 'juan.perez@logistica.com', '$2y$10$abcdefghijklmnopqrstuvwxyz1234567890', 1),
(2, 2, 'maria.lopez@logistica.com', '$2y$10$bcdefghijklmnopqrstuvwxyz12345678901', 4),
(3, 3, 'carlos.sanchez@logistica.com', '$2y$10$cdefghijklmnopqrstuvwxyz123456789012', 2),
(4, 6, 'carmen.ramirez@logistica.com', '$2y$10$defghijklmnopqrstuvwxyz1234567890123', 3),
(5, 7, 'pedro.diaz@logistica.com', '$2y$10$efghijklmnopqrstuvwxyz12345678901234', 2),
(6, 9, 'jorge.torres@logistica.com', '$2y$10$fghijklmnopqrstuvwxyz123456789012345', 4),
(7, 10, 'elena.vargas@logistica.com', '$2y$10$ghijklmnopqrstuvwxyz1234567890123456', 5),
(10, 46, 'ana.morales@logistica.com', '$2y$10$klmnopqrstuvwxyz123456789012345678', 3),
(11, 47, 'patricia.lopez@logistica.com', '$2y$10$lmnopqrstuvwxyz1234567890123456789', 4),
(12, 48, 'rosa.gonzalez@logistica.com', '$2y$10$mnopqrstuvwxyz12345678901234567890', 1);

-- Buques
INSERT INTO Buque (matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual) VALUES
('IMO-1234567', 'Pacific Trader', 8000, 1, 120000.00, '12.0464°S, 77.0428°W'),
('IMO-2345678', 'Atlantic Express', 10000, 2, 140000.00, '11.9234°S, 77.1345°W'),
('IMO-3456789', 'Mediterranean Star', 9000, 2, 135000.00, '11.9234°S, 77.1345°W'),
('IMO-4567890', 'Asian Navigator', 12000, 1, 160000.00, NULL),
('IMO-5678901', 'European Carrier', 11000, 1, 155000.00, '12.1567°S, 77.2456°W'),
('IMO-9347438', 'Hapag Spirit', 12000, 2, 150000.00, '12.046374°S, 77.042793°W'),
('IMO-8765432', 'MSC Pacific Star', 15000, 1, 180000.00, NULL),
('IMO-7654321', 'CMA CGM Andes', 10000, 2, 135000.00, '12.156789°S, 77.245678°W'),
('PE-2023-001', 'Pacífico Star', 5000, 1, 50000.00, '-12.0464,-77.0428'),
('PE-2023-002', 'Andes Navigator', 3500, 1, 35000.00, '-12.0464,-77.0428'),
('PE-2022-003', 'Lima Express', 4200, 2, 42000.00, '-13.1631,-76.2500'),
('CH-2023-004', 'Southern Cross', 6000, 1, 60000.00, '-33.4489,-70.6693');

-- Contenedores
INSERT INTO Contenedor (id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor, disponibilidad) VALUES
(1, 'CONT-20-001', 2300.00, 28000.00, '20x8x8.5', 1, 1, true),
(2, 'CONT-20-002', 2400.00, 28000.00, '20x8x8.5', 2, 1, false),
(3, 'CONT-40-001', 3800.00, 26500.00, '40x8x8.5', 2, 2, false),
(4, 'CONT-40-002', 3900.00, 26500.00, '40x8x8.5', 1, 2, true),
(5, 'CONT-40HC-001', 4200.00, 26330.00, '40x8x9.5', 2, 3, false),
(6, 'CONT-20RF-001', 3100.00, 28000.00, '20x8x8.5', 1, 4, true),
(7, 'CONT-40RF-001', 4800.00, 26500.00, '40x8x8.5', 3, 5, false),
(8, 'CONT-20-003', 2500.50, 28000.00, '20x8x8.5', 1, 1, TRUE),
(9, 'CONT-40-003', 4100.00, 26500.00, '40x8x8.5', 4, 2, FALSE),
(10, 'CONT-20RF-002', 3300.25, 28000.00, '20x8x8.5', 1, 4, TRUE);

-- Mercancía de Contenedores
INSERT INTO ContenedorMercancia (id_contenedor, tipo_mercancia) VALUES
(1, 'Textiles'),
(2, 'Electrodomésticos'),
(3, 'Maquinaria Industrial'),
(4, 'Repuestos Automotrices'),
(5, 'Productos Químicos'),
(6, 'Alimentos Perecibles'),
(7, 'Productos Farmacéuticos'),
(8, 'Electrónica'),
(9, 'Textiles'),
(10, 'Alimentos Perecibles');

-- Certificaciones
INSERT INTO Certificacion (id_certificacion, codigo, nombre, descripcion, duracion_anios) VALUES
(1, 'CERT-001', 'STCW Basic Safety Training', 'Certificación básica de seguridad para buques', 5),
(2, 'CERT-002', 'GMDSS Operator', 'Certificación de operación GMDSS', 5),
(3, 'CERT-003', 'Advanced Fire Fighting', 'Certificación avanzada contra incendios', 5),
(4, 'CERT-004', 'Medical First Aid', 'Certificación de primeros auxilios médicos', 5),
(5, 'CERT-005', 'Ship Security Officer', 'Certificación de oficial de seguridad', 5),
(6, 'CERT-006', 'Bridge Resource Management', 'Gestión de recursos del puente', 5),
(7, 'CERT-007', 'Radar Navigation', 'Navegación por radar', 5),
(8, 'CERT-008', 'Engine Room Simulator', 'Simulador de sala de máquinas', 5),
(9, 'CERT-009', 'Crisis Management', 'Gestión de crisis', 5),
(10, 'CERT-010', 'ECDIS Training', 'Entrenamiento ECDIS', 5),
(11, 'CERT-011', 'Capitán de Altura', 'Certificación para comandar buques de alto tonelaje', 5),
(12, 'CERT-012', 'Oficial de Navegación', 'Certificación de navegación internacional', 3),
(13, 'CERT-013', 'Operador de Grúa Nivel 1', 'Certificación básica de operación de grúas', 2),
(14, 'CERT-014', 'Seguridad Marítima STCW', 'Certificación internacional de seguridad', 5),
(15, 'CERT-015', 'Inspector de Calidad ISO', 'Certificación en sistemas de calidad', 3);

-- Certificaciones de Buque
INSERT INTO CertificacionBuque (id_certificacion_buque, matricula, id_certificacion, fecha_emision, fecha_vencimiento) VALUES
(1, 'IMO-1234567', 1, '2023-03-15', '2028-03-15'),
(2, 'IMO-2345678', 2, '2023-04-10', '2028-04-10'),
(3, 'IMO-3456789', 3, '2024-01-20', '2029-01-20'),
(4, 'IMO-4567890', 4, '2022-11-05', '2027-11-05'),
(5, 'IMO-5678901', 5, '2021-08-15', '2026-08-15'),
(6, 'IMO-9347438', 1, '2023-01-10', '2028-01-10'),
(7, 'PE-2023-001', 14, '2023-01-10', '2028-01-10'),
(8, 'PE-2023-002', 14, '2023-02-15', '2028-02-15'),
(9, 'PE-2022-003', 14, '2022-06-20', '2027-06-20'),
(10, 'CH-2023-004', 14, '2023-03-25', '2028-03-25');

-- Rutas
INSERT INTO Ruta (id_ruta, codigo, origen, destino, duracion, tarifa) VALUES
(1, 'R001', 'Puerto del Callao', 'Puerto de Paita', 48, 500.00),
(2, 'R002', 'Puerto del Callao', 'Puerto de Matarani', 72, 750.00),
(3, 'R003', 'Puerto de Paita', 'Puerto de Matarani', 60, 600.00),
(4, 'RUT-001', 'Callao', 'Valparaíso', 5, 15000.00),
(5, 'RUT-002', 'Callao', 'Guayaquil', 3, 8500.00),
(6, 'RUT-003', 'Paita', 'Guayaquil', 2, 6000.00),
(7, 'RUT-004', 'Callao', 'San Antonio', 6, 18000.00),
(13, 'RUT-013', 'Callao', 'Lima Centro', 1, 150.00),
(14, 'RUT-014', 'Callao', 'Arequipa', 2, 800.00),
(15, 'RUT-015', 'Lima', 'Trujillo', 2, 650.00),
(16, 'RUT-016', 'Lima', 'Cusco', 3, 950.00),
(17, 'RUT-017', 'Callao', 'Ica', 1, 450.00),
(18, 'RUT-018', 'Lima', 'Chiclayo', 2, 700.00),
(19, 'RUT-019', 'Callao', 'Huancayo', 1, 350.00),
(20, 'RUT-020', 'Lima', 'Piura', 3, 1100.00);

-- Activos
INSERT INTO Activo (id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion) VALUES
-- Vehículos terrestres
(1, 'ACT-001', 'Camión Volvo FH16', 2, 1, 'Patio Principal'),
(2, 'ACT-002', 'Camión Mercedes-Benz Actros', 2, 1, 'Patio Principal'),
(3, 'ACT-003', 'Tracto Scania R500', 2, 1, 'Patio Principal'),
(4, 'ACT-004', 'Camión Hino 500', 2, 2, 'Taller Mecánico'),
(5, 'ACT-005', 'Furgón Isuzu NPR', 2, 1, 'Patio Secundario'),
(6, 'ACT-006', 'Camión JAC 1063', 2, 1, 'Patio Principal'),
(7, 'ACT-007', 'Tracto Kenworth T800', 2, 1, 'Patio Principal'),
(8, 'ACT-008', 'Camión Freightliner Cascadia', 2, 3, 'Taller Mecánico'),
(9, 'ACT-009', 'Furgón Mitsubishi Canter', 2, 1, 'Patio Secundario'),
(10, 'ACT-010', 'Camión Iveco Trakker', 2, 1, 'Patio Principal'),
-- Equipos portuarios
(11, 'ACT-011', 'Grúa Pórtico Konecranes', 1, 1, 'Muelle 1'),
(12, 'ACT-012', 'Reach Stacker Kalmar', 1, 1, 'Patio Contenedores'),
(13, 'ACT-013', 'Montacargas Toyota 8FD25', 1, 2, 'Taller Mantenimiento'),
(14, 'ACT-014', 'Grúa Móvil Liebherr LTM 1100', 1, 1, 'Muelle 2'),
(15, 'ACT-015', 'Tractor Terminal Terberg', 1, 1, 'Patio Principal'),
(16, 'ACT-016', 'Montacargas Hyster H120FT', 1, 1, 'Almacén A'),
(17, 'ACT-017', 'Grúa Pórtico ZPMC', 1, 2, 'Taller Mantenimiento'),
(18, 'ACT-018', 'Reach Stacker CVS Ferrari', 1, 1, 'Patio Contenedores');

-- Vehículos
INSERT INTO Vehiculo (id_vehiculo, id_activo, placa, capacidad_ton, id_tipo_vehiculo, id_estado_vehiculo) VALUES
(1, 1, 'AXW-758', 28.00, 2, 1),
(2, 2, 'BYZ-842', 30.00, 2, 1),
(3, 3, 'CZA-915', 32.00, 2, 1),
(4, 4, 'DAB-123', 25.00, 1, 3),
(5, 5, 'EBC-456', 8.00, 3, 1),
(6, 6, 'FCD-789', 20.00, 1, 1),
(7, 7, 'GDE-321', 35.00, 2, 1),
(8, 8, 'HEF-654', 28.00, 1, 4),
(9, 9, 'IFG-987', 7.50, 3, 1),
(10, 10, 'JGH-147', 30.00, 2, 1);

-- Operaciones (compartidas entre módulos)
INSERT INTO Operacion (id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion) VALUES
-- Operaciones módulo reservas (1-3)
(1, 'OP-2024-001', '2024-02-01 08:00:00', '2024-02-03 18:00:00', 1),
(2, 'OP-2024-002', '2024-03-05 09:00:00', '2024-03-07 20:00:00', 2),
(3, 'OP-2024-003', '2024-04-10 07:30:00', '2024-04-12 19:30:00', 3),
-- Operaciones módulo operaciones marítimas (4-8)
(4, 'OP-2024-004', '2024-09-01 08:00:00', '2024-09-06 18:00:00', 3),
(5, 'OP-2024-005', '2024-09-15 06:00:00', NULL, 2),
(6, 'OP-2024-006', '2024-09-20 14:00:00', '2024-09-20 20:00:00', 3),
(7, 'OP-2024-007', '2024-10-01 10:00:00', NULL, 2),
(8, 'OP-2024-008', '2024-10-05 07:00:00', NULL, 1),
-- Operaciones módulo personal tripulación (21-25)
(21, 'OP-2025-021', '2025-09-05 06:00:00', '2025-09-10 18:00:00', 3),
(22, 'OP-2025-022', '2025-09-08 08:00:00', NULL, 2),
(23, 'OP-2025-023', '2025-09-11 07:00:00', NULL, 2),
(24, 'OP-2025-024', '2025-09-13 09:00:00', '2025-09-18 17:00:00', 3),
(25, 'OP-2025-025', '2025-09-15 10:00:00', NULL, 2),
-- Operaciones módulo operaciones terrestres (26-33)
(26, 'OP-2025-026', '2025-09-25 08:00:00', '2025-09-25 20:00:00', 3),
(27, 'OP-2025-027', '2025-09-26 06:00:00', NULL, 2),
(28, 'OP-2025-028', '2025-09-27 07:00:00', '2025-09-29 18:00:00', 3),
(29, 'OP-2025-029', '2025-09-28 09:00:00', NULL, 2),
(30, 'OP-2025-030', '2025-09-29 08:30:00', NULL, 2),
(31, 'OP-2025-031', '2025-09-30 07:00:00', '2025-10-02 16:00:00', 3),
(32, 'OP-2025-032', '2025-10-01 06:00:00', NULL, 2),
(33, 'OP-2025-033', '2025-10-02 08:00:00', NULL, 2),
-- Operaciones módulo mantenimiento (34-41)
(34, 'OP-2025-034', '2025-09-16 08:00:00', '2025-09-16 18:00:00', 3),
(35, 'OP-2025-035', '2025-09-19 07:00:00', '2025-09-20 16:00:00', 3),
(36, 'OP-2025-036', '2025-09-21 09:00:00', '2025-09-21 17:00:00', 3),
(37, 'OP-2025-037', '2025-09-23 08:30:00', '2025-09-23 19:00:00', 3),
(38, 'OP-2025-038', '2025-09-26 07:00:00', NULL, 2),
(39, 'OP-2025-039', '2025-09-29 08:00:00', '2025-09-29 18:00:00', 3),
(40, 'OP-2025-040', '2025-10-01 07:30:00', '2025-10-01 16:30:00', 3),
(41, 'OP-2025-041', '2025-10-02 08:00:00', '2025-10-03 17:00:00', 3),
-- Operaciones módulo monitoreo (42-47)
(42, 'OP-2025-042', '2025-09-20 08:00:00', '2025-09-25 18:00:00', 3),
(43, 'OP-2025-043', '2025-09-22 10:00:00', NULL, 2),
(44, 'OP-2025-044', '2025-09-24 14:00:00', NULL, 2),
(45, 'OP-2025-045', '2025-09-26 09:00:00', NULL, 2),
(46, 'OP-2025-046', '2025-09-28 07:00:00', '2025-10-02 16:00:00', 3),
(47, 'OP-2025-047', '2025-10-01 11:00:00', NULL, 2);

-- Incidencias (compartidas)
INSERT INTO Incidencia (id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_estado_incidencia, id_operacion, id_usuario) VALUES
(1, 'INC-001', 2, 'Retraso de 2 horas por condiciones climáticas adversas', 2, '2024-09-02 12:00:00', 3, 4, 2),
(2, 'INC-002', 1, 'Falla menor en sistema hidráulico de grúa', 3, '2024-09-20 16:30:00', 3, 6, 3),
(3, 'INC-OT-001', 2, 'Retraso por tráfico pesado en Av. Javier Prado', 2, '2025-09-26 10:30:00', 3, 27, 10),
(4, 'INC-OT-002', 1, 'Neumático pinchado en ruta - reemplazo realizado', 3, '2025-09-28 14:20:00', 4, 28, 10),
(5, 'INC-OT-003', 2, 'Demora en punto de control policial', 1, '2025-09-29 11:45:00', 4, 29, 11),
(6, 'INC-OT-004', 3, 'Derrame menor de líquido refrigerante', 4, '2025-09-30 16:10:00', 2, 31, 10),
(7, 'INC-OT-005', 2, 'Falla temporal en sistema GPS', 2, '2025-10-01 09:30:00', 3, 32, 11),
(8, 'INC-MON-001', 2, 'Vibración excesiva detectada en contenedor durante transporte', 2, '2025-09-22 15:30:00', 3, 43, 3),
(9, 'INC-MON-002', 3, 'Temperatura fuera de rango en contenedor refrigerado', 4, '2025-09-23 11:45:00', 2, 44, 5),
(10, 'INC-MON-003', 1, 'Apertura no autorizada detectada en contenedor', 5, '2025-09-24 09:20:00', 2, 45, 3);

-- ============================================
-- MÓDULO: reservas
-- ============================================

SET search_path TO reservas, shared;

-- Estados de Reserva
INSERT INTO EstadoReserva (id_estado_reserva, nombre) VALUES
(1, 'Activa'),
(2, 'Confirmada'),
(3, 'Completada'),
(4, 'Cancelada');

-- Clientes
INSERT INTO Cliente (ruc, razon_social, direccion, email) VALUES
('20123456789', 'Transportes Andinos S.A.', 'Av. Perú 123, Lima', 'contacto@andinos.com.pe'),
('20123456780', 'Comercial Lima S.A.', 'Jr. Arequipa 456, Lima', 'ventas@comercialima.pe'),
('20123456781', 'Logística Cusco E.I.R.L.', 'Av. El Sol 789, Cusco', 'info@logisticacusco.pe');

-- Teléfonos de Clientes
INSERT INTO ClienteTelefono (ruc, telefono) VALUES
('20123456789', '987654321'),
('20123456789', '987654322'),
('20123456780', '988877766'),
('20123456781', '999888777');

-- Agentes de Reservas
INSERT INTO AgenteReservas (id_agente_reservas, id_empleado) VALUES
(1, 11),
(2, 12);

-- Operaciones Terrestres
INSERT INTO OperacionTerrestre (id_operacion_terrestre, id_operacion, codigo, costo_operacion_terrestre) VALUES
(1, 1, 'OT001', 200.00),
(2, 2, 'OT002', 350.00),
(3, 3, 'OT003', 500.00);

-- Operaciones Marítimas
INSERT INTO OperacionMaritima (id_operacion_maritima, id_operacion, codigo, matricula_buque, cant_contenedores, porcentaje_trayecto) VALUES
(1, 1, 'OM001', 'IMO-1234567', 10, 40),
(2, 2, 'OM002', 'IMO-2345678', 15, 60),
(3, 3, 'OM003', 'IMO-3456789', 8, 50);

-- Rutas Marítimas
INSERT INTO RutaMaritima (id_ruta_maritima, id_ruta, puerto_origen, puerto_destino) VALUES
(1, 1, 'Puerto del Callao', 'Puerto de Paita'),
(2, 2, 'Puerto del Callao', 'Puerto de Matarani'),
(3, 3, 'Puerto de Paita', 'Puerto de Matarani');

-- Operación Ruta Marítima
INSERT INTO OperacionRutaMaritima (id_operacion_ruta_maritima, id_operacion_maritima, id_ruta_maritima) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Reservas
INSERT INTO Reserva (id_reserva, codigo, fecha_registro, id_estado_reserva, pago_total, ruc_cliente, id_agente_reservas, matricula_buque, id_ruta) VALUES
(1, 'RES001', '2024-01-15', 1, 1000.00, '20123456789', 1, 'IMO-1234567', 1),
(2, 'RES002', '2024-02-20', 2, 1500.00, '20123456780', 2, 'IMO-2345678', 2),
(3, 'RES003', '2025-03-25', 3, 2000.00, '20123456781', 1, 'IMO-3456789', 3);

-- Reserva Contenedor
INSERT INTO ReservaContenedor (id_reserva, id_contenedor, fecha_asignacion, cantidad) VALUES
(1, 1, '2024-01-15', 2),
(2, 4, '2024-02-20', 1),
(3, 8, '2025-03-25', 3);

-- Reserva Operación Terrestre
INSERT INTO ReservaOperacionTerrestre (id_reserva, id_operacion_terrestre, fecha_vinculacion) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-02-20'),
(3, 3, '2025-03-25');

-- Reserva Operación Marítima
INSERT INTO ReservaOperacionMaritima (id_reserva, id_operacion_maritima, fecha_vinculacion) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-02-20'),
(3, 3, '2025-03-25');

-- ============================================
-- MÓDULO: personal_tripulacion
-- ============================================

SET search_path TO personal_tripulacion, shared;

-- Estados de Contrato
INSERT INTO EstadoContrato (id_estado_contrato, nombre) VALUES
(1, 'Vigente'),
(2, 'Vencido'),
(3, 'Suspendido'),
(4, 'Renovado');

-- Contratos
INSERT INTO Contrato (id_contrato, id_estado_contrato, fecha_emision, fecha_vencimiento) VALUES
(1, 1, '2024-01-15', '2025-01-15'),
(2, 1, '2024-03-10', '2025-03-10'),
(3, 1, '2024-02-20', '2025-02-20'),
(4, 1, '2023-11-05', '2024-11-05'),
(5, 2, '2023-06-15', '2024-06-15'),
(6, 1, '2024-05-20', '2025-05-20'),
(7, 1, '2024-04-10', '2025-04-10'),
(8, 1, '2024-06-01', '2025-06-01'),
(9, 1, '2023-12-10', '2024-12-10'),
(10, 1, '2024-07-15', '2025-07-15'),
(11, 1, '2024-02-28', '2025-02-28'),
(12, 1, '2024-08-05', '2025-08-05'),
(13, 1, '2024-01-20', '2025-01-20');

-- Tripulantes
INSERT INTO Tripulante (id_tripulante, id_empleado, disponibilidad, nacionalidad, id_contrato) VALUES
(1, 16, TRUE, 'Peruana', 1),
(2, 17, TRUE, 'Peruana', 2),
(3, 18, FALSE, 'Chilena', 3),
(4, 19, TRUE, 'Peruana', 4),
(5, 20, TRUE, 'Ecuatoriana', 5),
(6, 28, TRUE, 'Peruana', 6),
(7, 29, TRUE, 'Colombiana', 7),
(8, 30, FALSE, 'Peruana', 8),
(9, 31, TRUE, 'Peruana', 9),
(10, 32, TRUE, 'Venezolana', 10),
(11, 33, TRUE, 'Peruana', 11),
(12, 34, TRUE, 'Peruana', 12),
(13, 35, FALSE, 'Boliviana', 13);

-- Idiomas de Tripulantes
INSERT INTO TripulanteIdioma (id_tripulante, idioma, nivel) VALUES
(1, 'Español', 'Nativo'),
(1, 'Inglés', 'Avanzado'),
(2, 'Español', 'Nativo'),
(2, 'Inglés', 'Intermedio'),
(3, 'Español', 'Nativo'),
(3, 'Inglés', 'Avanzado'),
(3, 'Portugués', 'Básico'),
(4, 'Español', 'Nativo'),
(4, 'Inglés', 'Avanzado'),
(4, 'Francés', 'Intermedio'),
(5, 'Español', 'Nativo'),
(5, 'Inglés', 'Intermedio'),
(6, 'Español', 'Nativo'),
(6, 'Inglés', 'Avanzado'),
(7, 'Español', 'Nativo'),
(7, 'Inglés', 'Avanzado'),
(8, 'Español', 'Nativo'),
(8, 'Inglés', 'Intermedio'),
(9, 'Español', 'Nativo'),
(9, 'Inglés', 'Avanzado'),
(10, 'Español', 'Nativo'),
(10, 'Inglés', 'Intermedio'),
(11, 'Español', 'Nativo'),
(11, 'Inglés', 'Avanzado'),
(12, 'Español', 'Nativo'),
(12, 'Inglés', 'Avanzado'),
(12, 'Portugués', 'Intermedio'),
(13, 'Español', 'Nativo'),
(13, 'Inglés', 'Básico');

-- Certificaciones de Tripulantes
INSERT INTO CertificacionTripulante (id_certificacion_tripulante, id_tripulante, id_certificacion, fecha_emision, fecha_vencimiento) VALUES
(1, 1, 1, '2023-03-15', '2028-03-15'),
(2, 1, 2, '2023-04-10', '2028-04-10'),
(3, 1, 6, '2024-05-10', '2029-05-10'),
(4, 2, 1, '2023-03-15', '2028-03-15'),
(5, 2, 3, '2024-01-20', '2029-01-20'),
(6, 3, 1, '2023-03-15', '2028-03-15'),
(7, 3, 2, '2023-04-10', '2028-04-10'),
(8, 3, 7, '2023-07-15', '2028-07-15'),
(9, 4, 1, '2023-03-15', '2028-03-15'),
(10, 4, 2, '2023-04-10', '2028-04-10'),
(11, 4, 5, '2021-08-15', '2026-08-15'),
(12, 5, 1, '2023-03-15', '2028-03-15'),
(13, 5, 4, '2022-11-05', '2027-11-05');

-- Buque Tripulante
INSERT INTO BuqueTripulante (matricula, id_tripulante, fecha_asignacion, fecha_desasignacion) VALUES
('IMO-1234567', 1, '2024-03-01', '2024-09-01'),
('IMO-1234567', 2, '2024-03-01', NULL),
('IMO-1234567', 6, '2024-09-15', NULL),
('IMO-2345678', 3, '2024-02-15', NULL),
('IMO-2345678', 4, '2024-02-15', NULL),
('IMO-2345678', 7, '2024-06-01', NULL),
('IMO-3456789', 5, '2024-04-10', '2024-10-10'),
('IMO-3456789', 8, '2024-04-10', NULL),
('IMO-3456789', 9, '2024-10-15', NULL),
('IMO-4567890', 1, '2024-09-05', NULL),
('IMO-4567890', 10, '2024-05-20', NULL),
('IMO-4567890', 11, '2024-05-20', NULL),
('IMO-5678901', 12, '2024-06-15', NULL),
('IMO-5678901', 13, '2024-06-15', NULL);

-- Operaciones Marítimas
INSERT INTO OperacionMaritima (id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, condiciones_operativas, porcentaje_trayecto, estatus_navegacion, matricula) VALUES
(6, 21, 'OPM-2025-006', 280, 'Normal', 100.00, 'Atracado', 'IMO-1234567'),
(7, 22, 'OPM-2025-007', 350, 'Viento intenso', 55.20, 'Navegando', 'IMO-2345678'),
(8, 23, 'OPM-2025-008', 200, 'Oleaje fuerte', 38.90, 'Navegando', 'IMO-3456789'),
(9, 24, 'OPM-2025-009', 420, 'Normal', 100.00, 'Atracado', 'IMO-4567890'),
(10, 25, 'OPM-2025-010', 310, 'Niebla densa', 68.40, 'Navegando', 'IMO-5678901');

-- Usuario Operación
INSERT INTO UsuarioOperacion (id_usuario, id_operacion, fecha_asignacion, rol_en_operacion) VALUES
(1, 21, '2025-09-03', 'Coordinador General'),
(1, 22, '2025-09-06', 'Coordinador General'),
(2, 23, '2025-09-09', 'Supervisor'),
(3, 24, '2025-09-11', 'Inspector'),
(1, 25, '2025-09-13', 'Coordinador General');

-- ============================================
-- MÓDULO: operaciones_maritimas
-- ============================================

SET search_path TO operaciones_maritimas, shared;

-- Tablas de dominio específicas
INSERT INTO EstadoEquipoPortuario (id_estado_equipo_portuario, nombre) VALUES
(1, 'Disponible'),
(2, 'En Uso'),
(3, 'En Mantenimiento'),
(4, 'Fuera de Servicio');

INSERT INTO EstadoGeneracion (id_estado_generacion, nombre) VALUES
(1, 'Generado'),
(2, 'Pendiente'),
(3, 'Validado');

INSERT INTO EstatusNavegacion (id_estatus_navegacion, nombre) VALUES
(1, 'En Puerto'),
(2, 'Navegando'),
(3, 'Atracado'),
(4, 'Fondeado'),
(5, 'En Tránsito');

INSERT INTO TipoEquipoPortuario (id_tipo_equipo_portuario, nombre) VALUES
(1, 'Grúa Pórtico'),
(2, 'Grúa Móvil'),
(3, 'Reach Stacker'),
(4, 'Montacargas'),
(5, 'Tractor Terminal');

INSERT INTO TipoInspeccion (id_tipo_inspeccion, nombre) VALUES
(1, 'Seguridad'),
(2, 'Calidad'),
(3, 'Aduanera'),
(4, 'Sanitaria'),
(5, 'Estructural');

INSERT INTO TipoHallazgo (id_tipo_hallazgo, nombre) VALUES
(1, 'Daño Estructural'),
(2, 'Contaminación'),
(3, 'Documentación Incompleta'),
(4, 'Mercancía No Conforme'),
(5, 'Falla de Seguridad');

INSERT INTO TipoOperacionPortuaria (id_tipo_operacion_portuaria, nombre) VALUES
(1, 'Carga'),
(2, 'Descarga'),
(3, 'Transbordo'),
(4, 'Almacenamiento');

INSERT INTO Turno (id_turno, nombre) VALUES
(1, 'Mañana'),
(2, 'Tarde'),
(3, 'Noche'),
(4, 'Rotativo');

INSERT INTO EquipoProteccion (id_equipo_proteccion, nombre) VALUES
(1, 'Casco'),
(2, 'Chaleco Reflectante'),
(3, 'Guantes'),
(4, 'Botas de Seguridad'),
(5, 'Arnés');

INSERT INTO CondicionOperativa (id_condicion_operativa, nombre) VALUES
(1, 'Clima Favorable'),
(2, 'Marea Alta'),
(3, 'Marea Baja'),
(4, 'Viento Fuerte'),
(5, 'Lluvia');

-- Tripulantes
INSERT INTO Tripulante (id_tripulante, id_empleado, disponibilidad, nacionalidad) VALUES
(14, 16, TRUE, 'Peruana'),
(15, 17, TRUE, 'Peruana'),
(16, 18, TRUE, 'Chilena');

-- Trabajadores Portuarios
INSERT INTO TrabajadorPortuario (id_trabajador_portuario, id_empleado, disponibilidad, id_turno) VALUES
(1, 4, TRUE, 1),
(2, 5, TRUE, 2),
(3, 8, TRUE, 1);

-- Puertos
INSERT INTO Puerto (id_puerto, codigo, nombre, pais, direccion) VALUES
(1, 'PE-CAO', 'Puerto del Callao', 'Perú', 'Av. Manco Cápac s/n, Callao'),
(2, 'PE-PAI', 'Puerto de Paita', 'Perú', 'Km 1057 Panamericana Norte, Paita'),
(3, 'CL-VAL', 'Puerto de Valparaíso', 'Chile', 'Av. Errázuriz 335, Valparaíso'),
(4, 'CL-SAN', 'Puerto de San Antonio', 'Chile', 'Ruta 78, San Antonio'),
(5, 'EC-GUA', 'Puerto de Guayaquil', 'Ecuador', 'Malecón Simón Bolívar, Guayaquil');

-- Muelles
INSERT INTO Muelle (id_muelle, codigo, ubicacion, capacidad, disponibilidad, id_puerto) VALUES
(1, 'CAO-M01', 'Muelle Norte', 2000, TRUE, 1),
(2, 'CAO-M02', 'Muelle Sur', 2500, TRUE, 1),
(3, 'CAO-M03', 'Muelle Multipropósito', 1800, TRUE, 1),
(4, 'PAI-M01', 'Muelle Principal', 1500, TRUE, 2),
(5, 'VAL-M01', 'Muelle de Contenedores', 3000, TRUE, 3),
(6, 'SAN-M01', 'Terminal Norte', 2200, TRUE, 4),
(7, 'GUA-M01', 'Muelle de Carga General', 2800, TRUE, 5);

-- Equipos Portuarios
INSERT INTO EquipoPortuario (id_equipo_portuario, codigo, capacidad, id_tipo_equipo_portuario, id_estado_equipo_portuario, ubicacion) VALUES
(1, 'GRU-001', 65.00, 1, 1, 'Muelle Norte - Callao'),
(2, 'GRU-002', 65.00, 1, 1, 'Muelle Sur - Callao'),
(3, 'GRM-001', 45.00, 2, 1, 'Patio de Contenedores'),
(4, 'RST-001', 42.00, 3, 2, 'Zona de Almacenamiento'),
(5, 'MTC-001', 25.00, 4, 1, 'Patio Principal'),
(6, 'TRT-001', 35.00, 5, 1, 'Terminal de Contenedores');

-- Certificación Aduanera
INSERT INTO CertificacionAduanera (id_certificacion_aduanera, codigo, nombre, descripcion, pais_aplicacion) VALUES
(1, 'ADU001', 'Declaración de Importación', 'Certificación para importaciones', 'Perú'),
(2, 'ADU002', 'Declaración de Exportación', 'Certificación para exportaciones', 'Perú'),
(3, 'ADU003', 'Tránsito Aduanero', 'Certificación de tránsito internacional', 'Regional'),
(4, 'ADU004', 'Certificado Fitosanitario', 'Certificación sanitaria de productos', 'Internacional');

-- Rutas Marítimas
INSERT INTO RutaMaritima (id_ruta_maritima, id_ruta, codigo, id_puerto_origen, id_puerto_destino, distancia) VALUES
(4, 4, 'RMAR-001', 1, 3, 1389),
(5, 5, 'RMAR-002', 1, 5, 876),
(6, 6, 'RMAR-003', 2, 5, 520),
(7, 7, 'RMAR-004', 1, 4, 1505);

-- Operaciones Marítimas
INSERT INTO OperacionMaritima (id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, id_estatus_navegacion, porcentaje_trayecto, matricula) VALUES
(11, 4, 'OPMAR-001', 45, 1, 100.00, 'PE-2023-001'),
(12, 5, 'OPMAR-002', 32, 2, 65.50, 'PE-2023-002'),
(13, 7, 'OPMAR-004', 28, 2, 35.00, 'CH-2023-004');

-- Operaciones Portuarias
INSERT INTO OperacionPortuaria (id_operacion_portuaria, id_operacion, codigo, id_puerto, id_muelle, id_tipo_operacion_portuaria, matricula) VALUES
(1, 6, 'OPPOR-003', 1, 1, 2, 'PE-2023-001'),
(2, 8, 'OPPOR-005', 1, 2, 1, 'PE-2022-003');

-- Operación Ruta Marítima
INSERT INTO OperacionRutaMaritima (id_operacion_ruta_maritima, id_operacion_maritima, id_ruta_maritima, id_muelle_origen, id_muelle_destino) VALUES
(4, 11, 4, 1, 5),
(5, 12, 5, 2, 7),
(6, 13, 7, 1, 6);

-- Inspecciones
INSERT INTO Inspeccion (id_inspeccion, codigo, id_tipo_inspeccion, fecha_inspeccion, hora_inspeccion, id_prioridad, id_operacion, id_usuario) VALUES
(1, 'INSP-001', 1, '2024-09-01', '09:00:00', 3, 4, 5),
(2, 'INSP-002', 3, '2024-09-15', '10:30:00', 4, 5, 5),
(3, 'INSP-003', 2, '2024-09-20', '15:00:00', 2, 6, 5);

-- Hallazgos
INSERT INTO Hallazgo (id_hallazgo, codigo, id_tipo_hallazgo, nivel_gravedad, descripcion, accion_sugerida, id_inspeccion) VALUES
(1, 'HAL-001', 3, 2, 'Documentación de certificados aduaneros incompleta', 'Completar documentación antes del zarpe', 1),
(2, 'HAL-002', 5, 3, 'Arnés de seguridad en mal estado', 'Reemplazar equipo de protección inmediatamente', 2);

-- Estiba
INSERT INTO Estiba (id_estiba, id_operacion_portuaria, ubicacion, zona_buque, id_contenedor) VALUES
(1, 1, 'Fila 3, Columna 5', 'Proa', 1),
(2, 1, 'Fila 3, Columna 6', 'Proa', 2),
(3, 2, 'Fila 1, Columna 2', 'Popa', 6);

-- Certificaciones de Empleados
INSERT INTO CertificacionEmpleado (id_certificacion_empleado, id_empleado, id_certificacion, fecha_emision, fecha_vencimiento) VALUES
(1, 16, 11, '2020-01-15', '2025-01-15'),
(2, 16, 14, '2021-03-20', '2026-03-20'),
(3, 17, 12, '2022-05-10', '2025-05-10');

-- Trabajador Portuario Equipo
INSERT INTO TrabajadorPortuarioEquipo (id_trabajador_portuario, id_equipo_proteccion, fecha_asignacion) VALUES
(1, 1, '2024-01-15'),
(1, 2, '2024-01-15'),
(1, 4, '2024-01-15'),
(2, 1, '2024-02-20'),
(2, 2, '2024-02-20'),
(2, 3, '2024-02-20'),
(3, 1, '2024-03-10'),
(3, 2, '2024-03-10'),
(3, 5, '2024-03-10');

-- Usuario Operación
INSERT INTO UsuarioOperacion (id_usuario, id_operacion, fecha_asignacion, rol_en_operacion) VALUES
(1, 4, '2024-09-01', 'Coordinador'),
(2, 5, '2024-09-15', 'Supervisor de Navegación'),
(4, 6, '2024-09-20', 'Operador Principal'),
(5, 8, '2024-10-05', 'Inspector de Calidad');

-- Idiomas de Tripulantes
INSERT INTO TripulanteIdioma (id_tripulante, idioma, nivel) VALUES
(14, 'Español', 'Nativo'),
(14, 'Inglés', 'Avanzado'),
(15, 'Español', 'Nativo'),
(15, 'Inglés', 'Intermedio'),
(16, 'Español', 'Nativo'),
(16, 'Inglés', 'Avanzado'),
(16, 'Portugués', 'Básico');

-- Condiciones Operativas de Operación Marítima
INSERT INTO OperacionMaritimaCondicion (id_operacion_maritima, id_condicion_operativa) VALUES
(11, 1),
(11, 2),
(12, 1),
(12, 4),
(13, 1),
(13, 3);

-- ============================================
-- MÓDULO: operaciones_terrestres
-- ============================================

SET search_path TO operaciones_terrestres, shared;

-- Tipos de Reporte
INSERT INTO TipoReporte (id_tipo_reporte, nombre) VALUES
(1, 'Control salida'),
(2, 'Control llegada'),
(3, 'Incidencia'),
(4, 'Seguimiento');

-- Rutas Terrestres
INSERT INTO RutaTerrestre (id_ruta_terrestre, id_ruta) VALUES
(1, 13),
(2, 14),
(3, 15),
(4, 16),
(5, 17),
(6, 18),
(7, 19),
(8, 20);

-- Conductores
INSERT INTO Conductor (id_conductor, id_empleado, licencia, categoria, disponibilidad) VALUES
(1, 36, 'Q36223344', 'A-IIIb', TRUE),
(2, 37, 'Q37334455', 'A-IIIc', TRUE),
(3, 38, 'Q38445566', 'A-IIIb', FALSE),
(4, 39, 'Q39556677', 'A-IIIc', TRUE),
(5, 40, 'Q40667788', 'A-IIIb', TRUE),
(6, 41, 'Q41778899', 'A-IIIc', FALSE),
(7, 42, 'Q42889900', 'A-IIIb', TRUE),
(8, 43, 'Q43990011', 'A-IIIb', TRUE),
(9, 44, 'Q44001122', 'A-IIIc', TRUE),
(10, 45, 'Q45112233', 'A-IIIb', TRUE);

-- Operaciones Terrestres
INSERT INTO OperacionTerrestre (id_operacion_terrestre, id_operacion, codigo, id_vehiculo, id_ruta_terrestre, id_conductor, costo_operacion_terrestre) VALUES
(4, 26, 'OT-2025-001', 1, 1, 1, 180.00),
(5, 27, 'OT-2025-002', 2, 2, 2, 950.00),
(6, 28, 'OT-2025-003', 3, 3, 4, 780.00),
(7, 29, 'OT-2025-004', 5, 4, 5, 1150.00),
(8, 30, 'OT-2025-005', 6, 5, 7, 520.00),
(9, 31, 'OT-2025-006', 7, 6, 8, 840.00),
(10, 32, 'OT-2025-007', 9, 7, 9, 420.00),
(11, 33, 'OT-2025-008', 10, 8, 10, 1300.00);

-- Checklist de Despacho
INSERT INTO ChecklistDespacho (id_checklist, codigo, observaciones, combustible, frenos, id_operacion_terrestre) VALUES
(1, 'CHK-001', 'Vehículo en óptimas condiciones', 'Completo', 'Aprobado', 4),
(2, 'CHK-002', 'Neumáticos revisados y aprobados', 'Completo', 'Aprobado', 5),
(3, 'CHK-003', 'Sistema eléctrico verificado', '3/4 tanque', 'Aprobado', 6),
(4, 'CHK-004', 'Extintor recargado recientemente', 'Completo', 'Aprobado', 7),
(5, 'CHK-005', 'Luces direccionales funcionando', 'Completo', 'Aprobado', 8),
(6, 'CHK-006', 'Documentación completa', 'Completo', 'Aprobado', 9),
(7, 'CHK-007', 'Kit de emergencia verificado', '2/3 tanque', 'Aprobado', 10),
(8, 'CHK-008', 'Sistema de frenos revisado', 'Completo', 'Aprobado', 11);

-- Documentación de Operación
INSERT INTO DocumentacionOperacion (id_documento, codigo, nombre, ruta_archivo, fecha_emision, id_tipo_documento) VALUES
(1, 'DOC-001', 'Guía de Remisión GR-2025-001', '/docs/guias/gr_2025_001.pdf', '2025-09-25', 1),
(2, 'DOC-002', 'Factura FAC-2025-156', '/docs/facturas/fac_2025_156.pdf', '2025-09-25', 2),
(3, 'DOC-003', 'Guía de Remisión GR-2025-002', '/docs/guias/gr_2025_002.pdf', '2025-09-26', 1),
(4, 'DOC-004', 'Manifiesto de Carga MAN-2025-034', '/docs/manifiestos/man_2025_034.pdf', '2025-09-27', 5),
(5, 'DOC-005', 'Guía de Remisión GR-2025-003', '/docs/guias/gr_2025_003.pdf', '2025-09-28', 1),
(6, 'DOC-006', 'Certificado de Inspección CI-2025-089', '/docs/certificados/ci_2025_089.pdf', '2025-09-29', 4),
(7, 'DOC-007', 'Factura FAC-2025-157', '/docs/facturas/fac_2025_157.pdf', '2025-09-30', 2),
(8, 'DOC-008', 'Guía de Remisión GR-2025-004', '/docs/guias/gr_2025_004.pdf', '2025-10-01', 1);

-- Operación Documento
INSERT INTO OperacionDocumento (id_operacion, id_documento) VALUES
(26, 1),
(26, 2),
(27, 3),
(28, 4),
(29, 5),
(30, 6),
(31, 7),
(32, 8);

-- Reportes de Transporte
INSERT INTO ReporteTransporte (id_reporte, codigo, id_tipo_reporte, fecha_generado, id_operacion_terrestre) VALUES
(1, 'REP-001', 1, '2025-09-25', 4),
(2, 'REP-002', 1, '2025-09-26', 5),
(3, 'REP-003', 3, '2025-09-28', 6),
(4, 'REP-004', 1, '2025-09-28', 7),
(5, 'REP-005', 1, '2025-09-29', 8),
(6, 'REP-006', 2, '2025-10-02', 9),
(7, 'REP-007', 1, '2025-10-01', 10),
(8, 'REP-008', 1, '2025-10-02', 11);

-- ============================================
-- MÓDULO: mantenimiento_logistico
-- ============================================

SET search_path TO mantenimiento_logistico, shared;

-- Estados de Plan
INSERT INTO EstadoPlan (id_estado_plan, nombre) VALUES
(1, 'Activo'),
(2, 'Suspendido'),
(3, 'Completado'),
(4, 'Cancelado');

-- Estados de Solicitud
INSERT INTO EstadoSolicitud (id_estado_solicitud, nombre) VALUES
(1, 'Pendiente'),
(2, 'Aprobada'),
(3, 'Rechazada'),
(4, 'En ejecución');

-- Estados de Orden
INSERT INTO EstadoOrden (id_estado_orden, nombre) VALUES
(1, 'Abierta'),
(2, 'En ejecución'),
(3, 'Completada'),
(4, 'Cancelada');

-- Estados de Tarea
INSERT INTO EstadoTarea (id_estado_tarea, nombre) VALUES
(1, 'Pendiente'),
(2, 'En progreso'),
(3, 'Completada'),
(4, 'Cancelada');

-- Tipos de Mantenimiento
INSERT INTO TipoMantenimiento (id_tipo_mantenimiento, nombre) VALUES
(1, 'Preventivo'),
(2, 'Correctivo'),
(3, 'Predictivo'),
(4, 'Emergencia');

-- Técnicos
INSERT INTO Tecnico (id_tecnico, id_empleado, especialidad) VALUES
(1, 49, 'Mecánica Automotriz'),
(2, 50, 'Sistemas Hidráulicos'),
(3, 51, 'Electricidad Industrial'),
(4, 52, 'Mecánica Diesel'),
(5, 53, 'Sistemas Electrónicos'),
(6, 54, 'Soldadura Industrial'),
(7, 55, 'Neumática'),
(8, 56, 'Refrigeración');

-- Responsables de Solicitud
INSERT INTO ResponsableSolicitud (id_responsable_solicitud, id_empleado) VALUES
(1, 57),
(2, 58),
(3, 59),
(4, 60);

-- Planes de Mantenimiento
INSERT INTO PlanMantenimiento (id_plan_mantenimiento, codigo, id_estado_plan, frecuencia, fecha_inicio, id_activo) VALUES
(1, 'PM-2025-001', 1, 'Mensual', '2025-01-01', 1),
(2, 'PM-2025-002', 1, 'Trimestral', '2025-01-01', 2),
(3, 'PM-2025-003', 1, 'Semestral', '2025-01-01', 3),
(4, 'PM-2025-004', 1, 'Mensual', '2025-02-01', 11),
(5, 'PM-2025-005', 1, 'Bimensual', '2025-02-01', 12),
(6, 'PM-2025-006', 2, 'Trimestral', '2025-01-01', 4),
(7, 'PM-2025-007', 1, 'Mensual', '2025-03-01', 14),
(8, 'PM-2025-008', 1, 'Bimensual', '2025-03-01', 15);

-- Solicitudes de Mantenimiento
INSERT INTO SolicitudMantenimiento (id_solicitud_mantenimiento, codigo, descripcion_problema, fecha_solicitud, id_prioridad, id_estado_solicitud, id_responsable_solicitud, id_activo) VALUES
(1, 'SOL-2025-001', 'Falla en sistema hidráulico de elevación', '2025-09-15', 3, 2, 1, 4),
(2, 'SOL-2025-002', 'Sobrecalentamiento del motor', '2025-09-18', 4, 2, 1, 8),
(3, 'SOL-2025-003', 'Ruido anormal en caja de cambios', '2025-09-20', 2, 2, 2, 5),
(4, 'SOL-2025-004', 'Sistema eléctrico intermitente', '2025-09-22', 3, 2, 2, 13),
(5, 'SOL-2025-005', 'Fuga de aceite hidráulico', '2025-09-25', 4, 4, 3, 17),
(6, 'SOL-2025-006', 'Frenos con baja respuesta', '2025-09-28', 3, 2, 3, 6),
(7, 'SOL-2025-007', 'Neumáticos desgastados', '2025-09-30', 2, 1, 4, 9);

-- Operaciones de Mantenimiento
INSERT INTO OperacionMantenimiento (id_operacion_mantenimiento, id_operacion, id_plan_mantenimiento, id_solicitud_mantenimiento) VALUES
(1, 34, NULL, 1),
(2, 35, NULL, 2),
(3, 36, NULL, 3),
(4, 37, NULL, 4),
(5, 38, NULL, 5),
(6, 39, NULL, 6),
(7, 40, 1, NULL),
(8, 41, 4, NULL);

-- Órdenes de Mantenimiento
INSERT INTO OrdenMantenimiento (id_orden, codigo, fecha_generada, fecha_programada, fecha_cierre, id_tipo_mantenimiento, id_estado_orden, id_operacion_mantenimiento) VALUES
(1, 'ORD-2025-001', '2025-09-15', '2025-09-16', '2025-09-16', 2, 3, 1),
(2, 'ORD-2025-002', '2025-09-18', '2025-09-19', '2025-09-20', 4, 3, 2),
(3, 'ORD-2025-003', '2025-09-20', '2025-09-21', '2025-09-21', 2, 3, 3),
(4, 'ORD-2025-004', '2025-09-22', '2025-09-23', '2025-09-23', 2, 3, 4),
(5, 'ORD-2025-005', '2025-09-25', '2025-09-26', NULL, 4, 2, 5),
(6, 'ORD-2025-006', '2025-09-28', '2025-09-29', '2025-09-29', 2, 3, 6),
(7, 'ORD-2025-007', '2025-09-30', '2025-10-01', '2025-10-01', 1, 3, 7),
(8, 'ORD-2025-008', '2025-10-01', '2025-10-02', '2025-10-03', 1, 3, 8);

-- Tareas de Mantenimiento
INSERT INTO TareaMantenimiento (id_tarea, descripcion, id_estado_tarea, id_orden) VALUES
(1, 'Inspeccionar sistema hidráulico completo', 3, 1),
(2, 'Reemplazar manguera hidráulica dañada', 3, 1),
(3, 'Purgar sistema hidráulico', 3, 1),
(4, 'Revisar sistema de refrigeración', 3, 2),
(5, 'Limpiar radiador', 3, 2),
(6, 'Cambiar termostato', 3, 2),
(7, 'Reemplazar líquido refrigerante', 3, 2),
(8, 'Diagnosticar ruido en caja de cambios', 3, 3),
(9, 'Cambiar aceite de transmisión', 3, 3),
(10, 'Ajustar sincronización', 3, 3),
(11, 'Revisar sistema eléctrico completo', 3, 4),
(12, 'Reemplazar fusibles dañados', 3, 4),
(13, 'Reparar cableado', 3, 4),
(14, 'Localizar punto de fuga', 2, 5),
(15, 'Reemplazar sellos hidráulicos', 2, 5),
(16, 'Probar sistema bajo presión', 1, 5),
(17, 'Inspeccionar sistema de frenos', 3, 6),
(18, 'Reemplazar pastillas de freno', 3, 6),
(19, 'Purgar líquido de frenos', 3, 6),
(20, 'Cambio de aceite y filtros', 3, 7),
(21, 'Revisión de niveles de fluidos', 3, 7),
(22, 'Inspección visual general', 3, 7),
(23, 'Lubricación de componentes móviles', 3, 8),
(24, 'Revisión de sistema de elevación', 3, 8),
(25, 'Calibración de sensores', 3, 8);

-- Repuestos
INSERT INTO Repuesto (id_repuesto, codigo, nombre, stock, stock_minimo) VALUES
(1, 'REP-001', 'Filtro de aceite', 45, 10),
(2, 'REP-002', 'Filtro de combustible', 38, 10),
(3, 'REP-003', 'Manguera hidráulica 1/2"', 25, 5),
(4, 'REP-004', 'Termostato motor diesel', 15, 3),
(5, 'REP-005', 'Líquido refrigerante (galón)', 60, 20),
(6, 'REP-006', 'Aceite motor 15W-40 (galón)', 80, 25),
(7, 'REP-007', 'Pastillas de freno delanteras', 20, 8),
(8, 'REP-008', 'Líquido de frenos DOT 4 (litro)', 35, 10),
(9, 'REP-009', 'Fusibles automotrices set', 50, 15),
(10, 'REP-010', 'Cable eléctrico calibre 12 (metro)', 100, 30),
(11, 'REP-011', 'Sello hidráulico O-ring set', 40, 10),
(12, 'REP-012', 'Aceite hidráulico ISO 68 (galón)', 55, 15),
(13, 'REP-013', 'Grasa multiusos (kg)', 70, 20),
(14, 'REP-014', 'Correa de transmisión', 18, 5),
(15, 'REP-015', 'Batería 12V 150Ah', 12, 3);

-- Asignación de Técnicos a Operaciones
INSERT INTO OperacionMantenimientoTecnico (id_operacion_mantenimiento, id_tecnico, fecha_asignacion) VALUES
(1, 2, '2025-09-15'),
(1, 6, '2025-09-15'),
(2, 1, '2025-09-18'),
(2, 4, '2025-09-18'),
(2, 8, '2025-09-19'),
(3, 4, '2025-09-20'),
(4, 3, '2025-09-22'),
(4, 5, '2025-09-22'),
(5, 2, '2025-09-25'),
(5, 6, '2025-09-25'),
(6, 1, '2025-09-28'),
(6, 4, '2025-09-28'),
(7, 1, '2025-09-30'),
(7, 4, '2025-09-30'),
(8, 3, '2025-10-01'),
(8, 7, '2025-10-01');

-- Uso de Repuestos en Operaciones
INSERT INTO OperacionMantenimientoRepuesto (id_operacion_mantenimiento, id_repuesto, fecha_uso, cantidad, precio_unitario) VALUES
(1, 3, '2025-09-16', 2, 45.00),
(1, 12, '2025-09-16', 3, 85.00),
(2, 4, '2025-09-19', 1, 65.00),
(2, 5, '2025-09-19', 4, 25.00),
(2, 8, '2025-09-20', 2, 18.00),
(3, 6, '2025-09-21', 5, 22.00),
(3, 14, '2025-09-21', 1, 120.00),
(4, 9, '2025-09-23', 1, 35.00),
(4, 10, '2025-09-23', 15, 3.50),
(5, 11, '2025-09-26', 1, 55.00),
(5, 12, '2025-09-26', 2, 85.00),
(6, 7, '2025-09-29', 2, 95.00),
(6, 8, '2025-09-29', 2, 18.00),
(7, 1, '2025-10-01', 1, 28.00),
(7, 6, '2025-10-01', 4, 22.00),
(7, 2, '2025-10-01', 1, 32.00),
(8, 13, '2025-10-02', 3, 15.00),
(8, 12, '2025-10-02', 2, 85.00);


-- ============================================
-- MÓDULO: monitoreo
-- ============================================

SET search_path TO monitoreo, shared;

-- Estados de Entrega
INSERT INTO EstadoEntrega (id_estado_entrega, nombre) VALUES
(1, 'Programada'),
(2, 'En tránsito'),
(3, 'Completada'),
(4, 'Fallida');

-- Tipos de Sensor
INSERT INTO TipoSensor (id_tipo_sensor, nombre) VALUES
(1, 'Temperatura'),
(2, 'Humedad'),
(3, 'Vibración'),
(4, 'GPS'),
(5, 'Apertura');

-- Roles de Sensor
INSERT INTO RolSensor (id_rol_sensor, nombre) VALUES
(1, 'Monitoreo'),
(2, 'Control'),
(3, 'Alerta'),
(4, 'Registro');

-- Tipos de Notificación
INSERT INTO TipoNotificacion (id_tipo_notificacion, nombre) VALUES
(1, 'Alerta'),
(2, 'Advertencia'),
(3, 'Información'),
(4, 'Crítica');

-- Operadores
INSERT INTO Operador (id_operador, id_empleado, turno, zona_monitoreo) VALUES
(1, 2, 'Mañana', 'Zona Norte - Terminal Callao'),
(2, 4, 'Tarde', 'Zona Sur - Almacén Central'),
(3, 5, 'Noche', 'Zona Norte - Terminal Callao'),
(4, 8, 'Mañana', 'Zona Este - Puerto del Callao'),
(5, 9, 'Tarde', 'Zona Oeste - Depósito Lima');

-- Operaciones Monitoreo
INSERT INTO OperacionMonitoreo (id_operacion_monitoreo, id_operacion) VALUES
(1, 43),
(2, 44),
(3, 45),
(4, 47);

-- Documentación
INSERT INTO Documentacion (id_documentacion, codigo, nombre, fecha_emision, id_tipo_documento) VALUES
(1, 'DOC-MON-001', 'Bill of Lading - Envío Asia', '2025-09-15', 6),
(2, 'DOC-MON-002', 'Manifiesto de Carga MV Pacific', '2025-09-16', 5),
(3, 'DOC-MON-003', 'Certificado Sanitario - Alimentos', '2025-09-17', 4),
(4, 'DOC-MON-004', 'DUA - Importación Electrónicos', '2025-09-18', 7),
(5, 'DOC-MON-005', 'Packing List - Textiles', '2025-09-19', 8),
(6, 'DOC-MON-006', 'Bill of Lading - Envío Europa', '2025-09-20', 6),
(7, 'DOC-MON-007', 'Certificado Sanitario - Medicinas', '2025-09-21', 4),
(8, 'DOC-MON-008', 'DUA - Importación Maquinaria', '2025-09-22', 7);

-- Documentación Contenedor
INSERT INTO DocumentacionContenedor (id_documentacion, id_contenedor) VALUES
(1, 2),
(2, 3),
(3, 5),
(4, 7);

-- Sensores
INSERT INTO Sensor (id_sensor, codigo, nombre, id_tipo_sensor, id_rol_sensor, id_contenedor) VALUES
(1, 'SENS-001', 'Sensor Temp Container 001', 1, 1, 1),
(2, 'SENS-002', 'Sensor Hum Container 001', 2, 1, 1),
(3, 'SENS-003', 'Sensor GPS Container 001', 4, 3, 1),
(4, 'SENS-004', 'Sensor Temp Container 002', 1, 1, 2),
(5, 'SENS-005', 'Sensor Vibración Container 002', 3, 2, 2),
(6, 'SENS-006', 'Sensor GPS Container 002', 4, 3, 2),
(7, 'SENS-007', 'Sensor Temp Container 003', 1, 1, 3),
(8, 'SENS-008', 'Sensor Apertura Container 003', 5, 3, 3),
(9, 'SENS-009', 'Sensor GPS Container 003', 4, 1, 3),
(10, 'SENS-010', 'Sensor Temp Container 005', 1, 1, 5),
(11, 'SENS-011', 'Sensor Hum Container 005', 2, 2, 5),
(12, 'SENS-012', 'Sensor GPS Container 005', 4, 3, 5);

-- Reportes
INSERT INTO Reporte (id_reporte, codigo, fecha_reporte, detalle) VALUES
(1, 'REP-MON-001', '2025-09-22', 'Reporte diario de monitoreo - Contenedores en tránsito zona norte'),
(2, 'REP-MON-002', '2025-09-23', 'Reporte de alertas de temperatura - Contenedores refrigerados'),
(3, 'REP-MON-003', '2025-09-24', 'Reporte de tracking GPS - Ruta Lima-Callao'),
(4, 'REP-MON-004', '2025-09-25', 'Reporte semanal consolidado de operaciones'),
(5, 'REP-MON-005', '2025-09-26', 'Reporte de incidencias menores - Vibraciones detectadas');

-- Notificaciones
INSERT INTO Notificacion (id_notificacion, codigo, id_tipo_notificacion, fecha_hora, valor, id_sensor, id_reporte) VALUES
(1, 'NOT-001', 2, '2025-09-22 14:30:00', 25.50, 1, 1),
(2, 'NOT-002', 1, '2025-09-22 15:45:00', 28.30, 4, 1),
(3, 'NOT-003', 3, '2025-09-23 09:15:00', 65.20, 2, 2),
(4, 'NOT-004', 4, '2025-09-23 11:30:00', 32.50, 10, 2),
(5, 'NOT-005', 2, '2025-09-24 10:00:00', 2.80, 5, 3),
(6, 'NOT-006', 3, '2025-09-24 16:20:00', 22.10, 7, 3),
(7, 'NOT-007', 1, '2025-09-25 08:45:00', 70.50, 11, 4),
(8, 'NOT-008', 2, '2025-09-26 13:10:00', 3.20, 5, 5);

-- Incidencia Reporte
INSERT INTO IncidenciaReporte (id_incidencia, id_reporte) VALUES
(8, 1),
(8, 5),
(9, 2),
(9, 4),
(10, 3);

-- Importadores
INSERT INTO Importador (id_importador, codigo, ruc, razon_social) VALUES
(1, 'IMP-001', '20123456789', 'Importadora del Pacífico S.A.C.'),
(2, 'IMP-002', '20234567890', 'Comercial Andina S.R.L.'),
(3, 'IMP-003', '20345678901', 'Distribuidora Global Peru S.A.'),
(4, 'IMP-004', '20456789012', 'Tech Import Solutions E.I.R.L.'),
(5, 'IMP-005', '20567890123', 'Alimentos Internacionales S.A.C.'),
(6, 'IMP-006', '20678901234', 'Textiles del Sur S.A.'),
(7, 'IMP-007', '20789012345', 'Maquinarias Industriales Peru S.R.L.');

-- Direcciones de Importadores
INSERT INTO ImportadorDireccion (id_direccion, id_importador, direccion, tipo, principal) VALUES
(1, 1, 'Av. Argentina 2847, Callao', 'Fiscal', TRUE),
(2, 1, 'Jr. Comercio 156, Lima Centro', 'Comercial', FALSE),
(3, 2, 'Calle Los Cedros 389, San Isidro', 'Fiscal', TRUE),
(4, 3, 'Av. Javier Prado 5250, La Molina', 'Fiscal', TRUE),
(5, 3, 'Av. Universitaria 1245, Los Olivos', 'Almacén', FALSE),
(6, 4, 'Jr. Lampa 847, Lima Centro', 'Fiscal', TRUE),
(7, 5, 'Av. Colonial 1523, Callao', 'Fiscal', TRUE),
(8, 6, 'Calle Las Begonias 475, San Isidro', 'Fiscal', TRUE),
(9, 7, 'Av. Venezuela 1890, Lima', 'Fiscal', TRUE);

-- Entregas
INSERT INTO Entrega (id_entrega, codigo, id_estado_entrega, fecha_entrega, lugar_entrega, id_contenedor, id_importador) VALUES
(1, 'ENT-001', 3, '2025-09-25', 'Almacén Central - Av. Argentina, Callao', 7, 1),
(2, 'ENT-002', 2, '2025-09-28', 'Depósito San Isidro - Calle Los Cedros 389', 2, 2),
(3, 'ENT-003', 2, '2025-09-29', 'Terminal La Molina - Av. Javier Prado 5250', 3, 3),
(4, 'ENT-004', 1, '2025-10-01', 'Oficina Central - Jr. Lampa 847, Lima', 5, 4),
(5, 'ENT-005', 1, '2025-10-02', 'Almacén Callao - Av. Colonial 1523', 2, 5);

-- Posiciones de Contenedores
INSERT INTO PosicionContenedor (id_posicion, id_contenedor, latitud, longitud, fecha_hora) VALUES
(1, 2, -12.046374, -77.042793, '2025-09-22 08:00:00'),
(2, 2, -12.056789, -77.052345, '2025-09-22 10:30:00'),
(3, 2, -12.067234, -77.062891, '2025-09-22 13:00:00'),
(4, 2, -12.077890, -77.073456, '2025-09-22 15:30:00'),
(5, 3, -12.046374, -77.042793, '2025-09-24 09:00:00'),
(6, 3, -12.086543, -77.083012, '2025-09-24 11:00:00'),
(7, 3, -12.096789, -77.093567, '2025-09-24 13:30:00'),
(8, 5, -12.046374, -77.042793, '2025-09-26 07:00:00'),
(9, 5, -12.106234, -77.104123, '2025-09-26 09:30:00'),
(10, 5, -12.116890, -77.114678, '2025-09-26 12:00:00');

-- Posiciones de Vehículos
INSERT INTO PosicionVehiculo (id_posicion, id_vehiculo, latitud, longitud, fecha_hora) VALUES
(1, 1, -12.046374, -77.042793, '2025-09-22 08:00:00'),
(2, 1, -12.056789, -77.052345, '2025-09-22 10:30:00'),
(3, 1, -12.067234, -77.062891, '2025-09-22 13:00:00'),
(4, 2, -12.046374, -77.042793, '2025-09-24 09:00:00'),
(5, 2, -12.086543, -77.083012, '2025-09-24 11:00:00'),
(6, 2, -12.096789, -77.093567, '2025-09-24 13:30:00');

-- Posiciones de Buques
INSERT INTO PosicionBuque (id_posicion, matricula, latitud, longitud, fecha_hora) VALUES
(1, 'IMO-9347438', -12.046374, -77.042793, '2025-09-20 06:00:00'),
(2, 'IMO-9347438', -12.036789, -77.032345, '2025-09-20 12:00:00'),
(3, 'IMO-9347438', -12.026234, -77.022891, '2025-09-20 18:00:00'),
(4, 'IMO-7654321', -12.156789, -77.245678, '2025-09-24 08:00:00'),
(5, 'IMO-7654321', -12.146543, -77.235012, '2025-09-24 14:00:00'),
(6, 'IMO-7654321', -12.136890, -77.224567, '2025-09-24 20:00:00');

-- Operación Monitoreo Vehículo
INSERT INTO OperacionMonitoreoVehiculo (id_operacion_monitoreo, id_vehiculo, fecha_operacion) VALUES
(1, 1, '2025-09-22'),
(2, 2, '2025-09-24'),
(3, 1, '2025-09-26'),
(4, 2, '2025-10-01');

-- Operación Monitoreo Buque
INSERT INTO OperacionMonitoreoBuque (id_operacion_monitoreo, matricula, fecha_operacion) VALUES
(1, 'IMO-9347438', '2025-09-22'),
(2, 'IMO-7654321', '2025-09-24'),
(3, 'IMO-9347438', '2025-09-26'),
(4, 'IMO-8765432', '2025-10-01');

-- Contenedor Vehículo
INSERT INTO ContenedorVehiculo (id_contenedor, id_vehiculo, fecha_asignacion, fecha_transporte) VALUES
(2, 1, '2025-09-21', '2025-09-22'),
(3, 2, '2025-09-23', '2025-09-24'),
(5, 1, '2025-09-25', '2025-09-26'),
(2, 2, '2025-09-30', '2025-10-01');

-- Contenedor Buque
INSERT INTO ContenedorBuque (id_contenedor, matricula, fecha_asignacion, fecha_transporte) VALUES
(2, 'IMO-9347438', '2025-09-18', '2025-09-20'),
(3, 'IMO-7654321', '2025-09-20', '2025-09-22'),
(5, 'IMO-9347438', '2025-09-22', '2025-09-24'),
(7, 'IMO-8765432', '2025-09-25', '2025-09-27');

-- Operador Operación Monitoreo
INSERT INTO OperadorOperacionMonitoreo (id_operador, id_operacion_monitoreo, fecha_realizacion) VALUES
(1, 1, '2025-09-22'),
(2, 2, '2025-09-24'),
(1, 3, '2025-09-26'),
(3, 3, '2025-09-26'),
(2, 4, '2025-10-01'),
(4, 4, '2025-10-01');

-- ============================================
-- FIN DEL SCRIPT DML CONSOLIDADO
-- ============================================

-- Resumen de datos insertados
SELECT 'DATOS COMPARTIDOS (SCHEMA: shared)' as modulo;
SELECT 'Empleados: ' || COUNT(*) FROM shared.Empleado;
SELECT 'Usuarios: ' || COUNT(*) FROM shared.Usuario;
SELECT 'Buques: ' || COUNT(*) FROM shared.Buque;
SELECT 'Contenedores: ' || COUNT(*) FROM shared.Contenedor;
SELECT 'Operaciones: ' || COUNT(*) FROM shared.Operacion;
SELECT 'Rutas: ' || COUNT(*) FROM shared.Ruta;
SELECT 'Activos: ' || COUNT(*) FROM shared.Activo;
SELECT 'Vehículos: ' || COUNT(*) FROM shared.Vehiculo;

SELECT 'MÓDULO: reservas' as modulo;
SELECT 'Clientes: ' || COUNT(*) FROM reservas.Cliente;
SELECT 'Reservas: ' || COUNT(*) FROM reservas.Reserva;

SELECT 'MÓDULO: personal_tripulacion' as modulo;
SELECT 'Tripulantes: ' || COUNT(*) FROM personal_tripulacion.Tripulante;
SELECT 'Contratos: ' || COUNT(*) FROM personal_tripulacion.Contrato;

SELECT 'MÓDULO: operaciones_maritimas' as modulo;
SELECT 'Puertos: ' || COUNT(*) FROM operaciones_maritimas.Puerto;
SELECT 'Muelles: ' || COUNT(*) FROM operaciones_maritimas.Muelle;

SELECT 'MÓDULO: operaciones_terrestres' as modulo;
SELECT 'Conductores: ' || COUNT(*) FROM operaciones_terrestres.Conductor;
SELECT 'Operaciones Terrestres: ' || COUNT(*) FROM operaciones_terrestres.OperacionTerrestre;

SELECT 'MÓDULO: mantenimiento_logistico' as modulo;
SELECT 'Técnicos: ' || COUNT(*) FROM mantenimiento_logistico.Tecnico;
SELECT 'Planes de Mantenimiento: ' || COUNT(*) FROM mantenimiento_logistico.PlanMantenimiento;
SELECT 'Solicitudes: ' || COUNT(*) FROM mantenimiento_logistico.SolicitudMantenimiento;
SELECT 'Órdenes: ' || COUNT(*) FROM mantenimiento_logistico.OrdenMantenimiento;
SELECT 'Tareas: ' || COUNT(*) FROM mantenimiento_logistico.TareaMantenimiento;
SELECT 'Repuestos: ' || COUNT(*) FROM mantenimiento_logistico.Repuesto;

SELECT 'MÓDULO: monitoreo' as modulo;
SELECT 'Operadores: ' || COUNT(*) FROM monitoreo.Operador;
SELECT 'Sensores: ' || COUNT(*) FROM monitoreo.Sensor;
SELECT 'Reportes: ' || COUNT(*) FROM monitoreo.Reporte;
SELECT 'Notificaciones: ' || COUNT(*) FROM monitoreo.Notificacion;
SELECT 'Importadores: ' || COUNT(*) FROM monitoreo.Importador;
SELECT 'Entregas: ' || COUNT(*) FROM monitoreo.Entrega;