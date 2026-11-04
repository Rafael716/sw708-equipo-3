-- ============================================
-- SCHEMA: monitoreo
-- Sistema de Monitoreo de Entrega
-- ============================================

DROP SCHEMA IF EXISTS monitoreo CASCADE;
CREATE SCHEMA monitoreo;

-- ============================================
-- TABLAS DE DOMINIO (LOOKUP TABLES)
-- ============================================

CREATE TABLE monitoreo.EstadoOperacion (
    id_estado_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EspecialidadEmpleado (
    id_especialidad_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EstadoContenedor (
    id_estado_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.TipoContenedor (
    id_tipo_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_costo_tipo_cont CHECK (costo >= 0)
);

CREATE TABLE monitoreo.TipoDocumento (
    id_tipo_documento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EstadoEntrega (
    id_estado_entrega UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.TipoSensor (
    id_tipo_sensor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.RolSensor (
    id_rol_sensor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.TipoNotificacion (
    id_tipo_notificacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.TipoIncidencia (
    id_tipo_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EstadoEmbarcacion (
    id_estado_embarcacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.TipoVehiculo (
    id_tipo_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EstadoVehiculo (
    id_estado_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EstadoIncidencia (
    id_estado_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.RolUsuario (
    id_rol_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.TipoActivo (
    id_tipo_activo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EstadoActivo (
    id_estado_activo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.EstadoContrato (
    id_estado_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE monitoreo.TipoTelefono (
    id_tipo_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

CREATE TABLE monitoreo.Contrato (
    id_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_vencimiento DATE NOT NULL,
    id_estado_contrato UUID NOT NULL,
    CONSTRAINT fk_contrato_estado FOREIGN KEY (id_estado_contrato) 
        REFERENCES monitoreo.EstadoContrato(id_estado_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_contrato CHECK (fecha_vencimiento >= fecha_emision)
);

CREATE TABLE monitoreo.Empleado (
    id_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_especialidad_empleado UUID NOT NULL,
    id_contrato UUID NOT NULL,
    CONSTRAINT fk_empleado_rol FOREIGN KEY (id_especialidad_empleado) 
        REFERENCES monitoreo.EspecialidadEmpleado(id_especialidad_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (id_contrato) 
        REFERENCES monitoreo.Contrato(id_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_dni_numerico CHECK (dni ~ '^[0-9]{8}$')
);

CREATE TABLE monitoreo.EmpleadoTelefono (
    id_empleado_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_tipo_telefono UUID,
    CONSTRAINT fk_empleado_telefono_empleado FOREIGN KEY (id_empleado) 
        REFERENCES monitoreo.Empleado(id_empleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_telefono_tipo FOREIGN KEY (id_tipo_telefono) 
        REFERENCES monitoreo.TipoTelefono(id_tipo_telefono)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_empleado_telefono UNIQUE (id_empleado, telefono),
    CONSTRAINT chk_telefono CHECK (LENGTH(TRIM(telefono)) >= 7)
);

CREATE TABLE monitoreo.Operador (
    id_operador UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    turno VARCHAR(20) NOT NULL,
    zona_monitoreo VARCHAR(100) NOT NULL,
    CONSTRAINT fk_operador_empleado FOREIGN KEY (id_empleado) 
        REFERENCES monitoreo.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_turno CHECK (turno IN ('Mañana', 'Tarde', 'Noche'))
);

CREATE TABLE monitoreo.Operacion (
    id_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP,
    id_estado_operacion UUID NOT NULL,
    CONSTRAINT fk_operacion_estado FOREIGN KEY (id_estado_operacion) 
        REFERENCES monitoreo.EstadoOperacion(id_estado_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_fechas_operacion CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE monitoreo.OperacionMonitoreo (
    id_operacion_monitoreo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    CONSTRAINT fk_operacion_monitoreo FOREIGN KEY (id_operacion) 
        REFERENCES monitoreo.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.Contenedor (
    id_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    peso DECIMAL(10,2) NOT NULL,
    capacidad DECIMAL(10,2) NOT NULL,
    dimensiones VARCHAR(50) NOT NULL,
    id_estado_contenedor UUID NOT NULL,
    id_tipo_contenedor UUID NOT NULL,
    CONSTRAINT fk_contenedor_estado FOREIGN KEY (id_estado_contenedor) 
        REFERENCES monitoreo.EstadoContenedor(id_estado_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_contenedor_tipo FOREIGN KEY (id_tipo_contenedor) 
        REFERENCES monitoreo.TipoContenedor(id_tipo_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_peso CHECK (peso >= 0),
    CONSTRAINT chk_capacidad CHECK (capacidad > 0 AND peso <= capacidad)
);

CREATE TABLE monitoreo.Documentacion (
    id_documentacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
    id_tipo_documento UUID NOT NULL,
    CONSTRAINT fk_documentacion_tipo FOREIGN KEY (id_tipo_documento) 
        REFERENCES monitoreo.TipoDocumento(id_tipo_documento)
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
        REFERENCES monitoreo.Contenedor(id_contenedor)
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
        REFERENCES monitoreo.TipoSensor(id_tipo_sensor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_sensor_rol FOREIGN KEY (id_rol_sensor) 
        REFERENCES monitoreo.RolSensor(id_rol_sensor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_sensor_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES monitoreo.Contenedor(id_contenedor)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

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
        REFERENCES monitoreo.TipoNotificacion(id_tipo_notificacion)
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

CREATE TABLE monitoreo.Usuario (
    id_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    id_rol_usuario UUID NOT NULL,
    CONSTRAINT fk_usuario_empleado FOREIGN KEY (id_empleado) 
        REFERENCES monitoreo.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol_usuario) 
        REFERENCES monitoreo.RolUsuario(id_rol_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_correo CHECK (correo_electronico ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE monitoreo.Incidencia (
    id_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_incidencia UUID NOT NULL,
    descripcion TEXT NOT NULL,
    grado_severidad INT NOT NULL DEFAULT 1,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estado_incidencia UUID NOT NULL,
    id_operacion UUID NOT NULL,
    id_usuario UUID NOT NULL,
    CONSTRAINT fk_incidencia_tipo FOREIGN KEY (id_tipo_incidencia) 
        REFERENCES monitoreo.TipoIncidencia(id_tipo_incidencia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_estado FOREIGN KEY (id_estado_incidencia) 
        REFERENCES monitoreo.EstadoIncidencia(id_estado_incidencia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_operacion FOREIGN KEY (id_operacion) 
        REFERENCES monitoreo.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_usuario FOREIGN KEY (id_usuario) 
        REFERENCES monitoreo.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_severidad CHECK (grado_severidad BETWEEN 1 AND 5)
);

CREATE TABLE monitoreo.IncidenciaReporte (
    id_incidencia_reporte UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_incidencia UUID NOT NULL,
    id_reporte UUID NOT NULL,
    CONSTRAINT uk_incidencia_reporte UNIQUE (id_incidencia, id_reporte),
    CONSTRAINT fk_inc_reporte_inc FOREIGN KEY (id_incidencia) 
        REFERENCES monitoreo.Incidencia(id_incidencia)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_inc_reporte_rep FOREIGN KEY (id_reporte) 
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
        REFERENCES monitoreo.EstadoEntrega(id_estado_entrega)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_entrega_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES monitoreo.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_entrega_importador FOREIGN KEY (id_importador) 
        REFERENCES monitoreo.Importador(id_importador)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.Activo (
    id_activo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    id_tipo_activo UUID NOT NULL,
    id_estado_activo UUID NOT NULL,
    ubicacion VARCHAR(100),
    CONSTRAINT fk_activo_tipo FOREIGN KEY (id_tipo_activo) 
        REFERENCES monitoreo.TipoActivo(id_tipo_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_activo_estado FOREIGN KEY (id_estado_activo) 
        REFERENCES monitoreo.EstadoActivo(id_estado_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE monitoreo.Vehiculo (
    id_vehiculo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_activo UUID NOT NULL UNIQUE,
    placa VARCHAR(20) NOT NULL UNIQUE,
    capacidad_ton DECIMAL(10,2) NOT NULL,
    id_tipo_vehiculo UUID NOT NULL,
    id_estado_vehiculo UUID NOT NULL,
    CONSTRAINT fk_vehiculo_activo FOREIGN KEY (id_activo) 
        REFERENCES monitoreo.Activo(id_activo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_vehiculo_tipo FOREIGN KEY (id_tipo_vehiculo) 
        REFERENCES monitoreo.TipoVehiculo(id_tipo_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_vehiculo_estado FOREIGN KEY (id_estado_vehiculo) 
        REFERENCES monitoreo.EstadoVehiculo(id_estado_vehiculo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_capacidad_ton CHECK (capacidad_ton > 0)
);

CREATE TABLE monitoreo.Buque (
    id_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    matricula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    id_estado_embarcacion UUID NOT NULL,
    peso DECIMAL(15,2) NOT NULL,
    ubicacion_actual VARCHAR(100),
    CONSTRAINT fk_buque_estado FOREIGN KEY (id_estado_embarcacion) 
        REFERENCES monitoreo.EstadoEmbarcacion(id_estado_embarcacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_capacidad_buque CHECK (capacidad > 0),
    CONSTRAINT chk_peso_buque CHECK (peso > 0)
);

CREATE TABLE monitoreo.PosicionContenedor (
    id_posicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenedor UUID NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_posicion_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES monitoreo.Contenedor(id_contenedor)
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
        REFERENCES monitoreo.Vehiculo(id_vehiculo)
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
        REFERENCES monitoreo.Buque(id_buque)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_latitud_buq CHECK (latitud BETWEEN -90 AND 90),
    CONSTRAINT chk_longitud_buq CHECK (longitud BETWEEN -180 AND 180)
);

CREATE INDEX idx_posicion_buque_fecha ON monitoreo.PosicionBuque(id_buque, fecha_hora);

-- ============================================
-- TABLAS ASOCIATIVAS CON SURROGATE KEYS
-- ============================================

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
        REFERENCES monitoreo.Vehiculo(id_vehiculo)
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
        REFERENCES monitoreo.Buque(id_buque)
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
        REFERENCES monitoreo.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_cont_veh_veh FOREIGN KEY (id_vehiculo) 
        REFERENCES monitoreo.Vehiculo(id_vehiculo)
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
        REFERENCES monitoreo.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_cont_buq_buq FOREIGN KEY (id_buque) 
        REFERENCES monitoreo.Buque(id_buque)
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

-- ============================================
-- COMENTARIOS SOBRE EL ESQUEMA
-- ============================================

COMMENT ON SCHEMA monitoreo IS 'Sistema de Monitoreo de Entrega - Módulo 5';

COMMENT ON TABLE monitoreo.Empleado IS 'Persona que trabaja en la empresa de logística';
COMMENT ON TABLE monitoreo.Operador IS 'Empleado especializado en operaciones de monitoreo';
COMMENT ON TABLE monitoreo.Contenedor IS 'Unidad estandarizada de transporte de mercancías';
COMMENT ON TABLE monitoreo.Sensor IS 'Dispositivo IoT para monitoreo de contenedores';
COMMENT ON TABLE monitoreo.Notificacion IS 'Alerta generada por sensores del contenedor';
COMMENT ON TABLE monitoreo.Incidencia IS 'Evento negativo o problema registrado durante una operación';
COMMENT ON TABLE monitoreo.Reporte IS 'Documento que consolida información del monitoreo';
COMMENT ON TABLE monitoreo.Entrega IS 'Proceso de entrega de contenedores al importador';
COMMENT ON TABLE monitoreo.Vehiculo IS 'Medio de transporte utilizado en operaciones terrestres';
COMMENT ON TABLE monitoreo.Buque IS 'Embarcación de transporte marítimo';
