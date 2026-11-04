
SET search_path TO personal_tripulacion;


-- Roles de Empleado
INSERT INTO personal_tripulacion.EspecialidadEmpleado (id_especialidad_empleado, nombre) VALUES
(gen_random_uuid(), 'Capitán de Buque'),
(gen_random_uuid(), 'Oficial de Navegación'),
(gen_random_uuid(), 'Ingeniero Naval'),
(gen_random_uuid(), 'Operador de Grúa'),
(gen_random_uuid(), 'Estibador'),
(gen_random_uuid(), 'Inspector Aduanero'),
(gen_random_uuid(), 'Técnico de Mantenimiento');

-- Roles de Usuario
INSERT INTO personal_tripulacion.RolUsuario (id_rol_usuario, nombre) VALUES
(gen_random_uuid(), 'Administrador'),
(gen_random_uuid(), 'Inspector'),
(gen_random_uuid(), 'Coordinador'),
(gen_random_uuid(), 'Operador'),
(gen_random_uuid(), 'Consultor');


-- Estados de Operación
INSERT INTO personal_tripulacion.EstadoOperacion (id_estado_operacion, nombre) VALUES
(gen_random_uuid(), 'En Planificación'),
(gen_random_uuid(), 'En Progreso'),
(gen_random_uuid(), 'Completada'),
(gen_random_uuid(), 'Cancelada'),
(gen_random_uuid(), 'En Espera');

-- Estados de Embarcación
INSERT INTO personal_tripulacion.EstadoEmbarcacion (id_estado_embarcacion, nombre) VALUES
(gen_random_uuid(), 'Disponible'),
(gen_random_uuid(), 'En mantenimiento'),
(gen_random_uuid(), 'En operación'),
(gen_random_uuid(), 'Fuera de servicio');

-- Estados de Contrato
INSERT INTO personal_tripulacion.EstadoContrato (id_estado_contrato, nombre) VALUES
(gen_random_uuid(), 'Vigente'),
(gen_random_uuid(), 'Suspendido'),
(gen_random_uuid(), 'Vencido');




INSERT INTO personal_tripulacion.Empleado (id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, anios_experiencia, id_contrato) VALUES
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'EMP-001', '12345678', 'Carlos', 'Rodríguez', 'Av. La Marina 1234, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Capitán de Buque' LIMIT 1), 15, 'e9f0a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'EMP-002', '23456789', 'María', 'González', 'Jr. Colón 567, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Inspector Aduanero' LIMIT 1), 8, 'f0a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'EMP-003', '34567890', 'Jorge', 'Pérez', 'Calle Lima 890, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Operador de Grúa' LIMIT 1), 12, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'),
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'EMP-004', '45678901', 'Ana', 'Martínez', 'Av. Grau 234, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Estibador' LIMIT 1), 5, 'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e'),
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'EMP-005', '56789012', 'Luis', 'Torres', 'Jr. Independencia 789, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Técnico de Mantenimiento' LIMIT 1), 10, 'c2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f'),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'EMP-006', '67890123', 'Roberto', 'Silva', 'Av. Argentina 456, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Oficial de Navegación' LIMIT 1), 7, 'd3e4f5a6-b7c8-4d9e-0f1a-2b3c4d5e6f7a'),
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'EMP-007', '78901234', 'Patricia', 'Ramírez', 'Jr. Libertad 321, Callao', (SELECT id_especialidad_empleado FROM gestion_maritima.EspecialidadEmpleado WHERE nombre = 'Ingeniero Naval' LIMIT 1), 12, 'e4f5a6b7-c8d9-4e0f-1a2b-3c4d5e6f7a8b');


INSERT INTO personal_tripulacion.Usuario (id_usuario, correo_electronico, contrasena, id_rol_usuario, id_empleado) VALUES
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'carlos.rodriguez@puerto.pe', '$2a$10$hashedpassword1', (SELECT id_rol_usuario FROM gestion_maritima.RolUsuario WHERE nombre = 'Coordinador' LIMIT 1), 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'),
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'maria.gonzalez@puerto.pe', '$2a$10$hashedpassword2', (SELECT id_rol_usuario FROM gestion_maritima.RolUsuario WHERE nombre = 'Inspector' LIMIT 1), 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'jorge.perez@puerto.pe', '$2a$10$hashedpassword3', (SELECT id_rol_usuario FROM gestion_maritima.RolUsuario WHERE nombre = 'Operador' LIMIT 1), 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a');



INSERT INTO personal_tripulacion.Buque (id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual) VALUES
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'PE-2024-001', 'MSC Pacífico', 8000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En operación' LIMIT 1), 75000.00, 'Puerto del Callao'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'CL-2024-045', 'Maersk Lima', 10000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En operación' LIMIT 1), 95000.00, 'Puerto de Valparaíso'),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'MX-2024-078', 'Evergreen Hope', 12000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En mantenimiento' LIMIT 1), 110000.00, 'Puerto de Veracruz'),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'CO-2024-023', 'CMA CGM Andino', 9000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'En operación' LIMIT 1), 88000.00, 'Puerto de Barranquilla'),
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'PE-2024-089', 'Hamburg Express', 15000, (SELECT id_estado_embarcacion FROM gestion_maritima.EstadoEmbarcacion WHERE nombre = 'Disponible' LIMIT 1), 125000.00, 'Puerto del Callao');




INSERT INTO personal_tripulacion.Contrato (id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato) VALUES
('e9f0a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', '2023-01-15', '2026-01-15', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('f0a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c', '2023-06-01', '2025-06-01', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', '2022-11-20', '2024-11-20', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vencido' LIMIT 1)),
('b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', '2023-03-10', '2026-03-10', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('c2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', '2023-08-15', '2025-08-15', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('d3e4f5a6-b7c8-4d9e-0f1a-2b3c4d5e6f7a', '2023-02-20', '2026-02-20', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1)),
('e4f5a6b7-c8d9-4e0f-1a2b-3c4d5e6f7a8b', '2023-09-05', '2025-09-05', (SELECT id_estado_contrato FROM gestion_maritima.EstadoContrato WHERE nombre = 'Vigente' LIMIT 1));



INSERT INTO personal_tripulacion.Certificacion (id_certificacion, nombre, descripcion) VALUES
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'Operador Económico Autorizado', 'Certificación para facilidades aduaneras'),
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'Certificado Internacional de Sanidad', 'Certificación sanitaria para buques'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'ISPS Code Compliance', 'Certificado de cumplimiento del código ISPS'),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'Certificado de Navegabilidad', 'Certificado de seguridad para navegación'),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'Manipulación de Cargas Peligrosas', 'Certificación para manejo de mercancías peligrosas');


INSERT INTO personal_tripulacion.Tripulante (id_tripulante, id_empleado, disponibilidad, nacionalidad) VALUES
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', TRUE, 'Peruana'),
('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', TRUE, 'Peruana'),
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', TRUE, 'Chilena');



INSERT INTO personal_tripulacion.CertificacionEmpleado (id_certificacion_empleado, id_empleado, id_certificacion, fecha_emision, fecha_vencimiento) VALUES
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', '2023-03-15', '2026-03-15'),
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', '2023-07-20', '2026-07-20'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', '2023-05-10', '2026-05-10'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', '2023-09-25', '2025-09-25');



INSERT INTO personal_tripulacion.Operacion (id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion) VALUES
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'OP-2024-001', '2024-11-01 08:00:00', '2024-11-05 18:00:00', (SELECT id_estado_operacion FROM gestion_maritima.EstadoOperacion WHERE nombre = 'Completada' LIMIT 1)),
('d6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'OP-2024-002', '2024-11-06 06:00:00', NULL, (SELECT id_estado_operacion FROM gestion_maritima.EstadoOperacion WHERE nombre = 'En Progreso' LIMIT 1)),
('e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'OP-2024-003', '2024-11-08 10:00:00', NULL, (SELECT id_estado_operacion FROM gestion_maritima.EstadoOperacion WHERE nombre = 'En Planificación' LIMIT 1));


INSERT INTO personal_tripulacion.OperacionMaritima (id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, id_estatus_navegacion, porcentaje_trayecto, id_buque) VALUES
('f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'OPM-2024-001', 450, (SELECT id_estatus_navegacion FROM gestion_maritima.EstatusNavegacion WHERE nombre = 'En Puerto' LIMIT 1), 100.00, 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b'),
('a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'OPM-2024-002', 620, (SELECT id_estatus_navegacion FROM gestion_maritima.EstatusNavegacion WHERE nombre = 'Navegando' LIMIT 1), 65.50, 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c');

INSERT INTO personal_tripulacion.UsuarioOperacion (id_usuario_operacion, id_usuario, id_operacion, fecha_asignacion, rol_en_operacion) VALUES
('b6c7d8e9-f0a1-4b2c-3d4e-5f6a7b8c9d0e', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', '2024-11-01', 'Supervisor de Operación'),
('c7d8e9f0-a1b2-4c3d-4e5f-6a7b8c9d0e1f', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', '2024-11-01', 'Inspector de Calidad'),
('d8e9f0a1-b2c3-4d4e-5f6a-7b8c9d0e1f2a', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'd6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', '2024-11-06', 'Supervisor de Operación');


INSERT INTO personal_tripulacion.BuqueTripulante (id_buque_tripulante, id_buque, id_tripulante, fecha_asignacion, hora_asignacion) VALUES
(gen_random_uuid(), 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', '2024-11-01', '08:00:00'),
(gen_random_uuid(), 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', '2024-11-01', '08:15:00'),
(gen_random_uuid(), 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', '2024-11-02', '09:00:00'),
(gen_random_uuid(), 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', '2024-11-03', '10:00:00'),
(gen_random_uuid(), 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', '2024-11-04', '11:00:00');
