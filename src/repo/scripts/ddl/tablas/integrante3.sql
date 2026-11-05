-- ============================================================
-- SCHEMA: GESTIÓN MARÍTIMA
-- Módulo de Gestión de Operaciones Marítimas
-- PostgreSQL con UUID nativos y restricciones
-- ============================================================

CREATE SCHEMA IF NOT EXISTS gestion_maritima;

-- Habilitar extensión UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- TABLAS DE CATÁLOGOS (Sin dependencias)
-- ============================================================

-- Tabla: EstadoOperacion
CREATE TABLE gestion_maritima.EstadoOperacion (
    id_estado_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_operacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: EstatusNavegacion
CREATE TABLE gestion_maritima.EstatusNavegacion (
    id_estatus_navegacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estatus_navegacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: EstadoEmbarcacion
CREATE TABLE gestion_maritima.EstadoEmbarcacion (
    id_estado_embarcacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_embarcacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: EstadoContenedor
CREATE TABLE gestion_maritima.EstadoContenedor (
    id_estado_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_contenedor_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: TipoContenedor
CREATE TABLE gestion_maritima.TipoContenedor (
    id_tipo_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_tipo_contenedor_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_tipo_contenedor_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_tipo_contenedor_costo CHECK (costo >= 0)
);

-- Tabla: TipoEquipoPortuario
CREATE TABLE gestion_maritima.TipoEquipoPortuario (
    id_tipo_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_tipo_equipo_portuario_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: EstadoEquipoPortuario
CREATE TABLE gestion_maritima.EstadoEquipoPortuario (
    id_estado_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_estado_equipo_portuario_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: EstadoInspeccion
CREATE TABLE gestion_maritima.EstadoInspeccion (
    id_estado_inspeccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_estado_inspeccion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: TipoInspeccion
CREATE TABLE gestion_maritima.TipoInspeccion (
    id_tipo_inspeccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_inspeccion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: TipoHallazgo
CREATE TABLE gestion_maritima.TipoHallazgo (
    id_tipo_hallazgo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_hallazgo_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: TipoOperacionPortuaria
CREATE TABLE gestion_maritima.TipoOperacionPortuaria (
    id_tipo_operacion_portuaria UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_operacion_portuaria_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: Turno
CREATE TABLE gestion_maritima.Turno (
    id_turno UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_turno_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: EquipoProteccion
CREATE TABLE gestion_maritima.EquipoProteccion (
    id_equipo_proteccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_equipo_proteccion_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: CondicionOperativa
CREATE TABLE gestion_maritima.CondicionOperativa (
    id_condicion_operativa UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_condicion_operativa_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: Prioridad
CREATE TABLE gestion_maritima.Prioridad (
    id_prioridad UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_prioridad_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: EstadoContrato
CREATE TABLE gestion_maritima.EstadoContrato (
    id_estado_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_estado_contrato_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: TipoTelefono
CREATE TABLE gestion_maritima.TipoTelefono (
    id_tipo_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_telefono_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: RolUsuario
CREATE TABLE gestion_maritima.RolUsuario (
    id_rol_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_rol_usuario_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: Especialidad
CREATE TABLE gestion_maritima.EspecialidadEmpleado (
    id_especialidad_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_especialidad_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- Tabla: TipoIncidencia
CREATE TABLE gestion_maritima.TipoIncidencia (
    id_tipo_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT chk_tipo_incidencia_nombre CHECK (LENGTH(TRIM(nombre)) > 0)
);

-- ============================================================
-- TABLAS PRINCIPALES (Con dependencias)
-- ============================================================

-- Tabla: Puerto
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

-- Tabla: Muelle
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

-- Tabla: Buque
CREATE TABLE gestion_maritima.Buque (
    id_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    matricula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    id_estado_embarcacion UUID NOT NULL,
    peso DECIMAL(15,2) NOT NULL,
    ubicacion_actual VARCHAR(100),
    CONSTRAINT fk_buque_estado FOREIGN KEY (id_estado_embarcacion) 
        REFERENCES gestion_maritima.EstadoEmbarcacion(id_estado_embarcacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_buque_matricula CHECK (LENGTH(TRIM(matricula)) > 0),
    CONSTRAINT chk_buque_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_buque_capacidad CHECK (capacidad > 0),
    CONSTRAINT chk_buque_peso CHECK (peso > 0)
);

-- Tabla: Operacion
CREATE TABLE gestion_maritima.Operacion (
    id_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    id_estado_operacion UUID NOT NULL,
    CONSTRAINT fk_operacion_estado FOREIGN KEY (id_estado_operacion) 
        REFERENCES gestion_maritima.EstadoOperacion(id_estado_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_operacion_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

-- Tabla: OperacionMaritima
CREATE TABLE gestion_maritima.OperacionMaritima (
    id_operacion_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    cantidad_contenedores INT NOT NULL,
    id_estatus_navegacion UUID NOT NULL,
    porcentaje_trayecto DECIMAL(5,2) NOT NULL,
    id_buque UUID NOT NULL,
    CONSTRAINT fk_operacion_maritima_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_maritima.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_maritima_estatus FOREIGN KEY (id_estatus_navegacion) 
        REFERENCES gestion_maritima.EstatusNavegacion(id_estatus_navegacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_maritima_buque FOREIGN KEY (id_buque) 
        REFERENCES gestion_maritima.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_maritima_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_operacion_maritima_contenedores CHECK (cantidad_contenedores >= 0),
    CONSTRAINT chk_operacion_maritima_porcentaje CHECK (porcentaje_trayecto BETWEEN 0 AND 100)
);

-- Tabla: OperacionPortuaria
CREATE TABLE gestion_maritima.OperacionPortuaria (
    id_operacion_portuaria UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_puerto UUID NOT NULL,
    id_muelle UUID NOT NULL,
    id_tipo_operacion_portuaria UUID NOT NULL,
    id_buque UUID NOT NULL,
    CONSTRAINT fk_operacion_portuaria_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_maritima.Operacion(id_operacion)
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
        REFERENCES gestion_maritima.TipoOperacionPortuaria(id_tipo_operacion_portuaria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_portuaria_buque FOREIGN KEY (id_buque) 
        REFERENCES gestion_maritima.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_operacion_portuaria_codigo CHECK (LENGTH(TRIM(codigo)) > 0)
);

-- Tabla: Contenedor
CREATE TABLE gestion_maritima.Contenedor (
    id_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    peso DECIMAL(10,2) NOT NULL,
    capacidad DECIMAL(10,2) NOT NULL,
    dimensiones VARCHAR(50) NOT NULL,
    id_estado_contenedor UUID NOT NULL,
    id_tipo_contenedor UUID NOT NULL,
    CONSTRAINT fk_contenedor_estado FOREIGN KEY (id_estado_contenedor) 
        REFERENCES gestion_maritima.EstadoContenedor(id_estado_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_contenedor_tipo FOREIGN KEY (id_tipo_contenedor) 
        REFERENCES gestion_maritima.TipoContenedor(id_tipo_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_contenedor_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_contenedor_peso CHECK (peso >= 0),
    CONSTRAINT chk_contenedor_capacidad CHECK (capacidad > 0),
    CONSTRAINT chk_contenedor_dimensiones CHECK (LENGTH(TRIM(dimensiones)) > 0)
);

-- Tabla: EquipoPortuario
CREATE TABLE gestion_maritima.EquipoPortuario (
    id_equipo_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    capacidad DECIMAL(10,2) NOT NULL,
    id_tipo_equipo_portuario UUID NOT NULL,
    id_estado_equipo_portuario UUID NOT NULL,
    ubicacion VARCHAR(100),
    CONSTRAINT fk_equipo_portuario_tipo FOREIGN KEY (id_tipo_equipo_portuario) 
        REFERENCES gestion_maritima.TipoEquipoPortuario(id_tipo_equipo_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_equipo_portuario_estado FOREIGN KEY (id_estado_equipo_portuario) 
        REFERENCES gestion_maritima.EstadoEquipoPortuario(id_estado_equipo_portuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_equipo_portuario_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_equipo_portuario_capacidad CHECK (capacidad > 0)
);

-- Tabla: Contrato
CREATE TABLE gestion_maritima.Contrato (
    id_contrato UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    id_estado_contrato UUID NOT NULL,
    CONSTRAINT fk_contrato_estado FOREIGN KEY (id_estado_contrato) 
        REFERENCES gestion_maritima.EstadoContrato(id_estado_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_contrato_fechas CHECK (fecha_vencimiento > fecha_emision)
);

-- Tabla: Empleado
CREATE TABLE gestion_maritima.Empleado (
    id_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_especialidad_empleado UUID NOT NULL,
    id_contrato UUID NOT NULL UNIQUE,
    CONSTRAINT fk_empleado_especialidad FOREIGN KEY (id_especialidad_empleado) 
        REFERENCES gestion_maritima.EspecialidadEmpleado(id_especialidad_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (id_contrato) 
        REFERENCES gestion_maritima.Contrato(id_contrato)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_empleado_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_empleado_dni CHECK (dni ~ '^\d{8}$'),
    CONSTRAINT chk_empleado_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_empleado_apellido CHECK (LENGTH(TRIM(apellido)) > 0)
);

-- Tabla: Usuario
CREATE TABLE gestion_maritima.Usuario (
    id_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    id_rol_usuario UUID NOT NULL,
    id_empleado UUID NOT NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol_usuario) 
        REFERENCES gestion_maritima.RolUsuario(id_rol_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_maritima.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_usuario_email CHECK (correo_electronico ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_usuario_contrasena CHECK (LENGTH(contrasena) >= 8)
);

-- Tabla: Tripulante
CREATE TABLE gestion_maritima.Tripulante (
    id_tripulante UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    nacionalidad VARCHAR(50) NOT NULL,
    CONSTRAINT fk_tripulante_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_maritima.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_tripulante_nacionalidad CHECK (LENGTH(TRIM(nacionalidad)) > 0)
);

-- Tabla: TrabajadorPortuario
CREATE TABLE gestion_maritima.TrabajadorPortuario (
    id_trabajador_portuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL UNIQUE,
    disponibilidad BOOLEAN NOT NULL DEFAULT TRUE,
    id_turno UUID NOT NULL,
    CONSTRAINT fk_trabajador_portuario_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_maritima.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_trabajador_portuario_turno FOREIGN KEY (id_turno) 
        REFERENCES gestion_maritima.Turno(id_turno)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Tabla: Certificacion
CREATE TABLE gestion_maritima.Certificacion (
    id_certificacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT chk_certificacion_nombre CHECK (LENGTH(TRIM(nombre)) > 0),
    CONSTRAINT chk_certificacion_descripcion CHECK (LENGTH(TRIM(descripcion)) > 0)
);

-- Tabla: CertificacionAduanera
CREATE TABLE gestion_maritima.CertificacionAduanera (
    id_certificacion_aduanera UUID PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    pais_aplicacion VARCHAR(100) NOT NULL,
    fecha_emision  TIMESTAMP WITH TIME ZONE NOT NULL,
    fecha_expiracion TIMESTAMP WITH TIME ZONE NOT NULL,
    CONSTRAINT fk_certificacion_aduanera_cert FOREIGN KEY (id_certificacion_aduanera) 
        REFERENCES gestion_maritima.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_cert_aduanera_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_cert_aduanera_descripcion CHECK (LENGTH(TRIM(descripcion)) > 0),
    CONSTRAINT chk_cert_aduanera_fechas CHECK (fecha_expiracion > fecha_emision)
);

-- Tabla: Ruta
CREATE TABLE gestion_maritima.Ruta (
    id_ruta UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,
    tarifa DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_ruta_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_ruta_origen CHECK (LENGTH(TRIM(origen)) > 0),
    CONSTRAINT chk_ruta_destino CHECK (LENGTH(TRIM(destino)) > 0),
    CONSTRAINT chk_ruta_duracion CHECK (duracion > 0),
    CONSTRAINT chk_ruta_tarifa CHECK (tarifa >= 0)
);

-- Tabla: RutaMaritima
CREATE TABLE gestion_maritima.RutaMaritima (
    id_ruta_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_ruta UUID NOT NULL UNIQUE,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    distancia DECIMAL(10,2) NOT NULL,
    id_puerto_origen UUID NOT NULL,
    id_puerto_destino UUID NOT NULL,
    CONSTRAINT fk_ruta_maritima_ruta FOREIGN KEY (id_ruta) 
        REFERENCES gestion_maritima.Ruta(id_ruta)
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

-- Tabla: Inspeccion
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
        REFERENCES gestion_maritima.TipoInspeccion(id_tipo_inspeccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_estado FOREIGN KEY (id_estado_inspeccion) 
        REFERENCES gestion_maritima.EstadoInspeccion(id_estado_inspeccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_prioridad FOREIGN KEY (id_prioridad) 
        REFERENCES gestion_maritima.Prioridad(id_prioridad)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_maritima.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_usuario FOREIGN KEY (id_usuario) 
        REFERENCES gestion_maritima.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_inspeccion_codigo CHECK (LENGTH(TRIM(codigo)) > 0)
);

-- Tabla: Hallazgo
CREATE TABLE gestion_maritima.Hallazgo (
    id_hallazgo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_hallazgo UUID NOT NULL,
    nivel_gravedad INT NOT NULL,
    descripcion TEXT NOT NULL,
    accion_sugerida TEXT,
    id_inspeccion UUID NOT NULL,
    CONSTRAINT fk_hallazgo_tipo FOREIGN KEY (id_tipo_hallazgo) 
        REFERENCES gestion_maritima.TipoHallazgo(id_tipo_hallazgo)
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

-- Tabla: Incidencia
CREATE TABLE gestion_maritima.Incidencia (
    id_incidencia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(20) NOT NULL UNIQUE,
    id_tipo_incidencia UUID NOT NULL,
    descripcion TEXT NOT NULL,
    grado_severidad INT NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_operacion UUID NOT NULL,
    id_usuario UUID NOT NULL,
    CONSTRAINT fk_incidencia_tipo FOREIGN KEY (id_tipo_incidencia) 
        REFERENCES gestion_maritima.TipoIncidencia(id_tipo_incidencia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_maritima.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_usuario FOREIGN KEY (id_usuario) 
        REFERENCES gestion_maritima.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_incidencia_codigo CHECK (LENGTH(TRIM(codigo)) > 0),
    CONSTRAINT chk_incidencia_severidad CHECK (grado_severidad BETWEEN 1 AND 5),
    CONSTRAINT chk_incidencia_descripcion CHECK (LENGTH(TRIM(descripcion)) > 0)
);

-- Tabla: OperacionRutaMaritima
CREATE TABLE gestion_maritima.OperacionRutaMaritima (
    id_operacion_ruta_maritima UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_maritima UUID NOT NULL UNIQUE,
    id_ruta_maritima UUID NOT NULL,
    id_muelle_origen UUID NOT NULL,
    id_muelle_destino UUID NOT NULL,
    CONSTRAINT fk_operacion_ruta_maritima_operacion FOREIGN KEY (id_operacion_maritima) 
        REFERENCES gestion_maritima.OperacionMaritima(id_operacion_maritima)
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

-- Tabla: Estiba
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
        REFERENCES gestion_maritima.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_estiba_ubicacion CHECK (LENGTH(TRIM(ubicacion)) > 0),
    CONSTRAINT chk_estiba_zona CHECK (LENGTH(TRIM(zona_buque)) > 0)
);

CREATE INDEX idx_estiba_operacion_portuaria ON gestion_maritima.Estiba(id_operacion_portuaria);
CREATE INDEX idx_estiba_contenedor ON gestion_maritima.Estiba(id_contenedor);

-- ============================================================
-- TABLAS ASOCIATIVAS
-- ============================================================

-- Tabla: ContenedorMercancia
CREATE TABLE gestion_maritima.ContenedorMercancia (
    id_contenedor_mercancia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_contenedor UUID NOT NULL,
    tipo_mercancia VARCHAR(100) NOT NULL,
    CONSTRAINT fk_contenedor_mercancia_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES gestion_maritima.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_contenedor_mercancia UNIQUE (id_contenedor, tipo_mercancia),
    CONSTRAINT chk_contenedor_mercancia_tipo CHECK (LENGTH(TRIM(tipo_mercancia)) > 0)
);

-- Tabla: EmpleadoTelefono
CREATE TABLE gestion_maritima.EmpleadoTelefono (
    id_empleado_telefono UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_tipo_telefono UUID NOT NULL,
    CONSTRAINT fk_empleado_telefono_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_maritima.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_empleado_telefono_tipo FOREIGN KEY (id_tipo_telefono) 
        REFERENCES gestion_maritima.TipoTelefono(id_tipo_telefono)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_empleado_telefono UNIQUE (id_empleado, telefono),
    CONSTRAINT chk_empleado_telefono_numero CHECK (telefono ~ '^\d{7,15}$')
);

-- Tabla: TrabajadorPortuarioEquipoProteccion
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
        REFERENCES gestion_maritima.EquipoProteccion(id_equipo_proteccion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_trabajador_equipo_proteccion UNIQUE (id_trabajador_portuario, id_equipo_proteccion)
);

-- Tabla: RutaPuertoIntermedio
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

CREATE INDEX idx_ruta_puerto_inter_ruta ON gestion_maritima.RutaPuertoIntermedio(id_ruta_maritima);
CREATE INDEX idx_ruta_puerto_inter_puerto ON gestion_maritima.RutaPuertoIntermedio(id_puerto);

-- Tabla: OperacionCertificacionAduanera
CREATE TABLE gestion_maritima.OperacionCertificacionAduanera (
    id_operacion_certificacion_aduanera UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_maritima UUID NOT NULL,
    id_certificacion_aduanera UUID NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_aprobacion DATE,
    CONSTRAINT fk_operacion_cert_adu_operacion FOREIGN KEY (id_operacion_maritima) 
        REFERENCES gestion_maritima.OperacionMaritima(id_operacion_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_cert_adu_certificacion FOREIGN KEY (id_certificacion_aduanera) 
        REFERENCES gestion_maritima.CertificacionAduanera(id_certificacion_aduanera)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_certificacion_aduanera UNIQUE (id_operacion_maritima, id_certificacion_aduanera),
    CONSTRAINT chk_operacion_cert_adu_estado CHECK (estado IN ('PENDIENTE', 'APROBADO', 'RECHAZADO'))
);

-- Tabla: TripulanteIdioma
CREATE TABLE gestion_maritima.TripulanteIdioma (
    id_tripulante_idioma UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_tripulante UUID NOT NULL,
    idioma VARCHAR(50) NOT NULL,
    nivel VARCHAR(20),
    CONSTRAINT fk_tripulante_idioma_tripulante FOREIGN KEY (id_tripulante) 
        REFERENCES gestion_maritima.Tripulante(id_tripulante)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_tripulante_idioma UNIQUE (id_tripulante, idioma),
    CONSTRAINT chk_tripulante_idioma_idioma CHECK (LENGTH(TRIM(idioma)) > 0),
    CONSTRAINT chk_tripulante_idioma_nivel CHECK (nivel IS NULL OR nivel IN ('Básico', 'Intermedio', 'Avanzado', 'Nativo'))
);

-- Tabla: OperacionMaritimaCondicion
CREATE TABLE gestion_maritima.OperacionMaritimaCondicion (
    id_operacion_maritima_condicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion_maritima UUID NOT NULL,
    id_condicion_operativa UUID NOT NULL,
    CONSTRAINT fk_operacion_mar_cond_operacion FOREIGN KEY (id_operacion_maritima) 
        REFERENCES gestion_maritima.OperacionMaritima(id_operacion_maritima)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_mar_cond_condicion FOREIGN KEY (id_condicion_operativa) 
        REFERENCES gestion_maritima.CondicionOperativa(id_condicion_operativa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_maritima_condicion UNIQUE (id_operacion_maritima, id_condicion_operativa)
);

-- Tabla: OperacionEmpleado
CREATE TABLE gestion_maritima.OperacionEmpleado (
    id_operacion_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL,
    id_empleado UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_desasignacion DATE,
    CONSTRAINT fk_operacion_empleado_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_maritima.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_empleado_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_maritima.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_empleado_fecha UNIQUE (id_operacion, id_empleado, fecha_asignacion),
    CONSTRAINT chk_operacion_empleado_fechas CHECK (fecha_desasignacion IS NULL OR fecha_desasignacion >= fecha_asignacion)
);

-- Tabla: UsuarioOperacion
CREATE TABLE gestion_maritima.UsuarioOperacion (
    id_usuario_operacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_usuario UUID NOT NULL,
    id_operacion UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    rol_en_operacion VARCHAR(50) NOT NULL,
    CONSTRAINT fk_usuario_operacion_usuario FOREIGN KEY (id_usuario) 
        REFERENCES gestion_maritima.Usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_operacion_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_maritima.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_usuario_operacion UNIQUE (id_usuario, id_operacion)
);

-- Tabla: TrabajadorPortuarioEquipoPortuario
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

-- Tabla: CertificacionEmpleado
CREATE TABLE gestion_maritima.CertificacionEmpleado (
    id_certificacion_empleado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_empleado UUID NOT NULL,
    id_certificacion UUID NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    CONSTRAINT fk_certificacion_empleado_empleado FOREIGN KEY (id_empleado) 
        REFERENCES gestion_maritima.Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_certificacion_empleado_certificacion FOREIGN KEY (id_certificacion) 
        REFERENCES gestion_maritima.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_certificacion_empleado UNIQUE (id_empleado, id_certificacion),
    CONSTRAINT chk_certificacion_empleado_fechas CHECK (fecha_vencimiento > fecha_emision)
);

-- Tabla: CertificacionBuque
CREATE TABLE gestion_maritima.CertificacionBuque (
    id_certificacion_buque UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_buque UUID NOT NULL,
    id_certificacion UUID NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    CONSTRAINT fk_certificacion_buque_buque FOREIGN KEY (id_buque) 
        REFERENCES gestion_maritima.Buque(id_buque)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_certificacion_buque_certificacion FOREIGN KEY (id_certificacion) 
        REFERENCES gestion_maritima.Certificacion(id_certificacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_certificacion_buque UNIQUE (id_buque, id_certificacion),
    CONSTRAINT chk_certificacion_buque_fechas CHECK (fecha_vencimiento > fecha_emision)
);

-- Tabla: OperacionContenedor
CREATE TABLE gestion_maritima.OperacionContenedor (
    id_operacion_contenedor UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_operacion UUID NOT NULL,
    id_contenedor UUID NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_operacion_contenedor_operacion FOREIGN KEY (id_operacion) 
        REFERENCES gestion_maritima.Operacion(id_operacion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_operacion_contenedor_contenedor FOREIGN KEY (id_contenedor) 
        REFERENCES gestion_maritima.Contenedor(id_contenedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uk_operacion_contenedor_fecha UNIQUE (id_operacion, id_contenedor, fecha_asignacion)
);

-- Tabla: OperacionEquipoPortuario
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

-- ============================================================
-- COMENTARIOS EN LAS TABLAS
-- ============================================================

COMMENT ON SCHEMA gestion_maritima IS 'Schema para el módulo de Gestión de Operaciones Marítimas';

COMMENT ON TABLE gestion_maritima.Operacion IS 'Tabla base para todas las operaciones del sistema';
COMMENT ON TABLE gestion_maritima.OperacionMaritima IS 'Operaciones de transporte marítimo entre puertos';
COMMENT ON TABLE gestion_maritima.OperacionPortuaria IS 'Operaciones realizadas dentro del puerto';
COMMENT ON TABLE gestion_maritima.Buque IS 'Embarcaciones utilizadas en operaciones marítimas';
COMMENT ON TABLE gestion_maritima.Contenedor IS 'Unidades de transporte de mercancías';
COMMENT ON TABLE gestion_maritima.Puerto IS 'Instalaciones portuarias donde se realizan operaciones';
COMMENT ON TABLE gestion_maritima.Muelle IS 'Estructuras de atraque dentro de los puertos';

-- ============================================================
-- FIN DEL SCRIPT
-- Total de tablas: 60
-- PostgreSQL 12+
-- ============================================================