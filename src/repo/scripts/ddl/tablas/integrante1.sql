-- ============================================
-- SCHEMA: gestion_reserva
-- ============================================

DROP SCHEMA IF EXISTS gestion_reserva CASCADE;
CREATE SCHEMA gestion_reserva;

-- ============================================
-- TABLAS DE DOMINIO (LOOKUP TABLES)
-- ============================================

CREATE TABLE gestion_reserva.TipoTelefono (
    id_tipo_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE gestion_reserva.EspecialidadEmpleado (
    id_especialidad_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE gestion_reserva.EstadoContrato (
    id_estado_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE gestion_reserva.EstadoContenedor (
    id_estado_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE gestion_reserva.TipoContenedor (
    id_tipo_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_costo_tipo_cont CHECK (costo >= 0)
);

CREATE TABLE gestion_reserva.EstadoEmbarcacion (
    id_estado_embarcacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE gestion_reserva.EstadoOperacion (
    id_estado_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE gestion_reserva.EstadoReserva (
    id_estado_reserva UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

CREATE TABLE gestion_reserva.Contrato (
    id_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_vencimiento DATE NOT NULL,
    id_estado_contrato UUID NOT NULL,
    CONSTRAINT fk_contrato_estado FOREIGN KEY (id_estado_contrato) 
        REFERENCES gestion_reserva.EstadoContrato(id_estado_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_contrato CHECK (fecha_vencimiento >= fecha_emision)
);

CREATE TABLE gestion_reserva.Empleado (
    id_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_especialidad UUID NOT NULL,
    id_contrato UUID NOT NULL UNIQUE,
    CONSTRAINT fk_empleado_especialidad FOREIGN KEY (id_especialidad) 
        REFERENCES gestion_reserva.EspecialidadEmpleado(id_especialidad_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (id_contrato) 
        REFERENCES gestion_reserva.Contrato(id_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_dni_numerico CHECK (dni ~ '^[0-9]{8}$')
);

CREATE TABLE gestion_reserva.EmpleadoTelefono (
    id_empleado_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_tipo_telefono UUID,
    CONSTRAINT fk_empleado_telefono_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_reserva.Empleado(id_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_telefono_tipo FOREIGN KEY (id_tipo_telefono) 
        REFERENCES gestion_reserva.TipoTelefono(id_tipo_telefono)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_empleado_telefono UNIQUE (id_empleado, telefono),
    CONSTRAINT chk_telefono CHECK (LENGTH(TRIM(telefono)) >= 7)
);

CREATE TABLE gestion_reserva.AgenteReservas (
    id_agente_reservas UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    CONSTRAINT fk_agente_reservas_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_reserva.Empleado(id_empleado)
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
        REFERENCES gestion_reserva.TipoTelefono(id_tipo_telefono)
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

CREATE TABLE gestion_reserva.Contenedor (
    id_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    peso DECIMAL(10,2) NOT NULL,
    capacidad DECIMAL(10,2) NOT NULL,
    dimensiones VARCHAR(50) NOT NULL,
    id_estado_contenedor UUID NOT NULL,
    id_tipo_contenedor UUID NOT NULL,
    CONSTRAINT fk_contenedor_estado FOREIGN KEY (id_estado_contenedor) 
        REFERENCES gestion_reserva.EstadoContenedor(id_estado_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_contenedor_tipo FOREIGN KEY (id_tipo_contenedor) 
        REFERENCES gestion_reserva.TipoContenedor(id_tipo_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_peso CHECK (peso >= 0),
    CONSTRAINT chk_capacidad CHECK (capacidad > 0 AND peso <= capacidad)
);

CREATE TABLE gestion_reserva.ContenedorMercancia (
    id_contenedor_mercancia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenedor UUID NOT NULL,
    tipo_mercancia VARCHAR(100) NOT NULL,
    CONSTRAINT fk_contenedor_mercancia_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES gestion_reserva.Contenedor(id_contenedor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uk_contenedor_mercancia UNIQUE (id_contenedor, tipo_mercancia)
);

CREATE TABLE gestion_reserva.Buque (
    id_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    matricula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    id_estado_embarcacion UUID NOT NULL,
    peso DECIMAL(15,2) NOT NULL,
    ubicacion_actual VARCHAR(100),
    CONSTRAINT fk_buque_estado FOREIGN KEY (id_estado_embarcacion) 
        REFERENCES gestion_reserva.EstadoEmbarcacion(id_estado_embarcacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_capacidad_buque CHECK (capacidad > 0),
    CONSTRAINT chk_peso_buque CHECK (peso > 0)
);

CREATE TABLE gestion_reserva.Certificacion (
    id_certificacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE gestion_reserva.CertificacionBuque (
    id_certificacion_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_buque UUID NOT NULL,
    id_certificacion UUID NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    CONSTRAINT fk_cert_buque_buque FOREIGN KEY (id_buque) 
        REFERENCES gestion_reserva.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_cert_buque_cert FOREIGN KEY (id_certificacion) 
        REFERENCES gestion_reserva.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_buque_certificacion UNIQUE (id_buque, id_certificacion),
    CONSTRAINT chk_fechas_cert CHECK (fecha_vencimiento >= fecha_emision)
);

CREATE TABLE gestion_reserva.Ruta (
    id_ruta UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,
    tarifa DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_duracion CHECK (duracion > 0),
    CONSTRAINT chk_tarifa CHECK (tarifa >= 0)
);

CREATE TABLE gestion_reserva.Operacion (
    id_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP,
    id_estado_operacion UUID NOT NULL,
    CONSTRAINT fk_operacion_estado FOREIGN KEY (id_estado_operacion) 
        REFERENCES gestion_reserva.EstadoOperacion(id_estado_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_operacion CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE gestion_reserva.OperacionTerrestre (
    id_operacion_terrestre UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    costo_operacion_terrestre DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_operacion_terrestre_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_reserva.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_costo_operacion CHECK (costo_operacion_terrestre >= 0)
);

CREATE TABLE gestion_reserva.OperacionMaritima (
    id_operacion_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    cantidad_contenedores INT NOT NULL,
    porcentaje_trayecto DECIMAL(5,2) NOT NULL,
    id_buque UUID NOT NULL,
    CONSTRAINT fk_operacion_maritima_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_reserva.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_maritima_buque FOREIGN KEY (id_buque) 
        REFERENCES gestion_reserva.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_maritima_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_operacion_maritima_contenedores CHECK (cantidad_contenedores >= 0),
    CONSTRAINT chk_operacion_maritima_porcentaje CHECK (porcentaje_trayecto BETWEEN 0 AND 100)
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
        REFERENCES gestion_reserva.EstadoReserva(id_estado_reserva)
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
        REFERENCES gestion_reserva.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_ruta FOREIGN KEY (id_ruta) 
        REFERENCES gestion_reserva.Ruta(id_ruta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_pago_total CHECK (pago_total IS NULL OR pago_total >= 0)
);

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

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
        REFERENCES gestion_reserva.Contenedor(id_contenedor)
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
        REFERENCES gestion_reserva.OperacionMaritima(id_operacion_maritima)
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
        REFERENCES gestion_reserva.OperacionTerrestre(id_operacion_terrestre)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================
-- FIN DEL SCRIPT DDL
-- ============================================