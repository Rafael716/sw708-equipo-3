-- 01. EstadoOperacion
COPY monitoreo.EstadoOperacion(id_estado_operacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/01_estado_operacion.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 02. EspecialidadEmpleado
COPY monitoreo.EspecialidadEmpleado(id_especialidad_empleado, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/02_especialidad_empleado.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 03. EstadoContenedor
COPY monitoreo.EstadoContenedor(id_estado_contenedor, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/03_estado_contenedor.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 04. TipoContenedor
COPY monitoreo.TipoContenedor(id_tipo_contenedor, codigo, nombre, costo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/04_tipo_contenedor.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 05. TipoDocumento
COPY monitoreo.TipoDocumento(id_tipo_documento, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/05_tipo_documento.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 06. EstadoEntrega
COPY monitoreo.EstadoEntrega(id_estado_entrega, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/06_estado_entrega.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 07. TipoSensor
COPY monitoreo.TipoSensor(id_tipo_sensor, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/07_tipo_sensor.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 08. RolSensor
COPY monitoreo.RolSensor(id_rol_sensor, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/08_rol_sensor.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 09. TipoNotificacion
COPY monitoreo.TipoNotificacion(id_tipo_notificacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/09_tipo_notificacion.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 10. TipoIncidencia
COPY monitoreo.TipoIncidencia(id_tipo_incidencia, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/10_tipo_incidencia.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 11. EstadoEmbarcacion
COPY monitoreo.EstadoEmbarcacion(id_estado_embarcacion, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/11_estado_embarcacion.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 12. TipoVehiculo
COPY monitoreo.TipoVehiculo(id_tipo_vehiculo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/12_tipo_vehiculo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 13. EstadoVehiculo
COPY monitoreo.EstadoVehiculo(id_estado_vehiculo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/13_estado_vehiculo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 14. EstadoIncidencia
COPY monitoreo.EstadoIncidencia(id_estado_incidencia, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/14_estado_incidencia.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 15. RolUsuario
COPY monitoreo.RolUsuario(id_rol_usuario, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/15_rol_usuario.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 16. TipoActivo
COPY monitoreo.TipoActivo(id_tipo_activo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/16_tipo_activo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 17. EstadoActivo
COPY monitoreo.EstadoActivo(id_estado_activo, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/17_estado_activo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 18. EstadoContrato
COPY monitoreo.EstadoContrato(id_estado_contrato, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/18_estado_contrato.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 19. TipoTelefono
COPY monitoreo.TipoTelefono(id_tipo_telefono, nombre)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/19_tipo_telefono.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 20. Contrato
COPY monitoreo.Contrato(id_contrato, fecha_emision, fecha_vencimiento, id_estado_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/20_contrato.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 21. Empleado
COPY monitoreo.Empleado(id_empleado, codigo, dni, nombre, apellido, direccion, id_especialidad_empleado, id_contrato)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/21_empleado.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 22. EmpleadoTelefono
COPY monitoreo.EmpleadoTelefono(id_empleado_telefono, id_empleado, telefono, id_tipo_telefono)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/22_empleado_telefono.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 23. Operador
COPY monitoreo.Operador(id_operador, id_empleado, turno, zona_monitoreo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/23_operador.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 24. Operacion
COPY monitoreo.Operacion(id_operacion, codigo, fecha_inicio, fecha_fin, id_estado_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/24_operacion.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 25. OperacionMonitoreo
COPY monitoreo.OperacionMonitoreo(id_operacion_monitoreo, id_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/25_operacion_monitoreo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 26. Contenedor
COPY monitoreo.Contenedor(id_contenedor, codigo, peso, capacidad, dimensiones, id_estado_contenedor, id_tipo_contenedor)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/26_contenedor.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 38. Documentacion
COPY monitoreo.Documentacion(id_documentacion, codigo, nombre, fecha_emision, id_tipo_documento)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/38_documentacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 39. DocumentacionContenedor
COPY monitoreo.DocumentacionContenedor(id_documentacion_contenedor, id_documentacion, id_contenedor)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/39_documentacion_contenedor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 40. Sensor
COPY monitoreo.Sensor(id_sensor, codigo, nombre, id_tipo_sensor, id_rol_sensor, id_contenedor)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/40_sensor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 41. Reporte
COPY monitoreo.Reporte(id_reporte, codigo, fecha_reporte, detalle)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/41_reporte.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 42. Notificacion
COPY monitoreo.Notificacion(id_notificacion, codigo, id_tipo_notificacion, fecha_hora, valor, id_sensor, id_reporte)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/42_notificacion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 43. Usuario
COPY monitoreo.Usuario(id_usuario, id_empleado, correo_electronico, contrasena, id_rol_usuario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/43_usuario.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 44. Incidencia
COPY monitoreo.Incidencia(id_incidencia, codigo, id_tipo_incidencia, descripcion, grado_severidad, fecha_hora, id_estado_incidencia, id_operacion, id_usuario)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/44_incidencia.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 45. IncidenciaReporte
COPY monitoreo.IncidenciaReporte(id_incidencia_reporte, id_incidencia, id_reporte)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/45_incidencia_reporte.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 46. Importador
COPY monitoreo.Importador(id_importador, codigo, ruc, razon_social)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/46_importador.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 47. ImportadorDireccion
COPY monitoreo.ImportadorDireccion(id_direccion, id_importador, direccion, tipo, principal)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/47_importador_direccion.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 48. Entrega
COPY monitoreo.Entrega(id_entrega, codigo, id_estado_entrega, fecha_entrega, lugar_entrega, id_contenedor, id_importador)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/48_entrega.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 27. Activo
COPY monitoreo.Activo(id_activo, codigo, nombre, id_tipo_activo, id_estado_activo, ubicacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/27_activo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 28. Vehiculo
COPY monitoreo.Vehiculo(id_vehiculo, id_activo, placa, capacidad_ton, id_tipo_vehiculo, id_estado_vehiculo)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/28_vehiculo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 29. Buque
COPY monitoreo.Buque(id_buque, matricula, nombre, capacidad, id_estado_embarcacion, peso, ubicacion_actual)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/29_buque.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 30. PosicionContenedor
COPY monitoreo.PosicionContenedor(id_posicion, id_contenedor, latitud, longitud, fecha_hora)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/30_posicion_contenedor.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 31. PosicionVehiculo
COPY monitoreo.PosicionVehiculo(id_posicion, id_vehiculo, latitud, longitud, fecha_hora)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/31_posicion_vehiculo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 32. PosicionBuque
COPY monitoreo.PosicionBuque(id_posicion, id_buque, latitud, longitud, fecha_hora)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/32_posicion_buque.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 33. OperacionMonitoreoVehiculo
COPY monitoreo.OperacionMonitoreoVehiculo(id_operacion_monitoreo_vehiculo, id_operacion_monitoreo, id_vehiculo, fecha_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/33_operacion_monitoreo_vehiculo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 34. OperacionMonitoreoBuque
COPY monitoreo.OperacionMonitoreoBuque(id_operacion_monitoreo_buque, id_operacion_monitoreo, id_buque, fecha_operacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/34_operacion_monitoreo_buque.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 35. ContenedorVehiculo
COPY monitoreo.ContenedorVehiculo(id_contenedor_vehiculo, id_contenedor, id_vehiculo, fecha_asignacion, fecha_transporte)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/35_contenedor_vehiculo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 36. ContenedorBuque
COPY monitoreo.ContenedorBuque(id_contenedor_buque, id_contenedor, id_buque, fecha_asignacion, fecha_transporte)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/36_contenedor_buque.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- 37. OperadorOperacionMonitoreo
COPY monitoreo.OperadorOperacionMonitoreo(id_operador_operacion_monitoreo, id_operador, id_operacion_monitoreo, fecha_realizacion)
FROM 'DirectorioDeCarpeta/datos_csv_modulo_5/37_operador_operacion_monitoreo.csv'
DELIMITER ',' CSV HEADER ENCODING 'UTF8';