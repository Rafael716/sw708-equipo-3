-- ============================================
-- SCHEMA: mantenimiento_logistico
-- Sistema de Gestión de Mantenimiento Logístico
-- Módulo 4.1
-- ============================================

DROP SCHEMA IF EXISTS mantenimiento_logistico CASCADE;
CREATE SCHEMA mantenimiento_logistico;

-- ============================================
-- EXTENSION PARA UUIDS
-- ============================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================
-- TABLAS DE DOMINIO (LOOKUP TABLES)
-- ============================================

CREATE TABLE mantenimiento_logistico.EstadoOperacion (
    id_estado_operacion CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.EstadoPlan (
    id_estado_plan CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.EstadoSolicitud (
    id_estado_solicitud CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.EstadoOrden (
    id_estado_orden CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.EstadoTarea (
    id_estado_tarea CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.TipoActivo (
    id_tipo_activo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.EstadoActivo (
    id_estado_activo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.TipoMantenimiento (
    id_tipo_mantenimiento CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.Prioridad (
    id_prioridad CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.EspecialidadEmpleado (
    id_especialidad_empleado CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.EstadoContrato (
    id_estado_contrato CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE mantenimiento_logistico.TipoTelefono (
    id_tipo_telefono CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

CREATE TABLE mantenimiento_logistico.Contrato (
    id_contrato CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    id_estado_contrato CHAR(36) NOT NULL,
    CONSTRAINT fk_contrato_estado FOREIGN KEY (id_estado_contrato)
        REFERENCES mantenimiento_logistico.EstadoContrato(id_estado_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_contrato CHECK (fecha_vencimiento > fecha_emision)
);

CREATE TABLE mantenimiento_logistico.Empleado (
    id_empleado CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_especialidad_empleado CHAR(36) NOT NULL,
    id_contrato CHAR(36) NOT NULL UNIQUE,
    CONSTRAINT fk_empleado_especialidad FOREIGN KEY (id_especialidad_empleado)
        REFERENCES mantenimiento_logistico.EspecialidadEmpleado(id_especialidad_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (id_contrato)
        REFERENCES mantenimiento_logistico.Contrato(id_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_dni_empleado CHECK (dni ~ '^[0-9]{8}$')
);

CREATE TABLE mantenimiento_logistico.EmpleadoTelefono (
    id_empleado_telefono CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_empleado CHAR(36) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_tipo_telefono CHAR(36),
    CONSTRAINT fk_empleado_telefono FOREIGN KEY (id_empleado)
        REFERENCES mantenimiento_logistico.Empleado(id_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_tipo_telefono FOREIGN KEY (id_tipo_telefono)
        REFERENCES mantenimiento_logistico.TipoTelefono(id_tipo_telefono)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_empleado_telefono UNIQUE (id_empleado, telefono),
    CONSTRAINT chk_telefono CHECK (LENGTH(TRIM(telefono)) >= 7)
);

CREATE TABLE mantenimiento_logistico.Tecnico (
    id_tecnico CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_empleado CHAR(36) NOT NULL UNIQUE,
    especialidad VARCHAR(100) NOT NULL,
    CONSTRAINT fk_tecnico_empleado FOREIGN KEY (id_empleado)
        REFERENCES mantenimiento_logistico.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.ResponsableSolicitud (
    id_responsable_solicitud CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_empleado CHAR(36) NOT NULL UNIQUE,
    CONSTRAINT fk_responsable_empleado FOREIGN KEY (id_empleado)
        REFERENCES mantenimiento_logistico.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.Activo (
    id_activo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    id_tipo_activo CHAR(36) NOT NULL,
    id_estado_activo CHAR(36) NOT NULL,
    ubicacion VARCHAR(100),
    CONSTRAINT fk_activo_tipo FOREIGN KEY (id_tipo_activo)
        REFERENCES mantenimiento_logistico.TipoActivo(id_tipo_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_activo_estado FOREIGN KEY (id_estado_activo)
        REFERENCES mantenimiento_logistico.EstadoActivo(id_estado_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.Repuesto (
    id_repuesto CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    stock_minimo INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_stock CHECK (stock >= 0),
    CONSTRAINT chk_stock_minimo CHECK (stock_minimo >= 0)
);

CREATE TABLE mantenimiento_logistico.PlanMantenimiento (
    id_plan_mantenimiento CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_estado_plan CHAR(36) NOT NULL,
    frecuencia VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    id_activo CHAR(36) NOT NULL,
    CONSTRAINT fk_plan_estado FOREIGN KEY (id_estado_plan)
        REFERENCES mantenimiento_logistico.EstadoPlan(id_estado_plan)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_plan_activo FOREIGN KEY (id_activo)
        REFERENCES mantenimiento_logistico.Activo(id_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.SolicitudMantenimiento (
    id_solicitud_mantenimiento CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    descripcion_problema TEXT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    id_prioridad CHAR(36) NOT NULL,
    id_estado_solicitud CHAR(36) NOT NULL,
    id_responsable_solicitud CHAR(36) NOT NULL,
    id_activo CHAR(36) NOT NULL,
    CONSTRAINT fk_solicitud_prioridad FOREIGN KEY (id_prioridad)
        REFERENCES mantenimiento_logistico.Prioridad(id_prioridad)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_estado FOREIGN KEY (id_estado_solicitud)
        REFERENCES mantenimiento_logistico.EstadoSolicitud(id_estado_solicitud)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_responsable FOREIGN KEY (id_responsable_solicitud)
        REFERENCES mantenimiento_logistico.ResponsableSolicitud(id_responsable_solicitud)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_activo FOREIGN KEY (id_activo)
        REFERENCES mantenimiento_logistico.Activo(id_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.Operacion (
    id_operacion CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP,
    id_estado_operacion CHAR(36) NOT NULL,
    CONSTRAINT fk_operacion_estado FOREIGN KEY (id_estado_operacion)
        REFERENCES mantenimiento_logistico.EstadoOperacion(id_estado_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_operacion CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE mantenimiento_logistico.OperacionMantenimiento (
    id_operacion_mantenimiento CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_operacion CHAR(36) NOT NULL UNIQUE,
    id_plan_mantenimiento CHAR(36),
    id_solicitud_mantenimiento CHAR(36),
    CONSTRAINT fk_op_mantenimiento_operacion FOREIGN KEY (id_operacion)
        REFERENCES mantenimiento_logistico.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_mantenimiento_plan FOREIGN KEY (id_plan_mantenimiento)
        REFERENCES mantenimiento_logistico.PlanMantenimiento(id_plan_mantenimiento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_mantenimiento_solicitud FOREIGN KEY (id_solicitud_mantenimiento)
        REFERENCES mantenimiento_logistico.SolicitudMantenimiento(id_solicitud_mantenimiento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.OrdenMantenimiento (
    id_orden CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_generada DATE NOT NULL,
    fecha_programada DATE,
    fecha_cierre DATE,
    id_tipo_mantenimiento CHAR(36) NOT NULL,
    id_estado_orden CHAR(36) NOT NULL,
    id_operacion_mantenimiento CHAR(36) NOT NULL,
    CONSTRAINT fk_orden_tipo_mantenimiento FOREIGN KEY (id_tipo_mantenimiento)
        REFERENCES mantenimiento_logistico.TipoMantenimiento(id_tipo_mantenimiento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_orden_estado FOREIGN KEY (id_estado_orden)
        REFERENCES mantenimiento_logistico.EstadoOrden(id_estado_orden)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_orden_operacion FOREIGN KEY (id_operacion_mantenimiento)
        REFERENCES mantenimiento_logistico.OperacionMantenimiento(id_operacion_mantenimiento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_orden CHECK (
        (fecha_programada IS NULL OR fecha_programada >= fecha_generada) AND
        (fecha_cierre IS NULL OR fecha_cierre >= fecha_generada)
    )
);

CREATE TABLE mantenimiento_logistico.TareaMantenimiento (
    id_tarea CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    descripcion TEXT NOT NULL,
    id_estado_tarea CHAR(36) NOT NULL,
    id_orden CHAR(36) NOT NULL,
    CONSTRAINT fk_tarea_estado FOREIGN KEY (id_estado_tarea)
        REFERENCES mantenimiento_logistico.EstadoTarea(id_estado_tarea)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_tarea_orden FOREIGN KEY (id_orden)
        REFERENCES mantenimiento_logistico.OrdenMantenimiento(id_orden)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

CREATE TABLE mantenimiento_logistico.OperacionMantenimientoTecnico (
    id_operacion_mantenimiento CHAR(36) NOT NULL,
    id_tecnico CHAR(36) NOT NULL,
    fecha_asignacion DATE NOT NULL,
    PRIMARY KEY (id_operacion_mantenimiento, id_tecnico),
    CONSTRAINT fk_op_mant_tec_operacion FOREIGN KEY (id_operacion_mantenimiento)
        REFERENCES mantenimiento_logistico.OperacionMantenimiento(id_operacion_mantenimiento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_mant_tec_tecnico FOREIGN KEY (id_tecnico)
        REFERENCES mantenimiento_logistico.Tecnico(id_tecnico)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.OperacionMantenimientoRepuesto (
    id_operacion_mantenimiento CHAR(36) NOT NULL,
    id_repuesto CHAR(36) NOT NULL,
    fecha_uso DATE NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_operacion_mantenimiento, id_repuesto, fecha_uso),
    CONSTRAINT fk_op_mant_rep_operacion FOREIGN KEY (id_operacion_mantenimiento)
        REFERENCES mantenimiento_logistico.OperacionMantenimiento(id_operacion_mantenimiento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_mant_rep_repuesto FOREIGN KEY (id_repuesto)
        REFERENCES mantenimiento_logistico.Repuesto(id_repuesto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_precio_unitario CHECK (precio_unitario >= 0)
);

-- ============================================
-- ÍNDICES ADICIONALES
-- ============================================

CREATE INDEX idx_empleado_especialidad ON mantenimiento_logistico.Empleado(id_especialidad_empleado);
CREATE INDEX idx_empleado_contrato ON mantenimiento_logistico.Empleado(id_contrato);
CREATE INDEX idx_empleado_telefono_empleado ON mantenimiento_logistico.EmpleadoTelefono(id_empleado);
CREATE INDEX idx_activo_tipo ON mantenimiento_logistico.Activo(id_tipo_activo);
CREATE INDEX idx_activo_estado ON mantenimiento_logistico.Activo(id_estado_activo);
CREATE INDEX idx_operacion_estado ON mantenimiento_logistico.Operacion(id_estado_operacion);
CREATE INDEX idx_operacion_fechas ON mantenimiento_logistico.Operacion(fecha_inicio, fecha_fin);
CREATE INDEX idx_plan_activo ON mantenimiento_logistico.PlanMantenimiento(id_activo);
CREATE INDEX idx_plan_estado ON mantenimiento_logistico.PlanMantenimiento(id_estado_plan);
CREATE INDEX idx_solicitud_activo ON mantenimiento_logistico.SolicitudMantenimiento(id_activo);
CREATE INDEX idx_solicitud_estado ON mantenimiento_logistico.SolicitudMantenimiento(id_estado_solicitud);
CREATE INDEX idx_solicitud_prioridad ON mantenimiento_logistico.SolicitudMantenimiento(id_prioridad);
CREATE INDEX idx_solicitud_fecha ON mantenimiento_logistico.SolicitudMantenimiento(fecha_solicitud);
CREATE INDEX idx_orden_operacion ON mantenimiento_logistico.OrdenMantenimiento(id_operacion_mantenimiento);
CREATE INDEX idx_orden_estado ON mantenimiento_logistico.OrdenMantenimiento(id_estado_orden);
CREATE INDEX idx_tarea_orden ON mantenimiento_logistico.TareaMantenimiento(id_orden);
CREATE INDEX idx_tarea_estado ON mantenimiento_logistico.TareaMantenimiento(id_estado_tarea);
CREATE INDEX idx_repuesto_stock ON mantenimiento_logistico.Repuesto(stock, stock_minimo);

-- ============================================
-- COMENTARIOS EN TABLAS
-- ============================================

COMMENT ON SCHEMA mantenimiento_logistico IS 'Schema para gestión de mantenimiento logístico';
COMMENT ON TABLE mantenimiento_logistico.Empleado IS 'Tabla de empleados del sistema';
COMMENT ON TABLE mantenimiento_logistico.EmpleadoTelefono IS 'Tabla de teléfonos de empleados (multivaluado)';
COMMENT ON TABLE mantenimiento_logistico.Tecnico IS 'Empleados especializados en tareas de mantenimiento técnico';
COMMENT ON TABLE mantenimiento_logistico.ResponsableSolicitud IS 'Empleados autorizados para solicitar operaciones de mantenimiento';
COMMENT ON TABLE mantenimiento_logistico.Operacion IS 'Tabla base de operaciones logísticas';
COMMENT ON TABLE mantenimiento_logistico.OperacionMantenimiento IS 'Operaciones especializadas en mantenimiento de activos';
COMMENT ON TABLE mantenimiento_logistico.Activo IS 'Bienes o recursos sujetos a mantenimiento';
COMMENT ON TABLE mantenimiento_logistico.PlanMantenimiento IS 'Planes de mantenimiento preventivo para activos';
COMMENT ON TABLE mantenimiento_logistico.SolicitudMantenimiento IS 'Solicitudes de mantenimiento correctivo';
COMMENT ON TABLE mantenimiento_logistico.OrdenMantenimiento IS 'Órdenes de trabajo para ejecutar mantenimiento';
COMMENT ON TABLE mantenimiento_logistico.TareaMantenimiento IS 'Tareas específicas dentro de órdenes de mantenimiento';
COMMENT ON TABLE mantenimiento_logistico.Repuesto IS 'Inventario de repuestos para mantenimiento';
COMMENT ON TABLE mantenimiento_logistico.OperacionMantenimientoTecnico IS 'Asignación de técnicos a operaciones de mantenimiento';
COMMENT ON TABLE mantenimiento_logistico.OperacionMantenimientoRepuesto IS 'Registro de repuestos utilizados en operaciones de mantenimiento';