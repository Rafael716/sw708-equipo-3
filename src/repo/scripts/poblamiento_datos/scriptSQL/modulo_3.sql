-- ============================================
-- SCRIPT DE IMPORTACIÓN CSV - MÓDULO 3
-- Sistema de Gestión Marítima
-- ============================================

-- CATÁLOGOS (Tablas sin dependencias)

-- 01. EstadoOperacion
COPY gestion_maritima.EstadoOperacion(id_estado_operacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/01_estado_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 02. EstatusNavegacion
COPY gestion_maritima.EstatusNavegacion(id_estatus_navegacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/02_estatus_navegacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 03. EstadoEmbarcacion
COPY gestion_maritima.EstadoEmbarcacion(id_estado_embarcacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/03_estado_embarcacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 04. EstadoContenedor
COPY gestion_maritima.EstadoContenedor(id_estado_contenedor, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/04_estado_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 05. TipoContenedor
COPY gestion_maritima.TipoContenedor(id_tipo_contenedor, codigo, nombre, costo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/05_tipo_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 06. TipoEquipoPortuario
COPY gestion_maritima.TipoEquipoPortuario(id_tipo_equipo_portuario, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/06_tipo_equipo_portuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 07. EstadoEquipoPortuario
COPY gestion_maritima.EstadoEquipoPortuario(id_estado_equipo_portuario, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/07_estado_equipo_portuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 08. EstadoInspeccion
COPY gestion_maritima.EstadoInspeccion(id_estado_inspeccion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/08_estado_inspeccion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 09. TipoInspeccion
COPY gestion_maritima.TipoInspeccion(id_tipo_inspeccion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/09_tipo_inspeccion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 10. TipoHallazgo
COPY gestion_maritima.TipoHallazgo(id_tipo_hallazgo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/10_tipo_hallazgo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 11. TipoOperacionPortuaria
COPY gestion_maritima.TipoOperacionPortuaria(id_tipo_operacion_portuaria, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/11_tipo_operacion_portuaria.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 12. Turno
COPY gestion_maritima.Turno(id_turno, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/12_turno.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 13. EquipoProteccion
COPY gestion_maritima.EquipoProteccion(id_equipo_proteccion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/13_equipo_proteccion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 14. CondicionOperativa
COPY gestion_maritima.CondicionOperativa(id_condicion_operativa, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/14_condicion_operativa.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 15. Prioridad
COPY gestion_maritima.Prioridad(id_prioridad, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/15_prioridad.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 16. EstadoContrato
COPY gestion_maritima.EstadoContrato(id_estado_contrato, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/16_estado_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 17. TipoTelefono
COPY gestion_maritima.TipoTelefono(id_tipo_telefono, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/17_tipo_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 18. RolUsuario
COPY gestion_maritima.RolUsuario(id_rol_usuario, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/18_rol_usuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 19. EspecialidadEmpleado
COPY gestion_maritima.EspecialidadEmpleado(id_especialidad_empleado, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/19_especialidad_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 20. TipoIncidencia
COPY gestion_maritima.TipoIncidencia(id_tipo_incidencia, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/20_tipo_incidencia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

-- 21. Puerto
COPY gestion_maritima.Puerto(id_puerto, codigo, nombre, pais, direccion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/21_puerto.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 22. Muelle
COPY gestion_maritima.Muelle(id_muelle, codigo, ubicacion, capacidad, disponibilidad, id_puerto)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/22_muelle.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 23. Contrato
COPY gestion_maritima.Contrato(id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/23_contrato.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 24. Empleado
COPY gestion_maritima.Empleado(id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/24_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 25. EmpleadoTelefono
COPY gestion_maritima.EmpleadoTelefono(id_empleado_telefono, id_empleado, telefono, id_tipo_telefono)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/25_empleado_telefono.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 26. Buque
COPY gestion_maritima.Buque(id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/26_buque.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 27. Contenedor
COPY gestion_maritima.Contenedor(id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/27_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 28. Tripulante
COPY gestion_maritima.Tripulante(id_tripulante, id_empleado, disponibilidad, nacionalidad)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/28_tripulante.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 29. TrabajadorPortuario
COPY gestion_maritima.TrabajadorPortuario(id_trabajador_portuario, id_empleado, disponibilidad, id_turno)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/29_trabajador_portuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 30. EquipoPortuario
COPY gestion_maritima.EquipoPortuario(id_equipo_portuario, codigo, capacidad, id_tipo_equipo_portuario, id_estado_equipo_portuario, ubicacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/30_equipo_portuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 31. Certificacion
COPY gestion_maritima.Certificacion(id_certificacion, nombre, descripcion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/31_certificacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 32. Operacion
COPY gestion_maritima.Operacion(id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/32_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 33. OperacionMaritima
COPY gestion_maritima.OperacionMaritima(id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, id_estatus_navegacion, porcentaje_trayecto, id_buque)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/33_operacion_maritima.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 34. OperacionPortuaria
COPY gestion_maritima.OperacionPortuaria(id_operacion_portuaria, id_operacion, codigo, id_puerto, id_muelle, id_tipo_operacion_portuaria, id_buque)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/34_operacion_portuaria.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 37. Usuario (ANTES de Inspeccion)
COPY gestion_maritima.Usuario(id_usuario, correo_electronico, contrasena, id_rol_usuario, id_empleado)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/37_usuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 35. Inspeccion
COPY gestion_maritima.Inspeccion(id_inspeccion, codigo, fecha, id_tipo_inspeccion, id_estado_inspeccion, id_prioridad, id_operacion, id_usuario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/35_inspeccion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 36. Hallazgo
COPY gestion_maritima.Hallazgo(id_hallazgo, codigo, id_tipo_hallazgo, nivel_gravedad, descripcion, accion_sugerida, id_inspeccion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/36_hallazgo.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 38. Incidencia
COPY gestion_maritima.Incidencia(id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_operacion, id_usuario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/38_incidencia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS ASOCIATIVAS
-- ============================================

-- 39. TripulanteIdioma
COPY gestion_maritima.TripulanteIdioma(id_tripulante_idioma, id_tripulante, idioma, nivel)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/39_tripulante_idioma.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 40. OperacionMaritimaCondicion
COPY gestion_maritima.OperacionMaritimaCondicion(id_operacion_maritima_condicion, id_operacion_maritima, id_condicion_operativa)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/40_operacion_maritima_condicion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 41. OperacionEmpleado
COPY gestion_maritima.OperacionEmpleado(id_operacion_empleado, id_operacion, id_empleado, fecha_asignacion, fecha_desasignacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/41_operacion_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 42. UsuarioOperacion
COPY gestion_maritima.UsuarioOperacion(id_usuario_operacion, id_usuario, id_operacion, fecha_asignacion, rol_en_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/42_usuario_operacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 43. TrabajadorPortuarioEquipoPortuario
COPY gestion_maritima.TrabajadorPortuarioEquipoPortuario(id_trabajador_portuario_equipo_portuario, id_trabajador_portuario, id_equipo_portuario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/43_trabajador_portuario_equipo_portuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 44. CertificacionEmpleado
COPY gestion_maritima.CertificacionEmpleado(id_certificacion_empleado, id_empleado, id_certificacion, fecha_emision, fecha_vencimiento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/44_certificacion_empleado.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 45. CertificacionBuque
COPY gestion_maritima.CertificacionBuque(id_certificacion_buque, id_buque, id_certificacion, fecha_emision, fecha_vencimiento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/45_certificacion_buque.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 46. OperacionContenedor
COPY gestion_maritima.OperacionContenedor(id_operacion_contenedor, id_operacion, id_contenedor, fecha_asignacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/46_operacion_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 47. OperacionEquipoPortuario
COPY gestion_maritima.OperacionEquipoPortuario(id_operacion_equipo_portuario, id_operacion_portuaria, id_equipo_portuario, id_trabajador_portuario, fecha_asignacion, fecha_devolucion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/47_operacion_equipo_portuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- TABLAS ADICIONALES
-- ============================================

-- 48. ContenedorMercancia
COPY gestion_maritima.ContenedorMercancia(id_contenedor_mercancia, id_contenedor, tipo_mercancia)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/48_contenedor_mercancia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 49. TrabajadorPortuarioEquipoProteccion
COPY gestion_maritima.TrabajadorPortuarioEquipoProteccion(id_trabajador_portuario_equipo_proteccion, id_trabajador_portuario, id_equipo_proteccion, fecha_asignacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/49_trabajador_portuario_equipo_proteccion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 50. Ruta
COPY gestion_maritima.Ruta(id_ruta, codigo, origen, destino, duracion, tarifa)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/50_ruta.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 51. RutaMaritima
COPY gestion_maritima.RutaMaritima(id_ruta_maritima, id_ruta, codigo, distancia, id_puerto_origen, id_puerto_destino)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/51_ruta_maritima.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 52. RutaPuertoIntermedio
COPY gestion_maritima.RutaPuertoIntermedio(id_ruta_puerto_intermedio, id_ruta_maritima, id_puerto)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/52_ruta_puerto_intermedio.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 53. CertificacionAduanera
COPY gestion_maritima.CertificacionAduanera(id_certificacion_aduanera, codigo, nombre, descripcion, pais_aplicacion, fecha_emision, fecha_expiracion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/53_certificacion_aduanera.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 54. OperacionCertificacionAduanera
COPY gestion_maritima.OperacionCertificacionAduanera(id_operacion_certificacion_aduanera, id_operacion_maritima, id_certificacion_aduanera, estado, fecha_aprobacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/54_operacion_certificacion_aduanera.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 55. OperacionRutaMaritima
COPY gestion_maritima.OperacionRutaMaritima(id_operacion_ruta_maritima, id_operacion_maritima, id_ruta_maritima, id_muelle_origen, id_muelle_destino)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/55_operacion_ruta_maritima.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 56. Estiba
COPY gestion_maritima.Estiba(id_estiba, id_operacion_portuaria, ubicacion, zona_buque, id_contenedor)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_3/56_estiba.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- VERIFICACIÓN
-- ============================================

SELECT 'EstadoOperacion' AS tabla, COUNT(*) FROM gestion_maritima.EstadoOperacion
UNION ALL
SELECT 'Puerto', COUNT(*) FROM gestion_maritima.Puerto
UNION ALL
SELECT 'Empleado', COUNT(*) FROM gestion_maritima.Empleado
UNION ALL
SELECT 'Buque', COUNT(*) FROM gestion_maritima.Buque
UNION ALL
SELECT 'Contenedor', COUNT(*) FROM gestion_maritima.Contenedor
UNION ALL
SELECT 'Operacion', COUNT(*) FROM gestion_maritima.Operacion
UNION ALL
SELECT 'Usuario', COUNT(*) FROM gestion_maritima.Usuario;