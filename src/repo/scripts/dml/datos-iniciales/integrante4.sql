-- ============================================
-- SCRIPT COMPLETO: LIMPIAR Y POBLAR
-- MÓDULO OPERACIONES TERRESTRES
-- ============================================

-- ============================================
-- PASO 1: ELIMINAR DATOS EXISTENTES
-- ============================================

-- Eliminar en orden inverso por dependencias
DELETE FROM operaciones_terrestres.ReporteTransporte;
DELETE FROM operaciones_terrestres.OperacionDocumento;
DELETE FROM operaciones_terrestres.DocumentacionOperacion;
DELETE FROM operaciones_terrestres.Incidencia;
DELETE FROM operaciones_terrestres.ChecklistDespacho;
DELETE FROM operaciones_terrestres.OperacionTerrestre;
DELETE FROM operaciones_terrestres.Operacion;
DELETE FROM operaciones_terrestres.RutaTerrestre;
DELETE FROM operaciones_terrestres.Ruta;
DELETE FROM operaciones_terrestres.Vehiculo;
DELETE FROM operaciones_terrestres.Activo;
DELETE FROM operaciones_terrestres.Conductor;
DELETE FROM operaciones_terrestres.Usuario;
DELETE FROM operaciones_terrestres.EmpleadoTelefono;
DELETE FROM operaciones_terrestres.Empleado;
DELETE FROM operaciones_terrestres.Contrato;

-- Tablas de dominio (lookup tables)
DELETE FROM operaciones_terrestres.RolUsuario;
DELETE FROM operaciones_terrestres.TipoReporte;
DELETE FROM operaciones_terrestres.TipoDocumento;
DELETE FROM operaciones_terrestres.EstadoIncidencia;
DELETE FROM operaciones_terrestres.TipoIncidencia;
DELETE FROM operaciones_terrestres.TipoTelefono;
DELETE FROM operaciones_terrestres.EstadoContrato;
DELETE FROM operaciones_terrestres.EspecialidadEmpleado;
DELETE FROM operaciones_terrestres.EstadoVehiculo;
DELETE FROM operaciones_terrestres.TipoVehiculo;
DELETE FROM operaciones_terrestres.EstadoActivo;
DELETE FROM operaciones_terrestres.TipoActivo;
DELETE FROM operaciones_terrestres.EstadoOperacion;

-- ============================================
-- PASO 2: POBLAR DATOS
-- ============================================

-- TABLAS DE DOMINIO
INSERT INTO operaciones_terrestres.EstadoOperacion (id_estado_operacion, nombre) VALUES
(gen_random_uuid()::TEXT, 'Pendiente'),
(gen_random_uuid()::TEXT, 'En curso'),
(gen_random_uuid()::TEXT, 'Completada'),
(gen_random_uuid()::TEXT, 'Cancelada');

INSERT INTO operaciones_terrestres.TipoActivo (id_tipo_activo, nombre) VALUES
(gen_random_uuid()::TEXT, 'Equipo portuario'),
(gen_random_uuid()::TEXT, 'Vehículo'),
(gen_random_uuid()::TEXT, 'Infraestructura'),
(gen_random_uuid()::TEXT, 'Herramienta');

INSERT INTO operaciones_terrestres.EstadoActivo (id_estado_activo, nombre) VALUES
(gen_random_uuid()::TEXT, 'Operativo'),
(gen_random_uuid()::TEXT, 'En mantenimiento'),
(gen_random_uuid()::TEXT, 'Fuera de servicio'),
(gen_random_uuid()::TEXT, 'Dado de baja');

INSERT INTO operaciones_terrestres.TipoVehiculo (id_tipo_vehiculo, nombre) VALUES
(gen_random_uuid()::TEXT, 'Camión rígido'),
(gen_random_uuid()::TEXT, 'Tracto camión'),
(gen_random_uuid()::TEXT, 'Furgón'),
(gen_random_uuid()::TEXT, 'Camión cisterna');

INSERT INTO operaciones_terrestres.EstadoVehiculo (id_estado_vehiculo, nombre) VALUES
(gen_random_uuid()::TEXT, 'Disponible'),
(gen_random_uuid()::TEXT, 'En ruta'),
(gen_random_uuid()::TEXT, 'Mantenimiento'),
(gen_random_uuid()::TEXT, 'Fuera de servicio');

INSERT INTO operaciones_terrestres.EspecialidadEmpleado (id_especialidad_empleado, nombre) VALUES
(gen_random_uuid()::TEXT, 'Supervisor'),
(gen_random_uuid()::TEXT, 'Operario'),
(gen_random_uuid()::TEXT, 'Administrativo'),
(gen_random_uuid()::TEXT, 'Técnico'),
(gen_random_uuid()::TEXT, 'Gerente'),
(gen_random_uuid()::TEXT, 'Agente de Reservas'),
(gen_random_uuid()::TEXT, 'Tripulante'),
(gen_random_uuid()::TEXT, 'Trabajador Portuario'),
(gen_random_uuid()::TEXT, 'Conductor');

INSERT INTO operaciones_terrestres.EstadoContrato (id_estado_contrato, nombre) VALUES
(gen_random_uuid()::TEXT, 'Vigente'),
(gen_random_uuid()::TEXT, 'Vencido'),
(gen_random_uuid()::TEXT, 'Cancelado');

INSERT INTO operaciones_terrestres.TipoTelefono (id_tipo_telefono, nombre) VALUES
(gen_random_uuid()::TEXT, 'Fijo'),
(gen_random_uuid()::TEXT, 'Móvil'),
(gen_random_uuid()::TEXT, 'Corporativo');

INSERT INTO operaciones_terrestres.TipoIncidencia (id_tipo_incidencia, nombre) VALUES
(gen_random_uuid()::TEXT, 'Seguridad'),
(gen_random_uuid()::TEXT, 'Operacional'),
(gen_random_uuid()::TEXT, 'Ambiental'),
(gen_random_uuid()::TEXT, 'Administrativa');

INSERT INTO operaciones_terrestres.EstadoIncidencia (id_estado_incidencia, nombre) VALUES
(gen_random_uuid()::TEXT, 'Reportada'),
(gen_random_uuid()::TEXT, 'En investigación'),
(gen_random_uuid()::TEXT, 'Resuelta'),
(gen_random_uuid()::TEXT, 'Cerrada');

INSERT INTO operaciones_terrestres.TipoDocumento (id_tipo_documento, nombre) VALUES
(gen_random_uuid()::TEXT, 'Guía de remisión'),
(gen_random_uuid()::TEXT, 'Factura'),
(gen_random_uuid()::TEXT, 'Orden de compra'),
(gen_random_uuid()::TEXT, 'Certificado'),
(gen_random_uuid()::TEXT, 'Manifiesto de carga');

INSERT INTO operaciones_terrestres.TipoReporte (id_tipo_reporte, nombre) VALUES
(gen_random_uuid()::TEXT, 'Control salida'),
(gen_random_uuid()::TEXT, 'Control llegada'),
(gen_random_uuid()::TEXT, 'Incidencia'),
(gen_random_uuid()::TEXT, 'Seguimiento');

INSERT INTO operaciones_terrestres.RolUsuario (id_rol_usuario, nombre) VALUES
(gen_random_uuid()::TEXT, 'Administrador'),
(gen_random_uuid()::TEXT, 'Inspector'),
(gen_random_uuid()::TEXT, 'Coordinador'),
(gen_random_uuid()::TEXT, 'Operador'),
(gen_random_uuid()::TEXT, 'Consultor');

-- CONTRATOS (25 contratos)
INSERT INTO operaciones_terrestres.Contrato (id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato)
VALUES
(gen_random_uuid()::TEXT, '2024-01-15', '2026-01-15', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-02-01', '2026-02-01', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-03-10', '2026-03-10', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-04-05', '2026-04-05', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-05-20', '2026-05-20', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-06-12', '2026-06-12', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-07-08', '2026-07-08', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-08-15', '2026-08-15', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-09-01', '2026-09-01', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-10-10', '2026-10-10', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-11-05', '2026-11-05', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-12-01', '2026-12-01', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-01-15', '2027-01-15', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-02-10', '2027-02-10', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-03-05', '2027-03-05', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-04-20', '2027-04-20', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-05-15', '2027-05-15', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-06-08', '2027-06-08', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-07-12', '2027-07-12', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-08-03', '2027-08-03', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2023-05-10', '2025-05-10', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vencido')),
(gen_random_uuid()::TEXT, '2023-06-15', '2025-06-15', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vencido')),
(gen_random_uuid()::TEXT, '2024-01-20', '2026-01-20', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Cancelado')),
(gen_random_uuid()::TEXT, '2025-09-10', '2027-09-10', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-10-15', '2027-10-15', (SELECT id_estado_contrato FROM operaciones_terrestres.EstadoContrato WHERE nombre = 'Vigente'));

-- EMPLEADOS (25 empleados - 20 conductores, 5 personal operativo)
DO $$
DECLARE
    v_especialidad_conductor CHAR(36);
    v_especialidad_coordinador CHAR(36);
    v_especialidad_operador CHAR(36);
    v_especialidad_supervisor CHAR(36);
    v_especialidad_gerente CHAR(36);
    v_contratos CHAR(36)[];
BEGIN
    SELECT id_especialidad_empleado INTO v_especialidad_conductor FROM operaciones_terrestres.EspecialidadEmpleado WHERE nombre = 'Conductor';
    SELECT id_especialidad_empleado INTO v_especialidad_coordinador FROM operaciones_terrestres.EspecialidadEmpleado WHERE nombre = 'Administrativo';
    SELECT id_especialidad_empleado INTO v_especialidad_operador FROM operaciones_terrestres.EspecialidadEmpleado WHERE nombre = 'Operario';
    SELECT id_especialidad_empleado INTO v_especialidad_supervisor FROM operaciones_terrestres.EspecialidadEmpleado WHERE nombre = 'Supervisor';
    SELECT id_especialidad_empleado INTO v_especialidad_gerente FROM operaciones_terrestres.EspecialidadEmpleado WHERE nombre = 'Gerente';

    SELECT ARRAY_AGG(id_contrato) INTO v_contratos FROM operaciones_terrestres.Contrato;

    -- 20 Conductores
    INSERT INTO operaciones_terrestres.Empleado (id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato) VALUES
    (gen_random_uuid()::TEXT, 'EMP-101', '72345678', 'Juan Carlos', 'Pérez Rodríguez', 'Av. Los Álamos 234, Lima', v_especialidad_conductor, v_contratos[1]),
    (gen_random_uuid()::TEXT, 'EMP-102', '73456789', 'Miguel Ángel', 'García López', 'Jr. Las Flores 567, Lima', v_especialidad_conductor, v_contratos[2]),
    (gen_random_uuid()::TEXT, 'EMP-103', '74567890', 'César Augusto', 'Martínez Silva', 'Calle Los Pinos 890, Callao', v_especialidad_conductor, v_contratos[3]),
    (gen_random_uuid()::TEXT, 'EMP-104', '75678901', 'Luis Fernando', 'Flores Vargas', 'Av. Universitaria 123, Lima', v_especialidad_conductor, v_contratos[4]),
    (gen_random_uuid()::TEXT, 'EMP-105', '76789012', 'José María', 'Mendoza Cruz', 'Jr. Las Camelias 456, Lima', v_especialidad_conductor, v_contratos[5]),
    (gen_random_uuid()::TEXT, 'EMP-106', '77890123', 'Mario Alberto', 'Castro Díaz', 'Av. Venezuela 789, Lima', v_especialidad_conductor, v_contratos[6]),
    (gen_random_uuid()::TEXT, 'EMP-107', '78901234', 'Raúl Enrique', 'Soto Ramírez', 'Calle Lima 321, Callao', v_especialidad_conductor, v_contratos[7]),
    (gen_random_uuid()::TEXT, 'EMP-108', '79012345', 'Jorge Luis', 'Vega Torres', 'Jr. Arequipa 654, Lima', v_especialidad_conductor, v_contratos[8]),
    (gen_random_uuid()::TEXT, 'EMP-109', '70123456', 'Carlos Andrés', 'Luna Salazar', 'Av. Brasil 987, Lima', v_especialidad_conductor, v_contratos[9]),
    (gen_random_uuid()::TEXT, 'EMP-110', '71234567', 'Roberto Manuel', 'Silva Guzmán', 'Calle Real 147, Lima', v_especialidad_conductor, v_contratos[10]),
    (gen_random_uuid()::TEXT, 'EMP-111', '72234568', 'Pedro Antonio', 'Quispe Mamani', 'Av. Túpac Amaru 258, Lima', v_especialidad_conductor, v_contratos[11]),
    (gen_random_uuid()::TEXT, 'EMP-112', '73345679', 'Fernando José', 'Rojas Sánchez', 'Jr. Los Olivos 369, Lima', v_especialidad_conductor, v_contratos[12]),
    (gen_random_uuid()::TEXT, 'EMP-113', '74456790', 'Diego Alejandro', 'Huamán Pérez', 'Av. La Marina 741, Callao', v_especialidad_conductor, v_contratos[13]),
    (gen_random_uuid()::TEXT, 'EMP-114', '75567801', 'Óscar David', 'Campos Ruiz', 'Calle Amazonas 852, Lima', v_especialidad_conductor, v_contratos[14]),
    (gen_random_uuid()::TEXT, 'EMP-115', '76678912', 'Eduardo Rafael', 'Núñez Paredes', 'Jr. Colón 963, Lima', v_especialidad_conductor, v_contratos[15]),
    (gen_random_uuid()::TEXT, 'EMP-116', '77789023', 'Ricardo Pablo', 'Herrera Cortez', 'Av. Próceres 147, Lima', v_especialidad_conductor, v_contratos[16]),
    (gen_random_uuid()::TEXT, 'EMP-117', '78890134', 'Javier Sebastián', 'Morales Vásquez', 'Calle Progreso 258, Callao', v_especialidad_conductor, v_contratos[17]),
    (gen_random_uuid()::TEXT, 'EMP-118', '79901245', 'Andrés Felipe', 'Chávez Robles', 'Jr. Independencia 369, Lima', v_especialidad_conductor, v_contratos[18]),
    (gen_random_uuid()::TEXT, 'EMP-119', '70012356', 'Daniel Ernesto', 'Reyes Montenegro', 'Av. Benavides 741, Lima', v_especialidad_conductor, v_contratos[19]),
    (gen_random_uuid()::TEXT, 'EMP-120', '71123467', 'Francisco Javier', 'Paredes Ochoa', 'Calle Industrial 852, Callao', v_especialidad_conductor, v_contratos[20]),
    -- Personal administrativo y operativo
    (gen_random_uuid()::TEXT, 'EMP-121', '72234578', 'Ana María', 'Morales Ruiz', 'Av. Arequipa 258, Lima', v_especialidad_coordinador, v_contratos[21]),
    (gen_random_uuid()::TEXT, 'EMP-122', '73345689', 'Patricia Elena', 'López Castro', 'Jr. Cusco 369, Lima', v_especialidad_operador, v_contratos[22]),
    (gen_random_uuid()::TEXT, 'EMP-123', '74456700', 'Rosa Isabel', 'González Pérez', 'Av. La Marina 741, Lima', v_especialidad_supervisor, v_contratos[23]),
    (gen_random_uuid()::TEXT, 'EMP-124', '75567811', 'Carmen Lucía', 'Torres Jiménez', 'Calle Los Rosales 852, Lima', v_especialidad_coordinador, v_contratos[24]),
    (gen_random_uuid()::TEXT, 'EMP-125', '76678922', 'Julio César', 'Ramírez Arce', 'Av. Colonial 963, Lima', v_especialidad_gerente, v_contratos[25]);
END $$;

-- TELÉFONOS DE EMPLEADOS (35 teléfonos - al menos 1 por empleado, algunos con 2)
DO $$
DECLARE
    v_tipo_movil CHAR(36);
    v_tipo_fijo CHAR(36);
    v_tipo_corporativo CHAR(36);
BEGIN
    SELECT id_tipo_telefono INTO v_tipo_movil FROM operaciones_terrestres.TipoTelefono WHERE nombre = 'Móvil';
    SELECT id_tipo_telefono INTO v_tipo_fijo FROM operaciones_terrestres.TipoTelefono WHERE nombre = 'Fijo';
    SELECT id_tipo_telefono INTO v_tipo_corporativo FROM operaciones_terrestres.TipoTelefono WHERE nombre = 'Corporativo';

    INSERT INTO operaciones_terrestres.EmpleadoTelefono (id_empleado_telefono, id_empleado, telefono, id_tipo_telefono)
    SELECT gen_random_uuid()::TEXT, id_empleado, '91' || LPAD((ROW_NUMBER() OVER())::TEXT, 7, '0'), v_tipo_movil
    FROM operaciones_terrestres.Empleado WHERE codigo LIKE 'EMP-1%';

    -- Teléfonos adicionales para personal administrativo
    INSERT INTO operaciones_terrestres.EmpleadoTelefono (id_empleado_telefono, id_empleado, telefono, id_tipo_telefono) VALUES
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-121'), '014567890', v_tipo_fijo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-121'), '987654321', v_tipo_corporativo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-123'), '014589012', v_tipo_fijo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-124'), '014590123', v_tipo_fijo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-124'), '987654322', v_tipo_corporativo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-125'), '014591234', v_tipo_fijo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-125'), '987654323', v_tipo_corporativo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-125'), '987654324', v_tipo_corporativo);
END $$;

-- USUARIOS (5 usuarios del personal administrativo)
DO $$
DECLARE
    v_rol_coordinador CHAR(36);
    v_rol_operador CHAR(36);
    v_rol_admin CHAR(36);
    v_rol_inspector CHAR(36);
    v_rol_consultor CHAR(36);
BEGIN
    SELECT id_rol_usuario INTO v_rol_coordinador FROM operaciones_terrestres.RolUsuario WHERE nombre = 'Coordinador';
    SELECT id_rol_usuario INTO v_rol_operador FROM operaciones_terrestres.RolUsuario WHERE nombre = 'Operador';
    SELECT id_rol_usuario INTO v_rol_admin FROM operaciones_terrestres.RolUsuario WHERE nombre = 'Administrador';
    SELECT id_rol_usuario INTO v_rol_inspector FROM operaciones_terrestres.RolUsuario WHERE nombre = 'Inspector';
    SELECT id_rol_usuario INTO v_rol_consultor FROM operaciones_terrestres.RolUsuario WHERE nombre = 'Consultor';

    INSERT INTO operaciones_terrestres.Usuario (id_usuario, id_empleado, correo_electronico, contrasena, id_rol_usuario) VALUES
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-121'), 'ana.morales@logistica.com', '$2y$10$hash1234567890abcdefghijklmnopqr', v_rol_coordinador),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-122'), 'patricia.lopez@logistica.com', '$2y$10$hash2345678901bcdefghijklmnopqrs', v_rol_operador),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-123'), 'rosa.gonzalez@logistica.com', '$2y$10$hash3456789012cdefghijklmnopqrst', v_rol_admin),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-124'), 'carmen.torres@logistica.com', '$2y$10$hash4567890123defghijklmnopqrstu', v_rol_inspector),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM operaciones_terrestres.Empleado WHERE codigo = 'EMP-125'), 'julio.ramirez@logistica.com', '$2y$10$hash5678901234efghijklmnopqrstuv', v_rol_consultor);
END $$;

-- CONDUCTORES (20 conductores)
DO $$
DECLARE
    conductor_record RECORD;
    contador INT := 0;
BEGIN
    FOR conductor_record IN
        SELECT id_empleado, codigo FROM operaciones_terrestres.Empleado
        WHERE codigo LIKE 'EMP-1%' AND codigo BETWEEN 'EMP-101' AND 'EMP-120'
        ORDER BY codigo
    LOOP
        contador := contador + 1;
        INSERT INTO operaciones_terrestres.Conductor (id_conductor, id_empleado, licencia, categoria, disponibilidad) VALUES
        (
            gen_random_uuid()::TEXT,
            conductor_record.id_empleado,
            'LIC-' || LPAD(contador::TEXT, 6, '0'),
            CASE WHEN contador % 2 = 0 THEN 'A-IIIb' ELSE 'A-IIIc' END,
            CASE WHEN contador % 4 = 0 THEN FALSE ELSE TRUE END  -- 5 no disponibles, 15 disponibles
        );
    END LOOP;
END $$;

-- RUTAS (20 rutas terrestres)
INSERT INTO operaciones_terrestres.Ruta (id_ruta, codigo, origen, destino, duracion, tarifa) VALUES
(gen_random_uuid()::TEXT, 'RUT-001', 'Callao', 'Lima Centro', 1, 150.00),
(gen_random_uuid()::TEXT, 'RUT-002', 'Callao', 'Arequipa', 16, 1800.00),
(gen_random_uuid()::TEXT, 'RUT-003', 'Lima', 'Trujillo', 9, 1200.00),
(gen_random_uuid()::TEXT, 'RUT-004', 'Lima', 'Cusco', 21, 2500.00),
(gen_random_uuid()::TEXT, 'RUT-005', 'Callao', 'Ica', 5, 800.00),
(gen_random_uuid()::TEXT, 'RUT-006', 'Lima', 'Chiclayo', 12, 1500.00),
(gen_random_uuid()::TEXT, 'RUT-007', 'Callao', 'Huancayo', 7, 950.00),
(gen_random_uuid()::TEXT, 'RUT-008', 'Lima', 'Piura', 15, 1900.00),
(gen_random_uuid()::TEXT, 'RUT-009', 'Callao', 'Tacna', 18, 2200.00),
(gen_random_uuid()::TEXT, 'RUT-010', 'Lima', 'Puno', 22, 2800.00),
(gen_random_uuid()::TEXT, 'RUT-011', 'Callao', 'Chimbote', 7, 1000.00),
(gen_random_uuid()::TEXT, 'RUT-012', 'Lima', 'Tarapoto', 24, 3000.00),
(gen_random_uuid()::TEXT, 'RUT-013', 'Callao', 'Tumbes', 20, 2500.00),
(gen_random_uuid()::TEXT, 'RUT-014', 'Lima', 'Ayacucho', 12, 1600.00),
(gen_random_uuid()::TEXT, 'RUT-015', 'Callao', 'Huaraz', 8, 1100.00),
(gen_random_uuid()::TEXT, 'RUT-016', 'Lima', 'Cajamarca', 14, 1800.00),
(gen_random_uuid()::TEXT, 'RUT-017', 'Callao', 'Pisco', 4, 650.00),
(gen_random_uuid()::TEXT, 'RUT-018', 'Lima', 'Nazca', 7, 950.00),
(gen_random_uuid()::TEXT, 'RUT-019', 'Callao', 'Moquegua', 17, 2100.00),
(gen_random_uuid()::TEXT, 'RUT-020', 'Lima', 'Iquitos', 36, 4500.00);

-- Rutas Terrestres
INSERT INTO operaciones_terrestres.RutaTerrestre (id_ruta_terrestre, id_ruta)
SELECT gen_random_uuid()::TEXT, id_ruta FROM operaciones_terrestres.Ruta;

-- ACTIVOS (20 activos de tipo vehículo)
DO $$
DECLARE
    v_tipo_vehiculo CHAR(36);
    v_estado_operativo CHAR(36);
    v_estado_mantenimiento CHAR(36);
    v_estado_fuera_servicio CHAR(36);
BEGIN
    SELECT id_tipo_activo INTO v_tipo_vehiculo FROM operaciones_terrestres.TipoActivo WHERE nombre = 'Vehículo';
    SELECT id_estado_activo INTO v_estado_operativo FROM operaciones_terrestres.EstadoActivo WHERE nombre = 'Operativo';
    SELECT id_estado_activo INTO v_estado_mantenimiento FROM operaciones_terrestres.EstadoActivo WHERE nombre = 'En mantenimiento';
    SELECT id_estado_activo INTO v_estado_fuera_servicio FROM operaciones_terrestres.EstadoActivo WHERE nombre = 'Fuera de servicio';

    INSERT INTO operaciones_terrestres.Activo (id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion) VALUES
    (gen_random_uuid()::TEXT, 'ACT-001', 'Camión Volvo FH16 750HP', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal A'),
    (gen_random_uuid()::TEXT, 'ACT-002', 'Camión Mercedes-Benz Actros 2546', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal A'),
    (gen_random_uuid()::TEXT, 'ACT-003', 'Tracto Scania R500 V8', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal B'),
    (gen_random_uuid()::TEXT, 'ACT-004', 'Camión Hino 500 Series', v_tipo_vehiculo, v_estado_mantenimiento, 'Taller Mecánico 1'),
    (gen_random_uuid()::TEXT, 'ACT-005', 'Furgón Isuzu NPR 75L', v_tipo_vehiculo, v_estado_operativo, 'Patio Secundario'),
    (gen_random_uuid()::TEXT, 'ACT-006', 'Camión JAC 1063 HFC', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal A'),
    (gen_random_uuid()::TEXT, 'ACT-007', 'Tracto Kenworth T800', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal B'),
    (gen_random_uuid()::TEXT, 'ACT-008', 'Camión Freightliner Cascadia', v_tipo_vehiculo, v_estado_fuera_servicio, 'Taller Mecánico 2'),
    (gen_random_uuid()::TEXT, 'ACT-009', 'Furgón Mitsubishi Canter 7.5T', v_tipo_vehiculo, v_estado_operativo, 'Patio Secundario'),
    (gen_random_uuid()::TEXT, 'ACT-010', 'Camión Iveco Trakker AT380', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal A'),
    (gen_random_uuid()::TEXT, 'ACT-011', 'Tracto Volvo FH540', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal B'),
    (gen_random_uuid()::TEXT, 'ACT-012', 'Camión MAN TGX 28.540', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal A'),
    (gen_random_uuid()::TEXT, 'ACT-013', 'Furgón Ford Cargo 1519', v_tipo_vehiculo, v_estado_mantenimiento, 'Taller Mecánico 1'),
    (gen_random_uuid()::TEXT, 'ACT-014', 'Tracto Scania R450', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal B'),
    (gen_random_uuid()::TEXT, 'ACT-015', 'Camión DAF XF105.510', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal A'),
    (gen_random_uuid()::TEXT, 'ACT-016', 'Furgón Chevrolet NPR Reward', v_tipo_vehiculo, v_estado_operativo, 'Patio Secundario'),
    (gen_random_uuid()::TEXT, 'ACT-017', 'Tracto International ProStar', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal B'),
    (gen_random_uuid()::TEXT, 'ACT-018', 'Camión Nissan Cabstar', v_tipo_vehiculo, v_estado_operativo, 'Patio Secundario'),
    (gen_random_uuid()::TEXT, 'ACT-019', 'Tracto Mack Anthem', v_tipo_vehiculo, v_estado_mantenimiento, 'Taller Mecánico 1'),
    (gen_random_uuid()::TEXT, 'ACT-020', 'Camión Hino 700 Series', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal A');
END $$;

-- VEHÍCULOS (20 vehículos) - VERSIÓN CORREGIDA
DO $$
DECLARE
    v_tipo_tracto CHAR(36);
    v_tipo_rigido CHAR(36);
    v_tipo_furgon CHAR(36);
    v_tipo_cisterna CHAR(36);
    v_estado_disponible CHAR(36);
    v_estado_en_ruta CHAR(36);
    v_estado_mantenimiento CHAR(36);
    v_estado_fuera_servicio CHAR(36);
    v_activos CHAR(36)[];
BEGIN
    -- Obtener tipos de vehículo
    SELECT id_tipo_vehiculo INTO v_tipo_tracto FROM operaciones_terrestres.TipoVehiculo WHERE nombre = 'Tracto camión';
    SELECT id_tipo_vehiculo INTO v_tipo_rigido FROM operaciones_terrestres.TipoVehiculo WHERE nombre = 'Camión rígido';
    SELECT id_tipo_vehiculo INTO v_tipo_furgon FROM operaciones_terrestres.TipoVehiculo WHERE nombre = 'Furgón';
    SELECT id_tipo_vehiculo INTO v_tipo_cisterna FROM operaciones_terrestres.TipoVehiculo WHERE nombre = 'Camión cisterna';

    -- Obtener estados de vehículo
    SELECT id_estado_vehiculo INTO v_estado_disponible FROM operaciones_terrestres.EstadoVehiculo WHERE nombre ='Disponible';
    SELECT id_estado_vehiculo INTO v_estado_en_ruta FROM operaciones_terrestres.EstadoVehiculo WHERE nombre = 'En ruta';
    SELECT id_estado_vehiculo INTO v_estado_mantenimiento FROM operaciones_terrestres.EstadoVehiculo WHERE nombre = 'Mantenimiento';
    SELECT id_estado_vehiculo INTO v_estado_fuera_servicio FROM operaciones_terrestres.EstadoVehiculo WHERE nombre = 'Fuera de servicio';

    -- Obtener array de activos
    SELECT ARRAY_AGG(id_activo ORDER BY codigo) INTO v_activos FROM operaciones_terrestres.Activo WHERE codigo LIKE 'ACT-%';

    -- Insertar vehículos
    INSERT INTO operaciones_terrestres.Vehiculo (id_vehiculo, id_activo, placa, capacidad_ton, id_tipo_vehiculo, id_estado_vehiculo) VALUES
    (gen_random_uuid()::TEXT, v_activos[1], 'A1B-234', 28.50, v_tipo_tracto, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[2], 'A2C-345', 30.00, v_tipo_tracto, v_estado_en_ruta),
    (gen_random_uuid()::TEXT, v_activos[3], 'A3D-456', 32.00, v_tipo_tracto, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[4], 'B1E-567', 25.00, v_tipo_rigido, v_estado_mantenimiento),
    (gen_random_uuid()::TEXT, v_activos[5], 'C1F-678', 8.50, v_tipo_furgon, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[6], 'B2G-789', 20.00, v_tipo_rigido, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[7], 'A4H-890', 35.00, v_tipo_tracto, v_estado_en_ruta),
    (gen_random_uuid()::TEXT, v_activos[8], 'B3I-901', 28.00, v_tipo_rigido, v_estado_fuera_servicio),
    (gen_random_uuid()::TEXT, v_activos[9], 'C2J-012', 7.50, v_tipo_furgon, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[10], 'A5K-123', 30.00, v_tipo_tracto, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[11], 'A6L-234', 33.00, v_tipo_tracto, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[12], 'B4M-345', 26.00, v_tipo_rigido, v_estado_en_ruta),
    (gen_random_uuid()::TEXT, v_activos[13], 'C3N-456', 9.00, v_tipo_furgon, v_estado_mantenimiento),
    (gen_random_uuid()::TEXT, v_activos[14], 'A7O-567', 34.00, v_tipo_tracto, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[15], 'B5P-678', 27.00, v_tipo_rigido, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[16], 'C4Q-789', 8.00, v_tipo_furgon, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[17], 'A8R-890', 36.00, v_tipo_tracto, v_estado_en_ruta),
    (gen_random_uuid()::TEXT, v_activos[18], 'C5S-901', 7.00, v_tipo_furgon, v_estado_disponible),
    (gen_random_uuid()::TEXT, v_activos[19], 'A9T-012', 35.50, v_tipo_tracto, v_estado_mantenimiento),
    (gen_random_uuid()::TEXT, v_activos[20], 'B6U-123', 29.00, v_tipo_rigido, v_estado_disponible);
END $$;

-- OPERACIONES (30 operaciones con diferentes estados)
DO $$
DECLARE
    v_estado_completada CHAR(36);
    v_estado_en_curso CHAR(36);
    v_estado_pendiente CHAR(36);
    v_estado_cancelada CHAR(36);
BEGIN
    SELECT id_estado_operacion INTO v_estado_completada FROM operaciones_terrestres.EstadoOperacion WHERE nombre = 'Completada';
    SELECT id_estado_operacion INTO v_estado_en_curso FROM operaciones_terrestres.EstadoOperacion WHERE nombre = 'En curso';
    SELECT id_estado_operacion INTO v_estado_pendiente FROM operaciones_terrestres.EstadoOperacion WHERE nombre = 'Pendiente';
    SELECT id_estado_operacion INTO v_estado_cancelada FROM operaciones_terrestres.EstadoOperacion WHERE nombre = 'Cancelada';

    INSERT INTO operaciones_terrestres.Operacion (id_operacion, codigo, fecha_inicio, fecha_fin,id_estado_operacion) VALUES
    -- Operaciones completadas (15)
    (gen_random_uuid()::TEXT, 'OP-2025-001', '2025-09-01 06:00:00', '2025-09-01 18:30:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-002', '2025-09-02 07:00:00', '2025-09-03 20:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-003', '2025-09-03 08:00:00', '2025-09-03 19:45:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-004', '2025-09-04 06:30:00', '2025-09-06 16:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-005', '2025-09-05 07:15:00', '2025-09-05 15:30:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-006', '2025-09-06 08:00:00', '2025-09-07 22:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-007', '2025-09-07 06:00:00', '2025-09-08 14:30:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-008', '2025-09-08 07:30:00', '2025-09-10 20:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-009', '2025-09-09 06:00:00', '2025-09-11 18:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-010', '2025-09-10 08:00:00', '2025-09-12 21:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-011', '2025-09-11 07:00:00', '2025-09-11 16:30:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-012', '2025-09-12 06:30:00', '2025-09-14 19:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-013', '2025-09-13 07:00:00', '2025-09-15 15:00:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-014', '2025-09-14 08:00:00', '2025-09-15 17:30:00', v_estado_completada),
    (gen_random_uuid()::TEXT, 'OP-2025-015', '2025-09-15 06:00:00', '2025-09-16 20:00:00', v_estado_completada),
    -- Operaciones en curso (10)
    (gen_random_uuid()::TEXT, 'OP-2025-016', '2025-09-16 07:00:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-017', '2025-09-17 06:30:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-018', '2025-09-18 08:00:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-019', '2025-09-19 07:00:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-020', '2025-09-20 06:00:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-021', '2025-09-21 07:30:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-022', '2025-09-22 08:00:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-023', '2025-09-23 06:30:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-024', '2025-09-24 07:00:00', NULL, v_estado_en_curso),
    (gen_random_uuid()::TEXT, 'OP-2025-025', '2025-09-25 08:00:00', NULL, v_estado_en_curso),
    -- Operaciones pendientes (3)
    (gen_random_uuid()::TEXT, 'OP-2025-026', '2025-09-26 06:00:00', NULL, v_estado_pendiente),
    (gen_random_uuid()::TEXT, 'OP-2025-027', '2025-09-27 07:00:00', NULL, v_estado_pendiente),
    (gen_random_uuid()::TEXT, 'OP-2025-028', '2025-09-28 08:00:00', NULL, v_estado_pendiente),
    -- Operaciones canceladas (2)
    (gen_random_uuid()::TEXT, 'OP-2025-029', '2025-09-15 10:00:00', '2025-09-15 11:00:00', v_estado_cancelada),
    (gen_random_uuid()::TEXT, 'OP-2025-030', '2025-09-20 09:00:00', '2025-09-20 09:30:00', v_estado_cancelada);
END $$;

-- OPERACIONES TERRESTRES (25 operaciones - excluyendo las canceladas y algunas pendientes)
DO $$
DECLARE
    operacion_record RECORD;
    v_rutas CHAR(36)[];
    v_vehiculos CHAR(36)[];
    v_conductores CHAR(36)[];
    contador INT := 0;
BEGIN
    -- Obtener rutas terrestres (sin ordenar por código ya que RutaTerrestre no tiene código)
    SELECT ARRAY_AGG(id_ruta_terrestre) INTO v_rutas FROM operaciones_terrestres.RutaTerrestre;
    
    SELECT ARRAY_AGG(id_vehiculo) INTO v_vehiculos FROM operaciones_terrestres.Vehiculo 
    WHERE id_estado_vehiculo != (SELECT id_estado_vehiculo FROM operaciones_terrestres.EstadoVehiculo WHERE nombre = 'Fuera de servicio');
    
    SELECT ARRAY_AGG(id_conductor ORDER BY licencia) INTO v_conductores FROM operaciones_terrestres.Conductor 
    WHERE disponibilidad = true;

    FOR operacion_record IN
        SELECT id_operacion, codigo
        FROM operaciones_terrestres.Operacion
        WHERE codigo NOT IN ('OP-2025-028', 'OP-2025-029', 'OP-2025-030')
        ORDER BY codigo
        LIMIT 25
    LOOP
        contador := contador + 1;
        
        INSERT INTO operaciones_terrestres.OperacionTerrestre (
            id_operacion_terrestre, 
            id_operacion, 
            codigo, 
            id_vehiculo, 
            id_ruta_terrestre, 
            id_conductor, 
            costo_operacion_terrestre
        )
        VALUES (
            gen_random_uuid()::TEXT,
            operacion_record.id_operacion,
            'OT-' || SUBSTRING(operacion_record.codigo FROM 4),
            v_vehiculos[((contador - 1) % array_length(v_vehiculos, 1)) + 1],
            v_rutas[((contador - 1) % array_length(v_rutas, 1)) + 1],
            v_conductores[((contador - 1) % array_length(v_conductores, 1)) + 1],
            (RANDOM() * 2500 + 500)::DECIMAL(10,2)
        );
    END LOOP;
END $$;

-- CHECKLIST DE DESPACHO (25 checklists - uno por cada operación terrestre)
DO $$
DECLARE
    ot_record RECORD;
    contador INT := 0;
BEGIN
    FOR ot_record IN SELECT id_operacion_terrestre, codigo FROM operaciones_terrestres.OperacionTerrestre ORDER BY codigo
    LOOP
        contador := contador + 1;
        INSERT INTO operaciones_terrestres.ChecklistDespacho (id_checklist, codigo, observaciones, combustible, frenos, id_operacion_terrestre)
        VALUES (
            gen_random_uuid()::TEXT,
            'CHK-' || LPAD(contador::TEXT, 4, '0'),
            CASE
                WHEN contador % 5 = 0 THEN 'Neumáticos revisados - Presión OK'
                WHEN contador % 5 = 1 THEN 'Sistema eléctrico verificado - Todo operativo'
                WHEN contador % 5 = 2 THEN 'Documentación completa y vigente'
                WHEN contador % 5 = 3 THEN 'Kit de emergencia completo'
                ELSE 'Vehículo en óptimas condiciones'
            END,
            CASE
                WHEN contador % 4 = 0 THEN '3/4 tanque'
                WHEN contador % 4 = 1 THEN 'Completo'
                WHEN contador % 4 = 2 THEN '1/2 tanque'
                ELSE 'Completo'
            END,
            'Aprobado',
            ot_record.id_operacion_terrestre
        );
    END LOOP;
END $$;

-- INCIDENCIAS (15 incidencias)
DO $$
DECLARE
    v_tipo_operacional CHAR(36);
    v_tipo_seguridad CHAR(36);
    v_tipo_ambiental CHAR(36);
    v_tipo_administrativa CHAR(36);
    v_estado_reportada CHAR(36);
    v_estado_investigacion CHAR(36);
    v_estado_resuelta CHAR(36);
    v_estado_cerrada CHAR(36);
    v_usuarios CHAR(36)[];
    v_operaciones CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT id_tipo_incidencia INTO v_tipo_operacional FROM operaciones_terrestres.TipoIncidencia WHERE nombre = 'Operacional';
    SELECT id_tipo_incidencia INTO v_tipo_seguridad FROM operaciones_terrestres.TipoIncidencia WHERE nombre = 'Seguridad';
    SELECT id_tipo_incidencia INTO v_tipo_ambiental FROM operaciones_terrestres.TipoIncidencia WHERE nombre = 'Ambiental';
    SELECT id_tipo_incidencia INTO v_tipo_administrativa FROM operaciones_terrestres.TipoIncidencia WHERE nombre = 'Administrativa';

    SELECT id_estado_incidencia INTO v_estado_reportada FROM operaciones_terrestres.EstadoIncidencia WHERE nombre = 'Reportada';
    SELECT id_estado_incidencia INTO v_estado_investigacion FROM operaciones_terrestres.EstadoIncidencia WHERE nombre = 'En investigación';
    SELECT id_estado_incidencia INTO v_estado_resuelta FROM operaciones_terrestres.EstadoIncidencia WHERE nombre = 'Resuelta';
    SELECT id_estado_incidencia INTO v_estado_cerrada FROM operaciones_terrestres.EstadoIncidencia WHERE nombre = 'Cerrada';

    SELECT ARRAY_AGG(id_usuario) INTO v_usuarios FROM operaciones_terrestres.Usuario;
    SELECT ARRAY_AGG(id_operacion ORDER BY codigo) INTO v_operaciones FROM operaciones_terrestres.Operacion WHERE id_estado_operacion IN (
        SELECT id_estado_operacion FROM operaciones_terrestres.EstadoOperacion WHERE nombre IN ('En curso', 'Completada')
    );

    INSERT INTO operaciones_terrestres.Incidencia (id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_estado_incidencia, id_operacion, id_usuario) VALUES
    (gen_random_uuid()::TEXT, 'INC-2025-001', v_tipo_operacional, 'Retraso por tráfico intenso en Av. Panamericana Norte - 45 min de demora', 2, '2025-09-02 10:30:00', v_estado_cerrada, v_operaciones[2], v_usuarios[1]),
    (gen_random_uuid()::TEXT, 'INC-2025-002', v_tipo_seguridad, 'Neumático trasero pinchado en ruta - Reemplazo inmediato realizado', 3, '2025-09-03 14:20:00', v_estado_cerrada, v_operaciones[3], v_usuarios[2]),
    (gen_random_uuid()::TEXT, 'INC-2025-003', v_tipo_operacional, 'Demora en punto de control policial - Revisión documentaria', 1, '2025-09-04 11:45:00', v_estado_cerrada, v_operaciones[4], v_usuarios[1]),
    (gen_random_uuid()::TEXT, 'INC-2025-004', v_tipo_ambiental, 'Derrame menor de líquido refrigerante - Protocolo de limpieza activado', 4, '2025-09-06 16:10:00', v_estado_resuelta, v_operaciones[6], v_usuarios[3]),
    (gen_random_uuid()::TEXT, 'INC-2025-005', v_tipo_operacional, 'Falla temporal en sistema GPS - Reinicio de equipo resolvió el problema', 2, '2025-09-07 09:30:00', v_estado_cerrada, v_operaciones[7], v_usuarios[1]),
    (gen_random_uuid()::TEXT, 'INC-2025-006', v_tipo_administrativa, 'Documentación de carga incompleta - Retraso en salida 1 hora', 3, '2025-09-09 08:15:00', v_estado_cerrada, v_operaciones[9], v_usuarios[2]),
    (gen_random_uuid()::TEXT, 'INC-2025-007', v_tipo_seguridad, 'Frenada de emergencia por vehículo invasor - Sin daños reportados', 4, '2025-09-11 15:40:00', v_estado_investigacion, v_operaciones[10], v_usuarios[3]),
    (gen_random_uuid()::TEXT, 'INC-2025-008', v_tipo_operacional, 'Sensor de temperatura alertando - Inspección preventiva realizada', 2, '2025-09-12 10:20:00', v_estado_cerrada, v_operaciones[11], v_usuarios[1]),
    (gen_random_uuid()::TEXT, 'INC-2025-009', v_tipo_operacional, 'Congestión vehicular por accidente en vía - 2 horas de demora', 3, '2025-09-14 12:30:00', v_estado_cerrada, v_operaciones[13], v_usuarios[2]),
    (gen_random_uuid()::TEXT, 'INC-2025-010', v_tipo_seguridad, 'Luz de freno trasera averiada - Reparación en ruta', 2, '2025-09-15 16:50:00', v_estado_resuelta, v_operaciones[14], v_usuarios[1]),
    (gen_random_uuid()::TEXT, 'INC-2025-011', v_tipo_operacional, 'Falla en comunicación por radio - Sistema de respaldo activado', 1, '2025-09-17 08:10:00', v_estado_investigacion, v_operaciones[17], v_usuarios[3]),
    (gen_random_uuid()::TEXT, 'INC-2025-012', v_tipo_ambiental, 'Ruido excesivo en motor - Requiere inspección mecánica', 3, '2025-09-19 14:25:00', v_estado_reportada, v_operaciones[19], v_usuarios[2]),
    (gen_random_uuid()::TEXT, 'INC-2025-013', v_tipo_operacional, 'Desvío por obras en carretera - Ruta alternativa tomada +30km', 2, '2025-09-21 11:00:00', v_estado_resuelta, v_operaciones[21], v_usuarios[1]),
    (gen_random_uuid()::TEXT, 'INC-2025-014', v_tipo_administrativa, 'Cambio de destino último minuto - Actualización de documentación', 2, '2025-09-23 09:45:00', v_estado_cerrada, v_operaciones[23], v_usuarios[2]),
    (gen_random_uuid()::TEXT, 'INC-2025-015', v_tipo_seguridad, 'Condiciones climáticas adversas - Lluvia intensa - Velocidad reducida', 3, '2025-09-24 13:30:00', v_estado_reportada, v_operaciones[24], v_usuarios[3]);
END $$;

-- DOCUMENTACIÓN (30 documentos)
DO $$
DECLARE
    v_tipo_guia CHAR(36);
    v_tipo_factura CHAR(36);
    v_tipo_manifiesto CHAR(36);
    v_tipo_certificado CHAR(36);
    v_tipo_orden CHAR(36);
    contador INT := 0;
BEGIN
    SELECT id_tipo_documento INTO v_tipo_guia FROM operaciones_terrestres.TipoDocumento WHERE nombre = 'Guía de remisión';
    SELECT id_tipo_documento INTO v_tipo_factura FROM operaciones_terrestres.TipoDocumento WHERE nombre = 'Factura';
    SELECT id_tipo_documento INTO v_tipo_manifiesto FROM operaciones_terrestres.TipoDocumento WHERE nombre = 'Manifiesto de carga';
    SELECT id_tipo_documento INTO v_tipo_certificado FROM operaciones_terrestres.TipoDocumento WHERE nombre = 'Certificado';
    SELECT id_tipo_documento INTO v_tipo_orden FROM operaciones_terrestres.TipoDocumento WHERE nombre = 'Orden de compra';

    FOR contador IN 1..30 LOOP
        INSERT INTO operaciones_terrestres.DocumentacionOperacion (id_documento, codigo, nombre, ruta_archivo, fecha_emision, id_tipo_documento)
        VALUES (
            gen_random_uuid()::TEXT,
            'DOC-' || LPAD(contador::TEXT, 4, '0'),
            CASE
                WHEN contador % 5 = 1 THEN 'Guía de Remisión GR-2025-' || LPAD(contador::TEXT, 3, '0')
                WHEN contador % 5 = 2 THEN 'Factura FAC-2025-' || LPAD((contador + 100)::TEXT, 3, '0')
                WHEN contador % 5 = 3 THEN 'Manifiesto de Carga MAN-2025-' || LPAD(contador::TEXT, 3, '0')
                WHEN contador % 5 = 4 THEN 'Certificado CI-2025-' || LPAD((contador + 50)::TEXT, 3, '0')
                ELSE 'Orden de Compra OC-2025-' || LPAD(contador::TEXT, 3, '0')
            END,
            CASE
                WHEN contador % 5 = 1 THEN '/docs/guias/gr_2025_' || LPAD(contador::TEXT, 3, '0') || '.pdf'
                WHEN contador % 5 = 2 THEN '/docs/facturas/fac_2025_' || LPAD((contador + 100)::TEXT, 3, '0') || '.pdf'
                WHEN contador % 5 = 3 THEN '/docs/manifiestos/man_2025_' || LPAD(contador::TEXT, 3, '0') || '.pdf'
                WHEN contador % 5 = 4 THEN '/docs/certificados/ci_2025_' || LPAD((contador + 50)::TEXT, 3, '0') || '.pdf'
                ELSE '/docs/ordenes/oc_2025_' || LPAD(contador::TEXT, 3, '0') || '.pdf'
            END,
            ('2025-09-' || LPAD(((contador % 25) + 1)::TEXT, 2, '0'))::DATE,
            CASE
                WHEN contador % 5 = 1 THEN v_tipo_guia
                WHEN contador % 5 = 2 THEN v_tipo_factura
                WHEN contador % 5 = 3 THEN v_tipo_manifiesto
                WHEN contador % 5 = 4 THEN v_tipo_certificado
                ELSE v_tipo_orden
            END
        );
    END LOOP;
END $$;

-- Asociación Operación-Documento (50 asociaciones - algunas operaciones con múltiples documentos)
DO $$
DECLARE
    v_operaciones CHAR(36)[];
    v_documentos CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT ARRAY_AGG(id_operacion ORDER BY codigo) INTO v_operaciones FROM operaciones_terrestres.Operacion WHERE codigo NOT LIKE '%029%' AND codigo NOT LIKE '%030%';
    SELECT ARRAY_AGG(id_documento ORDER BY codigo) INTO v_documentos FROM operaciones_terrestres.DocumentacionOperacion;

    -- Cada operación tiene al menos 1-2 documentos
    FOR contador IN 1..25 LOOP
        INSERT INTO operaciones_terrestres.OperacionDocumento (id_operacion, id_documento) VALUES
        (v_operaciones[contador], v_documentos[contador]),
        (v_operaciones[contador], v_documentos[contador + 5]);
    END LOOP;
END $$;

-- REPORTES DE TRANSPORTE (25 reportes)
DO $$
DECLARE
    v_tipo_control_salida CHAR(36);
    v_tipo_control_llegada CHAR(36);
    v_tipo_incidencia CHAR(36);
    v_tipo_seguimiento CHAR(36);
    v_operaciones_terrestres CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT id_tipo_reporte INTO v_tipo_control_salida FROM operaciones_terrestres.TipoReporte WHERE nombre = 'Control salida';
    SELECT id_tipo_reporte INTO v_tipo_control_llegada FROM operaciones_terrestres.TipoReporte WHERE nombre = 'Control llegada';
    SELECT id_tipo_reporte INTO v_tipo_incidencia FROM operaciones_terrestres.TipoReporte WHERE nombre = 'Incidencia';
    SELECT id_tipo_reporte INTO v_tipo_seguimiento FROM operaciones_terrestres.TipoReporte WHERE nombre = 'Seguimiento';

    SELECT ARRAY_AGG(id_operacion_terrestre ORDER BY codigo) INTO v_operaciones_terrestres FROM operaciones_terrestres.OperacionTerrestre;

    FOR contador IN 1..25 LOOP
        INSERT INTO operaciones_terrestres.ReporteTransporte (id_reporte, codigo, id_tipo_reporte, fecha_generado, id_operacion_terrestre)
        VALUES (
            gen_random_uuid()::TEXT,
            'REP-' || LPAD(contador::TEXT, 4, '0'),
            CASE
                WHEN contador % 4 = 1 THEN v_tipo_control_salida
                WHEN contador % 4 = 2 THEN v_tipo_seguimiento
                WHEN contador % 4 = 3 THEN v_tipo_control_llegada
                ELSE v_tipo_incidencia
            END,
            ('2025-09-' || LPAD(((contador % 25) + 1)::TEXT, 2, '0'))::DATE,
            v_operaciones_terrestres[contador]
        );
    END LOOP;
END $$;

-- ============================================
-- VERIFICACIÓN FINAL
-- ============================================
SELECT '=== VERIFICACIÓN DE DATOS INSERTADOS ===' AS titulo;
SELECT 'Contratos: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Contrato;-- 25 contratos (22 vigentes, 2 vencidos, 1 cancelado)
SELECT 'Empleados: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Empleado; -- 25 empleados (20 conductores, 5 personal operativo)
SELECT 'Teléfonos: ' || COUNT(*) AS resultado FROM operaciones_terrestres.EmpleadoTelefono;  -- 35 teléfonos
SELECT 'Conductores: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Conductor;  -- 20 conductores
SELECT 'Usuarios: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Usuario;-- 5 usuarios
SELECT 'Rutas: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Ruta;
SELECT 'Rutas Terrestres: ' || COUNT(*) AS resultado FROM operaciones_terrestres.RutaTerrestre;-- 20 rutas terrestres
SELECT 'Activos: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Activo;-- 20 activos/vehículos
SELECT 'Vehículos: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Vehiculo;--20 vehiculos
SELECT 'Operaciones: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Operacion;  -- 30 operaciones (15 completadas, 10 en curso, 3 pendientes, 2 canceladas)
SELECT 'Operaciones Terrestres: ' || COUNT(*) AS resultado FROM operaciones_terrestres.OperacionTerrestre;  -- 25 operaciones terrestres
SELECT 'Checklists: ' || COUNT(*) AS resultado FROM operaciones_terrestres.ChecklistDespacho;  -- 25 checklists
SELECT 'Incidencias: ' || COUNT(*) AS resultado FROM operaciones_terrestres.Incidencia;-- 15 incidencias
SELECT 'Documentos: ' || COUNT(*) AS resultado FROM operaciones_terrestres.DocumentacionOperacion;-- 30 documentos
SELECT 'Operación-Documento: ' || COUNT(*) AS resultado FROM operaciones_terrestres.OperacionDocumento; -- 50 asociaciones operación-documento
SELECT 'Reportes: ' || COUNT(*) AS resultado FROM operaciones_terrestres.ReporteTransporte;-- 25 reportes
SELECT '=== DATOS INSERTADOS EXITOSAMENTE ===' AS titulo;
