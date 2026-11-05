-- ============================================
-- SISTEMA MARÍTIMO CONSOLIDADO
-- Consolidación de 6 Schemas
-- PostgreSQL con UUID
-- ============================================

-- Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================
-- SCHEMA: shared
-- Tablas compartidas entre múltiples schemas
-- ============================================

DROP SCHEMA IF EXISTS shared CASCADE;
CREATE SCHEMA shared;

-- ============================================
-- LOOKUP TABLES - SCHEMA SHARED
-- ============================================

-- Tablas compartidas por 6 schemas
CREATE TABLE shared.EspecialidadEmpleado (
    id_especialidad_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_especialidad_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoContrato (
    id_estado_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_contrato_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoOperacion (
    id_estado_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_operacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tablas compartidas por 5 schemas
CREATE TABLE shared.TipoTelefono (
    id_tipo_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_tipo_telefono_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tablas compartidas por 4 schemas
CREATE TABLE shared.EstadoEmbarcacion (
    id_estado_embarcacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_embarcacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.RolUsuario (
    id_rol_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_rol_usuario_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tablas compartidas por 3 schemas
CREATE TABLE shared.EstadoContenedor (
    id_estado_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_contenedor_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoContenedor (
    id_tipo_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_tipo_contenedor_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_tipo_contenedor_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_tipo_contenedor_costo CHECK (costo >= 0)
);

CREATE TABLE shared.TipoIncidencia (
    id_tipo_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_tipo_incidencia_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoActivo (
    id_tipo_activo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_tipo_activo_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoActivo (
    id_estado_activo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_activo_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tablas compartidas por 2 schemas
CREATE TABLE shared.EstatusNavegacion (
    id_estatus_navegacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estatus_navegacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.Prioridad (
    id_prioridad UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_prioridad_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoVehiculo (
    id_tipo_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_tipo_vehiculo_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoVehiculo (
    id_estado_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_vehiculo_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoIncidencia (
    id_estado_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_incidencia_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoDocumento (
    id_tipo_documento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_tipo_documento_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoReserva (
    id_estado_reserva UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.TipoEquipoPortuario (
    id_tipo_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_tipo_equipo_portuario_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoEquipoPortuario (
    id_estado_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_equipo_portuario_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EstadoInspeccion (
    id_estado_inspeccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_estado_inspeccion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoInspeccion (
    id_tipo_inspeccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_inspeccion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoHallazgo (
    id_tipo_hallazgo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_hallazgo_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoOperacionPortuaria (
    id_tipo_operacion_portuaria UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_operacion_portuaria_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.Turno (
    id_turno UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_turno_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.EquipoProteccion (
    id_equipo_proteccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_equipo_proteccion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.CondicionOperativa (
    id_condicion_operativa UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_condicion_operativa_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

CREATE TABLE shared.TipoReporte (
    id_tipo_reporte UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.EstadoPlan (
    id_estado_plan UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.EstadoSolicitud (
    id_estado_solicitud UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.EstadoOrden (
    id_estado_orden UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.EstadoTarea (
    id_estado_tarea UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.TipoMantenimiento (
    id_tipo_mantenimiento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.EstadoEntrega (
    id_estado_entrega UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.TipoSensor (
    id_tipo_sensor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.RolSensor (
    id_rol_sensor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.TipoNotificacion (
    id_tipo_notificacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE shared.EstadoLectura (
    id_estado_lectura UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_lectura_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- ============================================
-- TABLAS PRINCIPALES - SCHEMA SHARED
-- ============================================

CREATE TABLE shared.Contrato (
    id_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    id_estado_contrato UUID NOT NULL,
    CONSTRAINT fk_contrato_estado FOREIGN KEY (id_estado_contrato) 
        REFERENCES shared.EstadoContrato(id_estado_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_contrato_fechas CHECK (fecha_vencimiento > fecha_emision)
);

CREATE TABLE shared.Empleado (
    id_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_especialidad_empleado UUID NOT NULL,
    id_contrato UUID NOT NULL UNIQUE,
    CONSTRAINT fk_empleado_especialidad FOREIGN KEY (id_especialidad_empleado) 
        REFERENCES shared.EspecialidadEmpleado(id_especialidad_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (id_contrato) 
        REFERENCES shared.Contrato(id_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_empleado_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_empleado_dni CHECK (dni ~ '^\d{8}$'),
    CONSTRAINT chk_empleado_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_empleado_apellido CHECK (LENGTH(TRIM(apellido)) > 0)
);

CREATE TABLE shared.EmpleadoTelefono (
    id_empleado_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_tipo_telefono UUID,
    CONSTRAINT fk_empleado_telefono_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_telefono_tipo FOREIGN KEY (id_tipo_telefono) 
        REFERENCES shared.TipoTelefono(id_tipo_telefono)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_empleado_telefono UNIQUE (id_empleado, telefono),
    CONSTRAINT chk_telefono CHECK (LENGTH(TRIM(telefono)) >= 7)
);

CREATE TABLE shared.Usuario (
    id_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    id_rol_usuario UUID NOT NULL,
    id_empleado UUID NOT NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol_usuario) 
        REFERENCES shared.RolUsuario(id_rol_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_usuario_email CHECK (correo_electronico ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_usuario_contrasena CHECK (LENGTH(contrasena) >= 8)
);

CREATE TABLE shared.Operacion (
    id_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    id_estado_operacion UUID NOT NULL,
    CONSTRAINT fk_operacion_estado FOREIGN KEY (id_estado_operacion) 
        REFERENCES shared.EstadoOperacion(id_estado_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_operacion_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE shared.Buque (
    id_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    matricula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    id_estado_embarcacion UUID NOT NULL,
    peso DECIMAL(15,2) NOT NULL,
    ubicacion_actual VARCHAR(100),
    CONSTRAINT fk_buque_estado FOREIGN KEY (id_estado_embarcacion) 
        REFERENCES shared.EstadoEmbarcacion(id_estado_embarcacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_buque_matricula CHECK (LENGTH(TRIM(matricula)) > 0),
    CONSTRAINT chk_buque_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_buque_capacidad CHECK (capacidad > 0),
    CONSTRAINT chk_buque_peso CHECK (peso > 0)
);

CREATE TABLE shared.Contenedor (
    id_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    peso DECIMAL(10,2) NOT NULL,
    capacidad DECIMAL(10,2) NOT NULL,
    dimensiones VARCHAR(50) NOT NULL,
    id_estado_contenedor UUID NOT NULL,
    id_tipo_contenedor UUID NOT NULL,
    CONSTRAINT fk_contenedor_estado FOREIGN KEY (id_estado_contenedor) 
        REFERENCES shared.EstadoContenedor(id_estado_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_contenedor_tipo FOREIGN KEY (id_tipo_contenedor) 
        REFERENCES shared.TipoContenedor(id_tipo_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_peso CHECK (peso >= 0),
    CONSTRAINT chk_capacidad CHECK (capacidad > 0 AND peso <= capacidad)
);

CREATE TABLE shared.ContenedorMercancia (
    id_contenedor_mercancia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenedor UUID NOT NULL,
    tipo_mercancia VARCHAR(100) NOT NULL,
    CONSTRAINT fk_contenedor_mercancia_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uk_contenedor_mercancia UNIQUE (id_contenedor, tipo_mercancia)
);

CREATE TABLE shared.Certificacion (
    id_certificacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT chk_certificacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_certificacion_descripcion CHECK (LENGTH(TRIM(descripcion)) > 0)
);

CREATE TABLE shared.CertificacionBuque (
    id_certificacion_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_buque UUID NOT NULL,
    id_certificacion UUID NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    CONSTRAINT fk_cert_buque_buque FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_cert_buque_cert FOREIGN KEY (id_certificacion) 
        REFERENCES shared.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_buque_certificacion UNIQUE (id_buque, id_certificacion),
    CONSTRAINT chk_fechas_cert CHECK (fecha_vencimiento >= fecha_emision)
);

CREATE TABLE shared.CertificacionEmpleado (
    id_certificacion_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL,
    id_certificacion UUID NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    CONSTRAINT fk_certificacion_empleado_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_certificacion_empleado_certificacion FOREIGN KEY (id_certificacion) 
        REFERENCES shared.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_certificacion_empleado UNIQUE (id_empleado, id_certificacion),
    CONSTRAINT chk_certificacion_empleado_fechas CHECK (fecha_vencimiento > fecha_emision)
);

CREATE TABLE shared.OperacionMaritima (
    id_operacion_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    cantidad_contenedores INT NOT NULL,
    id_estatus_navegacion UUID NOT NULL,
    porcentaje_trayecto DECIMAL(5,2) NOT NULL,
    id_buque UUID NOT NULL,
    CONSTRAINT fk_operacion_maritima_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_maritima_estatus FOREIGN KEY (id_estatus_navegacion) 
        REFERENCES shared.EstatusNavegacion(id_estatus_navegacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_maritima_buque FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_maritima_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_operacion_maritima_contenedores CHECK (cantidad_contenedores >= 0),
    CONSTRAINT chk_operacion_maritima_porcentaje CHECK (porcentaje_trayecto BETWEEN 0 AND 100)
);

CREATE TABLE shared.Tripulante (
    id_tripulante UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    nacionalidad VARCHAR(50) NOT NULL,
    CONSTRAINT fk_tripulante_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_tripulante_nacionalidad CHECK (LENGTH(TRIM(nacionalidad)) > 0)
);

CREATE TABLE shared.UsuarioOperacion (
    id_usuario_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_usuario UUID NOT NULL,
    id_operacion UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    rol_en_operacion VARCHAR(50) NOT NULL,
    CONSTRAINT fk_usuario_operacion_usuario FOREIGN KEY (id_usuario) 
        REFERENCES shared.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_operacion_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_usuario_operacion UNIQUE (id_usuario, id_operacion)
);

CREATE TABLE shared.Ruta (
    id_ruta UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,
    tarifa DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_ruta_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_ruta_origen CHECK (LENGTH(TRIM(origen)) > 0),
    CONSTRAINT chk_ruta_destino CHECK (LENGTH(TRIM(destino)) > 0),
    CONSTRAINT chk_duracion CHECK (duracion > 0),
    CONSTRAINT chk_tarifa CHECK (tarifa >= 0)
);

CREATE TABLE shared.OperacionTerrestre (
    id_operacion_terrestre UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    costo_operacion_terrestre DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_operacion_terrestre_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_costo_operacion CHECK (costo_operacion_terrestre >= 0)
);

CREATE TABLE shared.Activo (
    id_activo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    id_tipo_activo UUID NOT NULL,
    id_estado_activo UUID NOT NULL,
    ubicacion VARCHAR(100),
    CONSTRAINT fk_activo_tipo FOREIGN KEY (id_tipo_activo) 
        REFERENCES shared.TipoActivo(id_tipo_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_activo_estado FOREIGN KEY (id_estado_activo) 
        REFERENCES shared.EstadoActivo(id_estado_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE shared.Vehiculo (
    id_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_activo UUID NOT NULL UNIQUE,
    placa VARCHAR(20) NOT NULL UNIQUE,
    capacidad_ton DECIMAL(10,2) NOT NULL,
    id_tipo_vehiculo UUID NOT NULL,
    id_estado_vehiculo UUID NOT NULL,
    CONSTRAINT fk_vehiculo_activo FOREIGN KEY (id_activo) 
        REFERENCES shared.Activo(id_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_vehiculo_tipo FOREIGN KEY (id_tipo_vehiculo) 
        REFERENCES shared.TipoVehiculo(id_tipo_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_vehiculo_estado FOREIGN KEY (id_estado_vehiculo) 
        REFERENCES shared.EstadoVehiculo(id_estado_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_capacidad CHECK (capacidad_ton > 0)
);

CREATE TABLE shared.Incidencia (
    id_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_incidencia UUID NOT NULL,
    descripcion TEXT NOT NULL,
    grado_severidad INT NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estado_incidencia UUID NOT NULL,
    id_operacion UUID NOT NULL,
    id_usuario UUID NOT NULL,
    CONSTRAINT fk_incidencia_tipo FOREIGN KEY (id_tipo_incidencia) 
        REFERENCES shared.TipoIncidencia(id_tipo_incidencia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_estado FOREIGN KEY (id_estado_incidencia) 
        REFERENCES shared.EstadoIncidencia(id_estado_incidencia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_usuario FOREIGN KEY (id_usuario) 
        REFERENCES shared.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_severidad CHECK (grado_severidad BETWEEN 1 AND 5)
);

-- ============================================
-- SCHEMA: gestion_reserva
-- ============================================

DROP SCHEMA IF EXISTS gestion_reserva CASCADE;
CREATE SCHEMA gestion_reserva;

-- Tablas principales
CREATE TABLE gestion_reserva.AgenteReservas (
    id_agente_reservas UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    CONSTRAINT fk_agente_reservas_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE gestion_reserva.Cliente (
    id_cliente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ruc CHAR(11) NOT NULL UNIQUE,
    razon_social VARCHAR(150) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    email VARCHAR(100),
    CONSTRAINT chk_ruc CHECK (ruc ~ '^[0-9]{11}$'),
    CONSTRAINT chk_email CHECK (email IS NULL OR email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE gestion_reserva.ClienteTelefono (
    id_cliente_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_cliente UUID NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_tipo_telefono UUID,
    CONSTRAINT fk_cliente_telefono_cliente FOREIGN KEY (id_cliente) 
        REFERENCES gestion_reserva.Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_cliente_telefono_tipo FOREIGN KEY (id_tipo_telefono) 
        REFERENCES shared.TipoTelefono(id_tipo_telefono)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_cliente_telefono UNIQUE (id_cliente, telefono),
    CONSTRAINT chk_telefono_cliente CHECK (LENGTH(TRIM(telefono)) >= 7)
);

CREATE TABLE gestion_reserva.AtencionCliente (
    id_atencion_cliente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_cliente UUID NOT NULL,
    id_agente_reservas UUID NOT NULL,
    fecha_atencion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_atencion_cliente_cliente FOREIGN KEY (id_cliente) 
        REFERENCES gestion_reserva.Cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_atencion_cliente_agente FOREIGN KEY (id_agente_reservas) 
        REFERENCES gestion_reserva.AgenteReservas(id_agente_reservas)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE gestion_reserva.Reserva (
    id_reserva UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,
    id_estado_reserva UUID NOT NULL,
    pago_total DECIMAL(10,2),
    ruc_cliente CHAR(11) NOT NULL,
    id_agente_reservas UUID NOT NULL,
    id_buque UUID NOT NULL,
    id_ruta UUID NOT NULL,
    CONSTRAINT fk_reserva_estado FOREIGN KEY (id_estado_reserva) 
        REFERENCES shared.EstadoReserva(id_estado_reserva)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_cliente FOREIGN KEY (ruc_cliente) 
        REFERENCES gestion_reserva.Cliente(ruc)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_agente FOREIGN KEY (id_agente_reservas) 
        REFERENCES gestion_reserva.AgenteReservas(id_agente_reservas)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_buque FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_ruta FOREIGN KEY (id_ruta) 
        REFERENCES shared.Ruta(id_ruta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_pago_total CHECK (pago_total IS NULL OR pago_total >= 0)
);

CREATE TABLE gestion_reserva.ReservaContenedor (
    id_reserva_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_reserva UUID NOT NULL,
    id_contenedor UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    cantidad INT NOT NULL DEFAULT 1,
    CONSTRAINT uk_reserva_contenedor UNIQUE (id_reserva, id_contenedor),
    CONSTRAINT fk_reserva_cont_reserva FOREIGN KEY (id_reserva) 
        REFERENCES gestion_reserva.Reserva(id_reserva)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_cont_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_cantidad CHECK (cantidad > 0)
);

CREATE TABLE gestion_reserva.ReservaOperacionMaritima (
    id_reserva_operacion_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_reserva UUID NOT NULL,
    id_operacion_maritima UUID NOT NULL,
    fecha_vinculacion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT uk_reserva_op_maritima UNIQUE (id_reserva, id_operacion_maritima),
    CONSTRAINT fk_res_op_mar_reserva FOREIGN KEY (id_reserva) 
        REFERENCES gestion_reserva.Reserva(id_reserva)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_res_op_mar_operacion FOREIGN KEY (id_operacion_maritima) 
        REFERENCES shared.OperacionMaritima(id_operacion_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE gestion_reserva.ReservaOperacionTerrestre (
    id_reserva_operacion_terrestre UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_reserva UUID NOT NULL,
    id_operacion_terrestre UUID NOT NULL,
    fecha_vinculacion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT uk_reserva_op_terrestre UNIQUE (id_reserva, id_operacion_terrestre),
    CONSTRAINT fk_res_op_terr_reserva FOREIGN KEY (id_reserva) 
        REFERENCES gestion_reserva.Reserva(id_reserva)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_res_op_terr_operacion FOREIGN KEY (id_operacion_terrestre) 
        REFERENCES shared.OperacionTerrestre(id_operacion_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================
-- SCHEMA: personal_tripulacion
-- ============================================

DROP SCHEMA IF EXISTS personal_tripulacion CASCADE;
CREATE SCHEMA personal_tripulacion;

CREATE TABLE personal_tripulacion.BuqueTripulante (
    id_buque_tripulante UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_buque UUID NOT NULL,      
    id_tripulante UUID NOT NULL,         
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE, 
    hora_asignacion TIME NOT NULL DEFAULT CURRENT_TIME,  
    CONSTRAINT fk_buq_trip_buque FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_buq_trip_tripulante FOREIGN KEY (id_tripulante) 
        REFERENCES shared.Tripulante(id_tripulante)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================
-- SCHEMA: gestion_maritima
-- ============================================

DROP SCHEMA IF EXISTS gestion_maritima CASCADE;
CREATE SCHEMA gestion_maritima;

-- Tablas principales
CREATE TABLE gestion_maritima.Puerto (
    id_puerto UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    direccion TEXT NOT NULL,
    CONSTRAINT chk_puerto_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_puerto_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_puerto_pais CHECK (LENGTH(TRIM(pais)) > 0)
);

CREATE TABLE gestion_maritima.Muelle (
    id_muelle UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    ubicacion VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    id_puerto UUID NOT NULL,
    CONSTRAINT fk_muelle_puerto FOREIGN KEY (id_puerto) 
        REFERENCES gestion_maritima.Puerto(id_puerto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_muelle_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_muelle_capacidad CHECK (capacidad > 0)
);

CREATE TABLE gestion_maritima.EquipoPortuario (
    id_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    capacidad DECIMAL(10,2) NOT NULL,
    id_tipo_equipo_portuario UUID NOT NULL,
    id_estado_equipo_portuario UUID NOT NULL,
    ubicacion VARCHAR(100),
    CONSTRAINT fk_equipo_portuario_tipo FOREIGN KEY (id_tipo_equipo_portuario) 
        REFERENCES shared.TipoEquipoPortuario(id_tipo_equipo_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_equipo_portuario_estado FOREIGN KEY (id_estado_equipo_portuario) 
        REFERENCES shared.EstadoEquipoPortuario(id_estado_equipo_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_equipo_portuario_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_equipo_portuario_capacidad CHECK (capacidad > 0)
);

CREATE TABLE gestion_maritima.TrabajadorPortuario (
    id_trabajador_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    id_turno UUID NOT NULL,
    CONSTRAINT fk_trabajador_port_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_trabajador_port_turno FOREIGN KEY (id_turno) 
        REFERENCES shared.Turno(id_turno)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE gestion_maritima.OperacionPortuaria (
    id_operacion_portuaria UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_puerto UUID NOT NULL,
    id_muelle UUID NOT NULL,
    id_tipo_operacion_portuaria UUID NOT NULL,
    id_buque UUID NOT NULL,
    CONSTRAINT fk_operacion_portuaria_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_portuaria_puerto FOREIGN KEY (id_puerto) 
        REFERENCES gestion_maritima.Puerto(id_puerto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_portuaria_muelle FOREIGN KEY (id_muelle) 
        REFERENCES gestion_maritima.Muelle(id_muelle)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_portuaria_tipo FOREIGN KEY (id_tipo_operacion_portuaria) 
        REFERENCES shared.TipoOperacionPortuaria(id_tipo_operacion_portuaria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_portuaria_buque FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_portuaria_codigo CHECK (LENGTH(TRIM(codigo)) > 0)
);

CREATE TABLE gestion_maritima.Inspeccion (
    id_inspeccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_tipo_inspeccion UUID NOT NULL,
    id_estado_inspeccion UUID NOT NULL,
    id_prioridad UUID NOT NULL,
    id_operacion UUID NOT NULL,
    id_usuario UUID NOT NULL,
    CONSTRAINT fk_inspeccion_tipo FOREIGN KEY (id_tipo_inspeccion) 
        REFERENCES shared.TipoInspeccion(id_tipo_inspeccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_estado FOREIGN KEY (id_estado_inspeccion) 
        REFERENCES shared.EstadoInspeccion(id_estado_inspeccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_prioridad FOREIGN KEY (id_prioridad) 
        REFERENCES shared.Prioridad(id_prioridad)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_usuario FOREIGN KEY (id_usuario) 
        REFERENCES shared.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_inspeccion_codigo CHECK (LENGTH(TRIM(codigo)) > 0)
);

CREATE TABLE gestion_maritima.Hallazgo (
    id_hallazgo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_hallazgo UUID NOT NULL,
    nivel_gravedad INT NOT NULL,
    descripcion TEXT NOT NULL,
    accion_sugerida TEXT,
    id_inspeccion UUID NOT NULL,
    CONSTRAINT fk_hallazgo_tipo FOREIGN KEY (id_tipo_hallazgo) 
        REFERENCES shared.TipoHallazgo(id_tipo_hallazgo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_hallazgo_inspeccion FOREIGN KEY (id_inspeccion) 
        REFERENCES gestion_maritima.Inspeccion(id_inspeccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_hallazgo_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_hallazgo_gravedad CHECK (nivel_gravedad BETWEEN 1 AND 5),
    CONSTRAINT chk_hallazgo_descripcion CHECK (LENGTH(TRIM(descripcion)) > 0)
);

CREATE TABLE gestion_maritima.TripulanteIdioma (
    id_tripulante_idioma UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_tripulante UUID NOT NULL,
    idioma VARCHAR(50) NOT NULL,
    nivel VARCHAR(20),
    CONSTRAINT fk_tripulante_idioma_tripulante FOREIGN KEY (id_tripulante) 
        REFERENCES shared.Tripulante(id_tripulante)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_tripulante_idioma UNIQUE (id_tripulante, idioma),
    CONSTRAINT chk_tripulante_idioma_idioma CHECK (LENGTH(TRIM(idioma)) > 0),
    CONSTRAINT chk_tripulante_idioma_nivel CHECK (nivel IS NULL OR nivel IN ('Básico', 'Intermedio', 'Avanzado', 'Nativo'))
);

CREATE TABLE gestion_maritima.OperacionMaritimaCondicion (
    id_operacion_maritima_condicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_maritima UUID NOT NULL,
    id_condicion_operativa UUID NOT NULL,
    CONSTRAINT fk_operacion_mar_cond_operacion FOREIGN KEY (id_operacion_maritima) 
        REFERENCES shared.OperacionMaritima(id_operacion_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_mar_cond_condicion FOREIGN KEY (id_condicion_operativa) 
        REFERENCES shared.CondicionOperativa(id_condicion_operativa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_maritima_condicion UNIQUE (id_operacion_maritima, id_condicion_operativa)
);

CREATE TABLE gestion_maritima.OperacionEmpleado (
    id_operacion_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL,
    id_empleado UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_desasignacion DATE,
    CONSTRAINT fk_operacion_empleado_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_empleado_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_empleado_fecha UNIQUE (id_operacion, id_empleado, fecha_asignacion),
    CONSTRAINT chk_operacion_empleado_fechas CHECK (fecha_desasignacion IS NULL OR fecha_desasignacion >= fecha_asignacion)
);

CREATE TABLE gestion_maritima.TrabajadorPortuarioEquipoPortuario (
    id_trabajador_portuario_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_trabajador_portuario UUID NOT NULL,
    id_equipo_portuario UUID NOT NULL,
    CONSTRAINT fk_trabajador_equipo_port_trabajador FOREIGN KEY (id_trabajador_portuario) 
        REFERENCES gestion_maritima.TrabajadorPortuario(id_trabajador_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_trabajador_equipo_port_equipo FOREIGN KEY (id_equipo_portuario) 
        REFERENCES gestion_maritima.EquipoPortuario(id_equipo_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_trabajador_equipo_portuario UNIQUE (id_trabajador_portuario, id_equipo_portuario)
);

CREATE TABLE gestion_maritima.OperacionContenedor (
    id_operacion_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL,
    id_contenedor UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_operacion_contenedor_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_contenedor_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_contenedor_fecha UNIQUE (id_operacion, id_contenedor, fecha_asignacion)
);

CREATE TABLE gestion_maritima.OperacionEquipoPortuario (
    id_operacion_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_portuaria UUID NOT NULL,
    id_equipo_portuario UUID NOT NULL,
    id_trabajador_portuario UUID NOT NULL,
    fecha_asignacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion TIMESTAMP,
    CONSTRAINT fk_operacion_equipo_port_operacion FOREIGN KEY (id_operacion_portuaria) 
        REFERENCES gestion_maritima.OperacionPortuaria(id_operacion_portuaria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_equipo_port_equipo FOREIGN KEY (id_equipo_portuario) 
        REFERENCES gestion_maritima.EquipoPortuario(id_equipo_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_equipo_port_trabajador FOREIGN KEY (id_trabajador_portuario) 
        REFERENCES gestion_maritima.TrabajadorPortuario(id_trabajador_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_equipo_fecha UNIQUE (id_operacion_portuaria, id_equipo_portuario, fecha_asignacion),
    CONSTRAINT chk_operacion_equipo_port_fechas CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_asignacion)
);

CREATE TABLE gestion_maritima.CertificacionAduanera (
    id_certificacion_aduanera UUID PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    pais_aplicacion VARCHAR(100) NOT NULL,
    fecha_emision  TIMESTAMP WITH TIME ZONE NOT NULL,
    fecha_expiracion TIMESTAMP WITH TIME ZONE NOT NULL,
    CONSTRAINT fk_certificacion_aduanera_cert FOREIGN KEY (id_certificacion_aduanera) 
        REFERENCES shared.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_cert_aduanera_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_cert_aduanera_descripcion CHECK (LENGTH(TRIM(descripcion)) > 0),
    CONSTRAINT chk_cert_aduanera_fechas CHECK (fecha_expiracion > fecha_emision)
);

CREATE TABLE gestion_maritima.RutaMaritima (
    id_ruta_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_ruta UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    distancia DECIMAL(10,2) NOT NULL,
    id_puerto_origen UUID NOT NULL,
    id_puerto_destino UUID NOT NULL,
    CONSTRAINT fk_ruta_maritima_ruta FOREIGN KEY (id_ruta) 
        REFERENCES shared.Ruta(id_ruta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_ruta_maritima_puerto_origen FOREIGN KEY (id_puerto_origen) 
        REFERENCES gestion_maritima.Puerto(id_puerto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_ruta_maritima_puerto_destino FOREIGN KEY (id_puerto_destino) 
        REFERENCES gestion_maritima.Puerto(id_puerto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_ruta_maritima_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_ruta_maritima_distancia CHECK (distancia > 0),
    CONSTRAINT chk_ruta_maritima_puertos CHECK (id_puerto_origen != id_puerto_destino)
);

CREATE TABLE gestion_maritima.OperacionRutaMaritima (
    id_operacion_ruta_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_maritima UUID NOT NULL UNIQUE,
    id_ruta_maritima UUID NOT NULL,
    id_muelle_origen UUID NOT NULL,
    id_muelle_destino UUID NOT NULL,
    CONSTRAINT fk_operacion_ruta_maritima_operacion FOREIGN KEY (id_operacion_maritima) 
        REFERENCES shared.OperacionMaritima(id_operacion_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_ruta_maritima_ruta FOREIGN KEY (id_ruta_maritima) 
        REFERENCES gestion_maritima.RutaMaritima(id_ruta_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_ruta_maritima_muelle_origen FOREIGN KEY (id_muelle_origen) 
        REFERENCES gestion_maritima.Muelle(id_muelle)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_ruta_maritima_muelle_destino FOREIGN KEY (id_muelle_destino) 
        REFERENCES gestion_maritima.Muelle(id_muelle)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_ruta_maritima_muelles CHECK (id_muelle_origen != id_muelle_destino)
);

CREATE TABLE gestion_maritima.Estiba (
    id_estiba UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_portuaria UUID NOT NULL,
    ubicacion VARCHAR(50) NOT NULL,
    zona_buque VARCHAR(30) NOT NULL,
    id_contenedor UUID NOT NULL,
    CONSTRAINT fk_estiba_operacion_portuaria FOREIGN KEY (id_operacion_portuaria) 
        REFERENCES gestion_maritima.OperacionPortuaria(id_operacion_portuaria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_estiba_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_estiba_ubicacion CHECK (LENGTH(TRIM(ubicacion)) > 0),
    CONSTRAINT chk_estiba_zona CHECK (LENGTH(TRIM(zona_buque)) > 0)
);

CREATE TABLE gestion_maritima.TrabajadorPortuarioEquipoProteccion (
    id_trabajador_portuario_equipo_proteccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_trabajador_portuario UUID NOT NULL,
    id_equipo_proteccion UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_trabajador_equipo_prot_trabajador FOREIGN KEY (id_trabajador_portuario) 
        REFERENCES gestion_maritima.TrabajadorPortuario(id_trabajador_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_trabajador_equipo_prot_equipo FOREIGN KEY (id_equipo_proteccion) 
        REFERENCES shared.EquipoProteccion(id_equipo_proteccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_trabajador_equipo_proteccion UNIQUE (id_trabajador_portuario, id_equipo_proteccion)
);

CREATE TABLE gestion_maritima.RutaPuertoIntermedio (
    id_ruta_puerto_intermedio UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_ruta_maritima UUID NOT NULL,
    id_puerto UUID NOT NULL,
    CONSTRAINT fk_ruta_puerto_inter_ruta FOREIGN KEY (id_ruta_maritima) 
        REFERENCES gestion_maritima.RutaMaritima(id_ruta_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_ruta_puerto_inter_puerto FOREIGN KEY (id_puerto) 
        REFERENCES gestion_maritima.Puerto(id_puerto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_ruta_puerto_intermedio UNIQUE (id_ruta_maritima, id_puerto)
);

CREATE TABLE gestion_maritima.OperacionCertificacionAduanera (
    id_operacion_certificacion_aduanera UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_maritima UUID NOT NULL,
    id_certificacion_aduanera UUID NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_aprobacion DATE,
    CONSTRAINT fk_operacion_cert_adu_operacion FOREIGN KEY (id_operacion_maritima) 
        REFERENCES shared.OperacionMaritima(id_operacion_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_cert_adu_certificacion FOREIGN KEY (id_certificacion_aduanera) 
        REFERENCES gestion_maritima.CertificacionAduanera(id_certificacion_aduanera)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_certificacion_aduanera UNIQUE (id_operacion_maritima, id_certificacion_aduanera),
    CONSTRAINT chk_operacion_cert_adu_estado CHECK (estado IN ('PENDIENTE', 'APROBADO', 'RECHAZADO'))
);

-- ============================================
-- SCHEMA: operaciones_terrestres
-- ============================================

DROP SCHEMA IF EXISTS operaciones_terrestres CASCADE;
CREATE SCHEMA operaciones_terrestres;

-- Tablas principales
CREATE TABLE operaciones_terrestres.RutaTerrestre (
    id_ruta_terrestre UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_ruta UUID NOT NULL UNIQUE,
    CONSTRAINT fk_ruta_terrestre_ruta FOREIGN KEY (id_ruta) 
        REFERENCES shared.Ruta(id_ruta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.Conductor (
    id_conductor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    licencia VARCHAR(20) NOT NULL UNIQUE,
    categoria VARCHAR(20) NOT NULL,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_conductor_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.OperacionTerrestreDetalle (
    id_operacion_terrestre_detalle UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_terrestre UUID NOT NULL UNIQUE,
    id_vehiculo UUID NOT NULL,
    id_ruta_terrestre UUID NOT NULL,
    id_conductor UUID NOT NULL,
    CONSTRAINT fk_op_terr_det_op_terrestre FOREIGN KEY (id_operacion_terrestre) 
        REFERENCES shared.OperacionTerrestre(id_operacion_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_terr_det_vehiculo FOREIGN KEY (id_vehiculo) 
        REFERENCES shared.Vehiculo(id_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_terr_det_ruta FOREIGN KEY (id_ruta_terrestre) 
        REFERENCES operaciones_terrestres.RutaTerrestre(id_ruta_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_terr_det_conductor FOREIGN KEY (id_conductor) 
        REFERENCES operaciones_terrestres.Conductor(id_conductor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.ChecklistDespacho (
    id_checklist UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    observaciones TEXT,
    combustible VARCHAR(50) NOT NULL,
    frenos VARCHAR(50) NOT NULL,
    id_operacion_terrestre UUID NOT NULL UNIQUE,
    CONSTRAINT fk_checklist_operacion FOREIGN KEY (id_operacion_terrestre) 
        REFERENCES shared.OperacionTerrestre(id_operacion_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.DocumentacionOperacion (
    id_documento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    ruta_archivo VARCHAR(255) NOT NULL,
    fecha_emision DATE NOT NULL,
    id_tipo_documento UUID NOT NULL,
    CONSTRAINT fk_documento_tipo FOREIGN KEY (id_tipo_documento) 
        REFERENCES shared.TipoDocumento(id_tipo_documento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.OperacionDocumento (
    id_operacion UUID NOT NULL,
    id_documento UUID NOT NULL,
    PRIMARY KEY (id_operacion, id_documento),
    CONSTRAINT fk_op_doc_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_doc_documento FOREIGN KEY (id_documento) 
        REFERENCES operaciones_terrestres.DocumentacionOperacion(id_documento)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE operaciones_terrestres.ReporteTransporte (
    id_reporte UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_reporte UUID NOT NULL,
    fecha_generado DATE NOT NULL,
    id_operacion_terrestre UUID NOT NULL UNIQUE,
    CONSTRAINT fk_reporte_tipo FOREIGN KEY (id_tipo_reporte) 
        REFERENCES shared.TipoReporte(id_tipo_reporte)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reporte_operacion FOREIGN KEY (id_operacion_terrestre) 
        REFERENCES shared.OperacionTerrestre(id_operacion_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================
-- SCHEMA: mantenimiento_logistico
-- ============================================

DROP SCHEMA IF EXISTS mantenimiento_logistico CASCADE;
CREATE SCHEMA mantenimiento_logistico;

-- Tablas principales
CREATE TABLE mantenimiento_logistico.Tecnico (
    id_tecnico UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    especialidad VARCHAR(100) NOT NULL,
    CONSTRAINT fk_tecnico_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.ResponsableSolicitud (
    id_responsable_solicitud UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    CONSTRAINT fk_responsable_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.Repuesto (
    id_repuesto UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    stock_minimo INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_repuesto_stock CHECK (stock >= 0),
    CONSTRAINT chk_repuesto_stock_minimo CHECK (stock_minimo >= 0),
    CONSTRAINT chk_repuesto_precio CHECK (precio_unitario >= 0)
);

CREATE TABLE mantenimiento_logistico.PlanMantenimiento (
    id_plan_mantenimiento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    frecuencia INT NOT NULL,
    fecha_creacion DATE NOT NULL DEFAULT CURRENT_DATE,
    id_estado_plan UUID NOT NULL,
    id_activo UUID NOT NULL,
    CONSTRAINT fk_plan_estado FOREIGN KEY (id_estado_plan) 
        REFERENCES shared.EstadoPlan(id_estado_plan)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_plan_activo FOREIGN KEY (id_activo) 
        REFERENCES shared.Activo(id_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_plan_frecuencia CHECK (frecuencia > 0)
);

CREATE TABLE mantenimiento_logistico.SolicitudMantenimiento (
    id_solicitud_mantenimiento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    descripcion_problema TEXT NOT NULL,
    fecha_solicitud DATE NOT NULL DEFAULT CURRENT_DATE,
    id_prioridad UUID NOT NULL,
    id_estado_solicitud UUID NOT NULL,
    id_responsable_solicitud UUID NOT NULL,
    id_activo UUID NOT NULL,
    CONSTRAINT fk_solicitud_prioridad FOREIGN KEY (id_prioridad) 
        REFERENCES shared.Prioridad(id_prioridad)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_estado FOREIGN KEY (id_estado_solicitud) 
        REFERENCES shared.EstadoSolicitud(id_estado_solicitud)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_responsable FOREIGN KEY (id_responsable_solicitud) 
        REFERENCES mantenimiento_logistico.ResponsableSolicitud(id_responsable_solicitud)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_activo FOREIGN KEY (id_activo) 
        REFERENCES shared.Activo(id_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.OperacionMantenimiento (
    id_operacion_mantenimiento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    id_plan_mantenimiento UUID,
    id_solicitud_mantenimiento UUID,
    CONSTRAINT fk_op_mantenimiento_operacion FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
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
    id_orden UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_generada DATE NOT NULL,
    fecha_programada DATE,
    fecha_cierre DATE,
    id_tipo_mantenimiento UUID NOT NULL,
    id_estado_orden UUID NOT NULL,
    id_operacion_mantenimiento UUID NOT NULL,
    CONSTRAINT fk_orden_tipo_mantenimiento FOREIGN KEY (id_tipo_mantenimiento) 
        REFERENCES shared.TipoMantenimiento(id_tipo_mantenimiento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_orden_estado FOREIGN KEY (id_estado_orden) 
        REFERENCES shared.EstadoOrden(id_estado_orden)
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
    id_tarea UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion TEXT NOT NULL,
    id_estado_tarea UUID NOT NULL,
    id_orden UUID NOT NULL,
    CONSTRAINT fk_tarea_estado FOREIGN KEY (id_estado_tarea) 
        REFERENCES shared.EstadoTarea(id_estado_tarea)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_tarea_orden FOREIGN KEY (id_orden) 
        REFERENCES mantenimiento_logistico.OrdenMantenimiento(id_orden)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE mantenimiento_logistico.OperacionMantenimientoTecnico (
    id_operacion_mantenimiento UUID NOT NULL,
    id_tecnico UUID NOT NULL,
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
    id_operacion_mantenimiento UUID NOT NULL,
    id_repuesto UUID NOT NULL,
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
-- SCHEMA: monitoreo
-- ============================================

DROP SCHEMA IF EXISTS monitoreo CASCADE;
CREATE SCHEMA monitoreo;

-- Tablas principales
CREATE TABLE monitoreo.Operador (
    id_operador UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    turno VARCHAR(20) NOT NULL,
    zona_monitoreo VARCHAR(100) NOT NULL,
    CONSTRAINT fk_operador_empleado FOREIGN KEY (id_empleado) 
        REFERENCES shared.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_turno CHECK (turno IN ('Mañana', 'Tarde', 'Noche'))
);

CREATE TABLE monitoreo.OperacionMonitoreo (
    id_operacion_monitoreo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    CONSTRAINT fk_operacion_monitoreo FOREIGN KEY (id_operacion) 
        REFERENCES shared.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.Sensor (
    id_sensor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    id_tipo_sensor UUID NOT NULL,
    id_rol_sensor UUID NOT NULL,
    id_contenedor UUID NOT NULL,
    CONSTRAINT fk_sensor_tipo FOREIGN KEY (id_tipo_sensor) 
        REFERENCES shared.TipoSensor(id_tipo_sensor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_sensor_rol FOREIGN KEY (id_rol_sensor) 
        REFERENCES shared.RolSensor(id_rol_sensor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_sensor_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.LecturaSensor (
    id_lectura_sensor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_sensor UUID NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor DECIMAL(10,2) NOT NULL,
    unidad VARCHAR(10) NOT NULL,
    id_estado_lectura UUID NOT NULL,
    CONSTRAINT fk_lectura_sensor FOREIGN KEY (id_sensor) 
        REFERENCES monitoreo.Sensor(id_sensor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_lectura_estado FOREIGN KEY (id_estado_lectura) 
        REFERENCES shared.EstadoLectura(id_estado_lectura)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE INDEX idx_lectura_sensor_fecha ON monitoreo.LecturaSensor(id_sensor, fecha_hora);

CREATE TABLE monitoreo.Reporte (
    id_reporte UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_reporte DATE NOT NULL DEFAULT CURRENT_DATE,
    detalle TEXT NOT NULL
);

CREATE TABLE monitoreo.Notificacion (
    id_notificacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_notificacion UUID NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor DECIMAL(10,2) NOT NULL,
    id_sensor UUID NOT NULL,
    id_reporte UUID NOT NULL,
    CONSTRAINT fk_notificacion_tipo FOREIGN KEY (id_tipo_notificacion) 
        REFERENCES shared.TipoNotificacion(id_tipo_notificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_notificacion_sensor FOREIGN KEY (id_sensor) 
        REFERENCES monitoreo.Sensor(id_sensor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_notificacion_reporte FOREIGN KEY (id_reporte) 
        REFERENCES monitoreo.Reporte(id_reporte)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.Importador (
    id_importador UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    ruc CHAR(11) NOT NULL UNIQUE,
    razon_social VARCHAR(150) NOT NULL,
    CONSTRAINT chk_ruc CHECK (ruc ~ '^[0-9]{11}$')
);

CREATE TABLE monitoreo.ImportadorDireccion (
    id_direccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_importador UUID NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    tipo VARCHAR(50),
    principal BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_importador_direccion FOREIGN KEY (id_importador) 
        REFERENCES monitoreo.Importador(id_importador)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.Entrega (
    id_entrega UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_estado_entrega UUID NOT NULL,
    fecha_entrega DATE NOT NULL,
    lugar_entrega VARCHAR(100) NOT NULL,
    id_contenedor UUID NOT NULL,
    id_importador UUID NOT NULL,
    CONSTRAINT fk_entrega_estado FOREIGN KEY (id_estado_entrega) 
        REFERENCES shared.EstadoEntrega(id_estado_entrega)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_entrega_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_entrega_importador FOREIGN KEY (id_importador) 
        REFERENCES monitoreo.Importador(id_importador)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.IncidenciaReporte (
    id_incidencia_reporte UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_incidencia UUID NOT NULL,
    id_reporte UUID NOT NULL,
    CONSTRAINT uk_incidencia_reporte UNIQUE (id_incidencia, id_reporte),
    CONSTRAINT fk_inc_reporte_inc FOREIGN KEY (id_incidencia) 
        REFERENCES shared.Incidencia(id_incidencia)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_inc_reporte_rep FOREIGN KEY (id_reporte) 
        REFERENCES monitoreo.Reporte(id_reporte)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.PosicionContenedor (
    id_posicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenedor UUID NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_posicion_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_latitud_cont CHECK (latitud BETWEEN -90 AND 90),
    CONSTRAINT chk_longitud_cont CHECK (longitud BETWEEN -180 AND 180)
);

CREATE INDEX idx_posicion_contenedor_fecha ON monitoreo.PosicionContenedor(id_contenedor, fecha_hora);

CREATE TABLE monitoreo.PosicionVehiculo (
    id_posicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_vehiculo UUID NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_posicion_vehiculo FOREIGN KEY (id_vehiculo) 
        REFERENCES shared.Vehiculo(id_vehiculo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_latitud_veh CHECK (latitud BETWEEN -90 AND 90),
    CONSTRAINT chk_longitud_veh CHECK (longitud BETWEEN -180 AND 180)
);

CREATE INDEX idx_posicion_vehiculo_fecha ON monitoreo.PosicionVehiculo(id_vehiculo, fecha_hora);

CREATE TABLE monitoreo.PosicionBuque (
    id_posicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_buque UUID NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_posicion_buque FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_latitud_buq CHECK (latitud BETWEEN -90 AND 90),
    CONSTRAINT chk_longitud_buq CHECK (longitud BETWEEN -180 AND 180)
);

CREATE INDEX idx_posicion_buque_fecha ON monitoreo.PosicionBuque(id_buque, fecha_hora);

CREATE TABLE monitoreo.OperacionMonitoreoVehiculo (
    id_operacion_monitoreo_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_monitoreo UUID NOT NULL,
    id_vehiculo UUID NOT NULL,
    fecha_operacion DATE NOT NULL,
    CONSTRAINT uk_operacion_vehiculo_fecha UNIQUE (id_operacion_monitoreo, id_vehiculo, fecha_operacion),
    CONSTRAINT fk_om_vehiculo_om FOREIGN KEY (id_operacion_monitoreo) 
        REFERENCES monitoreo.OperacionMonitoreo(id_operacion_monitoreo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_om_vehiculo_veh FOREIGN KEY (id_vehiculo) 
        REFERENCES shared.Vehiculo(id_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.OperacionMonitoreoBuque (
    id_operacion_monitoreo_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_monitoreo UUID NOT NULL,
    id_buque UUID NOT NULL,
    fecha_operacion DATE NOT NULL,
    CONSTRAINT uk_operacion_buque_fecha UNIQUE (id_operacion_monitoreo, id_buque, fecha_operacion),
    CONSTRAINT fk_om_buque_om FOREIGN KEY (id_operacion_monitoreo) 
        REFERENCES monitoreo.OperacionMonitoreo(id_operacion_monitoreo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_om_buque_buq FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.ContenedorVehiculo (
    id_contenedor_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenedor UUID NOT NULL,
    id_vehiculo UUID NOT NULL,
    fecha_asignacion DATE NOT NULL,
    fecha_transporte DATE NOT NULL,
    CONSTRAINT uk_contenedor_vehiculo_asignacion UNIQUE (id_contenedor, id_vehiculo, fecha_asignacion),
    CONSTRAINT fk_cont_veh_cont FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_cont_veh_veh FOREIGN KEY (id_vehiculo) 
        REFERENCES shared.Vehiculo(id_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_cont_veh CHECK (fecha_transporte >= fecha_asignacion)
);

CREATE TABLE monitoreo.ContenedorBuque (
    id_contenedor_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenedor UUID NOT NULL,
    id_buque UUID NOT NULL,
    fecha_asignacion DATE NOT NULL,
    fecha_transporte DATE NOT NULL,
    CONSTRAINT uk_contenedor_buque_asignacion UNIQUE (id_contenedor, id_buque, fecha_asignacion),
    CONSTRAINT fk_cont_buq_cont FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_cont_buq_buq FOREIGN KEY (id_buque) 
        REFERENCES shared.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_cont_buq CHECK (fecha_transporte >= fecha_asignacion)
);

CREATE TABLE monitoreo.OperadorOperacionMonitoreo (
    id_operador_operacion_monitoreo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operador UUID NOT NULL,
    id_operacion_monitoreo UUID NOT NULL,
    fecha_realizacion DATE NOT NULL,
    CONSTRAINT uk_operador_operacion_fecha UNIQUE (id_operador, id_operacion_monitoreo, fecha_realizacion),
    CONSTRAINT fk_op_om_operador FOREIGN KEY (id_operador) 
        REFERENCES monitoreo.Operador(id_operador)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_op_om_om FOREIGN KEY (id_operacion_monitoreo) 
        REFERENCES monitoreo.OperacionMonitoreo(id_operacion_monitoreo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.Documentacion (
    id_documentacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
    id_tipo_documento UUID NOT NULL,
    CONSTRAINT fk_documentacion_tipo FOREIGN KEY (id_tipo_documento) 
        REFERENCES shared.TipoDocumento(id_tipo_documento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.DocumentacionContenedor (
    id_documentacion_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_documentacion UUID NOT NULL UNIQUE,
    id_contenedor UUID NOT NULL UNIQUE,
    CONSTRAINT fk_doc_contenedor_doc FOREIGN KEY (id_documentacion) 
        REFERENCES monitoreo.Documentacion(id_documentacion)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_doc_contenedor_cont FOREIGN KEY (id_contenedor) 
        REFERENCES shared.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================================
-- SCHEMA: monitoreo_analytics (Proceso Batch módulo monitoreo)
-- ============================================================

DROP SCHEMA IF EXISTS monitoreo_analytics CASCADE;
CREATE SCHEMA monitoreo_analytics;

-- Dimensión de fechas
CREATE TABLE monitoreo_analytics.DimFecha (
    id_fecha SERIAL PRIMARY KEY,
    fecha DATE NOT NULL UNIQUE,
    anio INT NOT NULL,
    mes INT NOT NULL,
    dia INT NOT NULL,
    nombre_mes VARCHAR(20),
    nombre_dia VARCHAR(20)
);

-- Dimensión de estados de operación
CREATE TABLE monitoreo_analytics.DimEstadoOperacion (
    id_estado_operacion UUID PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Dimensión de buques (copiada desde shared.Buque)
CREATE TABLE monitoreo_analytics.DimBuque (
    id_buque UUID PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    peso DECIMAL(15,2) NOT NULL
);

-- Dimensión de vehículos (copiada desde shared.Vehiculo)
CREATE TABLE monitoreo_analytics.DimVehiculo (
    id_vehiculo UUID PRIMARY KEY,
    placa VARCHAR(20) NOT NULL,
    capacidad_ton DECIMAL(10,2) NOT NULL
);

-- Tabla de hechos: operaciones monitoreadas por fecha de corte
CREATE TABLE monitoreo_analytics.FactOperacionMonitoreo (
    id_fact UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL,
    id_fecha_corte INT NOT NULL,
    id_estado_operacion UUID NOT NULL,
    id_buque UUID,
    id_vehiculo UUID,
    medio_transporte VARCHAR(20) NOT NULL,
    duracion_minutos INT,
    incidencias_total INT,
    incidencias_alta_severidad INT,
    -- Última posición GPS conocida
    ultima_latitud DECIMAL(9,6),
    ultima_longitud DECIMAL(9,6),
    fecha_ultima_posicion TIMESTAMP,
    fecha_registro_batch TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_fact_fecha FOREIGN KEY (id_fecha_corte)
        REFERENCES monitoreo_analytics.DimFecha(id_fecha),
    CONSTRAINT fk_fact_estado FOREIGN KEY (id_estado_operacion)
        REFERENCES monitoreo_analytics.DimEstadoOperacion(id_estado_operacion),
    CONSTRAINT fk_fact_buque FOREIGN KEY (id_buque)
        REFERENCES monitoreo_analytics.DimBuque(id_buque),
    CONSTRAINT fk_fact_vehiculo FOREIGN KEY (id_vehiculo)
        REFERENCES monitoreo_analytics.DimVehiculo(id_vehiculo)
);

CREATE INDEX idx_fact_operacion_fecha ON monitoreo_analytics.FactOperacionMonitoreo(id_operacion, id_fecha_corte);

-- ============================================================
-- FUNCIÓN BATCH: cierre diario de operaciones monitoreadas
-- ============================================================

CREATE OR REPLACE FUNCTION monitoreo_analytics.f_cierre_diario_operaciones(p_fecha_corte DATE)
RETURNS void AS
$$
DECLARE
    cur_op CURSOR FOR
        SELECT o.id_operacion,
               o.codigo,
               o.fecha_inicio,
               o.fecha_fin,
               o.id_estado_operacion
        FROM shared.Operacion o
        JOIN shared.EstadoOperacion eo ON eo.id_estado_operacion = o.id_estado_operacion
        WHERE DATE(o.fecha_fin) = p_fecha_corte
          AND eo.nombre = 'Completada';

    v_op RECORD;
    v_id_buque UUID;
    v_id_vehiculo UUID;
    v_duracion_minutos INT;
    v_incidencias_total INT;
    v_incidencias_alta INT;
    v_medio_transporte VARCHAR(20);
    v_id_fecha INT;
    v_ultima_lat DECIMAL(9,6);
    v_ultima_lon DECIMAL(9,6);
    v_fecha_ultima_pos TIMESTAMP;
BEGIN
    -- Asegurar registro en DimFecha
    SELECT id_fecha
    INTO v_id_fecha
    FROM monitoreo_analytics.DimFecha
    WHERE fecha = p_fecha_corte;

    IF NOT FOUND THEN
        INSERT INTO monitoreo_analytics.DimFecha(fecha, anio, mes, dia, nombre_mes, nombre_dia)
        VALUES (
            p_fecha_corte,
            EXTRACT(YEAR FROM p_fecha_corte),
            EXTRACT(MONTH FROM p_fecha_corte),
            EXTRACT(DAY FROM p_fecha_corte),
            TO_CHAR(p_fecha_corte, 'TMMonth'),
            TO_CHAR(p_fecha_corte, 'TMDay')
        )
        RETURNING id_fecha INTO v_id_fecha;
    END IF;

    -- Poblar dimensiones de estado (copiando desde shared)
    INSERT INTO monitoreo_analytics.DimEstadoOperacion (id_estado_operacion, nombre)
    SELECT eo.id_estado_operacion, eo.nombre
    FROM shared.EstadoOperacion eo
    ON CONFLICT (id_estado_operacion) DO NOTHING;

    -- Poblar dimensiones de buque y vehículo según existan
    INSERT INTO monitoreo_analytics.DimBuque (id_buque, matricula, nombre, capacidad, peso)
    SELECT b.id_buque, b.matricula, b.nombre, b.capacidad, b.peso
    FROM shared.Buque b
    ON CONFLICT (id_buque) DO NOTHING;

    INSERT INTO monitoreo_analytics.DimVehiculo (id_vehiculo, placa, capacidad_ton)
    SELECT v.id_vehiculo, v.placa, v.capacidad_ton
    FROM shared.Vehiculo v
    ON CONFLICT (id_vehiculo) DO NOTHING;

    OPEN cur_op;

    LOOP
        FETCH cur_op INTO v_op;
        EXIT WHEN NOT FOUND;

        -- Duración en minutos
        v_duracion_minutos := NULL;
        IF v_op.fecha_inicio IS NOT NULL AND v_op.fecha_fin IS NOT NULL THEN
            v_duracion_minutos := (EXTRACT(EPOCH FROM (v_op.fecha_fin - v_op.fecha_inicio)) / 60)::INT;
        END IF;

        -- Determinar medio de transporte y activo asociado
        v_id_buque := NULL;
        v_id_vehiculo := NULL;
        v_medio_transporte := 'No definido';

        SELECT om.id_buque
        INTO v_id_buque
        FROM shared.OperacionMaritima om
        WHERE om.id_operacion = v_op.id_operacion;

        IF FOUND THEN
            v_medio_transporte := 'Marítimo';
        ELSE
            SELECT d.id_vehiculo
            INTO v_id_vehiculo
            FROM shared.OperacionTerrestre ot
            JOIN operaciones_terrestres.OperacionTerrestreDetalle d
              ON ot.id_operacion_terrestre = d.id_operacion_terrestre
            WHERE ot.id_operacion = v_op.id_operacion;

            IF FOUND THEN
                v_medio_transporte := 'Terrestre';
            END IF;
        END IF;

        -- Incidencias asociadas
        SELECT COUNT(*)
        INTO v_incidencias_total
        FROM shared.Incidencia i
        WHERE i.id_operacion = v_op.id_operacion;

        SELECT COUNT(*)
        INTO v_incidencias_alta
        FROM shared.Incidencia i
        WHERE i.id_operacion = v_op.id_operacion
          AND i.grado_severidad >= 4;

        -- Última posición GPS según medio de transporte
        v_ultima_lat := NULL;
        v_ultima_lon := NULL;
        v_fecha_ultima_pos := NULL;

        IF v_id_buque IS NOT NULL THEN
            SELECT pb.latitud, pb.longitud, pb.fecha_hora
            INTO v_ultima_lat, v_ultima_lon, v_fecha_ultima_pos
            FROM monitoreo.PosicionBuque pb
            WHERE pb.id_buque = v_id_buque
            ORDER BY pb.fecha_hora DESC
            LIMIT 1;
        ELSIF v_id_vehiculo IS NOT NULL THEN
            SELECT pv.latitud, pv.longitud, pv.fecha_hora
            INTO v_ultima_lat, v_ultima_lon, v_fecha_ultima_pos
            FROM monitoreo.PosicionVehiculo pv
            WHERE pv.id_vehiculo = v_id_vehiculo
            ORDER BY pv.fecha_hora DESC
            LIMIT 1;
        END IF;

        -- Insertar en la tabla de hechos si no existe ya para esa operación y fecha
        IF NOT EXISTS (
            SELECT 1
            FROM monitoreo_analytics.FactOperacionMonitoreo f
            WHERE f.id_operacion = v_op.id_operacion
              AND f.id_fecha_corte = v_id_fecha
        ) THEN
            INSERT INTO monitoreo_analytics.FactOperacionMonitoreo (
                id_operacion,
                id_fecha_corte,
                id_estado_operacion,
                id_buque,
                id_vehiculo,
                medio_transporte,
                duracion_minutos,
                incidencias_total,
                incidencias_alta_severidad,
                ultima_latitud,
                ultima_longitud,
                fecha_ultima_posicion,
                fecha_registro_batch
            ) VALUES (
                v_op.id_operacion,
                v_id_fecha,
                v_op.id_estado_operacion,
                v_id_buque,
                v_id_vehiculo,
                v_medio_transporte,
                v_duracion_minutos,
                v_incidencias_total,
                v_incidencias_alta,
                v_ultima_lat,
                v_ultima_lon,
                v_fecha_ultima_pos,
                NOW()
            );
        END IF;
    END LOOP;

    CLOSE cur_op;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- FUNCIÓN BATCH: cierre diario de operaciones monitoreadas
-- ============================================================

CREATE OR REPLACE FUNCTION monitoreo_analytics.f_cierre_rango_fechas(
  p_fecha_inicio DATE,
  p_fecha_fin    DATE
)
RETURNS void AS
$$
DECLARE
  v_fecha DATE;
BEGIN
  IF p_fecha_inicio IS NULL OR p_fecha_fin IS NULL THEN
    RAISE EXCEPTION 'Las fechas no pueden ser nulas';
  END IF;

  IF p_fecha_inicio > p_fecha_fin THEN
    RAISE EXCEPTION 'p_fecha_inicio (%) no puede ser mayor que p_fecha_fin (%)',
      p_fecha_inicio, p_fecha_fin;
  END IF;

  v_fecha := p_fecha_inicio;
  WHILE v_fecha <= p_fecha_fin LOOP
    PERFORM monitoreo_analytics.f_cierre_diario_operaciones(v_fecha);
    v_fecha := v_fecha + INTERVAL '1 day';
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- SCHEMA: gestion_maritima_audit (Proceso batch conciliación)
-- Documentación: docs 11.1.3 (esquema) y 11.2.3 (función)
-- ============================================================

DROP SCHEMA IF EXISTS gestion_maritima_audit CASCADE;
CREATE SCHEMA gestion_maritima_audit;

-- Dimensión de fechas
CREATE TABLE gestion_maritima_audit.DimFecha (
    id_fecha SERIAL PRIMARY KEY,
    fecha DATE NOT NULL UNIQUE,
    anio INT NOT NULL,
    mes INT NOT NULL,
    dia INT NOT NULL,
    nombre_mes VARCHAR(20),
    nombre_dia VARCHAR(20)
);

-- Dimensión de estados de operación
CREATE TABLE gestion_maritima_audit.DimEstadoOperacion (
    id_estado_operacion UUID PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Dimensión de buques
CREATE TABLE gestion_maritima_audit.DimBuque (
    id_buque UUID PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    peso DECIMAL(15,2) NOT NULL
);

-- Dimensión de tipos de operación
CREATE TABLE gestion_maritima_audit.DimTipoOperacion (
    id_tipo_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

-- Dimensión de tipos de corrección
CREATE TABLE gestion_maritima_audit.DimTipoCorreccion (
    id_tipo_correccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

-- Dimensión de inconsistencias
CREATE TABLE gestion_maritima_audit.DimInconsistencia (
    id_inconsistencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tipo_inconsistencia VARCHAR(50) NOT NULL,
    nivel_severidad INT NOT NULL,
    descripcion VARCHAR(255),
    CONSTRAINT chk_dim_inconsistencia_severidad CHECK (nivel_severidad BETWEEN 1 AND 4)
);

-- Tabla de hechos: conciliación de operaciones
CREATE TABLE gestion_maritima_audit.FactConciliacionOperacion (
    id_fact UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL,
    id_fecha_corte INT NOT NULL,
    id_estado_operacion_anterior UUID NOT NULL,
    id_estado_operacion_nuevo UUID NOT NULL,
    id_buque UUID,
    tipo_operacion VARCHAR(20) NOT NULL,
    tipo_correccion VARCHAR(50) NOT NULL,
    porcentaje_trayecto_anterior DECIMAL(5,2),
    porcentaje_trayecto_nuevo DECIMAL(5,2),
    fecha_inicio_operacion TIMESTAMP NOT NULL,
    fecha_fin_original TIMESTAMP,
    fecha_fin_corregida TIMESTAMP,
    duracion_real_horas DECIMAL(10,2),
    incidencias_asociadas INT DEFAULT 0,
    incidencias_alta_severidad INT DEFAULT 0,
    inconsistencias_detectadas INT DEFAULT 0,
    requiere_intervencion_manual BOOLEAN DEFAULT FALSE,
    correccion_aplicada BOOLEAN DEFAULT TRUE,
    descripcion_correccion TEXT,
    fecha_registro_batch TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_fact_conc_fecha FOREIGN KEY (id_fecha_corte)
        REFERENCES gestion_maritima_audit.DimFecha(id_fecha),
    CONSTRAINT fk_fact_conc_estado_ant FOREIGN KEY (id_estado_operacion_anterior)
        REFERENCES gestion_maritima_audit.DimEstadoOperacion(id_estado_operacion),
    CONSTRAINT fk_fact_conc_estado_new FOREIGN KEY (id_estado_operacion_nuevo)
        REFERENCES gestion_maritima_audit.DimEstadoOperacion(id_estado_operacion),
    CONSTRAINT fk_fact_conc_buque FOREIGN KEY (id_buque)
        REFERENCES gestion_maritima_audit.DimBuque(id_buque),
    CONSTRAINT chk_fact_conc_tipo_operacion CHECK (tipo_operacion IN ('MARITIMA', 'PORTUARIA')),
    CONSTRAINT chk_fact_conc_tipo_correccion CHECK (tipo_correccion IN (
        'CIERRE_AUTOMATICO', 
        'ACTUALIZACION_ESTADO', 
        'SINCRONIZACION',
        'CORRECCION_PORCENTAJE'
    ))
);

-- Tabla de hechos: inconsistencias detectadas en operaciones
CREATE TABLE gestion_maritima_audit.FactInconsistenciaOperacion (
    id_fact_inconsistencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL,
    id_fecha_corte INT NOT NULL,
    id_inconsistencia UUID NOT NULL,
    id_tipo_correccion UUID,
    resuelta BOOLEAN NOT NULL DEFAULT FALSE,
    fecha_deteccion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion TIMESTAMP,
    usuario_resolucion VARCHAR(100),
    observaciones TEXT,
    
    CONSTRAINT fk_fact_incons_fecha FOREIGN KEY (id_fecha_corte)
        REFERENCES gestion_maritima_audit.DimFecha(id_fecha),
    CONSTRAINT fk_fact_incons_inconsistencia FOREIGN KEY (id_inconsistencia)
        REFERENCES gestion_maritima_audit.DimInconsistencia(id_inconsistencia),
    CONSTRAINT fk_fact_incons_tipo_correccion FOREIGN KEY (id_tipo_correccion)
        REFERENCES gestion_maritima_audit.DimTipoCorreccion(id_tipo_correccion)
);

-- Índices
CREATE INDEX idx_fact_conc_operacion ON gestion_maritima_audit.FactConciliacionOperacion(id_operacion);
CREATE INDEX idx_fact_conc_fecha ON gestion_maritima_audit.FactConciliacionOperacion(id_fecha_corte);
CREATE INDEX idx_fact_conc_buque ON gestion_maritima_audit.FactConciliacionOperacion(id_buque);
CREATE INDEX idx_fact_conc_tipo_operacion ON gestion_maritima_audit.FactConciliacionOperacion(tipo_operacion);
CREATE INDEX idx_fact_conc_intervencion ON gestion_maritima_audit.FactConciliacionOperacion(requiere_intervencion_manual);

CREATE INDEX idx_fact_incons_operacion ON gestion_maritima_audit.FactInconsistenciaOperacion(id_operacion);
CREATE INDEX idx_fact_incons_fecha ON gestion_maritima_audit.FactInconsistenciaOperacion(id_fecha_corte);
CREATE INDEX idx_fact_incons_resuelta ON gestion_maritima_audit.FactInconsistenciaOperacion(resuelta);
CREATE INDEX idx_fact_incons_inconsistencia ON gestion_maritima_audit.FactInconsistenciaOperacion(id_inconsistencia);

-- ============================================================
-- FUNCIÓN BATCH: conciliación nocturna de operaciones marítimas
-- Adaptada de la documentación (11.2.3): las tablas operacionales
-- viven en el schema "shared" y los estados finales son los del seed
-- ('Completada' / 'En Curso').
-- ============================================================

CREATE OR REPLACE FUNCTION gestion_maritima_audit.f_conciliacion_nocturna_operaciones(p_fecha_corte DATE)
RETURNS void AS
$$
DECLARE
    cur_op CURSOR FOR
        SELECT o.id_operacion,
               o.codigo,
               o.fecha_inicio,
               o.fecha_fin,
               o.id_estado_operacion
        FROM shared.Operacion o
        WHERE (o.fecha_fin IS NULL AND (NOW() - o.fecha_inicio) > INTERVAL '48 hours')
           OR DATE(o.fecha_fin) = p_fecha_corte;

    v_op RECORD;
    v_id_fecha INT;
    v_id_tipo_operacion UUID;
    v_id_buque UUID;
    v_porcentaje_anterior DECIMAL(5,2);
    v_porcentaje_nuevo DECIMAL(5,2);
    v_id_estado_anterior UUID;
    v_id_estado_nuevo UUID;
    v_fecha_fin_corregida TIMESTAMP;
    v_duracion_horas DECIMAL(10,2);
    v_incidencias_total INT;
    v_incidencias_alta INT;
    v_correccion_aplicada BOOLEAN;
    v_descripcion_correccion TEXT;
    v_id_tipo_correccion UUID;
    v_tipo_operacion VARCHAR(20);
    v_tipo_correccion VARCHAR(50);
BEGIN
    -- Asegurar registro en DimFecha
    SELECT id_fecha INTO v_id_fecha
    FROM gestion_maritima_audit.DimFecha
    WHERE fecha = p_fecha_corte;

    IF NOT FOUND THEN
        INSERT INTO gestion_maritima_audit.DimFecha(fecha, anio, mes, dia, nombre_mes, nombre_dia)
        VALUES (
            p_fecha_corte,
            EXTRACT(YEAR FROM p_fecha_corte),
            EXTRACT(MONTH FROM p_fecha_corte),
            EXTRACT(DAY FROM p_fecha_corte),
            TO_CHAR(p_fecha_corte, 'TMMonth'),
            TO_CHAR(p_fecha_corte, 'TMDay')
        )
        RETURNING id_fecha INTO v_id_fecha;
    END IF;

    -- Poblar dimensiones desde tablas operacionales
    INSERT INTO gestion_maritima_audit.DimEstadoOperacion (id_estado_operacion, nombre)
    SELECT eo.id_estado_operacion, eo.nombre
    FROM shared.EstadoOperacion eo
    ON CONFLICT (id_estado_operacion) DO NOTHING;

    INSERT INTO gestion_maritima_audit.DimBuque (id_buque, matricula, nombre, capacidad, peso)
    SELECT b.id_buque, b.matricula, b.nombre, b.capacidad, b.peso
    FROM shared.Buque b
    ON CONFLICT (id_buque) DO NOTHING;

    OPEN cur_op;

    LOOP
        FETCH cur_op INTO v_op;
        EXIT WHEN NOT FOUND;

        -- Inicializar variables
        v_id_buque := NULL;
        v_porcentaje_anterior := NULL;
        v_id_estado_anterior := v_op.id_estado_operacion;
        v_id_estado_nuevo := v_op.id_estado_operacion;
        v_fecha_fin_corregida := v_op.fecha_fin;
        v_correccion_aplicada := FALSE;
        v_descripcion_correccion := '';
        -- El batch concilia operaciones del módulo marítimo
        v_tipo_operacion := 'MARITIMA';
        v_tipo_correccion := 'SINCRONIZACION';

        -- Determinar tipo y datos específicos
        SELECT om.id_buque, om.porcentaje_trayecto
        INTO v_id_buque, v_porcentaje_anterior
        FROM shared.OperacionMaritima om
        WHERE om.id_operacion = v_op.id_operacion;

        IF FOUND THEN
            -- Reglas para operaciones marítimas
            IF v_porcentaje_anterior >= 100 THEN
                SELECT id_estado_operacion INTO v_id_estado_nuevo
                FROM shared.EstadoOperacion
                WHERE nombre = 'Completada';
                
                v_correccion_aplicada := TRUE;
                v_descripcion_correccion := 'Sincronización por trayecto completado';
            END IF;
        END IF;

        -- Regla de cierre automático
        IF v_op.fecha_fin IS NULL AND (NOW() - v_op.fecha_inicio) > INTERVAL '48 hours' THEN
            v_fecha_fin_corregida := v_op.fecha_inicio + INTERVAL '72 hours';
            
            SELECT id_estado_operacion INTO v_id_estado_nuevo
            FROM shared.EstadoOperacion
            WHERE nombre = 'Completada';
            
            UPDATE shared.Operacion
            SET fecha_fin = v_fecha_fin_corregida,
                id_estado_operacion = v_id_estado_nuevo
            WHERE id_operacion = v_op.id_operacion;
            
            v_correccion_aplicada := TRUE;
            v_descripcion_correccion := 'Cierre automático por vencimiento';
            v_tipo_correccion := 'CIERRE_AUTOMATICO';
        END IF;

        -- Calcular métricas
        IF v_op.fecha_inicio IS NOT NULL AND v_fecha_fin_corregida IS NOT NULL THEN
            v_duracion_horas := EXTRACT(EPOCH FROM (v_fecha_fin_corregida - v_op.fecha_inicio)) / 3600;
        END IF;

        SELECT COUNT(*) INTO v_incidencias_total
        FROM shared.Incidencia
        WHERE id_operacion = v_op.id_operacion;

        SELECT COUNT(*) INTO v_incidencias_alta
        FROM shared.Incidencia
        WHERE id_operacion = v_op.id_operacion AND grado_severidad >= 4;

        -- Insertar en tabla de hechos si hubo corrección
        IF v_correccion_aplicada THEN
            INSERT INTO gestion_maritima_audit.FactConciliacionOperacion (
                id_operacion, id_fecha_corte,
                id_estado_operacion_anterior, id_estado_operacion_nuevo,
                id_buque, tipo_operacion, tipo_correccion,
                fecha_inicio_operacion, fecha_fin_corregida,
                duracion_real_horas,
                incidencias_asociadas, incidencias_alta_severidad,
                correccion_aplicada, descripcion_correccion,
                fecha_registro_batch
            ) VALUES (
                v_op.id_operacion, v_id_fecha,
                v_id_estado_anterior, v_id_estado_nuevo,
                v_id_buque, v_tipo_operacion, v_tipo_correccion,
                v_op.fecha_inicio, v_fecha_fin_corregida,
                v_duracion_horas,
                v_incidencias_total, v_incidencias_alta,
                v_correccion_aplicada, v_descripcion_correccion,
                NOW()
            );
        END IF;

    END LOOP;

    CLOSE cur_op;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- COMENTARIOS
-- ============================================

COMMENT ON SCHEMA shared IS 'Schema compartido con tablas comunes entre múltiples módulos';
COMMENT ON SCHEMA gestion_reserva IS 'Sistema de Gestión de Reservas - Módulo 1';
COMMENT ON SCHEMA personal_tripulacion IS 'Sistema de Gestión del Personal y Tripulación - Módulo 2';
COMMENT ON SCHEMA gestion_maritima IS 'Sistema de Gestión de Operaciones Marítimas - Módulo 3';
COMMENT ON SCHEMA operaciones_terrestres IS 'Sistema de Gestión de Operaciones Terrestres - Módulo 4.4';
COMMENT ON SCHEMA mantenimiento_logistico IS 'Sistema de Gestión de Mantenimiento Logístico - Módulo 4.1';
COMMENT ON SCHEMA monitoreo IS 'Sistema de Monitoreo de Entrega - Módulo 5';
COMMENT ON SCHEMA gestion_maritima_audit IS 'Auditoría batch de conciliación nocturna - Módulo 3 (docs 11)';

-- ============================================
-- FIN DEL SCRIPT CONSOLIDADO
-- Total de schemas: 8 (1 shared + 6 módulos + 1 auditoría batch)
-- ============================================