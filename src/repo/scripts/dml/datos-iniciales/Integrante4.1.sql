-- ============================================
-- SCRIPT COMPLETO: LIMPIAR Y POBLAR
-- MÓDULO MANTENIMIENTO LOGÍSTICO
-- ============================================

-- ============================================
-- PASO 1: ELIMINAR DATOS EXISTENTES
-- ============================================

-- Eliminar en orden inverso por dependencias
DELETE FROM mantenimiento_logistico.OperacionMantenimientoRepuesto;
DELETE FROM mantenimiento_logistico.OperacionMantenimientoTecnico;
DELETE FROM mantenimiento_logistico.TareaMantenimiento;
DELETE FROM mantenimiento_logistico.OrdenMantenimiento;
DELETE FROM mantenimiento_logistico.OperacionMantenimiento;
DELETE FROM mantenimiento_logistico.SolicitudMantenimiento;
DELETE FROM mantenimiento_logistico.PlanMantenimiento;
DELETE FROM mantenimiento_logistico.Repuesto;
DELETE FROM mantenimiento_logistico.Operacion;
DELETE FROM mantenimiento_logistico.Activo;
DELETE FROM mantenimiento_logistico.ResponsableSolicitud;
DELETE FROM mantenimiento_logistico.Tecnico;
DELETE FROM mantenimiento_logistico.EmpleadoTelefono;
DELETE FROM mantenimiento_logistico.Empleado;
DELETE FROM mantenimiento_logistico.Contrato;

-- Tablas de dominio (lookup tables)
DELETE FROM mantenimiento_logistico.TipoTelefono;
DELETE FROM mantenimiento_logistico.EstadoContrato;
DELETE FROM mantenimiento_logistico.EspecialidadEmpleado;
DELETE FROM mantenimiento_logistico.Prioridad;
DELETE FROM mantenimiento_logistico.TipoMantenimiento;
DELETE FROM mantenimiento_logistico.EstadoActivo;
DELETE FROM mantenimiento_logistico.TipoActivo;
DELETE FROM mantenimiento_logistico.EstadoTarea;
DELETE FROM mantenimiento_logistico.EstadoOrden;
DELETE FROM mantenimiento_logistico.EstadoSolicitud;
DELETE FROM mantenimiento_logistico.EstadoPlan;
DELETE FROM mantenimiento_logistico.EstadoOperacion;

-- ============================================
-- PASO 2: POBLAR DATOS
-- ============================================

-- TABLAS DE DOMINIO
INSERT INTO mantenimiento_logistico.EstadoOperacion (id_estado_operacion, nombre) VALUES
(gen_random_uuid()::TEXT, 'Pendiente'),
(gen_random_uuid()::TEXT, 'En curso'),
(gen_random_uuid()::TEXT, 'Completada'),
(gen_random_uuid()::TEXT, 'Cancelada');

INSERT INTO mantenimiento_logistico.EstadoPlan (id_estado_plan, nombre) VALUES
(gen_random_uuid()::TEXT, 'Activo'),
(gen_random_uuid()::TEXT, 'Suspendido'),
(gen_random_uuid()::TEXT, 'Completado'),
(gen_random_uuid()::TEXT, 'Cancelado');

INSERT INTO mantenimiento_logistico.EstadoSolicitud (id_estado_solicitud, nombre) VALUES
(gen_random_uuid()::TEXT, 'Pendiente'),
(gen_random_uuid()::TEXT, 'Aprobada'),
(gen_random_uuid()::TEXT, 'Rechazada'),
(gen_random_uuid()::TEXT, 'En ejecución');

INSERT INTO mantenimiento_logistico.EstadoOrden (id_estado_orden, nombre) VALUES
(gen_random_uuid()::TEXT, 'Abierta'),
(gen_random_uuid()::TEXT, 'En ejecución'),
(gen_random_uuid()::TEXT, 'Completada'),
(gen_random_uuid()::TEXT, 'Cancelada');

INSERT INTO mantenimiento_logistico.EstadoTarea (id_estado_tarea, nombre) VALUES
(gen_random_uuid()::TEXT, 'Pendiente'),
(gen_random_uuid()::TEXT, 'En progreso'),
(gen_random_uuid()::TEXT, 'Completada'),
(gen_random_uuid()::TEXT, 'Cancelada');

INSERT INTO mantenimiento_logistico.TipoActivo (id_tipo_activo, nombre) VALUES
(gen_random_uuid()::TEXT, 'Equipo portuario'),
(gen_random_uuid()::TEXT, 'Vehículo'),
(gen_random_uuid()::TEXT, 'Infraestructura'),
(gen_random_uuid()::TEXT, 'Herramienta');

INSERT INTO mantenimiento_logistico.EstadoActivo (id_estado_activo, nombre) VALUES
(gen_random_uuid()::TEXT, 'Operativo'),
(gen_random_uuid()::TEXT, 'En mantenimiento'),
(gen_random_uuid()::TEXT, 'Fuera de servicio'),
(gen_random_uuid()::TEXT, 'Dado de baja');

INSERT INTO mantenimiento_logistico.TipoMantenimiento (id_tipo_mantenimiento, nombre) VALUES
(gen_random_uuid()::TEXT, 'Preventivo'),
(gen_random_uuid()::TEXT, 'Correctivo'),
(gen_random_uuid()::TEXT, 'Predictivo'),
(gen_random_uuid()::TEXT, 'Emergencia');

INSERT INTO mantenimiento_logistico.Prioridad (id_prioridad, nombre) VALUES
(gen_random_uuid()::TEXT, 'Baja'),
(gen_random_uuid()::TEXT, 'Media'),
(gen_random_uuid()::TEXT, 'Alta'),
(gen_random_uuid()::TEXT, 'Crítica');

INSERT INTO mantenimiento_logistico.EspecialidadEmpleado (id_especialidad_empleado, nombre) VALUES
(gen_random_uuid()::TEXT, 'Supervisor'),
(gen_random_uuid()::TEXT, 'Operario'),
(gen_random_uuid()::TEXT, 'Administrativo'),
(gen_random_uuid()::TEXT, 'Técnico'),
(gen_random_uuid()::TEXT, 'Gerente'),
(gen_random_uuid()::TEXT, 'Agente de Reservas'),
(gen_random_uuid()::TEXT, 'Tripulante'),
(gen_random_uuid()::TEXT, 'Trabajador Portuario'),
(gen_random_uuid()::TEXT, 'Conductor');

INSERT INTO mantenimiento_logistico.EstadoContrato (id_estado_contrato, nombre) VALUES
(gen_random_uuid()::TEXT, 'Vigente'),
(gen_random_uuid()::TEXT, 'Vencido'),
(gen_random_uuid()::TEXT, 'Cancelado');

INSERT INTO mantenimiento_logistico.TipoTelefono (id_tipo_telefono, nombre) VALUES
(gen_random_uuid()::TEXT, 'Fijo'),
(gen_random_uuid()::TEXT, 'Móvil'),
(gen_random_uuid()::TEXT, 'Corporativo');

-- CONTRATOS (25 contratos)
INSERT INTO mantenimiento_logistico.Contrato (id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato) VALUES
(gen_random_uuid()::TEXT, '2024-01-15', '2026-01-15', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-02-01', '2026-02-01', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-03-10', '2026-03-10', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-04-05', '2026-04-05', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-05-20', '2026-05-20', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-06-12', '2026-06-12', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-07-08', '2026-07-08', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-08-15', '2026-08-15', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-09-01', '2026-09-01', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-10-10', '2026-10-10', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-11-05', '2026-11-05', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2024-12-01', '2026-12-01', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-01-15', '2027-01-15', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-02-10', '2027-02-10', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-03-05', '2027-03-05', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-04-20', '2027-04-20', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-05-15', '2027-05-15', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-06-08', '2027-06-08', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-07-12', '2027-07-12', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-08-03', '2027-08-03', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2023-05-10', '2025-05-10', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vencido')),
(gen_random_uuid()::TEXT, '2023-06-15', '2025-06-15', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vencido')),
(gen_random_uuid()::TEXT, '2024-01-20', '2026-01-20', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Cancelado')),
(gen_random_uuid()::TEXT, '2025-09-10', '2027-09-10', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente')),
(gen_random_uuid()::TEXT, '2025-10-15', '2027-10-15', (SELECT id_estado_contrato FROM mantenimiento_logistico.EstadoContrato WHERE nombre = 'Vigente'));

-- EMPLEADOS (25 empleados - 12 técnicos, 8 responsables, 5 administrativos)
DO $$
DECLARE
    v_especialidad_tecnico CHAR(36);
    v_especialidad_supervisor CHAR(36);
    v_especialidad_administrativo CHAR(36);
    v_especialidad_gerente CHAR(36);
    v_contratos CHAR(36)[];
BEGIN
    SELECT id_especialidad_empleado INTO v_especialidad_tecnico FROM mantenimiento_logistico.EspecialidadEmpleado WHERE nombre = 'Técnico';
    SELECT id_especialidad_empleado INTO v_especialidad_supervisor FROM mantenimiento_logistico.EspecialidadEmpleado WHERE nombre = 'Supervisor';
    SELECT id_especialidad_empleado INTO v_especialidad_administrativo FROM mantenimiento_logistico.EspecialidadEmpleado WHERE nombre = 'Administrativo';
    SELECT id_especialidad_empleado INTO v_especialidad_gerente FROM mantenimiento_logistico.EspecialidadEmpleado WHERE nombre = 'Gerente';

    SELECT ARRAY_AGG(id_contrato) INTO v_contratos FROM mantenimiento_logistico.Contrato;

    -- 12 Técnicos
    INSERT INTO mantenimiento_logistico.Empleado (id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato) VALUES
    (gen_random_uuid()::TEXT, 'EMP-049', '49556677', 'Ricardo', 'Fernández Díaz', 'Av. Industrial 258, Callao', v_especialidad_tecnico, v_contratos[1]),
    (gen_random_uuid()::TEXT, 'EMP-050', '50667788', 'Andrés', 'Chávez Morales', 'Jr. Técnico 369, Lima', v_especialidad_tecnico, v_contratos[2]),
    (gen_random_uuid()::TEXT, 'EMP-051', '51778899', 'Julio', 'Paredes Silva', 'Calle Miraflores 147, Lima', v_especialidad_tecnico, v_contratos[3]),
    (gen_random_uuid()::TEXT, 'EMP-052', '52889900', 'Oscar', 'Gutierrez López', 'Av. República 456, Lima', v_especialidad_tecnico, v_contratos[4]),
    (gen_random_uuid()::TEXT, 'EMP-053', '53990011', 'Daniel', 'Campos Ruiz', 'Jr. Los Olivos 789, Callao', v_especialidad_tecnico, v_contratos[5]),
    (gen_random_uuid()::TEXT, 'EMP-054', '54001122', 'Manuel', 'Torres Castro', 'Av. Perú 321, Callao', v_especialidad_tecnico, v_contratos[6]),
    (gen_random_uuid()::TEXT, 'EMP-055', '55112233', 'Gabriel', 'Ríos Mendoza', 'Calle Industrial 654, Lima', v_especialidad_tecnico, v_contratos[7]),
    (gen_random_uuid()::TEXT, 'EMP-056', '56223344', 'Héctor', 'Salinas Vega', 'Jr. Progreso 987, Callao', v_especialidad_tecnico, v_contratos[8]),
    (gen_random_uuid()::TEXT, 'EMP-057', '57334455', 'Luis', 'Mendoza Rojas', 'Av. Tecnológica 123, Lima', v_especialidad_tecnico, v_contratos[9]),
    (gen_random_uuid()::TEXT, 'EMP-058', '58445566', 'Carlos', 'Vega Herrera', 'Jr. Ingenieros 456, Callao', v_especialidad_tecnico, v_contratos[10]),
    (gen_random_uuid()::TEXT, 'EMP-059', '59556677', 'Roberto', 'Silva Paredes', 'Calle Mecánica 789, Lima', v_especialidad_tecnico, v_contratos[11]),
    (gen_random_uuid()::TEXT, 'EMP-060', '60667788', 'Fernando', 'Castro Luna', 'Av. Industrial 852, Callao', v_especialidad_tecnico, v_contratos[12]),
    -- 8 Responsables/Supervisores
    (gen_random_uuid()::TEXT, 'EMP-061', '61778899', 'Laura', 'Ramírez Torres', 'Av. Universitaria 741, Lima', v_especialidad_supervisor, v_contratos[13]),
    (gen_random_uuid()::TEXT, 'EMP-062', '62889900', 'Carmen', 'Soto Flores', 'Jr. Comercio 852, Lima', v_especialidad_supervisor, v_contratos[14]),
    (gen_random_uuid()::TEXT, 'EMP-063', '63990011', 'Elena', 'Vargas Pérez', 'Calle Real 963, Callao', v_especialidad_supervisor, v_contratos[15]),
    (gen_random_uuid()::TEXT, 'EMP-064', '64001122', 'Mónica', 'Luna Castro', 'Av. Central 159, Lima', v_especialidad_supervisor, v_contratos[16]),
    (gen_random_uuid()::TEXT, 'EMP-065', '65112233', 'Patricia', 'Gómez Ruiz', 'Jr. Supervisor 753, Lima', v_especialidad_supervisor, v_contratos[17]),
    (gen_random_uuid()::TEXT, 'EMP-066', '66223344', 'Ana', 'Díaz Mendoza', 'Calle Control 456, Callao', v_especialidad_supervisor, v_contratos[18]),
    (gen_random_uuid()::TEXT, 'EMP-067', '67334455', 'Sofia', 'Herrera López', 'Av. Gestión 789, Lima', v_especialidad_supervisor, v_contratos[19]),
    (gen_random_uuid()::TEXT, 'EMP-068', '68445566', 'Lucía', 'Torres Vargas', 'Jr. Coordinación 321, Callao', v_especialidad_supervisor, v_contratos[20]),
    -- 5 Administrativos/Gerentes
    (gen_random_uuid()::TEXT, 'EMP-069', '69556677', 'Miguel', 'Rojas Santillán', 'Av. Gerencial 147, Lima', v_especialidad_gerente, v_contratos[21]),
    (gen_random_uuid()::TEXT, 'EMP-070', '70667788', 'Jorge', 'Pérez Castro', 'Calle Administración 258, Callao', v_especialidad_administrativo, v_contratos[22]),
    (gen_random_uuid()::TEXT, 'EMP-071', '71778899', 'Raúl', 'García Flores', 'Jr. Dirección 369, Lima', v_especialidad_administrativo, v_contratos[23]),
    (gen_random_uuid()::TEXT, 'EMP-072', '72889900', 'Alberto', 'Martínez Soto', 'Av. Planificación 741, Lima', v_especialidad_administrativo, v_contratos[24]),
    (gen_random_uuid()::TEXT, 'EMP-073', '73990011', 'David', 'López Ramírez', 'Calle Estrategia 852, Callao', v_especialidad_administrativo, v_contratos[25]);
END $$;

-- TELÉFONOS DE EMPLEADOS (35 teléfonos)
DO $$
DECLARE
    v_tipo_movil CHAR(36);
    v_tipo_fijo CHAR(36);
    v_tipo_corporativo CHAR(36);
BEGIN
    SELECT id_tipo_telefono INTO v_tipo_movil FROM mantenimiento_logistico.TipoTelefono WHERE nombre = 'Móvil';
    SELECT id_tipo_telefono INTO v_tipo_fijo FROM mantenimiento_logistico.TipoTelefono WHERE nombre = 'Fijo';
    SELECT id_tipo_telefono INTO v_tipo_corporativo FROM mantenimiento_logistico.TipoTelefono WHERE nombre = 'Corporativo';

    -- Teléfonos móviles para todos los empleados
    INSERT INTO mantenimiento_logistico.EmpleadoTelefono (id_empleado_telefono, id_empleado, telefono, id_tipo_telefono)
    SELECT gen_random_uuid()::TEXT, id_empleado, '94' || LPAD((ROW_NUMBER() OVER())::TEXT, 7, '0'), v_tipo_movil
    FROM mantenimiento_logistico.Empleado;

    -- Teléfonos adicionales para supervisores y gerentes
    INSERT INTO mantenimiento_logistico.EmpleadoTelefono (id_empleado_telefono, id_empleado, telefono, id_tipo_telefono) VALUES
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM mantenimiento_logistico.Empleado WHERE codigo = 'EMP-061'), '014567890', v_tipo_fijo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM mantenimiento_logistico.Empleado WHERE codigo = 'EMP-061'), '987654321', v_tipo_corporativo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM mantenimiento_logistico.Empleado WHERE codigo = 'EMP-062'), '014567891', v_tipo_fijo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM mantenimiento_logistico.Empleado WHERE codigo = 'EMP-069'), '014567892', v_tipo_fijo),
    (gen_random_uuid()::TEXT, (SELECT id_empleado FROM mantenimiento_logistico.Empleado WHERE codigo = 'EMP-069'), '987654322', v_tipo_corporativo);
END $$;

-- TÉCNICOS (12 técnicos)
DO $$
DECLARE
    empleado_record RECORD;
    contador INT := 0;
    especialidades TEXT[] := ARRAY[
        'Mecánica Automotriz', 'Sistemas Hidráulicos', 'Electricidad Industrial', 'Mecánica Diesel',
        'Sistemas Electrónicos', 'Soldadura Industrial', 'Neumática', 'Refrigeración',
        'Instrumentación', 'Control Automático', 'Mantenimiento Predictivo', 'Calibración'
    ];
BEGIN
    FOR empleado_record IN
        SELECT id_empleado, codigo 
        FROM mantenimiento_logistico.Empleado 
        WHERE codigo BETWEEN 'EMP-049' AND 'EMP-060'
        ORDER BY codigo
    LOOP
        contador := contador + 1;
        INSERT INTO mantenimiento_logistico.Tecnico (id_tecnico, id_empleado, especialidad) VALUES
        (
            gen_random_uuid()::TEXT,
            empleado_record.id_empleado,
            especialidades[((contador - 1) % array_length(especialidades, 1)) + 1]
        );
    END LOOP;
END $$;

-- RESPONSABLES DE SOLICITUD (8 responsables)
DO $$
DECLARE
    empleado_record RECORD;
    contador INT := 0;
BEGIN
    FOR empleado_record IN
        SELECT id_empleado, codigo 
        FROM mantenimiento_logistico.Empleado 
        WHERE codigo BETWEEN 'EMP-061' AND 'EMP-068'
        ORDER BY codigo
    LOOP
        contador := contador + 1;
        INSERT INTO mantenimiento_logistico.ResponsableSolicitud (id_responsable_solicitud, id_empleado) VALUES
        (
            gen_random_uuid()::TEXT,
            empleado_record.id_empleado
        );
    END LOOP;
END $$;

-- ACTIVOS (25 activos)
DO $$
DECLARE
    v_tipo_vehiculo CHAR(36);
    v_tipo_equipo_portuario CHAR(36);
    v_tipo_infraestructura CHAR(36);
    v_tipo_herramienta CHAR(36);
    v_estado_operativo CHAR(36);
    v_estado_mantenimiento CHAR(36);
    v_estado_fuera_servicio CHAR(36);
BEGIN
    SELECT id_tipo_activo INTO v_tipo_vehiculo FROM mantenimiento_logistico.TipoActivo WHERE nombre = 'Vehículo';
    SELECT id_tipo_activo INTO v_tipo_equipo_portuario FROM mantenimiento_logistico.TipoActivo WHERE nombre = 'Equipo portuario';
    SELECT id_tipo_activo INTO v_tipo_infraestructura FROM mantenimiento_logistico.TipoActivo WHERE nombre = 'Infraestructura';
    SELECT id_tipo_activo INTO v_tipo_herramienta FROM mantenimiento_logistico.TipoActivo WHERE nombre = 'Herramienta';
    
    SELECT id_estado_activo INTO v_estado_operativo FROM mantenimiento_logistico.EstadoActivo WHERE nombre = 'Operativo';
    SELECT id_estado_activo INTO v_estado_mantenimiento FROM mantenimiento_logistico.EstadoActivo WHERE nombre = 'En mantenimiento';
    SELECT id_estado_activo INTO v_estado_fuera_servicio FROM mantenimiento_logistico.EstadoActivo WHERE nombre = 'Fuera de servicio';

    INSERT INTO mantenimiento_logistico.Activo (id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion) VALUES
    -- Vehículos
    (gen_random_uuid()::TEXT, 'ACT-001', 'Camión Volvo FH16 750HP', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal'),
    (gen_random_uuid()::TEXT, 'ACT-002', 'Camión Mercedes-Benz Actros 2546', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal'),
    (gen_random_uuid()::TEXT, 'ACT-003', 'Tracto Scania R500 V8', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal'),
    (gen_random_uuid()::TEXT, 'ACT-004', 'Camión Hino 500 Series', v_tipo_vehiculo, v_estado_mantenimiento, 'Taller Mecánico'),
    (gen_random_uuid()::TEXT, 'ACT-005', 'Furgón Isuzu NPR 75L', v_tipo_vehiculo, v_estado_operativo, 'Patio Secundario'),
    (gen_random_uuid()::TEXT, 'ACT-006', 'Camión JAC 1063 HFC', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal'),
    (gen_random_uuid()::TEXT, 'ACT-007', 'Tracto Kenworth T800', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal'),
    (gen_random_uuid()::TEXT, 'ACT-008', 'Camión Freightliner Cascadia', v_tipo_vehiculo, v_estado_fuera_servicio, 'Taller Mecánico'),
    (gen_random_uuid()::TEXT, 'ACT-009', 'Furgón Mitsubishi Canter 7.5T', v_tipo_vehiculo, v_estado_operativo, 'Patio Secundario'),
    (gen_random_uuid()::TEXT, 'ACT-010', 'Camión Iveco Trakker AT380', v_tipo_vehiculo, v_estado_operativo, 'Patio Principal'),
    -- Equipos portuarios
    (gen_random_uuid()::TEXT, 'ACT-011', 'Grúa Pórtico Konecranes', v_tipo_equipo_portuario, v_estado_operativo, 'Muelle 1'),
    (gen_random_uuid()::TEXT, 'ACT-012', 'Reach Stacker Kalmar', v_tipo_equipo_portuario, v_estado_operativo, 'Patio Contenedores'),
    (gen_random_uuid()::TEXT, 'ACT-013', 'Montacargas Toyota 8FD25', v_tipo_equipo_portuario, v_estado_mantenimiento, 'Taller Mantenimiento'),
    (gen_random_uuid()::TEXT, 'ACT-014', 'Grúa Móvil Liebherr LTM 1100', v_tipo_equipo_portuario, v_estado_operativo, 'Muelle 2'),
    (gen_random_uuid()::TEXT, 'ACT-015', 'Tractor Terminal Terberg', v_tipo_equipo_portuario, v_estado_operativo, 'Patio Principal'),
    (gen_random_uuid()::TEXT, 'ACT-016', 'Montacargas Hyster H120FT', v_tipo_equipo_portuario, v_estado_operativo, 'Almacén A'),
    (gen_random_uuid()::TEXT, 'ACT-017', 'Grúa Pórtico ZPMC', v_tipo_equipo_portuario, v_estado_mantenimiento, 'Taller Mantenimiento'),
    (gen_random_uuid()::TEXT, 'ACT-018', 'Reach Stacker CVS Ferrari', v_tipo_equipo_portuario, v_estado_operativo, 'Patio Contenedores'),
    -- Infraestructura
    (gen_random_uuid()::TEXT, 'ACT-019', 'Sistema de Almacenamiento Automatizado', v_tipo_infraestructura, v_estado_operativo, 'Almacén B'),
    (gen_random_uuid()::TEXT, 'ACT-020', 'Plataforma de Carga Dock 5', v_tipo_infraestructura, v_estado_operativo, 'Muelle 3'),
    (gen_random_uuid()::TEXT, 'ACT-021', 'Sistema de Control de Tráfico', v_tipo_infraestructura, v_estado_mantenimiento, 'Torre de Control'),
    (gen_random_uuid()::TEXT, 'ACT-022', 'Báscula Industrial 60T', v_tipo_infraestructura, v_estado_operativo, 'Entrada Principal'),
    -- Herramientas
    (gen_random_uuid()::TEXT, 'ACT-023', 'Kit de Herramientas Mecánicas Premium', v_tipo_herramienta, v_estado_operativo, 'Taller Central'),
    (gen_random_uuid()::TEXT, 'ACT-024', 'Analizador de Motor Diesel', v_tipo_herramienta, v_estado_operativo, 'Taller Diagnóstico'),
    (gen_random_uuid()::TEXT, 'ACT-025', 'Equipo de Soldadura MIG/TIG', v_tipo_herramienta, v_estado_mantenimiento, 'Taller Soldadura');
END $$;

-- REPUESTOS (30 repuestos)
DO $$
DECLARE
    contador INT := 0;
BEGIN
    FOR contador IN 1..30 LOOP
        INSERT INTO mantenimiento_logistico.Repuesto (id_repuesto, codigo, nombre, stock, stock_minimo) VALUES
        (
            gen_random_uuid()::TEXT,
            'REP-' || LPAD(contador::TEXT, 3, '0'),
            CASE 
                WHEN contador = 1 THEN 'Filtro de aceite'
                WHEN contador = 2 THEN 'Filtro de combustible'
                WHEN contador = 3 THEN 'Manguera hidráulica 1/2"'
                WHEN contador = 4 THEN 'Termostato motor diesel'
                WHEN contador = 5 THEN 'Líquido refrigerante (galón)'
                WHEN contador = 6 THEN 'Aceite motor 15W-40 (galón)'
                WHEN contador = 7 THEN 'Pastillas de freno delanteras'
                WHEN contador = 8 THEN 'Líquido de frenos DOT 4 (litro)'
                WHEN contador = 9 THEN 'Fusibles automotrices set'
                WHEN contador = 10 THEN 'Cable eléctrico calibre 12 (metro)'
                WHEN contador = 11 THEN 'Sello hidráulico O-ring set'
                WHEN contador = 12 THEN 'Aceite hidráulico ISO 68 (galón)'
                WHEN contador = 13 THEN 'Grasa multiusos (kg)'
                WHEN contador = 14 THEN 'Correa de transmisión'
                WHEN contador = 15 THEN 'Batería 12V 150Ah'
                WHEN contador = 16 THEN 'Sensor de temperatura'
                WHEN contador = 17 THEN 'Bomba de agua'
                WHEN contador = 18 THEN 'Radiador aluminio'
                WHEN contador = 19 THEN 'Alternador 12V 150A'
                WHEN contador = 20 THEN 'Motor de arranque'
                WHEN contador = 21 THEN 'Amortiguador delantero'
                WHEN contador = 22 THEN 'Rótula de dirección'
                WHEN contador = 23 THEN 'Bomba hidráulica'
                WHEN contador = 24 THEN 'Cilindro hidráulico'
                WHEN contador = 25 THEN 'Válvula de control'
                WHEN contador = 26 THEN 'Transductor presión'
                WHEN contador = 27 THEN 'PLC controlador'
                WHEN contador = 28 THEN 'Sensor de proximidad'
                WHEN contador = 29 THEN 'Cableado de potencia'
                ELSE 'Interruptor de seguridad'
            END,
            (RANDOM() * 100 + 20)::INT,
            (RANDOM() * 20 + 5)::INT
        );
    END LOOP;
END $$;

-- PLANES DE MANTENIMIENTO (15 planes)
DO $$
DECLARE
    v_estado_activo CHAR(36);
    v_estado_suspendido CHAR(36);
    v_estado_completado CHAR(36);
    v_activos CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT id_estado_plan INTO v_estado_activo FROM mantenimiento_logistico.EstadoPlan WHERE nombre = 'Activo';
    SELECT id_estado_plan INTO v_estado_suspendido FROM mantenimiento_logistico.EstadoPlan WHERE nombre = 'Suspendido';
    SELECT id_estado_plan INTO v_estado_completado FROM mantenimiento_logistico.EstadoPlan WHERE nombre = 'Completado';

    SELECT ARRAY_AGG(id_activo ORDER BY codigo) INTO v_activos FROM mantenimiento_logistico.Activo;

    FOR contador IN 1..15 LOOP
        INSERT INTO mantenimiento_logistico.PlanMantenimiento (id_plan_mantenimiento, codigo, id_estado_plan, frecuencia, fecha_inicio, id_activo) VALUES
        (
            gen_random_uuid()::TEXT,
            'PM-2025-' || LPAD(contador::TEXT, 3, '0'),
            CASE 
                WHEN contador <= 10 THEN v_estado_activo
                WHEN contador <= 13 THEN v_estado_suspendido
                ELSE v_estado_completado
            END,
            CASE 
                WHEN contador % 4 = 1 THEN 'Mensual'
                WHEN contador % 4 = 2 THEN 'Bimensual'
                WHEN contador % 4 = 3 THEN 'Trimestral'
                ELSE 'Semestral'
            END,
            '2025-01-01'::DATE + (contador * INTERVAL '15 days'),
            v_activos[((contador - 1) % array_length(v_activos, 1)) + 1]
        );
    END LOOP;
END $$;

-- SOLICITUDES DE MANTENIMIENTO (20 solicitudes)
DO $$
DECLARE
    v_prioridad_baja CHAR(36);
    v_prioridad_media CHAR(36);
    v_prioridad_alta CHAR(36);
    v_prioridad_critica CHAR(36);
    v_estado_pendiente CHAR(36);
    v_estado_aprobada CHAR(36);
    v_estado_ejecucion CHAR(36);
    v_estado_rechazada CHAR(36);
    v_responsables CHAR(36)[];
    v_activos CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT id_prioridad INTO v_prioridad_baja FROM mantenimiento_logistico.Prioridad WHERE nombre = 'Baja';
    SELECT id_prioridad INTO v_prioridad_media FROM mantenimiento_logistico.Prioridad WHERE nombre = 'Media';
    SELECT id_prioridad INTO v_prioridad_alta FROM mantenimiento_logistico.Prioridad WHERE nombre = 'Alta';
    SELECT id_prioridad INTO v_prioridad_critica FROM mantenimiento_logistico.Prioridad WHERE nombre = 'Crítica';
    
    SELECT id_estado_solicitud INTO v_estado_pendiente FROM mantenimiento_logistico.EstadoSolicitud WHERE nombre = 'Pendiente';
    SELECT id_estado_solicitud INTO v_estado_aprobada FROM mantenimiento_logistico.EstadoSolicitud WHERE nombre = 'Aprobada';
    SELECT id_estado_solicitud INTO v_estado_ejecucion FROM mantenimiento_logistico.EstadoSolicitud WHERE nombre = 'En ejecución';
    SELECT id_estado_solicitud INTO v_estado_rechazada FROM mantenimiento_logistico.EstadoSolicitud WHERE nombre = 'Rechazada';

    SELECT ARRAY_AGG(id_responsable_solicitud) INTO v_responsables FROM mantenimiento_logistico.ResponsableSolicitud;
    SELECT ARRAY_AGG(id_activo ORDER BY codigo) INTO v_activos FROM mantenimiento_logistico.Activo;

    FOR contador IN 1..20 LOOP
        INSERT INTO mantenimiento_logistico.SolicitudMantenimiento (
            id_solicitud_mantenimiento, codigo, descripcion_problema, fecha_solicitud,
            id_prioridad, id_estado_solicitud, id_responsable_solicitud, id_activo
        ) VALUES (
            gen_random_uuid()::TEXT,
            'SOL-2025-' || LPAD(contador::TEXT, 3, '0'),
            CASE 
                WHEN contador % 5 = 1 THEN 'Falla en sistema hidráulico de elevación - ' || contador
                WHEN contador % 5 = 2 THEN 'Sobrecalentamiento del motor - ' || contador
                WHEN contador % 5 = 3 THEN 'Ruido anormal en caja de cambios - ' || contador
                WHEN contador % 5 = 4 THEN 'Sistema eléctrico intermitente - ' || contador
                ELSE 'Fuga de aceite hidráulico - ' || contador
            END,
            '2025-09-01'::DATE + (contador * INTERVAL '2 days'),
            CASE 
                WHEN contador % 4 = 1 THEN v_prioridad_baja
                WHEN contador % 4 = 2 THEN v_prioridad_media
                WHEN contador % 4 = 3 THEN v_prioridad_alta
                ELSE v_prioridad_critica
            END,
            CASE 
                WHEN contador <= 8 THEN v_estado_aprobada
                WHEN contador <= 12 THEN v_estado_ejecucion
                WHEN contador <= 16 THEN v_estado_pendiente
                ELSE v_estado_rechazada
            END,
            v_responsables[((contador - 1) % array_length(v_responsables, 1)) + 1],
            v_activos[((contador - 1) % array_length(v_activos, 1)) + 1]
        );
    END LOOP;
END $$;

-- OPERACIONES (30 operaciones)
DO $$
DECLARE
    v_estado_pendiente CHAR(36);
    v_estado_en_curso CHAR(36);
    v_estado_completada CHAR(36);
    v_estado_cancelada CHAR(36);
    contador INT := 0;
BEGIN
    SELECT id_estado_operacion INTO v_estado_pendiente FROM mantenimiento_logistico.EstadoOperacion WHERE nombre = 'Pendiente';
    SELECT id_estado_operacion INTO v_estado_en_curso FROM mantenimiento_logistico.EstadoOperacion WHERE nombre = 'En curso';
    SELECT id_estado_operacion INTO v_estado_completada FROM mantenimiento_logistico.EstadoOperacion WHERE nombre = 'Completada';
    SELECT id_estado_operacion INTO v_estado_cancelada FROM mantenimiento_logistico.EstadoOperacion WHERE nombre = 'Cancelada';

    FOR contador IN 1..30 LOOP
        INSERT INTO mantenimiento_logistico.Operacion (id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion) VALUES
        (
            gen_random_uuid()::TEXT,
            'OP-2025-' || LPAD((contador + 33)::TEXT, 3, '0'),
            '2025-09-01 08:00:00'::TIMESTAMP + (contador * INTERVAL '1 day'),
            CASE 
                WHEN contador <= 20 THEN '2025-09-01 18:00:00'::TIMESTAMP + (contador * INTERVAL '1 day')
                ELSE NULL
            END,
            CASE 
                WHEN contador <= 15 THEN v_estado_completada
                WHEN contador <= 25 THEN v_estado_en_curso
                WHEN contador <= 28 THEN v_estado_pendiente
                ELSE v_estado_cancelada
            END
        );
    END LOOP;
END $$;

-- OPERACIONES DE MANTENIMIENTO (25 operaciones)
DO $$
DECLARE
    v_operaciones CHAR(36)[];
    v_solicitudes CHAR(36)[];
    v_planes CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT ARRAY_AGG(id_operacion ORDER BY codigo) INTO v_operaciones FROM mantenimiento_logistico.Operacion;
    SELECT ARRAY_AGG(id_solicitud_mantenimiento ORDER BY codigo) INTO v_solicitudes FROM mantenimiento_logistico.SolicitudMantenimiento;
    SELECT ARRAY_AGG(id_plan_mantenimiento ORDER BY codigo) INTO v_planes FROM mantenimiento_logistico.PlanMantenimiento;

    FOR contador IN 1..25 LOOP
        INSERT INTO mantenimiento_logistico.OperacionMantenimiento (
            id_operacion_mantenimiento, id_operacion, id_plan_mantenimiento, id_solicitud_mantenimiento
        ) VALUES (
            gen_random_uuid()::TEXT,
            v_operaciones[contador],
            CASE 
                WHEN contador % 3 = 0 THEN v_planes[((contador - 1) % array_length(v_planes, 1)) + 1]
                ELSE NULL
            END,
            CASE 
                WHEN contador % 3 != 0 THEN v_solicitudes[((contador - 1) % array_length(v_solicitudes, 1)) + 1]
                ELSE NULL
            END
        );
    END LOOP;
END $$;

-- ÓRDENES DE MANTENIMIENTO (20 órdenes)
DO $$
DECLARE
    v_tipo_preventivo CHAR(36);
    v_tipo_correctivo CHAR(36);
    v_tipo_predictivo CHAR(36);
    v_tipo_emergencia CHAR(36);
    v_estado_abierta CHAR(36);
    v_estado_ejecucion CHAR(36);
    v_estado_completada CHAR(36);
    v_estado_cancelada CHAR(36);
    v_operaciones_mant CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT id_tipo_mantenimiento INTO v_tipo_preventivo FROM mantenimiento_logistico.TipoMantenimiento WHERE nombre = 'Preventivo';
    SELECT id_tipo_mantenimiento INTO v_tipo_correctivo FROM mantenimiento_logistico.TipoMantenimiento WHERE nombre = 'Correctivo';
    SELECT id_tipo_mantenimiento INTO v_tipo_predictivo FROM mantenimiento_logistico.TipoMantenimiento WHERE nombre = 'Predictivo';
    SELECT id_tipo_mantenimiento INTO v_tipo_emergencia FROM mantenimiento_logistico.TipoMantenimiento WHERE nombre = 'Emergencia';
    
    SELECT id_estado_orden INTO v_estado_abierta FROM mantenimiento_logistico.EstadoOrden WHERE nombre = 'Abierta';
    SELECT id_estado_orden INTO v_estado_ejecucion FROM mantenimiento_logistico.EstadoOrden WHERE nombre = 'En ejecución';
    SELECT id_estado_orden INTO v_estado_completada FROM mantenimiento_logistico.EstadoOrden WHERE nombre = 'Completada';
    SELECT id_estado_orden INTO v_estado_cancelada FROM mantenimiento_logistico.EstadoOrden WHERE nombre = 'Cancelada';

    SELECT ARRAY_AGG(id_operacion_mantenimiento) INTO v_operaciones_mant FROM mantenimiento_logistico.OperacionMantenimiento;

    FOR contador IN 1..20 LOOP
        INSERT INTO mantenimiento_logistico.OrdenMantenimiento (
            id_orden, codigo, fecha_generada, fecha_programada, fecha_cierre,
            id_tipo_mantenimiento, id_estado_orden, id_operacion_mantenimiento
        ) VALUES (
            gen_random_uuid()::TEXT,
            'ORD-2025-' || LPAD(contador::TEXT, 3, '0'),
            '2025-09-01'::DATE + (contador * INTERVAL '1 day'),
            '2025-09-01'::DATE + ((contador + 1) * INTERVAL '1 day'),
            CASE 
                WHEN contador <= 15 THEN '2025-09-01'::DATE + ((contador + 2) * INTERVAL '1 day')
                ELSE NULL
            END,
            CASE 
                WHEN contador % 4 = 1 THEN v_tipo_preventivo
                WHEN contador % 4 = 2 THEN v_tipo_correctivo
                WHEN contador % 4 = 3 THEN v_tipo_predictivo
                ELSE v_tipo_emergencia
            END,
            CASE 
                WHEN contador <= 10 THEN v_estado_completada
                WHEN contador <= 15 THEN v_estado_ejecucion
                WHEN contador <= 18 THEN v_estado_abierta
                ELSE v_estado_cancelada
            END,
            v_operaciones_mant[((contador - 1) % array_length(v_operaciones_mant, 1)) + 1]
        );
    END LOOP;
END $$;

-- TAREAS DE MANTENIMIENTO (60 tareas)
DO $$
DECLARE
    v_estado_pendiente CHAR(36);
    v_estado_en_progreso CHAR(36);
    v_estado_completada CHAR(36);
    v_ordenes CHAR(36)[];
    contador INT := 0;
    orden_index INT := 1;
BEGIN
    SELECT id_estado_tarea INTO v_estado_pendiente FROM mantenimiento_logistico.EstadoTarea WHERE nombre = 'Pendiente';
    SELECT id_estado_tarea INTO v_estado_en_progreso FROM mantenimiento_logistico.EstadoTarea WHERE nombre = 'En progreso';
    SELECT id_estado_tarea INTO v_estado_completada FROM mantenimiento_logistico.EstadoTarea WHERE nombre = 'Completada';

    SELECT ARRAY_AGG(id_orden ORDER BY codigo) INTO v_ordenes FROM mantenimiento_logistico.OrdenMantenimiento;

    FOR contador IN 1..60 LOOP
        IF orden_index > array_length(v_ordenes, 1) THEN
            orden_index := 1;
        END IF;
        
        INSERT INTO mantenimiento_logistico.TareaMantenimiento (id_tarea, descripcion, id_estado_tarea, id_orden) VALUES
        (
            gen_random_uuid()::TEXT,
            CASE 
                WHEN contador % 6 = 1 THEN 'Inspección visual del equipo'
                WHEN contador % 6 = 2 THEN 'Revisión de sistemas hidráulicos'
                WHEN contador % 6 = 3 THEN 'Verificación de sistema eléctrico'
                WHEN contador % 6 = 4 THEN 'Lubricación de componentes'
                WHEN contador % 6 = 5 THEN 'Calibración de instrumentos'
                ELSE 'Prueba de funcionamiento'
            END || ' - Tarea ' || contador,
            CASE 
                WHEN contador <= 30 THEN v_estado_completada
                WHEN contador <= 45 THEN v_estado_en_progreso
                ELSE v_estado_pendiente
            END,
            v_ordenes[orden_index]
        );
        
        orden_index := orden_index + 1;
    END LOOP;
END $$;

-- ASIGNACIÓN DE TÉCNICOS A OPERACIONES (40 asignaciones)
DO $$
DECLARE
    v_operaciones_mant CHAR(36)[];
    v_tecnicos CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT ARRAY_AGG(id_operacion_mantenimiento) INTO v_operaciones_mant FROM mantenimiento_logistico.OperacionMantenimiento;
    SELECT ARRAY_AGG(id_tecnico) INTO v_tecnicos FROM mantenimiento_logistico.Tecnico;

    FOR contador IN 1..40 LOOP
        INSERT INTO mantenimiento_logistico.OperacionMantenimientoTecnico (
            id_operacion_mantenimiento, id_tecnico, fecha_asignacion
        ) VALUES (
            v_operaciones_mant[((contador - 1) % array_length(v_operaciones_mant, 1)) + 1],
            v_tecnicos[((contador - 1) % array_length(v_tecnicos, 1)) + 1],
            '2025-09-01'::DATE + ((contador % 20) * INTERVAL '1 day')
        );
    END LOOP;
END $$;

-- USO DE REPUESTOS EN OPERACIONES (50 registros)
DO $$
DECLARE
    v_operaciones_mant CHAR(36)[];
    v_repuestos CHAR(36)[];
    contador INT := 0;
BEGIN
    SELECT ARRAY_AGG(id_operacion_mantenimiento) INTO v_operaciones_mant FROM mantenimiento_logistico.OperacionMantenimiento;
    SELECT ARRAY_AGG(id_repuesto) INTO v_repuestos FROM mantenimiento_logistico.Repuesto;

    FOR contador IN 1..50 LOOP
        INSERT INTO mantenimiento_logistico.OperacionMantenimientoRepuesto (
            id_operacion_mantenimiento, id_repuesto, fecha_uso, cantidad, precio_unitario
        ) VALUES (
            v_operaciones_mant[((contador - 1) % array_length(v_operaciones_mant, 1)) + 1],
            v_repuestos[((contador - 1) % array_length(v_repuestos, 1)) + 1],
            '2025-09-01'::DATE + ((contador % 25) * INTERVAL '1 day'),
            (RANDOM() * 5 + 1)::INT,
            (RANDOM() * 100 + 10)::DECIMAL(10,2)
        );
    END LOOP;
END $$;

-- ============================================
-- VERIFICACIÓN FINAL
-- ============================================
SELECT '=== VERIFICACIÓN DE DATOS INSERTADOS - MANTENIMIENTO LOGÍSTICO ===' AS titulo;
SELECT 'Contratos: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.Contrato;
SELECT 'Empleados: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.Empleado;
SELECT 'Teléfonos: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.EmpleadoTelefono;
SELECT 'Técnicos: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.Tecnico;
SELECT 'Responsables Solicitud: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.ResponsableSolicitud;
SELECT 'Activos: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.Activo;
SELECT 'Repuestos: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.Repuesto;
SELECT 'Planes Mantenimiento: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.PlanMantenimiento;
SELECT 'Solicitudes Mantenimiento: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.SolicitudMantenimiento;
SELECT 'Operaciones: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.Operacion;
SELECT 'Operaciones Mantenimiento: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.OperacionMantenimiento;
SELECT 'Órdenes Mantenimiento: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.OrdenMantenimiento;
SELECT 'Tareas Mantenimiento: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.TareaMantenimiento;
SELECT 'Asignaciones Técnico-Operación: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.OperacionMantenimientoTecnico;
SELECT 'Uso de Repuestos: ' || COUNT(*) AS resultado FROM mantenimiento_logistico.OperacionMantenimientoRepuesto;
SELECT '=== DATOS INSERTADOS EXITOSAMENTE - MANTENIMIENTO LOGÍSTICO ===' AS titulo;