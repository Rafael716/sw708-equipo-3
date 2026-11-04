-- ============================================
-- DML: gestion_maritima
-- Sistema de Gestión de Operaciones Marítimas - Módulo 3
-- Versión PostgreSQL 17 con UUID
-- Script de inserción de datos de prueba (CORREGIDO)
-- ============================================

-- ============================================================
-- INSERTS PARA TABLAS DE CATÁLOGOS
-- ============================================================

-- EstadoOperacion
INSERT INTO gestion_maritima.EstadoOperacion (id_estado_operacion, nombre) VALUES
(gen_random_uuid(), 'En Planificación'),
(gen_random_uuid(), 'En Progreso'),
(gen_random_uuid(), 'Completada'),
(gen_random_uuid(), 'Cancelada'),
(gen_random_uuid(), 'En Espera');

-- EstatusNavegacion
INSERT INTO gestion_maritima.EstatusNavegacion (id_estatus_navegacion, nombre) VALUES
(gen_random_uuid(), 'En Puerto'),
(gen_random_uuid(), 'Navegando'),
(gen_random_uuid(), 'Llegando'),
(gen_random_uuid(), 'Atracado');

-- EstadoEmbarcacion
INSERT INTO gestion_maritima.EstadoEmbarcacion (id_estado_embarcacion, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En mantenimiento'),
(gen_random_uuid(), 'En operación'),
(gen_random_uuid(), 'Fuera de servicio');

-- EstadoContenedor
INSERT INTO gestion_maritima.EstadoContenedor (id_estado_contenedor, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En Tránsito'),
(gen_random_uuid(), 'En Mantenimiento'),
(gen_random_uuid(), 'Entregado');

-- TipoContenedor
INSERT INTO gestion_maritima.TipoContenedor (id_tipo_contenedor, codigo, nombre, costo) VALUES
(gen_random_uuid(), 'T-001', 'Refrigerado', 2500.00),
(gen_random_uuid(), 'T-002', 'Ventilado', 3500.00),
(gen_random_uuid(), 'T-003', 'Aislado térmicamente', 4000.00),
(gen_random_uuid(), 'T-004', 'Cisterna', 5000.00),
(gen_random_uuid(), 'T-005', 'Granell', 7500.00),
(gen_random_uuid(), 'T-006', 'Refrigerado', 3000.00),
(gen_random_uuid(), 'T-007', 'Granell', 4500.00);

-- TipoEquipoPortuario
INSERT INTO gestion_maritima.TipoEquipoPortuario (id_tipo_equipo_portuario, nombre) VALUES
(gen_random_uuid(), 'Grúa Pórtico'),
(gen_random_uuid(), 'Grúa Móvil'),
(gen_random_uuid(), 'Reach Stacker'),
(gen_random_uuid(), 'Montacargas'),
(gen_random_uuid(), 'Tractor Terminal'),
(gen_random_uuid(), 'Spreader');

-- EstadoEquipoPortuario
INSERT INTO gestion_maritima.EstadoEquipoPortuario (id_estado_equipo_portuario, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En mantenimiento'),
(gen_random_uuid(), 'Averiado'),
(gen_random_uuid(), 'En uso');

-- EstadoInspeccion
INSERT INTO gestion_maritima.EstadoInspeccion (id_estado_inspeccion, nombre) VALUES
(gen_random_uuid(), 'Programada'),
(gen_random_uuid(), 'En Proceso'),
(gen_random_uuid(), 'Completada'),
(gen_random_uuid(), 'Suspendida'),
(gen_random_uuid(), 'Cancelada');

-- TipoInspeccion
INSERT INTO gestion_maritima.TipoInspeccion (id_tipo_inspeccion, nombre) VALUES
(gen_random_uuid(), 'Aduanera'),
(gen_random_uuid(), 'Seguridad'),
(gen_random_uuid(), 'Calidad'),
(gen_random_uuid(), 'Sanitaria');

-- TipoHallazgo
INSERT INTO gestion_maritima.TipoHallazgo (id_tipo_hallazgo, nombre) VALUES
(gen_random_uuid(), 'Daño Estructural'),
(gen_random_uuid(), 'Incumplimiento Normativo'),
(gen_random_uuid(), 'Documentación Incompleta'),
(gen_random_uuid(), 'Contaminación');

-- TipoOperacionPortuaria
INSERT INTO gestion_maritima.TipoOperacionPortuaria (id_tipo_operacion_portuaria, nombre) VALUES
(gen_random_uuid(), 'Carga'),
(gen_random_uuid(), 'Descarga'),
(gen_random_uuid(), 'Estiba');

-- Turno
INSERT INTO gestion_maritima.Turno (id_turno, nombre) VALUES
(gen_random_uuid(), 'Mañana (06:00-14:00)'),
(gen_random_uuid(), 'Tarde (14:00-22:00)'),
(gen_random_uuid(), 'Noche (22:00-06:00)'),
(gen_random_uuid(), 'Rotativo');

-- EquipoProteccion
INSERT INTO gestion_maritima.EquipoProteccion (id_equipo_proteccion, nombre) VALUES
(gen_random_uuid(), 'Casco de Seguridad'),
(gen_random_uuid(), 'Chaleco Reflectante'),
(gen_random_uuid(), 'Botas de Seguridad'),
(gen_random_uuid(), 'Guantes de Trabajo'),
(gen_random_uuid(), 'Protección Auditiva'),
(gen_random_uuid(), 'Gafas de Seguridad'),
(gen_random_uuid(), 'Arnés de Seguridad');

-- CondicionOperativa
INSERT INTO gestion_maritima.CondicionOperativa (id_condicion_operativa, nombre) VALUES
(gen_random_uuid(), 'Oleaje fuerte'),
(gen_random_uuid(), 'Viento intenso'),
(gen_random_uuid(), 'Niebla Densa'),
(gen_random_uuid(), 'Lluvia Intensa'),
(gen_random_uuid(), 'Condiciones Óptimas');

-- Prioridad
INSERT INTO gestion_maritima.Prioridad (id_prioridad, nombre) VALUES
(gen_random_uuid(), 'Baja'),
(gen_random_uuid(), 'Media'),
(gen_random_uuid(), 'Alta'),
(gen_random_uuid(), 'Crítica');

-- EstadoContrato
INSERT INTO gestion_maritima.EstadoContrato (id_estado_contrato, nombre) VALUES
(gen_random_uuid(), 'Vigente'),
(gen_random_uuid(), 'Suspendido'),
(gen_random_uuid(), 'Vencido');

-- TipoTelefono
INSERT INTO gestion_maritima.TipoTelefono (id_tipo_telefono, nombre) VALUES
(gen_random_uuid(), 'Móvil'),
(gen_random_uuid(), 'Fijo');

-- RolUsuario
INSERT INTO gestion_maritima.RolUsuario (id_rol_usuario, nombre) VALUES
(gen_random_uuid(), 'Administrador'),
(gen_random_uuid(), 'Inspector'),
(gen_random_uuid(), 'Coordinador'),
(gen_random_uuid(), 'Operador'),
(gen_random_uuid(), 'Consultor');

-- EspecialidadEmpleado
INSERT INTO gestion_maritima.EspecialidadEmpleado (id_especialidad_empleado, nombre) VALUES
(gen_random_uuid(), 'Capitán de Buque'),
(gen_random_uuid(), 'Oficial de Navegación'),
(gen_random_uuid(), 'Ingeniero Naval'),
(gen_random_uuid(), 'Operador de Grúa'),
(gen_random_uuid(), 'Estibador'),
(gen_random_uuid(), 'Inspector Aduanero'),
(gen_random_uuid(), 'Técnico de Mantenimiento');

-- TipoIncidencia
INSERT INTO gestion_maritima.TipoIncidencia (id_tipo_incidencia, nombre) VALUES
(gen_random_uuid(), 'Seguridad'),
(gen_random_uuid(), 'Operacional'),
(gen_random_uuid(), 'Ambiental'),
(gen_random_uuid(), 'Administrativa');

-- ============================================================
-- INSERTS PARA TABLAS PRINCIPALES
-- ============================================================

-- Puerto
INSERT INTO gestion_maritima.Puerto (id_puerto, codigo, nombre, pais, direccion) VALUES
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'PECLL', 'Puerto del Callao', 'Perú', 'Av. Manco Cápac s/n, Callao'),
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'CLVAP', 'Puerto de Valparaíso', 'Chile', 'Av. Errázuriz 960, Valparaíso'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'MXVER', 'Puerto de Veracruz', 'México', 'Puerto de Veracruz s/n, Veracruz'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'COBAQ', 'Puerto de Barranquilla', 'Colombia', 'Carrera 38 #1-55, Barranquilla'),
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'USNYC', 'Puerto de Nueva York', 'Estados Unidos', '1 Harbour Way, New York');

-- Muelle
INSERT INTO gestion_maritima.Muelle (id_muelle, codigo, ubicacion, capacidad, disponibilidad, id_puerto) VALUES
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'M-CALL-01', 'Muelle Norte - Callao', 5, TRUE, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'M-CALL-02', 'Muelle Sur - Callao', 4, TRUE, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'),
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'M-VALP-01', 'Muelle Principal - Valparaíso', 6, TRUE, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'),
('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'M-VERA-01', 'Muelle A - Veracruz', 5, TRUE, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'),
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'M-BARR-01', 'Muelle de Contenedores - Barranquilla', 4, TRUE, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a');

-- Buque
INSERT INTO gestion_maritima.Buque (id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual) VALUES
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'PE-2024-001', 'MSC Pacífico', 8000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En operación' LIMIT 1), 75000.00, 'Puerto del Callao'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'CL-2024-045', 'Maersk Lima', 10000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En operación' LIMIT 1), 95000.00, 'Puerto de Valparaíso'),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'MX-2024-078', 'Evergreen Hope', 12000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En mantenimiento' LIMIT 1), 110000.00, 'Puerto de Veracruz'),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'CO-2024-023', 'CMA CGM Andino', 9000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En operación' LIMIT 1), 88000.00, 'Puerto de Barranquilla'),
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'PE-2024-089', 'Hamburg Express', 15000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'Disponible' LIMIT 1), 125000.00, 'Puerto del Callao');

-- Operacion
INSERT INTO gestion_maritima.Operacion (id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion) VALUES
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'OP-2024-001', '2024-11-01 08:00:00', '2024-11-05 18:00:00', (SELECT id_estado_operacion FROM gestion_maritima.EstadoOperacion WHERE nombre = 'Completada' LIMIT 1)),
('d6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'OP-2024-002', '2024-11-06 06:00:00', NULL, (SELECT id_estado_operacion FROM gestion_maritima.EstadoOperacion WHERE nombre = 'En Progreso' LIMIT 1)),
('e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'OP-2024-003', '2024-11-08 10:00:00', NULL, (SELECT id_estado_operacion FROM gestion_maritima.EstadoOperacion WHERE nombre = 'En Planificación' LIMIT 1));

-- OperacionMaritima
INSERT INTO gestion_maritima.OperacionMaritima (id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, id_estatus_navegacion, porcentaje_trayecto, id_buque) VALUES
('f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'OPM-2024-001', 450, (SELECT id_estatus_navegacion FROM gestion_maritima.EstatusNavegacion WHERE nombre = 'En Puerto' LIMIT 1), 100.00, 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b'),
('a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'OPM-2024-002', 620, (SELECT id_estatus_navegacion FROM gestion_maritima.EstatusNavegacion WHERE nombre = 'Navegando' LIMIT 1), 65.50, 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c');

-- OperacionPortuaria
INSERT INTO gestion_maritima.OperacionPortuaria (id_operacion_portuaria, id_operacion, codigo, id_puerto, id_muelle, id_tipo_operacion_portuaria, id_buque) VALUES
('b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'OPP-2024-001', 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', (SELECT id_tipo_operacion_portuaria FROM gestion_maritima.TipoOperacionPortuaria WHERE nombre = 'Descarga' LIMIT 1), 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b'),
('c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'OPP-2024-002', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', (SELECT id_tipo_operacion_portuaria FROM gestion_maritima.TipoOperacionPortuaria WHERE nombre = 'Carga' LIMIT 1), 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c');

-- Contenedor (usando los códigos T-001 a T-007 que existen en TipoContenedor)
INSERT INTO gestion_maritima.Contenedor (id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor) VALUES
('d2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a', 'CONT-001-T001', 2200.00, 33.00, '20x8x8.6 ft', (SELECT id_estado_contenedor FROM gestion_maritima.EstadoContenedor WHERE nombre = 'Disponible' LIMIT 1), (SELECT id_tipo_contenedor FROM gestion_maritima.TipoContenedor WHERE codigo = 'T-001' LIMIT 1)),
('e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6a7b', 'CONT-002-T002', 3800.00, 76.00, '40x8x9.6 ft', (SELECT id_estado_contenedor FROM gestion_maritima.EstadoContenedor WHERE nombre = 'Disponible' LIMIT 1), (SELECT id_tipo_contenedor FROM gestion_maritima.TipoContenedor WHERE codigo = 'T-002' LIMIT 1)),
('f4a5b6c7-d8e9-4f0a-1b2c-3d4e5f6a7b8c', 'CONT-003-T001', 2500.00, 28.00, '20x8x8.6 ft', (SELECT id_estado_contenedor FROM gestion_maritima.EstadoContenedor WHERE nombre = 'En Tránsito' LIMIT 1), (SELECT id_tipo_contenedor FROM gestion_maritima.TipoContenedor WHERE codigo = 'T-001' LIMIT 1)),
('a5b6c7d8-e9f0-4a1b-2c3d-4e5f6a7b8c9d', 'CONT-004-T003', 3600.00, 67.00, '40x8x8.6 ft', (SELECT id_estado_contenedor FROM gestion_maritima.EstadoContenedor WHERE nombre = 'Disponible' LIMIT 1), (SELECT id_tipo_contenedor FROM gestion_maritima.TipoContenedor WHERE codigo = 'T-003' LIMIT 1)),
('b5c6d7e8-f9a0-4b1c-2d3e-4f5a6b7c8d9e', 'CONT-005-T004', 4200.00, 68.00, '40x8x8.6 ft', (SELECT id_estado_contenedor FROM gestion_maritima.EstadoContenedor WHERE nombre = 'Disponible' LIMIT 1), (SELECT id_tipo_contenedor FROM gestion_maritima.TipoContenedor WHERE codigo = 'T-004' LIMIT 1)),
('c6d7e8f9-a0b1-4c2d-3e4f-5a6b7c8d9e0f', 'CONT-006-T005', 2300.00, 32.00, '20x8x8.6 ft', (SELECT id_estado_contenedor FROM gestion_maritima.EstadoContenedor WHERE nombre = 'Disponible' LIMIT 1), (SELECT id_tipo_contenedor FROM gestion_maritima.TipoContenedor WHERE codigo = 'T-005' LIMIT 1)),
('d7e8f9a0-b1c2-4d3e-4f5a-6b7c8d9e0f1a', 'CONT-007-T006', 4100.00, 70.00, '40x8x8.6 ft', (SELECT id_estado_contenedor FROM gestion_maritima.EstadoContenedor WHERE nombre = 'Disponible' LIMIT 1), (SELECT id_tipo_contenedor FROM gestion_maritima.TipoContenedor WHERE codigo = 'T-006' LIMIT 1));

-- EquipoPortuario
INSERT INTO gestion_maritima.EquipoPortuario (id_equipo_portuario, codigo, capacidad, id_tipo_equipo_portuario, id_estado_equipo_portuario, ubicacion) VALUES
('b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e', 'GRUA-PORT-01', 50.00, (SELECT id_tipo_equipo_portuario FROM gestion_maritima.TipoEquipoPortuario WHERE nombre = 'Grúa Pórtico' LIMIT 1), (SELECT id_estado_equipo_portuario FROM gestion_maritima.EstadoEquipoPortuario WHERE nombre = 'Disponible' LIMIT 1), 'Muelle Norte - Terminal A'),
('c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f', 'REACH-01', 45.00, (SELECT id_tipo_equipo_portuario FROM gestion_maritima.TipoEquipoPortuario WHERE nombre = 'Reach Stacker' LIMIT 1), (SELECT id_estado_equipo_portuario FROM gestion_maritima.EstadoEquipoPortuario WHERE nombre = 'Disponible' LIMIT 1), 'Patio de Contenedores'),
('d8e9f0a1-b2c3-4d4e-5f6a-7b8c9d0e1f2a', 'MONT-CAR-05', 10.00, (SELECT id_tipo_equipo_portuario FROM gestion_maritima.TipoEquipoPortuario WHERE nombre = 'Montacargas' LIMIT 1), (SELECT id_estado_equipo_portuario FROM gestion_maritima.EstadoEquipoPortuario WHERE nombre = 'En mantenimiento' LIMIT 1), 'Almacén 3');

-- Contrato
INSERT INTO gestion_maritima.Contrato (id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato) VALUES
('e9f0a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', '2023-01-15', '2026-01-15', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('f0a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c', '2023-06-01', '2025-06-01', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', '2022-11-20', '2024-11-20', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vencido' LIMIT 1)),
('b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', '2023-03-10', '2026-03-10', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('c2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', '2023-08-15', '2025-08-15', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('d3e4f5a6-b7c8-4d9e-0f1a-2b3c4d5e6f7a', '2023-02-20', '2026-02-20', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('e4f5a6b7-c8d9-4e0f-1a2b-3c4d5e6f7a8b', '2023-09-05', '2025-09-05', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1));

-- Empleado
INSERT INTO gestion_maritima.Empleado (id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato) VALUES
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'EMP-001', '12345678', 'Carlos', 'Rodríguez', 'Av. La Marina 1234, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Capitán de Buque' LIMIT 1), 'e9f0a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'EMP-002', '23456789', 'María', 'González', 'Jr. Colón 567, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Inspector Aduanero' LIMIT 1), 'f0a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'EMP-003', '34567890', 'Jorge', 'Pérez', 'Calle Lima 890, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Operador de Grúa' LIMIT 1), 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'),
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'EMP-004', '45678901', 'Ana', 'Martínez', 'Av. Grau 234, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Estibador' LIMIT 1), 'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e'),
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'EMP-005', '56789012', 'Luis', 'Torres', 'Jr. Independencia 789, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Técnico de Mantenimiento' LIMIT 1), 'c2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f'),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'EMP-006', '67890123', 'Roberto', 'Silva', 'Av. Argentina 456, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Oficial de Navegación' LIMIT 1), 'd3e4f5a6-b7c8-4d9e-0f1a-2b3c4d5e6f7a'),
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'EMP-007', '78901234', 'Patricia', 'Ramírez', 'Jr. Libertad 321, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Ingeniero Naval' LIMIT 1),  'e4f5a6b7-c8d9-4e0f-1a2b-3c4d5e6f7a8b');

-- Usuario
INSERT INTO gestion_maritima.Usuario (id_usuario, correo_electronico, contrasena, id_rol_usuario, id_empleado) VALUES
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'carlos.rodriguez@puerto.pe', '$2a$10$hashedpassword1', (SELECT id_rol_usuario FROM gestion_maritima.RolUsuario WHERE nombre = 'Coordinador' LIMIT 1), 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'),
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'maria.gonzalez@puerto.pe', '$2a$10$hashedpassword2', (SELECT id_rol_usuario FROM gestion_maritima.RolUsuario WHERE nombre = 'Inspector' LIMIT 1), 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'jorge.perez@puerto.pe', '$2a$10$hashedpassword3', (SELECT id_rol_usuario FROM gestion_maritima.RolUsuario WHERE nombre = 'Operador' LIMIT 1), 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a');

-- Tripulante
INSERT INTO gestion_maritima.Tripulante (id_tripulante, id_empleado, disponibilidad, nacionalidad) VALUES
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', TRUE, 'Peruana'),
('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', TRUE, 'Peruana'),
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', TRUE, 'Chilena');

-- TrabajadorPortuario
INSERT INTO gestion_maritima.TrabajadorPortuario (id_trabajador_portuario, id_empleado, disponibilidad, id_turno) VALUES
('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', TRUE, (SELECT id_turno FROM gestion_maritima.Turno WHERE nombre = 'Mañana (06:00-14:00)' LIMIT 1)),
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', TRUE, (SELECT id_turno FROM gestion_maritima.Turno WHERE nombre = 'Tarde (14:00-22:00)' LIMIT 1)),
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', TRUE, (SELECT id_turno FROM gestion_maritima.Turno WHERE nombre = 'Noche (22:00-06:00)' LIMIT 1));

-- Certificacion
INSERT INTO gestion_maritima.Certificacion (id_certificacion, nombre, descripcion) VALUES
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'Operador Económico Autorizado', 'Certificación para facilidades aduaneras'),
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'Certificado Internacional de Sanidad', 'Certificación sanitaria para buques'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'ISPS Code Compliance', 'Certificado de cumplimiento del código ISPS'),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'Certificado de Navegabilidad', 'Certificado de seguridad para navegación'),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'Manipulación de Cargas Peligrosas', 'Certificación para manejo de mercancías peligrosas');

-- CertificacionAduanera
INSERT INTO gestion_maritima.CertificacionAduanera (id_certificacion_aduanera, codigo, nombre, descripcion, pais_aplicacion, fecha_emision, fecha_expiracion) VALUES
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'CERT-ADU-001', 'Operador Económico Autorizado', 'Certificación para facilidades aduaneras', 'Perú', '2024-01-15 08:30:00-05:00', '2027-01-15 23:59:59-05:00'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'CERT-ADU-002', 'ISPS Code Compliance', 'Certificado de cumplimiento del código ISPS', 'Internacional', '2023-06-20 10:00:00-05:00', '2026-06-20 23:59:59-05:00');

-- Ruta
INSERT INTO gestion_maritima.Ruta (id_ruta, codigo, origen, destino, duracion, tarifa) VALUES
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'RUTA-001', 'Callao', 'Valparaíso', 72, 15000.00),
('d6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'RUTA-002', 'Callao', 'Veracruz', 240, 45000.00),
('e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'RUTA-003', 'Valparaíso', 'Barranquilla', 168, 32000.00);

-- RutaMaritima
INSERT INTO gestion_maritima.RutaMaritima (id_ruta_maritima, id_ruta, codigo, distancia, id_puerto_origen, id_puerto_destino) VALUES
('f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'RMT-001', 2450.00, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'),
('a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'RMT-002', 6800.00, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'),
('b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'RMT-003', 4500.00, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a');

-- Inspeccion
INSERT INTO gestion_maritima.Inspeccion (id_inspeccion, codigo, fecha, id_tipo_inspeccion, id_estado_inspeccion, id_prioridad, id_operacion, id_usuario) VALUES
('c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', 'INSP-2024-001', '2024-11-02 09:00:00', (SELECT id_tipo_inspeccion FROM gestion_maritima.TipoInspeccion WHERE nombre = 'Aduanera' LIMIT 1), (SELECT id_estado_inspeccion FROM gestion_maritima.EstadoInspeccion WHERE nombre = 'Completada' LIMIT 1), (SELECT id_prioridad FROM gestion_maritima.Prioridad WHERE nombre = 'Alta' LIMIT 1), 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c'),
('d2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a', 'INSP-2024-002', '2024-11-07 10:30:00', (SELECT id_tipo_inspeccion FROM gestion_maritima.TipoInspeccion WHERE nombre = 'Seguridad' LIMIT 1), (SELECT id_estado_inspeccion FROM gestion_maritima.EstadoInspeccion WHERE nombre = 'En Proceso' LIMIT 1), (SELECT id_prioridad FROM gestion_maritima.Prioridad WHERE nombre = 'Crítica' LIMIT 1), 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c');

-- Hallazgo
INSERT INTO gestion_maritima.Hallazgo (id_hallazgo, codigo, id_tipo_hallazgo, nivel_gravedad, descripcion, accion_sugerida, id_inspeccion) VALUES
('e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6a7b', 'HALL-001', (SELECT id_tipo_hallazgo FROM gestion_maritima.TipoHallazgo WHERE nombre = 'Documentación Incompleta' LIMIT 1), 2, 'Certificado de origen incompleto para 3 contenedores', 'Solicitar documentación completa al remitente', 'c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f'),
('f4a5b6c7-d8e9-4f0a-1b2c-3d4e5f6a7b8c', 'HALL-002', (SELECT id_tipo_hallazgo FROM gestion_maritima.TipoHallazgo WHERE nombre = 'Daño Estructural' LIMIT 1), 4, 'Diferencia entre peso declarado y peso real en contenedor CONT-002-T002', 'Realizar verificación exhaustiva de la mercancía', 'd2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a');

-- Incidencia
INSERT INTO gestion_maritima.Incidencia (id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_operacion, id_usuario) VALUES
('a5b6c7d8-e9f0-4a1b-2c3d-4e5f6a7b8c9d', 'INC-2024-001', (SELECT id_tipo_incidencia FROM gestion_maritima.TipoIncidencia WHERE nombre = 'Operacional' LIMIT 1), 'Retraso de 2 horas por condiciones climáticas adversas', 2, '2024-11-03 14:30:00', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b'),
('b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e', 'INC-2024-002', (SELECT id_tipo_incidencia FROM gestion_maritima.TipoIncidencia WHERE nombre = 'Seguridad' LIMIT 1), 'Falla en grúa pórtico durante operación de descarga', 3, '2024-11-04 11:15:00', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b');

-- OperacionRutaMaritima
INSERT INTO gestion_maritima.OperacionRutaMaritima (id_operacion_ruta_maritima, id_operacion_maritima, id_ruta_maritima, id_muelle_origen, id_muelle_destino) VALUES
('c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f', 'f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e'),
('d8e9f0a1-b2c3-4d4e-5f6a-7b8c9d0e1f2a', 'a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f');

-- Estiba
INSERT INTO gestion_maritima.Estiba (id_estiba, id_operacion_portuaria, ubicacion, zona_buque, id_contenedor) VALUES
('e9f0a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 'b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'Fila 3, Columna B', 'Proa - Nivel 2', 'd2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a'),
('f0a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c', 'b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'Fila 5, Columna A', 'Centro - Nivel 3', 'e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6a7b'),
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', 'Fila 8, Columna D', 'Popa - Nivel 1', 'f4a5b6c7-d8e9-4f0a-1b2c-3d4e5f6a7b8c');

-- ============================================================
-- INSERTS PARA TABLAS ASOCIATIVAS
-- ============================================================

-- ContenedorMercancia
INSERT INTO gestion_maritima.ContenedorMercancia (id_contenedor_mercancia, id_contenedor, tipo_mercancia) VALUES
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'd2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a', 'Electrónicos'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6a7b', 'Textiles'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'f4a5b6c7-d8e9-4f0a-1b2c-3d4e5f6a7b8c', 'Alimentos Perecederos'),
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'a5b6c7d8-e9f0-4a1b-2c3d-4e5f6a7b8c9d', 'Maquinaria Industrial'),
('f5a6b7c8-d9e0-4f1a-2b3c-4d5e6f7a8b9c', 'b5c6d7e8-f9a0-4b1c-2d3e-4f5a6b7c8d9e', 'Productos Farmacéuticos'),
('a6b7c8d9-e0f1-4a2b-3c4d-5e6f7a8b9c0d', 'c6d7e8f9-a0b1-4c2d-3e4f-5a6b7c8d9e0f', 'Vehículos'),
('b7c8d9e0-f1a2-4b3c-4d5e-6f7a8b9c0d1e', 'd7e8f9a0-b1c2-4d3e-4f5a-6b7c8d9e0f1a', 'Maquinaria Pesada');

-- EmpleadoTelefono
INSERT INTO gestion_maritima.EmpleadoTelefono (id_empleado_telefono, id_empleado, telefono, id_tipo_telefono) VALUES
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', '987654321', (SELECT id_tipo_telefono FROM gestion_maritima.TipoTelefono WHERE nombre = 'Móvil' LIMIT 1)),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', '014653210', (SELECT id_tipo_telefono FROM gestion_maritima.TipoTelefono WHERE nombre = 'Fijo' LIMIT 1)),
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', '956789012', (SELECT id_tipo_telefono FROM gestion_maritima.TipoTelefono WHERE nombre = 'Móvil' LIMIT 1)),
('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', '998765432', (SELECT id_tipo_telefono FROM gestion_maritima.TipoTelefono WHERE nombre = 'Móvil' LIMIT 1)),
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', '945678901', (SELECT id_tipo_telefono FROM gestion_maritima.TipoTelefono WHERE nombre = 'Móvil' LIMIT 1)),
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', '912345678', (SELECT id_tipo_telefono FROM gestion_maritima.TipoTelefono WHERE nombre = 'Móvil' LIMIT 1)),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', '014567890', (SELECT id_tipo_telefono FROM gestion_maritima.TipoTelefono WHERE nombre = 'Fijo' LIMIT 1));

-- TrabajadorPortuarioEquipoProteccion
INSERT INTO gestion_maritima.TrabajadorPortuarioEquipoProteccion (id_trabajador_portuario_equipo_proteccion, id_trabajador_portuario, id_equipo_proteccion, fecha_asignacion) VALUES
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Casco de Seguridad' LIMIT 1), '2024-01-10'),
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Chaleco Reflectante' LIMIT 1), '2024-01-10'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Botas de Seguridad' LIMIT 1), '2024-01-10'),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Guantes de Trabajo' LIMIT 1), '2024-01-10'),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Casco de Seguridad' LIMIT 1), '2024-03-15'),
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Guantes de Trabajo' LIMIT 1), '2024-03-15'),
('d6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Casco de Seguridad' LIMIT 1), '2024-08-20'),
('e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', (SELECT id_equipo_proteccion FROM gestion_maritima.EquipoProteccion WHERE nombre = 'Arnés de Seguridad' LIMIT 1), '2024-08-20');

-- RutaPuertoIntermedio
INSERT INTO gestion_maritima.RutaPuertoIntermedio (id_ruta_puerto_intermedio, id_ruta_maritima, id_puerto) VALUES
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a'),
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f');

-- OperacionCertificacionAduanera
INSERT INTO gestion_maritima.OperacionCertificacionAduanera (id_operacion_certificacion_aduanera, id_operacion_maritima, id_certificacion_aduanera, estado, fecha_aprobacion) VALUES
('d6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'APROBADO', '2024-11-01'),
('e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'PENDIENTE', NULL);

-- TripulanteIdioma
INSERT INTO gestion_maritima.TripulanteIdioma (id_tripulante_idioma, id_tripulante, idioma, nivel) VALUES
('f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'Español', 'Nativo'),
('a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'Inglés', 'Avanzado'),
('b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'Portugués', 'Intermedio');

-- OperacionMaritimaCondicion
INSERT INTO gestion_maritima.OperacionMaritimaCondicion (id_operacion_maritima_condicion, id_operacion_maritima, id_condicion_operativa) VALUES
('c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', 'f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', (SELECT id_condicion_operativa FROM gestion_maritima.CondicionOperativa WHERE nombre = 'Oleaje fuerte' LIMIT 1)),
('d2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a', 'a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', (SELECT id_condicion_operativa FROM gestion_maritima.CondicionOperativa WHERE nombre = 'Viento intenso' LIMIT 1));

-- OperacionEmpleado
INSERT INTO gestion_maritima.OperacionEmpleado (id_operacion_empleado, id_operacion, id_empleado, fecha_asignacion, fecha_desasignacion) VALUES
('e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6a7b', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', '2024-11-01', '2024-11-05'),
('f4a5b6c7-d8e9-4f0a-1b2c-3d4e5f6a7b8c', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', '2024-11-01', '2024-11-05'),
('a5b6c7d8-e9f0-4a1b-2c3d-4e5f6a7b8c9d', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', '2024-11-06', NULL),
('b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', '2024-11-01', '2024-11-05'),
('c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', '2024-11-06', NULL),
('d8e9f0a1-b2c3-4d4e-5f6a-7b8c9d0e1f2a', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', '2024-11-06', NULL);

-- UsuarioOperacion
INSERT INTO gestion_maritima.UsuarioOperacion (id_usuario_operacion, id_usuario, id_operacion, fecha_asignacion, rol_en_operacion) VALUES
('b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', '2024-11-01', 'Supervisor de Operación'),
('c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', '2024-11-01', 'Inspector de Calidad'),
('d8e9f0a1-b2c3-4d4e-5f6a-7b8c9d0e1f2a', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', '2024-11-06', 'Supervisor de Operación');

-- TrabajadorPortuarioEquipoPortuario
INSERT INTO gestion_maritima.TrabajadorPortuarioEquipoPortuario (id_trabajador_portuario_equipo_portuario, id_trabajador_portuario, id_equipo_portuario) VALUES
('e9f0a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e'),
('f0a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f');

-- CertificacionEmpleado 
INSERT INTO gestion_maritima.CertificacionEmpleado (id_certificacion_empleado, id_empleado, id_certificacion, fecha_emision, fecha_vencimiento) VALUES
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', '2023-03-15', '2026-03-15'),
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', '2023-07-20', '2026-07-20'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', '2023-05-10', '2026-05-10'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', '2023-09-25', '2025-09-25');

-- CertificacionBuque
INSERT INTO gestion_maritima.CertificacionBuque (id_certificacion_buque, id_buque, id_certificacion, fecha_emision, fecha_vencimiento) VALUES
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', '2023-02-10', '2026-02-10'),
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', '2023-04-15', '2026-04-15'),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', '2023-01-20', '2026-01-20'),
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', '2023-06-05', '2025-06-05'),
('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', '2023-08-12', '2026-08-12');

-- OperacionContenedor
INSERT INTO gestion_maritima.OperacionContenedor (id_operacion_contenedor, id_operacion, id_contenedor, fecha_asignacion) VALUES
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'd2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a', '2024-11-01'),
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6a7b', '2024-11-01'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'f4a5b6c7-d8e9-4f0a-1b2c-3d4e5f6a7b8c', '2024-11-01'),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'd2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a', '2024-11-06'),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'a5b6c7d8-e9f0-4a1b-2c3d-4e5f6a7b8c9d', '2024-11-06');

-- OperacionEquipoPortuario
INSERT INTO gestion_maritima.OperacionEquipoPortuario (id_operacion_equipo_portuario, id_operacion_portuaria, id_equipo_portuario, id_trabajador_portuario, fecha_asignacion, fecha_devolucion) VALUES
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', '2024-11-01 08:30:00', '2024-11-05 17:00:00'),
('d6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', '2024-11-02 09:00:00', '2024-11-05 16:30:00'),
('e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', 'b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', '2024-11-06 07:00:00', NULL),
('f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', 'c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', '2024-11-06 07:30:00', NULL);


-- ============================================
-- FIN DEL SCRIPT DML
-- ============================================
            




