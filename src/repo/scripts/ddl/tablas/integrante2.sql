-- ============================================
-- SCHEMA: personal_tripulacion
-- Sistema de Gestión del Personal y Tripulación 
-- ============================================

DROP SCHEMA IF EXISTS personal_tripulacion CASCADE;
CREATE SCHEMA personal_tripulacion;
SET search_path TO personal_tripulacion;

CREATE TABLE personal_tripulacion.EspecialidadEmpleado (
    id_especialidad_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_especialidad_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE personal_tripulacion.EstatusNavegacion (
    id_estatus_navegacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estatus_navegacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE personal_tripulacion.RolUsuario (
    id_rol_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_rol_usuario_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE personal_tripulacion.EstadoOperacion (
    id_estado_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_operacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);


CREATE TABLE personal_tripulacion.EstadoEmbarcacion (
    id_estado_embarcacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_embarcacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE personal_tripulacion.EstadoContrato (
    id_estado_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_estado_contrato_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE personal_tripulacion.Contrato (
    id_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    id_estado_contrato UUID NOT NULL,
    CONSTRAINT fk_contrato_estado FOREIGN KEY (id_estado_contrato) 
        REFERENCES personal_tripulacion.EstadoContrato(id_estado_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_contrato_fechas CHECK (fecha_vencimiento > fecha_emision)
);

CREATE TABLE personal_tripulacion.Empleado (
    id_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_especialidad_empleado UUID NOT NULL,
    anios_experiencia INT,
    id_contrato UUID NOT NULL UNIQUE,
    CONSTRAINT fk_empleado_especialidad FOREIGN KEY (id_especialidad_empleado) 
        REFERENCES personal_tripulacion.EspecialidadEmpleado(id_especialidad_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (id_contrato) 
        REFERENCES personal_tripulacion.Contrato(id_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_empleado_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_empleado_dni CHECK (dni ~ '^\d{8}$'),
    CONSTRAINT chk_empleado_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_empleado_apellido CHECK (LENGTH(TRIM(apellido)) > 0),
    CONSTRAINT chk_empleado_experiencia CHECK (anios_experiencia IS NULL OR anios_experiencia >= 0)
);


CREATE TABLE personal_tripulacion.Usuario (
    id_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    id_rol_usuario UUID NOT NULL,
    id_empleado UUID NOT NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol_usuario) 
        REFERENCES personal_tripulacion.RolUsuario(id_rol_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_empleado FOREIGN KEY (id_empleado) 
        REFERENCES personal_tripulacion.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_usuario_email CHECK (correo_electronico ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_usuario_contrasena CHECK (LENGTH(contrasena) >= 8)
);


CREATE TABLE personal_tripulacion.Buque (
    id_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    matricula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    id_estado_embarcacion UUID NOT NULL,
    peso DECIMAL(15,2) NOT NULL,
    ubicacion_actual VARCHAR(100),
    CONSTRAINT fk_buque_estado FOREIGN KEY (id_estado_embarcacion) 
        REFERENCES personal_tripulacion.EstadoEmbarcacion(id_estado_embarcacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_buque_matricula CHECK (LENGTH(TRIM(matricula)) > 0),
    CONSTRAINT chk_buque_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_buque_capacidad CHECK (capacidad > 0),
    CONSTRAINT chk_buque_peso CHECK (peso > 0)
);

CREATE TABLE personal_tripulacion.Operacion (
    id_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    id_estado_operacion UUID NOT NULL,
    CONSTRAINT fk_operacion_estado FOREIGN KEY (id_estado_operacion) 
        REFERENCES personal_tripulacion.EstadoOperacion(id_estado_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_operacion_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE personal_tripulacion.OperacionMaritima (
    id_operacion_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    cantidad_contenedores INT NOT NULL,
    id_estatus_navegacion UUID NOT NULL,
    porcentaje_trayecto DECIMAL(5,2) NOT NULL,
    id_buque UUID NOT NULL,
    CONSTRAINT fk_operacion_maritima_operacion FOREIGN KEY (id_operacion) 
        REFERENCES personal_tripulacion.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_maritima_estatus FOREIGN KEY (id_estatus_navegacion) 
        REFERENCES personal_tripulacion.EstatusNavegacion(id_estatus_navegacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_maritima_buque FOREIGN KEY (id_buque) 
        REFERENCES personal_tripulacion.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_maritima_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_operacion_maritima_contenedores CHECK (cantidad_contenedores >= 0),
    CONSTRAINT chk_operacion_maritima_porcentaje CHECK (porcentaje_trayecto BETWEEN 0 AND 100)
);

CREATE TABLE personal_tripulacion.Certificacion (
    id_certificacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT chk_certificacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_certificacion_descripcion CHECK (LENGTH(TRIM(descripcion)) > 0)
);

CREATE TABLE personal_tripulacion.Tripulante (
    id_tripulante UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    nacionalidad VARCHAR(50) NOT NULL,
    CONSTRAINT fk_tripulante_empleado FOREIGN KEY (id_empleado) 
        REFERENCES personal_tripulacion.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_tripulante_nacionalidad CHECK (LENGTH(TRIM(nacionalidad)) > 0)
);

CREATE TABLE personal_tripulacion.UsuarioOperacion (
    id_usuario_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_usuario UUID NOT NULL,
    id_operacion UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    rol_en_operacion VARCHAR(50) NOT NULL,
    CONSTRAINT fk_usuario_operacion_usuario FOREIGN KEY (id_usuario) 
        REFERENCES personal_tripulacion.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_operacion_operacion FOREIGN KEY (id_operacion) 
        REFERENCES personal_tripulacion.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_usuario_operacion UNIQUE (id_usuario, id_operacion)
);

CREATE TABLE personal_tripulacion.CertificacionEmpleado (
    id_certificacion_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL,
    id_certificacion UUID NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    CONSTRAINT fk_certificacion_empleado_empleado FOREIGN KEY (id_empleado) 
        REFERENCES personal_tripulacion.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_certificacion_empleado_certificacion FOREIGN KEY (id_certificacion) 
        REFERENCES personal_tripulacion.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_certificacion_empleado UNIQUE (id_empleado, id_certificacion),
    CONSTRAINT chk_certificacion_empleado_fechas CHECK (fecha_vencimiento > fecha_emision)
);

CREATE TABLE personal_tripulacion.BuqueTripulante (
    id_buque_tripulante UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    id_buque UUID NOT NULL,      
    id_tripulante UUID NOT NULL,         

    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE, 
    hora_asignacion TIME NOT NULL DEFAULT CURRENT_TIME,  


    CONSTRAINT fk_buq_trip_buque FOREIGN KEY (id_buque) 
        REFERENCES personal_tripulacion.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_buq_trip_tripulante FOREIGN KEY (id_tripulante) 
        REFERENCES personal_tripulacion.Tripulante(id_tripulante)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
