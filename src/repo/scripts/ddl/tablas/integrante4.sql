-- ============================================
-- SCHEMA: operaciones_terrestres
-- Sistema de Gestión de Operaciones Terrestres
-- Módulo 4.4
-- ============================================

DROP SCHEMA IF EXISTS operaciones_terrestres CASCADE;
CREATE SCHEMA operaciones_terrestres;

-- ============================================
-- EXTENSION PARA UUIDS
-- ============================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================
-- TABLAS DE DOMINIO (LOOKUP TABLES)
-- ============================================

CREATE TABLE operaciones_terrestres.EstadoOperacion (
    id_estado_operacion CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.TipoActivo (
    id_tipo_activo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.EstadoActivo (
    id_estado_activo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.TipoVehiculo (
    id_tipo_vehiculo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.EstadoVehiculo (
    id_estado_vehiculo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.EspecialidadEmpleado (
    id_especialidad_empleado CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.EstadoContrato (
    id_estado_contrato CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.TipoTelefono (
    id_tipo_telefono CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.TipoIncidencia (
    id_tipo_incidencia CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.EstadoIncidencia (
    id_estado_incidencia CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.TipoDocumento (
    id_tipo_documento CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.TipoReporte (
    id_tipo_reporte CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE operaciones_terrestres.RolUsuario (
    id_rol_usuario CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

CREATE TABLE operaciones_terrestres.Contrato (
    id_contrato CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    id_estado_contrato CHAR(36) NOT NULL,
    CONSTRAINT fk_contrato_estado FOREIGN KEY (id_estado_contrato)
        REFERENCES operaciones_terrestres.EstadoContrato(id_estado_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_contrato CHECK (fecha_vencimiento > fecha_emision)
);

CREATE TABLE operaciones_terrestres.Empleado (
    id_empleado CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_especialidad_empleado CHAR(36) NOT NULL,
    id_contrato CHAR(36) NOT NULL UNIQUE,
    CONSTRAINT fk_empleado_especialidad FOREIGN KEY (id_especialidad_empleado)
        REFERENCES operaciones_terrestres.EspecialidadEmpleado(id_especialidad_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (id_contrato)
        REFERENCES operaciones_terrestres.Contrato(id_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_dni_empleado CHECK (dni ~ '^[0-9]{8}$')
);

CREATE TABLE operaciones_terrestres.EmpleadoTelefono (
    id_empleado_telefono CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_empleado CHAR(36) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_tipo_telefono CHAR(36),
    CONSTRAINT fk_empleado_telefono FOREIGN KEY (id_empleado)
        REFERENCES operaciones_terrestres.Empleado(id_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_tipo_telefono FOREIGN KEY (id_tipo_telefono)
        REFERENCES operaciones_terrestres.TipoTelefono(id_tipo_telefono)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_empleado_telefono UNIQUE (id_empleado, telefono),
    CONSTRAINT chk_telefono CHECK (LENGTH(TRIM(telefono)) >= 7)
);

CREATE TABLE operaciones_terrestres.Usuario (
    id_usuario CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_empleado CHAR(36) NOT NULL UNIQUE,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    id_rol_usuario CHAR(36) NOT NULL,
    CONSTRAINT fk_usuario_empleado FOREIGN KEY (id_empleado)
        REFERENCES operaciones_terrestres.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol_usuario)
        REFERENCES operaciones_terrestres.RolUsuario(id_rol_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_correo CHECK (correo_electronico ~*
        '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE operaciones_terrestres.Operacion (
    id_operacion CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP,
    id_estado_operacion CHAR(36) NOT NULL,
    CONSTRAINT fk_operacion_estado FOREIGN KEY (id_estado_operacion)
        REFERENCES operaciones_terrestres.EstadoOperacion(id_estado_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_operacion CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE operaciones_terrestres.Ruta (
    id_ruta CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,
    tarifa DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_duracion CHECK (duracion > 0),
    CONSTRAINT chk_tarifa CHECK (tarifa >= 0)
);

CREATE TABLE operaciones_terrestres.RutaTerrestre (
    id_ruta_terrestre CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_ruta CHAR(36) NOT NULL UNIQUE,
    CONSTRAINT fk_ruta_terrestre_ruta FOREIGN KEY (id_ruta)
        REFERENCES operaciones_terrestres.Ruta(id_ruta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.Activo (
    id_activo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    id_tipo_activo CHAR(36) NOT NULL,
    id_estado_activo CHAR(36) NOT NULL,
    ubicacion VARCHAR(100),
    CONSTRAINT fk_activo_tipo FOREIGN KEY (id_tipo_activo)
        REFERENCES operaciones_terrestres.TipoActivo(id_tipo_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_activo_estado FOREIGN KEY (id_estado_activo)
        REFERENCES operaciones_terrestres.EstadoActivo(id_estado_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.Vehiculo (
    id_vehiculo CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_activo CHAR(36) NOT NULL UNIQUE,
    placa VARCHAR(20) NOT NULL UNIQUE,
    capacidad_ton DECIMAL(10,2) NOT NULL,
    id_tipo_vehiculo CHAR(36) NOT NULL,
    id_estado_vehiculo CHAR(36) NOT NULL,
    CONSTRAINT fk_vehiculo_activo FOREIGN KEY (id_activo)
        REFERENCES operaciones_terrestres.Activo(id_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_vehiculo_tipo FOREIGN KEY (id_tipo_vehiculo)
        REFERENCES operaciones_terrestres.TipoVehiculo(id_tipo_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_vehiculo_estado FOREIGN KEY (id_estado_vehiculo)
        REFERENCES operaciones_terrestres.EstadoVehiculo(id_estado_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_capacidad CHECK (capacidad_ton > 0)
);

CREATE TABLE operaciones_terrestres.Conductor (
    id_conductor CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_empleado CHAR(36) NOT NULL UNIQUE,
    licencia VARCHAR(20) NOT NULL UNIQUE,
    categoria VARCHAR(20) NOT NULL,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_conductor_empleado FOREIGN KEY (id_empleado)
        REFERENCES operaciones_terrestres.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.OperacionTerrestre (
    id_operacion_terrestre CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    id_operacion CHAR(36) NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_vehiculo CHAR(36) NOT NULL,
    id_ruta_terrestre CHAR(36) NOT NULL,
    id_conductor CHAR(36) NOT NULL,
    costo_operacion_terrestre DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_op_terrestre_operacion FOREIGN KEY (id_operacion)
        REFERENCES operaciones_terrestres.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_terrestre_vehiculo FOREIGN KEY (id_vehiculo)
        REFERENCES operaciones_terrestres.Vehiculo(id_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_terrestre_ruta FOREIGN KEY (id_ruta_terrestre)
        REFERENCES operaciones_terrestres.RutaTerrestre(id_ruta_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_terrestre_conductor FOREIGN KEY (id_conductor)
        REFERENCES operaciones_terrestres.Conductor(id_conductor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_costo CHECK (costo_operacion_terrestre >= 0)
);

CREATE TABLE operaciones_terrestres.ChecklistDespacho (
    id_checklist CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    observaciones TEXT,
    combustible VARCHAR(50) NOT NULL,
    frenos VARCHAR(50) NOT NULL,
    id_operacion_terrestre CHAR(36) NOT NULL UNIQUE,
    CONSTRAINT fk_checklist_operacion FOREIGN KEY (id_operacion_terrestre)
        REFERENCES operaciones_terrestres.OperacionTerrestre(id_operacion_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.Incidencia (
    id_incidencia CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_incidencia CHAR(36) NOT NULL,
    descripcion TEXT NOT NULL,
    grado_severidad INT NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estado_incidencia CHAR(36) NOT NULL,
    id_operacion CHAR(36) NOT NULL,
    id_usuario CHAR(36) NOT NULL,
    CONSTRAINT fk_incidencia_tipo FOREIGN KEY (id_tipo_incidencia)
        REFERENCES operaciones_terrestres.TipoIncidencia(id_tipo_incidencia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_estado FOREIGN KEY (id_estado_incidencia)
        REFERENCES operaciones_terrestres.EstadoIncidencia(id_estado_incidencia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_operacion FOREIGN KEY (id_operacion)
        REFERENCES operaciones_terrestres.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_usuario FOREIGN KEY (id_usuario)
        REFERENCES operaciones_terrestres.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_severidad CHECK (grado_severidad BETWEEN 1 AND 5)
);

CREATE TABLE operaciones_terrestres.DocumentacionOperacion (
    id_documento CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    ruta_archivo VARCHAR(255) NOT NULL,
    fecha_emision DATE NOT NULL,
    id_tipo_documento CHAR(36) NOT NULL,
    CONSTRAINT fk_documento_tipo FOREIGN KEY (id_tipo_documento)
        REFERENCES operaciones_terrestres.TipoDocumento(id_tipo_documento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.OperacionDocumento (
    id_operacion CHAR(36) NOT NULL,
    id_documento CHAR(36) NOT NULL,
    PRIMARY KEY (id_operacion, id_documento),
    CONSTRAINT fk_op_doc_operacion FOREIGN KEY (id_operacion)
        REFERENCES operaciones_terrestres.Operacion(id_operacion)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_doc_documento FOREIGN KEY (id_documento)
        REFERENCES operaciones_terrestres.DocumentacionOperacion(id_documento)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.ReporteTransporte (
    id_reporte CHAR(36) PRIMARY KEY DEFAULT gen_random_uuid()::TEXT,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_reporte CHAR(36) NOT NULL,
    fecha_generado DATE NOT NULL,
    id_operacion_terrestre CHAR(36) NOT NULL UNIQUE,
    CONSTRAINT fk_reporte_tipo FOREIGN KEY (id_tipo_reporte)
        REFERENCES operaciones_terrestres.TipoReporte(id_tipo_reporte)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reporte_operacion FOREIGN KEY (id_operacion_terrestre)
        REFERENCES operaciones_terrestres.OperacionTerrestre(id_operacion_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================
-- ÍNDICES ADICIONALES
-- ============================================

CREATE INDEX idx_empleado_especialidad ON operaciones_terrestres.Empleado(id_especialidad_empleado);
CREATE INDEX idx_empleado_contrato ON operaciones_terrestres.Empleado(id_contrato);
CREATE INDEX idx_empleado_telefono_empleado ON operaciones_terrestres.EmpleadoTelefono(id_empleado);
CREATE INDEX idx_conductor_disponibilidad ON operaciones_terrestres.Conductor(disponibilidad);
CREATE INDEX idx_vehiculo_estado ON operaciones_terrestres.Vehiculo(id_estado_vehiculo);
CREATE INDEX idx_operacion_estado ON operaciones_terrestres.Operacion(id_estado_operacion);
CREATE INDEX idx_operacion_fechas ON operaciones_terrestres.Operacion(fecha_inicio, fecha_fin);
CREATE INDEX idx_incidencia_operacion ON operaciones_terrestres.Incidencia(id_operacion);
CREATE INDEX idx_incidencia_fecha ON operaciones_terrestres.Incidencia(fecha_hora);
CREATE INDEX idx_incidencia_estado ON operaciones_terrestres.Incidencia(id_estado_incidencia);

-- ============================================
-- COMENTARIOS EN TABLAS
-- ============================================

COMMENT ON SCHEMA operaciones_terrestres IS 'Schema para gestión de operaciones de transporte terrestre';
COMMENT ON TABLE operaciones_terrestres.Empleado IS 'Tabla de empleados del sistema';
COMMENT ON TABLE operaciones_terrestres.EmpleadoTelefono IS 'Tabla de teléfonos de empleados (multivaluado)';
COMMENT ON TABLE operaciones_terrestres.Operacion IS 'Tabla base de operaciones logísticas';
COMMENT ON TABLE operaciones_terrestres.OperacionTerrestre IS 'Operaciones especializadas en transporte terrestre';
COMMENT ON TABLE operaciones_terrestres.Vehiculo IS 'Vehículos utilizados en operaciones terrestres';
COMMENT ON TABLE operaciones_terrestres.Conductor IS 'Conductores asignados a operaciones';
COMMENT ON TABLE operaciones_terrestres.Incidencia IS 'Registro de incidencias durante operaciones';