-- ============================================
-- SCRIPT DE IMPORTACION CSV - SISTEMA CONSOLIDADO
-- Sistema Maritimo Integrado - 121 Archivos
-- ============================================

-- ============================================
-- SCHEMA: shared - LOOKUP TABLES (01-37)
-- ============================================

-- 01. EspecialidadEmpleado
\copy shared.EspecialidadEmpleado(id_especialidad_empleado, nombre) FROM ':csvdir/01_especialidad_empleado.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 02. EstadoContrato
\copy shared.EstadoContrato(id_estado_contrato, nombre) FROM ':csvdir/02_estado_contrato.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 03. EstadoOperacion
\copy shared.EstadoOperacion(id_estado_operacion, nombre) FROM ':csvdir/03_estado_operacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 04. TipoTelefono
\copy shared.TipoTelefono(id_tipo_telefono, nombre) FROM ':csvdir/04_tipo_telefono.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 05. EstadoEmbarcacion
\copy shared.EstadoEmbarcacion(id_estado_embarcacion, nombre) FROM ':csvdir/05_estado_embarcacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 06. RolUsuario
\copy shared.RolUsuario(id_rol_usuario, nombre) FROM ':csvdir/06_rol_usuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 07. EstadoContenedor
\copy shared.EstadoContenedor(id_estado_contenedor, nombre) FROM ':csvdir/07_estado_contenedor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 08. TipoContenedor
\copy shared.TipoContenedor(id_tipo_contenedor, codigo, nombre, costo) FROM ':csvdir/08_tipo_contenedor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 09. TipoIncidencia
\copy shared.TipoIncidencia(id_tipo_incidencia, nombre) FROM ':csvdir/09_tipo_incidencia.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 10. TipoActivo
\copy shared.TipoActivo(id_tipo_activo, nombre) FROM ':csvdir/10_tipo_activo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 11. EstadoActivo
\copy shared.EstadoActivo(id_estado_activo, nombre) FROM ':csvdir/11_estado_activo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 12. EstatusNavegacion
\copy shared.EstatusNavegacion(id_estatus_navegacion, nombre) FROM ':csvdir/12_estatus_navegacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 13. Prioridad
\copy shared.Prioridad(id_prioridad, nombre) FROM ':csvdir/13_prioridad.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 14. TipoVehiculo
\copy shared.TipoVehiculo(id_tipo_vehiculo, nombre) FROM ':csvdir/14_tipo_vehiculo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 15. EstadoVehiculo
\copy shared.EstadoVehiculo(id_estado_vehiculo, nombre) FROM ':csvdir/15_estado_vehiculo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 16. EstadoIncidencia
\copy shared.EstadoIncidencia(id_estado_incidencia, nombre) FROM ':csvdir/16_estado_incidencia.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 17. TipoDocumento
\copy shared.TipoDocumento(id_tipo_documento, nombre) FROM ':csvdir/17_tipo_documento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 18. EstadoReserva
\copy shared.EstadoReserva(id_estado_reserva, nombre) FROM ':csvdir/18_estado_reserva.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 19. TipoEquipoPortuario
\copy shared.TipoEquipoPortuario(id_tipo_equipo_portuario, nombre) FROM ':csvdir/19_tipo_equipo_portuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 20. EstadoEquipoPortuario
\copy shared.EstadoEquipoPortuario(id_estado_equipo_portuario, nombre) FROM ':csvdir/20_estado_equipo_portuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 21. EstadoInspeccion
\copy shared.EstadoInspeccion(id_estado_inspeccion, nombre) FROM ':csvdir/21_estado_inspeccion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 22. TipoInspeccion
\copy shared.TipoInspeccion(id_tipo_inspeccion, nombre) FROM ':csvdir/22_tipo_inspeccion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 23. TipoHallazgo
\copy shared.TipoHallazgo(id_tipo_hallazgo, nombre) FROM ':csvdir/23_tipo_hallazgo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 24. TipoOperacionPortuaria
\copy shared.TipoOperacionPortuaria(id_tipo_operacion_portuaria, nombre) FROM ':csvdir/24_tipo_operacion_portuaria.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 25. Turno
\copy shared.Turno(id_turno, nombre) FROM ':csvdir/25_turno.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 26. EquipoProteccion
\copy shared.EquipoProteccion(id_equipo_proteccion, nombre) FROM ':csvdir/26_equipo_proteccion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 27. CondicionOperativa
\copy shared.CondicionOperativa(id_condicion_operativa, nombre) FROM ':csvdir/27_condicion_operativa.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 28. TipoReporte
\copy shared.TipoReporte(id_tipo_reporte, nombre) FROM ':csvdir/28_tipo_reporte.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 29. EstadoPlan
\copy shared.EstadoPlan(id_estado_plan, nombre) FROM ':csvdir/29_estado_plan.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 30. TipoMantenimiento
\copy shared.TipoMantenimiento(id_tipo_mantenimiento, nombre) FROM ':csvdir/30_tipo_mantenimiento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 31. EstadoSolicitud
\copy shared.EstadoSolicitud(id_estado_solicitud, nombre) FROM ':csvdir/31_estado_solicitud.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 32. EstadoOrden
\copy shared.EstadoOrden(id_estado_orden, nombre) FROM ':csvdir/32_estado_orden.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 33. EstadoTarea
\copy shared.EstadoTarea(id_estado_tarea, nombre) FROM ':csvdir/33_estado_tarea.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 34. EstadoEntrega
\copy shared.EstadoEntrega(id_estado_entrega, nombre) FROM ':csvdir/34_estado_entrega.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 35. TipoSensor
\copy shared.TipoSensor(id_tipo_sensor, nombre) FROM ':csvdir/35_tipo_sensor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 36. RolSensor
\copy shared.RolSensor(id_rol_sensor, nombre) FROM ':csvdir/36_rol_sensor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 37. TipoNotificacion
\copy shared.TipoNotificacion(id_tipo_notificacion, nombre) FROM ':csvdir/37_tipo_notificacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 37a. EstadoLectura
\copy shared.EstadoLectura(id_estado_lectura, nombre) FROM ':csvdir/37a_estado_lectura.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- SCHEMA: shared - TABLAS PRINCIPALES (38-56)
-- ============================================

-- 38. Contrato
\copy shared.Contrato(id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato) FROM ':csvdir/38_contrato.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 39. Empleado
\copy shared.Empleado(id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato) FROM ':csvdir/39_empleado.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 40. EmpleadoTelefono
\copy shared.EmpleadoTelefono(id_empleado_telefono, id_empleado, telefono, id_tipo_telefono) FROM ':csvdir/40_empleado_telefono.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 41. Usuario
\copy shared.Usuario(id_usuario, correo_electronico, contrasena, id_rol_usuario, id_empleado) FROM ':csvdir/41_usuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 42. Operacion
\copy shared.Operacion(id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion) FROM ':csvdir/42_operacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 43. Buque
\copy shared.Buque(id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual) FROM ':csvdir/43_buque.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 44. Contenedor
\copy shared.Contenedor(id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor) FROM ':csvdir/44_contenedor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 45. ContenedorMercancia
\copy shared.ContenedorMercancia(id_contenedor_mercancia, id_contenedor, tipo_mercancia) FROM ':csvdir/45_contenedor_mercancia.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 46. Certificacion
\copy shared.Certificacion(id_certificacion, nombre, descripcion) FROM ':csvdir/46_certificacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 47. CertificacionBuque
\copy shared.CertificacionBuque(id_certificacion_buque, id_buque, id_certificacion, fecha_emision, fecha_vencimiento) FROM ':csvdir/47_certificacion_buque.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 48. CertificacionEmpleado
\copy shared.CertificacionEmpleado(id_certificacion_empleado, id_empleado, id_certificacion, fecha_emision, fecha_vencimiento) FROM ':csvdir/48_certificacion_empleado.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 49. OperacionMaritima
\copy shared.OperacionMaritima(id_operacion_maritima, id_operacion, codigo, cantidad_contenedores, id_estatus_navegacion, porcentaje_trayecto, id_buque) FROM ':csvdir/49_operacion_maritima.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 50. Tripulante
\copy shared.Tripulante(id_tripulante, id_empleado, disponibilidad, nacionalidad) FROM ':csvdir/50_tripulante.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 51. UsuarioOperacion
\copy shared.UsuarioOperacion(id_usuario_operacion, id_usuario, id_operacion, fecha_asignacion, rol_en_operacion) FROM ':csvdir/51_usuario_operacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 52. Ruta
\copy shared.Ruta(id_ruta, codigo, origen, destino, duracion, tarifa) FROM ':csvdir/52_ruta.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 53. OperacionTerrestre
\copy shared.OperacionTerrestre(id_operacion_terrestre, id_operacion, codigo, costo_operacion_terrestre) FROM ':csvdir/53_operacion_terrestre.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 54. Activo
\copy shared.Activo(id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion) FROM ':csvdir/54_activo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 55. Vehiculo
\copy shared.Vehiculo(id_vehiculo, id_activo, placa, capacidad_ton, id_tipo_vehiculo, id_estado_vehiculo) FROM ':csvdir/55_vehiculo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 56. Incidencia
\copy shared.Incidencia(id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_estado_incidencia, id_operacion, id_usuario) FROM ':csvdir/56_incidencia.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- SCHEMA: gestion_reserva (57-64)
-- ============================================

-- 57. AgenteReservas
\copy gestion_reserva.AgenteReservas(id_agente_reservas, id_empleado) FROM ':csvdir/57_agente_reservas.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 58. Cliente
\copy gestion_reserva.Cliente(id_cliente, ruc, razon_social, direccion, email) FROM ':csvdir/58_cliente.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 59. ClienteTelefono
\copy gestion_reserva.ClienteTelefono(id_cliente_telefono, id_cliente, telefono, id_tipo_telefono) FROM ':csvdir/59_cliente_telefono.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 60. AtencionCliente
\copy gestion_reserva.AtencionCliente(id_atencion_cliente, id_cliente, id_agente_reservas, fecha_atencion) FROM ':csvdir/60_atencion_cliente.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 61. Reserva
\copy gestion_reserva.Reserva(id_reserva, codigo, fecha_registro, id_estado_reserva, pago_total, ruc_cliente, id_agente_reservas, id_buque, id_ruta) FROM ':csvdir/61_reserva.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 62. ReservaContenedor
\copy gestion_reserva.ReservaContenedor(id_reserva_contenedor, id_reserva, id_contenedor, fecha_asignacion, cantidad) FROM ':csvdir/62_reserva_contenedor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 63. ReservaOperacionMaritima
\copy gestion_reserva.ReservaOperacionMaritima(id_reserva_operacion_maritima, id_reserva, id_operacion_maritima, fecha_vinculacion) FROM ':csvdir/63_reserva_operacion_maritima.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 64. ReservaOperacionTerrestre
\copy gestion_reserva.ReservaOperacionTerrestre(id_reserva_operacion_terrestre, id_reserva, id_operacion_terrestre, fecha_vinculacion) FROM ':csvdir/64_reserva_operacion_terrestre.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- SCHEMA: personal_tripulacion (65)
-- ============================================

-- 65. BuqueTripulante
\copy personal_tripulacion.BuqueTripulante(id_buque_tripulante, id_buque, id_tripulante, fecha_asignacion, hora_asignacion) FROM ':csvdir/65_buque_tripulante.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- SCHEMA: gestion_maritima (66-85)
-- ============================================

-- 66. Puerto
\copy gestion_maritima.Puerto(id_puerto, codigo, nombre, pais, direccion) FROM ':csvdir/66_puerto.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 67. Muelle
\copy gestion_maritima.Muelle(id_muelle, codigo, ubicacion, capacidad, disponibilidad, id_puerto) FROM ':csvdir/67_muelle.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 68. EquipoPortuario
\copy gestion_maritima.EquipoPortuario(id_equipo_portuario, codigo, capacidad, id_tipo_equipo_portuario, id_estado_equipo_portuario, ubicacion) FROM ':csvdir/68_equipo_portuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 69. TrabajadorPortuario
\copy gestion_maritima.TrabajadorPortuario(id_trabajador_portuario, id_empleado, disponibilidad, id_turno) FROM ':csvdir/69_trabajador_portuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 70. OperacionPortuaria
\copy gestion_maritima.OperacionPortuaria(id_operacion_portuaria, id_operacion, codigo, id_puerto, id_muelle, id_tipo_operacion_portuaria, id_buque) FROM ':csvdir/70_operacion_portuaria.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 71. Inspeccion
\copy gestion_maritima.Inspeccion(id_inspeccion, codigo, fecha, id_tipo_inspeccion, id_estado_inspeccion, id_prioridad, id_operacion, id_usuario) FROM ':csvdir/71_inspeccion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 72. Hallazgo
\copy gestion_maritima.Hallazgo(id_hallazgo, codigo, id_tipo_hallazgo, nivel_gravedad, descripcion, accion_sugerida, id_inspeccion) FROM ':csvdir/72_hallazgo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 73. TripulanteIdioma
\copy gestion_maritima.TripulanteIdioma(id_tripulante_idioma, id_tripulante, idioma, nivel) FROM ':csvdir/73_tripulante_idioma.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 74. OperacionMaritimaCondicion
\copy gestion_maritima.OperacionMaritimaCondicion(id_operacion_maritima_condicion, id_operacion_maritima, id_condicion_operativa) FROM ':csvdir/74_operacion_maritima_condicion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 75. OperacionEmpleado
\copy gestion_maritima.OperacionEmpleado(id_operacion_empleado, id_operacion, id_empleado, fecha_asignacion, fecha_desasignacion) FROM ':csvdir/75_operacion_empleado.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 76. TrabajadorPortuarioEquipoPortuario
\copy gestion_maritima.TrabajadorPortuarioEquipoPortuario(id_trabajador_portuario_equipo_portuario, id_trabajador_portuario, id_equipo_portuario) FROM ':csvdir/76_trabajador_portuario_equipo_portuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 77. OperacionContenedor
\copy gestion_maritima.OperacionContenedor(id_operacion_contenedor, id_operacion, id_contenedor, fecha_asignacion) FROM ':csvdir/77_operacion_contenedor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 78. OperacionEquipoPortuario
\copy gestion_maritima.OperacionEquipoPortuario(id_operacion_equipo_portuario, id_operacion_portuaria, id_equipo_portuario, id_trabajador_portuario, fecha_asignacion, fecha_devolucion) FROM ':csvdir/78_operacion_equipo_portuario.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 79. CertificacionAduanera
\copy gestion_maritima.CertificacionAduanera(id_certificacion_aduanera, codigo, nombre, descripcion, pais_aplicacion, fecha_emision, fecha_expiracion) FROM ':csvdir/79_certificacion_aduanera.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 80. RutaMaritima
\copy gestion_maritima.RutaMaritima(id_ruta_maritima, id_ruta, codigo, distancia, id_puerto_origen, id_puerto_destino) FROM ':csvdir/80_ruta_maritima.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 81. OperacionRutaMaritima
\copy gestion_maritima.OperacionRutaMaritima(id_operacion_ruta_maritima, id_operacion_maritima, id_ruta_maritima, id_muelle_origen, id_muelle_destino) FROM ':csvdir/81_operacion_ruta_maritima.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 82. Estiba
\copy gestion_maritima.Estiba(id_estiba, id_operacion_portuaria, ubicacion, zona_buque, id_contenedor) FROM ':csvdir/82_estiba.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 83. TrabajadorPortuarioEquipoProteccion
\copy gestion_maritima.TrabajadorPortuarioEquipoProteccion(id_trabajador_portuario_equipo_proteccion, id_trabajador_portuario, id_equipo_proteccion, fecha_asignacion) FROM ':csvdir/83_trabajador_portuario_equipo_proteccion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 84. RutaPuertoIntermedio
\copy gestion_maritima.RutaPuertoIntermedio(id_ruta_puerto_intermedio, id_ruta_maritima, id_puerto) FROM ':csvdir/84_ruta_puerto_intermedio.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 85. OperacionCertificacionAduanera
\copy gestion_maritima.OperacionCertificacionAduanera(id_operacion_certificacion_aduanera, id_operacion_maritima, id_certificacion_aduanera, estado, fecha_aprobacion) FROM ':csvdir/85_operacion_certificacion_aduanera.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- SCHEMA: operaciones_terrestres (86-92)
-- ============================================

-- 86. RutaTerrestre
\copy operaciones_terrestres.RutaTerrestre(id_ruta_terrestre, id_ruta) FROM ':csvdir/86_ruta_terrestre.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 87. Conductor
\copy operaciones_terrestres.Conductor(id_conductor, id_empleado, licencia, categoria, disponibilidad) FROM ':csvdir/87_conductor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 88. OperacionTerrestreDetalle
\copy operaciones_terrestres.OperacionTerrestreDetalle(id_operacion_terrestre_detalle, id_operacion_terrestre, id_vehiculo, id_ruta_terrestre, id_conductor) FROM ':csvdir/88_operacion_terrestre_detalle.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 89. ChecklistDespacho
\copy operaciones_terrestres.ChecklistDespacho(id_checklist, codigo, observaciones, combustible, frenos, id_operacion_terrestre) FROM ':csvdir/89_checklist_despacho.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 90. DocumentacionOperacion
\copy operaciones_terrestres.DocumentacionOperacion(id_documento, codigo, nombre, ruta_archivo, fecha_emision, id_tipo_documento) FROM ':csvdir/90_documentacion_operacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 91. OperacionDocumento
\copy operaciones_terrestres.OperacionDocumento(id_operacion, id_documento) FROM ':csvdir/91_operacion_documento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 92. ReporteTransporte
\copy operaciones_terrestres.ReporteTransporte(id_reporte, codigo, id_tipo_reporte, fecha_generado, id_operacion_terrestre) FROM ':csvdir/92_reporte_transporte.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- SCHEMA: mantenimiento_logistico (93-102)
-- ============================================

-- 93. Tecnico
\copy mantenimiento_logistico.Tecnico(id_tecnico, id_empleado, especialidad) FROM ':csvdir/93_tecnico.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 94. ResponsableSolicitud
\copy mantenimiento_logistico.ResponsableSolicitud(id_responsable_solicitud, id_empleado) FROM ':csvdir/94_responsable_solicitud.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 95. Repuesto
\copy mantenimiento_logistico.Repuesto(id_repuesto, codigo, nombre, stock, stock_minimo, precio_unitario) FROM ':csvdir/95_repuesto.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 96. PlanMantenimiento
\copy mantenimiento_logistico.PlanMantenimiento(id_plan_mantenimiento, codigo, descripcion, frecuencia, fecha_creacion, id_estado_plan, id_activo) FROM ':csvdir/96_plan_mantenimiento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 97. SolicitudMantenimiento
\copy mantenimiento_logistico.SolicitudMantenimiento(id_solicitud_mantenimiento, codigo, descripcion_problema, fecha_solicitud, id_prioridad, id_estado_solicitud, id_responsable_solicitud, id_activo) FROM ':csvdir/97_solicitud_mantenimiento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 98. OperacionMantenimiento
\copy mantenimiento_logistico.OperacionMantenimiento(id_operacion_mantenimiento, id_operacion, id_plan_mantenimiento, id_solicitud_mantenimiento) FROM ':csvdir/98_operacion_mantenimiento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 99. OrdenMantenimiento
\copy mantenimiento_logistico.OrdenMantenimiento(id_orden, codigo, fecha_generada, fecha_programada, fecha_cierre, id_tipo_mantenimiento, id_estado_orden, id_operacion_mantenimiento) FROM ':csvdir/99_orden_mantenimiento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 100. TareaMantenimiento
\copy mantenimiento_logistico.TareaMantenimiento(id_tarea, descripcion, id_estado_tarea, id_orden) FROM ':csvdir/100_tarea_mantenimiento.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 101. OperacionMantenimientoTecnico
\copy mantenimiento_logistico.OperacionMantenimientoTecnico(id_operacion_mantenimiento, id_tecnico, fecha_asignacion) FROM ':csvdir/101_operacion_mantenimiento_tecnico.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 102. OperacionMantenimientoRepuesto
\copy mantenimiento_logistico.OperacionMantenimientoRepuesto(id_operacion_mantenimiento, id_repuesto, fecha_uso, cantidad, precio_unitario) FROM ':csvdir/102_operacion_mantenimiento_repuesto.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- SCHEMA: monitoreo (103-121)
-- ============================================

-- 103. Operador
\copy monitoreo.Operador(id_operador, id_empleado, turno, zona_monitoreo) FROM ':csvdir/103_operador.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 104. OperacionMonitoreo
\copy monitoreo.OperacionMonitoreo(id_operacion_monitoreo, id_operacion) FROM ':csvdir/104_operacion_monitoreo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 105. Sensor
\copy monitoreo.Sensor(id_sensor, codigo, nombre, id_tipo_sensor, id_rol_sensor, id_contenedor) FROM ':csvdir/105_sensor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 105a. LecturaSensor
\copy monitoreo.LecturaSensor(id_lectura_sensor, id_sensor, fecha_hora, valor, unidad, id_estado_lectura) FROM ':csvdir/105a_lectura_sensor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 106. Reporte
\copy monitoreo.Reporte(id_reporte, codigo, fecha_reporte, detalle) FROM ':csvdir/106_reporte.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 107. Notificacion
\copy monitoreo.Notificacion(id_notificacion, codigo, id_tipo_notificacion, fecha_hora, valor, id_sensor, id_reporte) FROM ':csvdir/107_notificacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 108. Importador
\copy monitoreo.Importador(id_importador, codigo, ruc, razon_social) FROM ':csvdir/108_importador.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 109. ImportadorDireccion
\copy monitoreo.ImportadorDireccion(id_direccion, id_importador, direccion, tipo, principal) FROM ':csvdir/109_importador_direccion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 110. Entrega
\copy monitoreo.Entrega(id_entrega, codigo, id_estado_entrega, fecha_entrega, lugar_entrega, id_contenedor, id_importador) FROM ':csvdir/110_entrega.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 111. IncidenciaReporte
\copy monitoreo.IncidenciaReporte(id_incidencia_reporte, id_incidencia, id_reporte) FROM ':csvdir/111_incidencia_reporte.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 112. PosicionContenedor
\copy monitoreo.PosicionContenedor(id_posicion, id_contenedor, latitud, longitud, fecha_hora) FROM ':csvdir/112_posicion_contenedor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 113. PosicionVehiculo
\copy monitoreo.PosicionVehiculo(id_posicion, id_vehiculo, latitud, longitud, fecha_hora) FROM ':csvdir/113_posicion_vehiculo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 114. PosicionBuque
\copy monitoreo.PosicionBuque(id_posicion, id_buque, latitud, longitud, fecha_hora) FROM ':csvdir/114_posicion_buque.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 115. OperacionMonitoreoVehiculo
\copy monitoreo.OperacionMonitoreoVehiculo(id_operacion_monitoreo_vehiculo, id_operacion_monitoreo, id_vehiculo, fecha_operacion) FROM ':csvdir/115_operacion_monitoreo_vehiculo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 116. OperacionMonitoreoBuque
\copy monitoreo.OperacionMonitoreoBuque(id_operacion_monitoreo_buque, id_operacion_monitoreo, id_buque, fecha_operacion) FROM ':csvdir/116_operacion_monitoreo_buque.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 117. ContenedorVehiculo
\copy monitoreo.ContenedorVehiculo(id_contenedor_vehiculo, id_contenedor, id_vehiculo, fecha_asignacion, fecha_transporte) FROM ':csvdir/117_contenedor_vehiculo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 118. ContenedorBuque
\copy monitoreo.ContenedorBuque(id_contenedor_buque, id_contenedor, id_buque, fecha_asignacion, fecha_transporte) FROM ':csvdir/118_contenedor_buque.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 119. OperadorOperacionMonitoreo
\copy monitoreo.OperadorOperacionMonitoreo(id_operador_operacion_monitoreo, id_operador, id_operacion_monitoreo, fecha_realizacion) FROM ':csvdir/119_operador_operacion_monitoreo.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 120. Documentacion
\copy monitoreo.Documentacion(id_documentacion, codigo, nombre, fecha_emision, id_tipo_documento) FROM ':csvdir/120_documentacion.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 121. DocumentacionContenedor
\copy monitoreo.DocumentacionContenedor(id_documentacion_contenedor, id_documentacion, id_contenedor) FROM ':csvdir/121_documentacion_contenedor.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- ============================================
-- VERIFICACION DE DATOS
-- ============================================

SELECT 'RESUMEN DE IMPORTACION' AS tipo, '' AS tabla, '' AS registros
UNION ALL
SELECT '', '==================', '=========='
UNION ALL
SELECT 'SCHEMA: shared - Lookup Tables', '', ''
UNION ALL
SELECT '', 'EspecialidadEmpleado', COUNT(*)::TEXT FROM shared.EspecialidadEmpleado
UNION ALL
SELECT '', 'EstadoContrato', COUNT(*)::TEXT FROM shared.EstadoContrato
UNION ALL
SELECT '', 'EstadoLectura', COUNT(*)::TEXT FROM shared.EstadoLectura
UNION ALL
SELECT '', 'TipoContenedor', COUNT(*)::TEXT FROM shared.TipoContenedor
UNION ALL
SELECT 'SCHEMA: shared - Principales', '', ''
UNION ALL
SELECT '', 'Contrato', COUNT(*)::TEXT FROM shared.Contrato
UNION ALL
SELECT '', 'Empleado', COUNT(*)::TEXT FROM shared.Empleado
UNION ALL
SELECT '', 'Usuario', COUNT(*)::TEXT FROM shared.Usuario
UNION ALL
SELECT '', 'Operacion', COUNT(*)::TEXT FROM shared.Operacion
UNION ALL
SELECT '', 'Buque', COUNT(*)::TEXT FROM shared.Buque
UNION ALL
SELECT '', 'Contenedor', COUNT(*)::TEXT FROM shared.Contenedor
UNION ALL
SELECT '', 'Vehiculo', COUNT(*)::TEXT FROM shared.Vehiculo
UNION ALL
SELECT 'SCHEMA: gestion_reserva', '', ''
UNION ALL
SELECT '', 'Cliente', COUNT(*)::TEXT FROM gestion_reserva.Cliente
UNION ALL
SELECT '', 'Reserva', COUNT(*)::TEXT FROM gestion_reserva.Reserva
UNION ALL
SELECT 'SCHEMA: gestion_maritima', '', ''
UNION ALL
SELECT '', 'Puerto', COUNT(*)::TEXT FROM gestion_maritima.Puerto
UNION ALL
SELECT '', 'EquipoPortuario', COUNT(*)::TEXT FROM gestion_maritima.EquipoPortuario
UNION ALL
SELECT '', 'Inspeccion', COUNT(*)::TEXT FROM gestion_maritima.Inspeccion
UNION ALL
SELECT 'SCHEMA: operaciones_terrestres', '', ''
UNION ALL
SELECT '', 'Conductor', COUNT(*)::TEXT FROM operaciones_terrestres.Conductor
UNION ALL
SELECT '', 'RutaTerrestre', COUNT(*)::TEXT FROM operaciones_terrestres.RutaTerrestre
UNION ALL
SELECT 'SCHEMA: mantenimiento_logistico', '', ''
UNION ALL
SELECT '', 'Tecnico', COUNT(*)::TEXT FROM mantenimiento_logistico.Tecnico
UNION ALL
SELECT '', 'Repuesto', COUNT(*)::TEXT FROM mantenimiento_logistico.Repuesto
UNION ALL
SELECT '', 'OrdenMantenimiento', COUNT(*)::TEXT FROM mantenimiento_logistico.OrdenMantenimiento
UNION ALL
SELECT 'SCHEMA: monitoreo', '', ''
UNION ALL
SELECT '', 'Operador', COUNT(*)::TEXT FROM monitoreo.Operador
UNION ALL
SELECT '', 'Sensor', COUNT(*)::TEXT FROM monitoreo.Sensor
UNION ALL
SELECT '', 'LecturaSensor', COUNT(*)::TEXT FROM monitoreo.LecturaSensor
UNION ALL
SELECT '', 'Importador', COUNT(*)::TEXT FROM monitoreo.Importador
UNION ALL
SELECT '', 'PosicionContenedor', COUNT(*)::TEXT FROM monitoreo.PosicionContenedor
ORDER BY tipo, tabla;

-- ============================================
-- FIN DEL SCRIPT DE IMPORTACION
-- Total de archivos: 123
-- ============================================