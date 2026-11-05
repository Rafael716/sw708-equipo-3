import csv
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

# Fecha base: dinámica (ahora) para que los datos generados caigan dentro
# de las ventanas que consulta la aplicación (últimos 30/60/120 días).
# Se puede fijar una fecha concreta con la variable de entorno BASE_NOW.
BASE_NOW = datetime.now()
_env_base = os.getenv('BASE_NOW')
if _env_base:
    BASE_NOW = datetime.fromisoformat(_env_base)

fake = Faker('es_ES')
OUTPUT_DIR = 'datos_csv_consolidado'

if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)
    print(f"Directorio '{OUTPUT_DIR}' creado")

def fecha_entre(base: datetime, dias_desde: int, dias_hasta: int):
    """Devuelve una fecha (date) entre base + días_desde y base + días_hasta."""
    delta = random.randint(dias_desde, dias_hasta)
    return (base + timedelta(days=delta)).date()

def fecha_hora_entre(base: datetime, dias_desde: int, dias_hasta: int):
    """Devuelve un datetime entre base + días_desde y base + días_hasta."""
    min_dt = base + timedelta(days=dias_desde)
    max_dt = base + timedelta(days=dias_hasta)
    # generar un offset de segundos entre min y max
    total_seconds = int((max_dt - min_dt).total_seconds())
    offset = random.randint(0, total_seconds)
    return min_dt + timedelta(seconds=offset)

class GeneradorCSVConsolidado:
    def __init__(self):
        self.ids = {}
        
    def guardar_csv(self, nombre_archivo, datos, encabezados):
        filepath = os.path.join(OUTPUT_DIR, nombre_archivo)
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(encabezados)
            writer.writerows(datos)
        print(f"  OK {nombre_archivo} - {len(datos)} registros")
        return filepath
    
    # ============================================
    # SCHEMA SHARED - TABLAS LOOKUP
    # ============================================
    
    def generar_especialidad_empleado(self):
        print("\nGenerando EspecialidadEmpleado...")
        especialidades = [
            'Capitan', 'Oficial de Cubierta', 'Ingeniero Naval',
            'Oficial de Maquinas', 'Contramaestre', 'Marinero',
            'Conductor Profesional', 'Mecanico', 'Supervisor',
            'Coordinador Logistico', 'Operador de Carga', 'Inspector',
            'Electricista', 'Electronico', 'Administrador'
        ]
        datos = []
        self.ids['especialidad_empleado'] = []
        
        for esp in especialidades:
            id_esp = str(uuid.uuid4())
            self.ids['especialidad_empleado'].append(id_esp)
            datos.append([id_esp, esp])
        
        return self.guardar_csv(
            '01_especialidad_empleado.csv',
            datos,
            ['id_especialidad_empleado', 'nombre']
        )
    
    def generar_estado_contrato(self):
        print("\nGenerando EstadoContrato...")
        estados = ['Vigente', 'Por Vencer', 'Vencido', 'Renovado', 'Cancelado']
        datos = []
        self.ids['estado_contrato'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_contrato'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '02_estado_contrato.csv',
            datos,
            ['id_estado_contrato', 'nombre']
        )
    
    def generar_estado_operacion(self):
        print("\nGenerando EstadoOperacion...")
        estados = ['Programada', 'En Curso', 'Completada', 'Cancelada', 'En Espera']
        datos = []
        self.ids['estado_operacion'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_operacion'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '03_estado_operacion.csv',
            datos,
            ['id_estado_operacion', 'nombre']
        )
    
    def generar_tipo_telefono(self):
        print("\nGenerando TipoTelefono...")
        tipos = ['Movil', 'Fijo', 'Trabajo', 'Emergencia']
        datos = []
        self.ids['tipo_telefono'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_telefono'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '04_tipo_telefono.csv',
            datos,
            ['id_tipo_telefono', 'nombre']
        )
    
    def generar_estado_embarcacion(self):
        print("\nGenerando EstadoEmbarcacion...")
        estados = ['Operativo', 'En Mantenimiento', 'Fuera de Servicio', 'En Reparacion', 'Disponible']
        datos = []
        self.ids['estado_embarcacion'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_embarcacion'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '05_estado_embarcacion.csv',
            datos,
            ['id_estado_embarcacion', 'nombre']
        )
    
    def generar_rol_usuario(self):
        print("\nGenerando RolUsuario...")
        roles = ['Administrador', 'Supervisor', 'Operador', 'Coordinador', 'Consultor', 'Auditor']
        datos = []
        self.ids['rol_usuario'] = []
        
        for rol in roles:
            id_rol = str(uuid.uuid4())
            self.ids['rol_usuario'].append(id_rol)
            datos.append([id_rol, rol])
        
        return self.guardar_csv(
            '06_rol_usuario.csv',
            datos,
            ['id_rol_usuario', 'nombre']
        )
    
    def generar_estado_contenedor(self):
        print("\nGenerando EstadoContenedor...")
        estados = ['Disponible', 'En Transito', 'En Puerto', 'En Reparacion', 'Fuera de Servicio']
        datos = []
        self.ids['estado_contenedor'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_contenedor'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '07_estado_contenedor.csv',
            datos,
            ['id_estado_contenedor', 'nombre']
        )
    
    def generar_tipo_contenedor(self):
        print("\nGenerando TipoContenedor...")
        tipos = [
            ('20STD', '20 Pies Estandar', 2500.00),
            ('40STD', '40 Pies Estandar', 3500.00),
            ('40HC', '40 Pies High Cube', 4000.00),
            ('20REF', '20 Pies Refrigerado', 5000.00),
            ('40REF', '40 Pies Refrigerado', 6500.00),
            ('20OT', '20 Pies Open Top', 3000.00),
            ('40OT', '40 Pies Open Top', 4200.00)
        ]
        datos = []
        self.ids['tipo_contenedor'] = []
        
        for codigo, nombre, costo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_contenedor'].append(id_tipo)
            datos.append([id_tipo, codigo, nombre, costo])
        
        return self.guardar_csv(
            '08_tipo_contenedor.csv',
            datos,
            ['id_tipo_contenedor', 'codigo', 'nombre', 'costo']
        )
    
    def generar_tipo_incidencia(self):
        print("\nGenerando TipoIncidencia...")
        tipos = ['Accidente', 'Averia Mecanica', 'Retraso', 'Dano a Carga', 'Robo', 'Incumplimiento']
        datos = []
        self.ids['tipo_incidencia'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_incidencia'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '09_tipo_incidencia.csv',
            datos,
            ['id_tipo_incidencia', 'nombre']
        )
    
    def generar_tipo_activo(self):
        print("\nGenerando TipoActivo...")
        tipos = ['Vehiculo', 'Maquinaria Pesada', 'Equipo Electronico', 'Mobiliario', 'Herramienta', 'Contenedor']
        datos = []
        self.ids['tipo_activo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_activo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '10_tipo_activo.csv',
            datos,
            ['id_tipo_activo', 'nombre']
        )
    
    def generar_estado_activo(self):
        print("\nGenerando EstadoActivo...")
        estados = ['Operativo', 'En Mantenimiento', 'Fuera de Servicio', 'Dado de Baja', 'En Reparacion']
        datos = []
        self.ids['estado_activo'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_activo'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '11_estado_activo.csv',
            datos,
            ['id_estado_activo', 'nombre']
        )
    
    def generar_estatus_navegacion(self):
        print("\nGenerando EstatusNavegacion...")
        estatus = ['En Puerto', 'Navegando', 'Fondeado', 'En Transito', 'Atracado']
        datos = []
        self.ids['estatus_navegacion'] = []
        
        for est in estatus:
            id_est = str(uuid.uuid4())
            self.ids['estatus_navegacion'].append(id_est)
            datos.append([id_est, est])
        
        return self.guardar_csv(
            '12_estatus_navegacion.csv',
            datos,
            ['id_estatus_navegacion', 'nombre']
        )
    
    def generar_prioridad(self):
        print("\nGenerando Prioridad...")
        prioridades = ['Baja', 'Media', 'Alta', 'Critica', 'Urgente']
        datos = []
        self.ids['prioridad'] = []
        
        for prioridad in prioridades:
            id_prioridad = str(uuid.uuid4())
            self.ids['prioridad'].append(id_prioridad)
            datos.append([id_prioridad, prioridad])
        
        return self.guardar_csv(
            '13_prioridad.csv',
            datos,
            ['id_prioridad', 'nombre']
        )
    
    def generar_tipo_vehiculo(self):
        print("\nGenerando TipoVehiculo...")
        tipos = ['Camion', 'Camioneta', 'Trailer', 'Furgoneta', 'Tractocamion']
        datos = []
        self.ids['tipo_vehiculo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_vehiculo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '14_tipo_vehiculo.csv',
            datos,
            ['id_tipo_vehiculo', 'nombre']
        )
    
    def generar_estado_vehiculo(self):
        print("\nGenerando EstadoVehiculo...")
        estados = ['Disponible', 'En Ruta', 'En Mantenimiento', 'Fuera de Servicio', 'En Revision']
        datos = []
        self.ids['estado_vehiculo'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_vehiculo'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '15_estado_vehiculo.csv',
            datos,
            ['id_estado_vehiculo', 'nombre']
        )
    
    def generar_estado_incidencia(self):
        print("\nGenerando EstadoIncidencia...")
        estados = ['Reportada', 'En Investigacion', 'Resuelta', 'Cerrada', 'Pendiente']
        datos = []
        self.ids['estado_incidencia'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_incidencia'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '16_estado_incidencia.csv',
            datos,
            ['id_estado_incidencia', 'nombre']
        )
    
    def generar_tipo_documento(self):
        print("\nGenerando TipoDocumento...")
        tipos = ['Guia de Remision', 'Factura', 'Orden de Transporte', 'Certificado', 'Manifiesto', 'Poliza', 'Bill of Lading']
        datos = []
        self.ids['tipo_documento'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_documento'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '17_tipo_documento.csv',
            datos,
            ['id_tipo_documento', 'nombre']
        )
    
    def generar_estado_reserva(self):
        print("\nGenerando EstadoReserva...")
        estados = ['Pendiente', 'Confirmada', 'Cancelada', 'Completada', 'En Proceso']
        datos = []
        self.ids['estado_reserva'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_reserva'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '18_estado_reserva.csv',
            datos,
            ['id_estado_reserva', 'nombre']
        )
    
    def generar_tipo_equipo_portuario(self):
        print("\nGenerando TipoEquipoPortuario...")
        tipos = ['Grua Portico', 'Grua Movil', 'Reach Stacker', 'Montacargas', 'Terminal Tractor']
        datos = []
        self.ids['tipo_equipo_portuario'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_equipo_portuario'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '19_tipo_equipo_portuario.csv',
            datos,
            ['id_tipo_equipo_portuario', 'nombre']
        )
    
    def generar_estado_equipo_portuario(self):
        print("\nGenerando EstadoEquipoPortuario...")
        estados = ['Disponible', 'En Uso', 'En Mantenimiento', 'Fuera de Servicio', 'En Reparacion']
        datos = []
        self.ids['estado_equipo_portuario'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_equipo_portuario'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '20_estado_equipo_portuario.csv',
            datos,
            ['id_estado_equipo_portuario', 'nombre']
        )
    
    def generar_estado_inspeccion(self):
        print("\nGenerando EstadoInspeccion...")
        estados = ['Pendiente', 'En Proceso', 'Completada', 'Aprobada', 'Rechazada']
        datos = []
        self.ids['estado_inspeccion'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_inspeccion'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '21_estado_inspeccion.csv',
            datos,
            ['id_estado_inspeccion', 'nombre']
        )
    
    def generar_tipo_inspeccion(self):
        print("\nGenerando TipoInspeccion...")
        tipos = ['Visual', 'Estructural', 'Contenido', 'Documentacion', 'Seguridad']
        datos = []
        self.ids['tipo_inspeccion'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_inspeccion'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '22_tipo_inspeccion.csv',
            datos,
            ['id_tipo_inspeccion', 'nombre']
        )
    
    def generar_tipo_hallazgo(self):
        print("\nGenerando TipoHallazgo...")
        tipos = ['Critico', 'Mayor', 'Menor', 'Observacion', 'Conformidad']
        datos = []
        self.ids['tipo_hallazgo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_hallazgo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '23_tipo_hallazgo.csv',
            datos,
            ['id_tipo_hallazgo', 'nombre']
        )
    
    def generar_tipo_operacion_portuaria(self):
        print("\nGenerando TipoOperacionPortuaria...")
        tipos = ['Carga', 'Descarga', 'Transbordo', 'Almacenamiento', 'Inspeccion']
        datos = []
        self.ids['tipo_operacion_portuaria'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_operacion_portuaria'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '24_tipo_operacion_portuaria.csv',
            datos,
            ['id_tipo_operacion_portuaria', 'nombre']
        )
    
    def generar_turno(self):
        print("\nGenerando Turno...")
        turnos = ['Manana', 'Tarde', 'Noche', 'Extra']
        datos = []
        self.ids['turno'] = []
        
        for turno in turnos:
            id_turno = str(uuid.uuid4())
            self.ids['turno'].append(id_turno)
            datos.append([id_turno, turno])
        
        return self.guardar_csv(
            '25_turno.csv',
            datos,
            ['id_turno', 'nombre']
        )
    
    def generar_equipo_proteccion(self):
        print("\nGenerando EquipoProteccion...")
        equipos = ['Casco', 'Chaleco Reflectivo', 'Guantes', 'Botas de Seguridad', 'Gafas de Seguridad', 'Arnes']
        datos = []
        self.ids['equipo_proteccion'] = []
        
        for equipo in equipos:
            id_equipo = str(uuid.uuid4())
            self.ids['equipo_proteccion'].append(id_equipo)
            datos.append([id_equipo, equipo])
        
        return self.guardar_csv(
            '26_equipo_proteccion.csv',
            datos,
            ['id_equipo_proteccion', 'nombre']
        )
    
    def generar_condicion_operativa(self):
        print("\nGenerando CondicionOperativa...")
        condiciones = ['Optima', 'Buena', 'Regular', 'Deficiente', 'Critica']
        datos = []
        self.ids['condicion_operativa'] = []
        
        for condicion in condiciones:
            id_condicion = str(uuid.uuid4())
            self.ids['condicion_operativa'].append(id_condicion)
            datos.append([id_condicion, condicion])
        
        return self.guardar_csv(
            '27_condicion_operativa.csv',
            datos,
            ['id_condicion_operativa', 'nombre']
        )
    
    def generar_tipo_reporte(self):
        print("\nGenerando TipoReporte...")
        tipos = ['Operativo', 'Incidencia', 'Desempeno', 'Cumplimiento', 'Seguimiento']
        datos = []
        self.ids['tipo_reporte'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_reporte'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '28_tipo_reporte.csv',
            datos,
            ['id_tipo_reporte', 'nombre']
        )
    
    def generar_estado_plan(self):
        print("\nGenerando EstadoPlan...")
        estados = ['Activo', 'Inactivo', 'En Revision', 'Suspendido', 'Completado']
        datos = []
        self.ids['estado_plan'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_plan'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '29_estado_plan.csv',
            datos,
            ['id_estado_plan', 'nombre']
        )
    
    def generar_tipo_mantenimiento(self):
        print("\nGenerando TipoMantenimiento...")
        tipos = ['Preventivo', 'Correctivo', 'Predictivo', 'Emergencia', 'Programado']
        datos = []
        self.ids['tipo_mantenimiento'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_mantenimiento'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '30_tipo_mantenimiento.csv',
            datos,
            ['id_tipo_mantenimiento', 'nombre']
        )
    
    def generar_estado_solicitud(self):
        print("\nGenerando EstadoSolicitud...")
        estados = ['Solicitada', 'Aprobada', 'Rechazada', 'En Proceso', 'Cerrada', 'Pendiente']
        datos = []
        self.ids['estado_solicitud'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_solicitud'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '31_estado_solicitud.csv',
            datos,
            ['id_estado_solicitud', 'nombre']
        )
    
    def generar_estado_orden(self):
        print("\nGenerando EstadoOrden...")
        estados = ['Generada', 'Programada', 'En Ejecucion', 'Completada', 'Cancelada', 'En Revision']
        datos = []
        self.ids['estado_orden'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_orden'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '32_estado_orden.csv',
            datos,
            ['id_estado_orden', 'nombre']
        )
    
    def generar_estado_tarea(self):
        print("\nGenerando EstadoTarea...")
        estados = ['Pendiente', 'En Progreso', 'Completada', 'Cancelada', 'Pausada']
        datos = []
        self.ids['estado_tarea'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_tarea'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '33_estado_tarea.csv',
            datos,
            ['id_estado_tarea', 'nombre']
        )
    
    def generar_estado_entrega(self):
        print("\nGenerando EstadoEntrega...")
        estados = ['Pendiente', 'En Transito', 'En Almacen', 'Entregada', 'Cancelada', 'Con Incidencia']
        datos = []
        self.ids['estado_entrega'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_entrega'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '34_estado_entrega.csv',
            datos,
            ['id_estado_entrega', 'nombre']
        )
    
    def generar_tipo_sensor(self):
        print("\nGenerando TipoSensor...")
        tipos = ['GPS', 'Temperatura', 'Humedad', 'Presion', 'Acelerometro', 'Giroscopio', 'RFID']
        datos = []
        self.ids['tipo_sensor'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_sensor'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '35_tipo_sensor.csv',
            datos,
            ['id_tipo_sensor', 'nombre']
        )
    
    def generar_rol_sensor(self):
        print("\nGenerando RolSensor...")
        roles = ['Primario', 'Secundario', 'Respaldo', 'Calibracion', 'Monitoreo']
        datos = []
        self.ids['rol_sensor'] = []
        
        for rol in roles:
            id_rol = str(uuid.uuid4())
            self.ids['rol_sensor'].append(id_rol)
            datos.append([id_rol, rol])
        
        return self.guardar_csv(
            '36_rol_sensor.csv',
            datos,
            ['id_rol_sensor', 'nombre']
        )
    
    def generar_tipo_notificacion(self):
        print("\nGenerando TipoNotificacion...")
        tipos = ['Alerta', 'Advertencia', 'Informacion', 'Critica', 'Urgente', 'Recordatorio']
        datos = []
        self.ids['tipo_notificacion'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_notificacion'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '37_tipo_notificacion.csv',
            datos,
            ['id_tipo_notificacion', 'nombre']
        )
    
    def generar_estado_lectura(self):
        print("\nGenerando EstadoLectura...")
        estados = ['Normal', 'Alerta', 'Critica', 'Sin Señal', 'Calibrando']
        datos = []
        self.ids['estado_lectura'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_lectura'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '37a_estado_lectura.csv',
            datos,
            ['id_estado_lectura', 'nombre']
        )
    
    # ============================================
    # TABLAS PRINCIPALES SHARED
    # ============================================
    
    def generar_contratos(self, cantidad=150):
        print(f"\nGenerando {cantidad} Contratos...")
        datos = []
        self.ids['contrato'] = []
        
        for i in range(cantidad):
            id_contrato = str(uuid.uuid4())
            fecha_emision = fecha_entre(BASE_NOW, dias_desde=-3*365, dias_hasta=0)
            fecha_vencimiento = fecha_emision + timedelta(days=random.randint(365, 1095))
            
            if random.random() < 0.7:
                id_estado = self.ids['estado_contrato'][0]  # Vigente
            else:
                id_estado = random.choice(self.ids['estado_contrato'])
            
            self.ids['contrato'].append(id_contrato)
            datos.append([
                id_contrato,
                fecha_emision.strftime('%Y-%m-%d'),
                fecha_vencimiento.strftime('%Y-%m-%d'),
                id_estado
            ])
        
        return self.guardar_csv(
            '38_contrato.csv',
            datos,
            ['id_contrato', 'fecha_emision', 'fecha_vencimiento', 'id_estado_contrato']
        )
    
    def generar_empleados(self, cantidad=120):
        print(f"\nGenerando {cantidad} Empleados...")
        datos = []
        self.ids['empleado'] = []
        dnis_usados = set()
        codigos_usados = set()
        
        for i in range(cantidad):
            id_empleado = str(uuid.uuid4())
            
            while True:
                codigo = f"EMP-{fake.random_number(digits=5):05d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            while True:
                dni = f"{fake.random_number(digits=8):08d}"
                if dni not in dnis_usados:
                    dnis_usados.add(dni)
                    break
            
            nombre = fake.first_name()
            apellido = fake.last_name()
            direccion = fake.address().replace('\n', ', ')
            id_especialidad = random.choice(self.ids['especialidad_empleado'])
            id_contrato = self.ids['contrato'][i]
            
            self.ids['empleado'].append(id_empleado)
            datos.append([
                id_empleado, codigo, dni, nombre, apellido,
                direccion, id_especialidad, id_contrato
            ])
        
        return self.guardar_csv(
            '39_empleado.csv',
            datos,
            ['id_empleado', 'codigo', 'dni', 'nombre', 'apellido',
             'direccion', 'id_especialidad_empleado', 'id_contrato']
        )
    
    def generar_empleado_telefonos(self):
        print(f"\nGenerando Telefonos de Empleados...")
        datos = []
        
        for id_empleado in self.ids['empleado']:
            num_telefonos = random.randint(1, 2)
            
            for _ in range(num_telefonos):
                id_empleado_telefono = str(uuid.uuid4())
                telefono = fake.phone_number()
                id_tipo = random.choice(self.ids['tipo_telefono'])
                
                datos.append([
                    id_empleado_telefono, id_empleado, telefono, id_tipo
                ])
        
        return self.guardar_csv(
            '40_empleado_telefono.csv',
            datos,
            ['id_empleado_telefono', 'id_empleado', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_usuarios(self):
        print(f"\nGenerando Usuarios...")
        datos = []
        self.ids['usuario'] = []
        correos_usados = set()
        
        for idx, id_empleado in enumerate(self.ids['empleado']):
            id_usuario = str(uuid.uuid4())
            
            if idx == 0:
                # Usuario demo: Administrador + Operador -> acceso a todos los módulos
                correo = 'admin@demo.com'
                contrasena = 'Admin123!'
                id_rol = self.ids['rol_usuario'][0]  # Administrador
                correos_usados.add(correo)
            else:
                while True:
                    correo = fake.email()
                    if correo not in correos_usados:
                        correos_usados.add(correo)
                        break
                
                contrasena = fake.password(length=12)
                id_rol = random.choice(self.ids['rol_usuario'])
            
            self.ids['usuario'].append(id_usuario)
            datos.append([
                id_usuario, correo, contrasena, id_rol, id_empleado
            ])
        
        return self.guardar_csv(
            '41_usuario.csv',
            datos,
            ['id_usuario', 'correo_electronico', 'contrasena', 
             'id_rol_usuario', 'id_empleado']
        )
    
    def generar_operaciones(self, cantidad=100):
        print(f"\nGenerando {cantidad} Operaciones...")
        datos = []
        self.ids['operacion'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_operacion = str(uuid.uuid4())
            
            while True:
                codigo = f"OP-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            fecha_inicio = fecha_hora_entre(BASE_NOW, dias_desde=-120 , dias_hasta=0)
            
            if random.random() < 0.6:
                fecha_fin = fecha_inicio + timedelta(hours=random.randint(24, 240))
            else:
                fecha_fin = None
            
            id_estado = random.choice(self.ids['estado_operacion'])
            
            self.ids['operacion'].append(id_operacion)
            datos.append([
                id_operacion, codigo,
                fecha_inicio.strftime('%Y-%m-%d %H:%M:%S'),
                fecha_fin.strftime('%Y-%m-%d %H:%M:%S') if fecha_fin else '',
                id_estado
            ])
        
        return self.guardar_csv(
            '42_operacion.csv',
            datos,
            ['id_operacion', 'codigo', 'fecha_inicio', 'fecha_fin', 'id_estado_operacion']
        )
    
    def generar_buques(self, cantidad=30):
        print(f"\nGenerando {cantidad} Buques...")
        datos = []
        self.ids['buque'] = []
        matriculas_usadas = set()
        
        nombres_buques = [
            'Estrella del Mar', 'Oceano Pacifico', 'Viento del Norte',
            'Horizonte Azul', 'Mar Profundo', 'Ola Grande',
            'Aventura Marina', 'Delfin Veloz', 'Navegante',
            'Costa Brava', 'Puerto Seguro', 'Mariner',
            'Atlantico', 'Pacifico Sur', 'Mediterraneo'
        ]
        
        puertos = [
            'Callao, Peru', 'Valparaiso, Chile', 'Buenos Aires, Argentina',
            'Santos, Brasil', 'Cartagena, Colombia', 'Panama',
            'Long Beach, USA', 'Shanghai, China', 'Singapur'
        ]
        
        for i in range(cantidad):
            id_buque = str(uuid.uuid4())
            
            while True:
                matricula = f"BQ-{fake.random_number(digits=6):06d}"
                if matricula not in matriculas_usadas:
                    matriculas_usadas.add(matricula)
                    break
            
            nombre = f"{random.choice(nombres_buques)} {random.randint(1, 99)}"
            capacidad = random.randint(100, 5000)
            id_estado = random.choice(self.ids['estado_embarcacion'])
            peso = round(random.uniform(5000.0, 150000.0), 2)
            ubicacion_actual = random.choice(puertos) if random.random() < 0.8 else ''
            
            self.ids['buque'].append(id_buque)
            datos.append([
                id_buque, matricula, nombre, capacidad,
                id_estado, peso, ubicacion_actual
            ])
        
        return self.guardar_csv(
            '43_buque.csv',
            datos,
            ['id_buque', 'matricula', 'nombre', 'capacidad',
             'id_estado_embarcacion', 'peso', 'ubicacion_actual']
        )
    
    def generar_contenedores(self, cantidad=200):
        print(f"\nGenerando {cantidad} Contenedores...")
        datos = []
        self.ids['contenedor'] = []
        codigos_usados = set()
        
        dimensiones_comunes = [
            '20x8x8.6 ft', '40x8x8.6 ft', '40x8x9.6 ft',
            '20x8x9.6 ft', '45x8x9.6 ft'
        ]
        
        for i in range(cantidad):
            id_contenedor = str(uuid.uuid4())
            
            while True:
                codigo = f"CONT-{fake.random_letter().upper()}{fake.random_letter().upper()}{fake.random_letter().upper()}{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            capacidad = round(random.uniform(20000.0, 30000.0), 2)
            peso = round(random.uniform(2000.0, capacidad * 0.8), 2)
            dimensiones = random.choice(dimensiones_comunes)
            id_tipo = random.choice(self.ids['tipo_contenedor'])
            id_estado = random.choice(self.ids['estado_contenedor'])
            
            self.ids['contenedor'].append(id_contenedor)
            datos.append([
                id_contenedor, codigo, peso, capacidad, dimensiones, id_estado, id_tipo
            ])
        
        return self.guardar_csv(
            '44_contenedor.csv',
            datos,
            ['id_contenedor', 'codigo', 'peso', 'capacidad', 'dimensiones',
             'id_estado_contenedor', 'id_tipo_contenedor']
        )
    
    def generar_contenedor_mercancia(self):
        print(f"\nGenerando ContenedorMercancia...")
        datos = []
        
        tipos_mercancia = [
            'Productos Electronicos', 'Textiles', 'Alimentos No Perecederos',
            'Maquinaria Industrial', 'Materiales de Construccion', 'Productos Quimicos',
            'Repuestos Automotrices', 'Mobiliario', 'Productos Farmaceuticos',
            'Materias Primas', 'Equipamiento Medico', 'Productos de Consumo'
        ]
        
        registros_unicos = set()
        
        for id_contenedor in self.ids['contenedor']:
            # Algunos contenedores pueden tener múltiples tipos de mercancía
            num_mercancias = random.randint(1, 3)
            mercancias = random.sample(tipos_mercancia, min(num_mercancias, len(tipos_mercancia)))
            
            for tipo_mercancia in mercancias:
                clave = (id_contenedor, tipo_mercancia)
                if clave not in registros_unicos:
                    id_contenedor_mercancia = str(uuid.uuid4())
                    datos.append([
                        id_contenedor_mercancia, id_contenedor, tipo_mercancia
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '45_contenedor_mercancia.csv',
            datos,
            ['id_contenedor_mercancia', 'id_contenedor', 'tipo_mercancia']
        )
    
    def generar_certificaciones(self):
        print("\nGenerando Certificaciones...")
        certificaciones = [
            ('STCW Basico', 'Certificacion basica de seguridad maritima'),
            ('Oficial de Guardia', 'Habilitacion para guardia de navegacion'),
            ('GMDSS', 'Sistema mundial de socorro y seguridad maritima'),
            ('Primeros Auxilios', 'Atencion medica de emergencia a bordo'),
            ('Contraincendios Avanzado', 'Control y extincion de incendios'),
            ('Supervivencia en el Mar', 'Tecnicas de supervivencia maritima'),
            ('Buque Tanque', 'Operaciones especializadas en buques tanque'),
            ('Carga Peligrosa', 'Manejo de mercancia peligrosa'),
            ('Radar y ARPA', 'Operacion de equipos de navegacion'),
            ('Manejo de Gruas', 'Operacion de equipos de carga'),
            ('ISO 9001', 'Sistema de gestion de calidad'),
            ('ISO 14001', 'Sistema de gestion ambiental'),
            ('ISPS', 'Codigo internacional para la proteccion de buques')
        ]
        datos = []
        self.ids['certificacion'] = []
        
        for nombre, descripcion in certificaciones:
            id_cert = str(uuid.uuid4())
            self.ids['certificacion'].append(id_cert)
            datos.append([id_cert, nombre, descripcion])
        
        return self.guardar_csv(
            '46_certificacion.csv',
            datos,
            ['id_certificacion', 'nombre', 'descripcion']
        )
    
    def generar_certificacion_buque(self):
        print(f"\nGenerando CertificacionBuque...")
        datos = []
        registros_unicos = set()
        
        for id_buque in self.ids['buque']:
            num_certificaciones = random.randint(3, 7)
            certificaciones = random.sample(
                self.ids['certificacion'], 
                min(num_certificaciones, len(self.ids['certificacion']))
            )
            
            for id_certificacion in certificaciones:
                clave = (id_buque, id_certificacion)
                if clave not in registros_unicos:
                    id_cert_buque = str(uuid.uuid4())
                    fecha_emision = fecha_entre(BASE_NOW, dias_desde=-3*365, dias_hasta=0)
                    fecha_vencimiento = fecha_emision + timedelta(days=random.randint(365, 1825))
                    
                    datos.append([
                        id_cert_buque, id_buque, id_certificacion,
                        fecha_emision.strftime('%Y-%m-%d'),
                        fecha_vencimiento.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '47_certificacion_buque.csv',
            datos,
            ['id_certificacion_buque', 'id_buque', 'id_certificacion',
             'fecha_emision', 'fecha_vencimiento']
        )
    
    def generar_certificacion_empleado(self):
        print(f"\nGenerando CertificacionEmpleado...")
        datos = []
        registros_unicos = set()
        
        for id_empleado in self.ids['empleado'][:80]:  # Solo algunos empleados tienen certificaciones
            num_certificaciones = random.randint(1, 5)
            certificaciones = random.sample(
                self.ids['certificacion'], 
                min(num_certificaciones, len(self.ids['certificacion']))
            )
            
            for id_certificacion in certificaciones:
                clave = (id_empleado, id_certificacion)
                if clave not in registros_unicos:
                    id_cert_empleado = str(uuid.uuid4())
                    fecha_emision = fecha_entre(BASE_NOW, dias_desde=-5*365, dias_hasta=0)
                    fecha_vencimiento = fecha_emision + timedelta(days=random.randint(730, 1825))
                    
                    datos.append([
                        id_cert_empleado, id_empleado, id_certificacion,
                        fecha_emision.strftime('%Y-%m-%d'),
                        fecha_vencimiento.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '48_certificacion_empleado.csv',
            datos,
            ['id_certificacion_empleado', 'id_empleado', 'id_certificacion',
             'fecha_emision', 'fecha_vencimiento']
        )
    
    def generar_operaciones_maritimas(self):
        print(f"\nGenerando Operaciones Maritimas...")
        datos = []
        self.ids['operacion_maritima'] = []
        codigos_usados = set()
        
        # Seleccionar la mitad de las operaciones para maritimas
        operaciones_maritimas = random.sample(self.ids['operacion'], min(50, len(self.ids['operacion'])))
        
        for id_operacion in operaciones_maritimas:
            id_op_maritima = str(uuid.uuid4())
            
            while True:
                codigo = f"OM-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            cantidad_contenedores = random.randint(1, 100)
            id_estatus = random.choice(self.ids['estatus_navegacion'])
            porcentaje_trayecto = round(random.uniform(0, 100), 2)
            id_buque = random.choice(self.ids['buque'])
            
            self.ids['operacion_maritima'].append([id_op_maritima, id_operacion])
            datos.append([
                id_op_maritima, id_operacion, codigo, cantidad_contenedores,
                id_estatus, porcentaje_trayecto, id_buque
            ])
        
        return self.guardar_csv(
            '49_operacion_maritima.csv',
            datos,
            ['id_operacion_maritima', 'id_operacion', 'codigo', 'cantidad_contenedores',
             'id_estatus_navegacion', 'porcentaje_trayecto', 'id_buque']
        )
    
    def generar_tripulantes(self):
        print(f"\nGenerando Tripulantes...")
        datos = []
        self.ids['tripulante'] = []
        
        nacionalidades = [
            'Peruana', 'Chilena', 'Argentina', 'Colombiana',
            'Ecuatoriana', 'Brasilena', 'Mexicana', 'Filipina',
            'China', 'India', 'Griega'
        ]
        
        empleados_tripulantes = random.sample(
            self.ids['empleado'], 
            min(60, len(self.ids['empleado']))
        )
        
        for id_empleado in empleados_tripulantes:
            id_tripulante = str(uuid.uuid4())
            disponibilidad = random.choice([True, False])
            nacionalidad = random.choice(nacionalidades)
            
            self.ids['tripulante'].append(id_tripulante)
            datos.append([
                id_tripulante, id_empleado, disponibilidad, nacionalidad
            ])
        
        return self.guardar_csv(
            '50_tripulante.csv',
            datos,
            ['id_tripulante', 'id_empleado', 'disponibilidad', 'nacionalidad']
        )
    
    def generar_usuario_operacion(self):
        print(f"\nGenerando UsuarioOperacion...")
        datos = []
        registros_unicos = set()
        
        roles_operacion = [
            'Coordinador', 'Supervisor', 'Ejecutor',
            'Auditor', 'Responsable de Seguridad', 'Operador'
        ]
        
        for id_operacion in self.ids['operacion']:
            num_usuarios = random.randint(1, 4)
            usuarios = random.sample(
                self.ids['usuario'], 
                min(num_usuarios, len(self.ids['usuario']))
            )
            
            for id_usuario in usuarios:
                clave = (id_usuario, id_operacion)
                if clave not in registros_unicos:
                    id_usuario_operacion = str(uuid.uuid4())
                    fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
                    rol_en_operacion = random.choice(roles_operacion)
                    
                    datos.append([
                        id_usuario_operacion, id_usuario, id_operacion,
                        fecha_asignacion.strftime('%Y-%m-%d'), rol_en_operacion
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '51_usuario_operacion.csv',
            datos,
            ['id_usuario_operacion', 'id_usuario', 'id_operacion',
             'fecha_asignacion', 'rol_en_operacion']
        )
    
    def generar_rutas(self, cantidad=50):
        print(f"\nGenerando {cantidad} Rutas...")
        datos = []
        self.ids['ruta'] = []
        codigos_usados = set()
        
        ciudades = [
            'Lima', 'Callao', 'Arequipa', 'Trujillo', 'Chiclayo',
            'Piura', 'Iquitos', 'Cusco', 'Santiago', 'Valparaiso',
            'Buenos Aires', 'Sao Paulo', 'Rio de Janeiro', 'Bogota',
            'Guayaquil', 'Quito', 'Panama', 'Miami', 'Los Angeles'
        ]
        
        for i in range(cantidad):
            id_ruta = str(uuid.uuid4())
            
            while True:
                codigo = f"RT-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            origen = random.choice(ciudades)
            destino = random.choice([c for c in ciudades if c != origen])
            duracion = random.randint(2, 72)
            tarifa = round(random.uniform(500.0, 5000.0), 2)
            
            self.ids['ruta'].append(id_ruta)
            datos.append([
                id_ruta, codigo, origen, destino, duracion, tarifa
            ])
        
        return self.guardar_csv(
            '52_ruta.csv',
            datos,
            ['id_ruta', 'codigo', 'origen', 'destino', 'duracion', 'tarifa']
        )
    
    def generar_operaciones_terrestres(self):
        print(f"\nGenerando Operaciones Terrestres...")
        datos = []
        self.ids['operacion_terrestre'] = []
        codigos_usados = set()
        
        # Operaciones que no son maritimas
        ops_maritimas_ids = [op[1] for op in self.ids['operacion_maritima']]
        ops_terrestres = [op for op in self.ids['operacion'] if op not in ops_maritimas_ids][:40]
        
        for id_operacion in ops_terrestres:
            id_op_terrestre = str(uuid.uuid4())
            
            while True:
                codigo = f"OT-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            costo = round(random.uniform(500.0, 3000.0), 2)
            
            self.ids['operacion_terrestre'].append([id_op_terrestre, id_operacion])
            datos.append([
                id_op_terrestre, id_operacion, codigo, costo
            ])
        
        return self.guardar_csv(
            '53_operacion_terrestre.csv',
            datos,
            ['id_operacion_terrestre', 'id_operacion', 'codigo', 'costo_operacion_terrestre']
        )
    
    def generar_activos(self, cantidad=80):
        print(f"\nGenerando {cantidad} Activos...")
        datos = []
        self.ids['activo'] = []
        codigos_usados = set()
        
        ubicaciones = [
            'Almacen Central', 'Planta Norte', 'Planta Sur',
            'Deposito A', 'Deposito B', 'Terminal Portuario',
            'Patio de Contenedores', 'Area de Mantenimiento'
        ]
        
        for i in range(cantidad):
            id_activo = str(uuid.uuid4())
            
            while True:
                codigo = f"ACT-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = f"{fake.word().capitalize()} {random.choice(['Industrial', 'Comercial', 'Operativo'])} {random.randint(100, 999)}"
            id_tipo = random.choice(self.ids['tipo_activo'])
            id_estado = random.choice(self.ids['estado_activo'])
            ubicacion = random.choice(ubicaciones)
            
            self.ids['activo'].append(id_activo)
            datos.append([
                id_activo, codigo, nombre, id_tipo, id_estado, ubicacion
            ])
        
        return self.guardar_csv(
            '54_activo.csv',
            datos,
            ['id_activo', 'codigo', 'nombre', 'id_tipo_activo', 
             'id_estado_activo', 'ubicacion']
        )
    
    def generar_vehiculos(self):
        print(f"\nGenerando Vehiculos...")
        datos = []
        self.ids['vehiculo'] = []
        placas_usadas = set()
        
        # Seleccionar activos de tipo vehiculo
        activos_vehiculo = random.sample(self.ids['activo'], min(40, len(self.ids['activo'])))
        
        for id_activo in activos_vehiculo:
            id_vehiculo = str(uuid.uuid4())
            
            while True:
                placa = f"{fake.random_letter().upper()}{fake.random_letter().upper()}-{fake.random_number(digits=4):04d}"
                if placa not in placas_usadas:
                    placas_usadas.add(placa)
                    break
            
            capacidad_ton = round(random.uniform(5.0, 40.0), 2)
            id_tipo = random.choice(self.ids['tipo_vehiculo'])
            id_estado = random.choice(self.ids['estado_vehiculo'])
            
            self.ids['vehiculo'].append(id_vehiculo)
            datos.append([
                id_vehiculo, id_activo, placa, capacidad_ton, id_tipo, id_estado
            ])
        
        return self.guardar_csv(
            '55_vehiculo.csv',
            datos,
            ['id_vehiculo', 'id_activo', 'placa', 'capacidad_ton', 
             'id_tipo_vehiculo', 'id_estado_vehiculo']
        )
    
    def generar_incidencias(self, cantidad=60):
        print(f"\nGenerando {cantidad} Incidencias...")
        datos = []
        self.ids['incidencia'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_incidencia = str(uuid.uuid4())
            
            while True:
                codigo = f"INC-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_tipo = random.choice(self.ids['tipo_incidencia'])
            descripcion = fake.paragraph(nb_sentences=3)
            grado_severidad = random.randint(1, 5)
            fecha_hora = fecha_hora_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
            id_estado = random.choice(self.ids['estado_incidencia'])
            id_operacion = random.choice(self.ids['operacion'])
            id_usuario = random.choice(self.ids['usuario'])
            
            self.ids['incidencia'].append(id_incidencia)
            datos.append([
                id_incidencia, codigo, id_tipo, descripcion, grado_severidad,
                fecha_hora.strftime('%Y-%m-%d %H:%M:%S'), id_estado,
                id_operacion, id_usuario
            ])
        
        return self.guardar_csv(
            '56_incidencia.csv',
            datos,
            ['id_incidencia', 'codigo', 'id_tipo_incidencia', 'descripcion',
             'grado_severidad', 'fecha_hora', 'id_estado_incidencia',
             'id_operacion', 'id_usuario']
        )
    
    # ============================================
    # SCHEMA: gestion_reserva
    # ============================================
    
    def generar_agentes_reservas(self):
        print(f"\nGenerando Agentes de Reservas...")
        datos = []
        self.ids['agente_reservas'] = []
        
        # Seleccionar algunos empleados para ser agentes
        empleados_agentes = random.sample(
            self.ids['empleado'], 
            min(25, len(self.ids['empleado']))
        )
        
        for id_empleado in empleados_agentes:
            id_agente = str(uuid.uuid4())
            
            self.ids['agente_reservas'].append(id_agente)
            datos.append([id_agente, id_empleado])
        
        return self.guardar_csv(
            '57_agente_reservas.csv',
            datos,
            ['id_agente_reservas', 'id_empleado']
        )
    
    def generar_clientes(self, cantidad=50):
        print(f"\nGenerando {cantidad} Clientes...")
        datos = []
        self.ids['cliente'] = []
        ruc_usados = set()
        
        for i in range(cantidad):
            id_cliente = str(uuid.uuid4())
            
            while True:
                ruc = f"{fake.random_number(digits=11):011d}"
                if ruc not in ruc_usados:
                    ruc_usados.add(ruc)
                    break
            
            razon_social = fake.company()
            direccion = fake.address().replace('\n', ', ')
            email = fake.company_email() if random.random() < 0.8 else None
            
            self.ids['cliente'].append({'id': id_cliente, 'ruc': ruc})
            datos.append([
                id_cliente, ruc, razon_social, direccion, email if email else ''
            ])
        
        return self.guardar_csv(
            '58_cliente.csv',
            datos,
            ['id_cliente', 'ruc', 'razon_social', 'direccion', 'email']
        )
    
    def generar_cliente_telefonos(self):
        print(f"\nGenerando Telefonos de Clientes...")
        datos = []
        
        for cliente in self.ids['cliente']:
            num_telefonos = random.randint(1, 3)
            
            for _ in range(num_telefonos):
                id_cliente_telefono = str(uuid.uuid4())
                telefono = fake.phone_number()
                id_tipo = random.choice(self.ids['tipo_telefono'])
                
                datos.append([
                    id_cliente_telefono, cliente['id'], telefono, id_tipo
                ])
        
        return self.guardar_csv(
            '59_cliente_telefono.csv',
            datos,
            ['id_cliente_telefono', 'id_cliente', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_atencion_cliente(self):
        print(f"\nGenerando Atencion Cliente...")
        datos = []
        
        for cliente in self.ids['cliente']:
            # Algunos clientes tienen múltiples atenciones
            num_atenciones = random.randint(1, 4)
            
            for _ in range(num_atenciones):
                id_atencion = str(uuid.uuid4())
                id_agente = random.choice(self.ids['agente_reservas'])
                fecha_atencion = fecha_hora_entre(BASE_NOW, dias_desde=-180, dias_hasta=0)
                
                datos.append([
                    id_atencion, cliente['id'], id_agente,
                    fecha_atencion.strftime('%Y-%m-%d %H:%M:%S')
                ])
        
        return self.guardar_csv(
            '60_atencion_cliente.csv',
            datos,
            ['id_atencion_cliente', 'id_cliente', 'id_agente_reservas', 'fecha_atencion']
        )
    
    def generar_reservas(self, cantidad=80):
        print(f"\nGenerando {cantidad} Reservas...")
        datos = []
        self.ids['reserva'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_reserva = str(uuid.uuid4())
            
            while True:
                codigo = f"RES-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            fecha_registro = fecha_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
            id_estado = random.choice(self.ids['estado_reserva'])
            pago_total = round(random.uniform(1000.0, 15000.0), 2) if random.random() < 0.8 else None
            
            cliente = random.choice(self.ids['cliente'])
            ruc_cliente = cliente['ruc']
            
            id_agente = random.choice(self.ids['agente_reservas'])
            
            # Obtener id del buque (UUID)
            id_buque = random.choice(self.ids['buque'])
            
            id_ruta = random.choice(self.ids['ruta'])
            
            self.ids['reserva'].append(id_reserva)
            datos.append([
                id_reserva, codigo, fecha_registro.strftime('%Y-%m-%d'),
                id_estado, pago_total if pago_total else '',
                ruc_cliente, id_agente, id_buque, id_ruta
            ])
        
        return self.guardar_csv(
            '61_reserva.csv',
            datos,
            ['id_reserva', 'codigo', 'fecha_registro', 'id_estado_reserva',
            'pago_total', 'ruc_cliente', 'id_agente_reservas', 
            'id_buque', 'id_ruta']
        )
    
    def generar_reserva_contenedor(self):
        print(f"\nGenerando ReservaContenedor...")
        datos = []
        registros_unicos = set()
        
        for id_reserva in self.ids['reserva']:
            num_contenedores = random.randint(1, 5)
            contenedores = random.sample(
                self.ids['contenedor'], 
                min(num_contenedores, len(self.ids['contenedor']))
            )
            
            for id_contenedor in contenedores:
                clave = (id_reserva, id_contenedor)
                if clave not in registros_unicos:
                    id_reserva_contenedor = str(uuid.uuid4())
                    fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                    cantidad = random.randint(1, 3)
                    
                    datos.append([
                        id_reserva_contenedor, id_reserva, id_contenedor,
                        fecha_asignacion.strftime('%Y-%m-%d'), cantidad
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '62_reserva_contenedor.csv',
            datos,
            ['id_reserva_contenedor', 'id_reserva', 'id_contenedor',
             'fecha_asignacion', 'cantidad']
        )
    
    def generar_reserva_operacion_maritima(self):
        print(f"\nGenerando ReservaOperacionMaritima...")
        datos = []
        registros_unicos = set()
        
        # Vincular reservas con operaciones marítimas
        for id_reserva in self.ids['reserva']:
            if random.random() < 0.6:  # 60% de reservas tienen operación marítima
                # Obtener id_operacion_maritima del array
                id_op_maritima = random.choice([om[0] for om in self.ids['operacion_maritima']])
                
                clave = (id_reserva, id_op_maritima)
                if clave not in registros_unicos:
                    id_reserva_op_maritima = str(uuid.uuid4())
                    fecha_vinculacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                    
                    datos.append([
                        id_reserva_op_maritima, id_reserva, id_op_maritima,
                        fecha_vinculacion.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '63_reserva_operacion_maritima.csv',
            datos,
            ['id_reserva_operacion_maritima', 'id_reserva', 'id_operacion_maritima',
             'fecha_vinculacion']
        )
    
    def generar_reserva_operacion_terrestre(self):
        print(f"\nGenerando ReservaOperacionTerrestre...")
        datos = []
        registros_unicos = set()
        
        # Vincular reservas con operaciones terrestres
        for id_reserva in self.ids['reserva']:
            if random.random() < 0.4:  # 40% de reservas tienen operación terrestre
                # Obtener id_operacion_terrestre del array
                id_op_terrestre = random.choice([ot[0] for ot in self.ids['operacion_terrestre']])
                
                clave = (id_reserva, id_op_terrestre)
                if clave not in registros_unicos:
                    id_reserva_op_terrestre = str(uuid.uuid4())
                    fecha_vinculacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                    
                    datos.append([
                        id_reserva_op_terrestre, id_reserva, id_op_terrestre,
                        fecha_vinculacion.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '64_reserva_operacion_terrestre.csv',
            datos,
            ['id_reserva_operacion_terrestre', 'id_reserva', 'id_operacion_terrestre',
             'fecha_vinculacion']
        )
    
    # ============================================
    # SCHEMA: personal_tripulacion
    # ============================================
    
    def generar_buque_tripulante(self):
        print(f"\nGenerando BuqueTripulante...")
        datos = []
        
        for id_buque in self.ids['buque']:
            num_tripulantes = random.randint(5, 15)
            tripulantes = random.sample(
                self.ids['tripulante'], 
                min(num_tripulantes, len(self.ids['tripulante']))
            )
            
            for id_tripulante in tripulantes:
                id_buque_tripulante = str(uuid.uuid4())
                fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-365, dias_hasta=0)
                hora_asignacion = fake.time()
                
                datos.append([
                    id_buque_tripulante, id_buque, id_tripulante,
                    fecha_asignacion.strftime('%Y-%m-%d'), hora_asignacion
                ])
        
        return self.guardar_csv(
            '65_buque_tripulante.csv',
            datos,
            ['id_buque_tripulante', 'id_buque', 'id_tripulante',
             'fecha_asignacion', 'hora_asignacion']
        )
    
    # ============================================
    # SCHEMA: gestion_maritima
    # ============================================
    
    def generar_puertos(self, cantidad=20):
        print(f"\nGenerando {cantidad} Puertos...")
        datos = []
        self.ids['puerto'] = []
        codigos_usados = set()
        
        puertos_data = [
            ('CAL', 'Puerto del Callao', 'Peru', 'Av. Manco Capac s/n, Callao'),
            ('PIU', 'Puerto de Paita', 'Peru', 'Carretera Paita-Sullana Km 2'),
            ('VAL', 'Puerto de Valparaiso', 'Chile', 'Av. Errázuriz 1834, Valparaiso'),
            ('SAN', 'Puerto de San Antonio', 'Chile', 'Av. Barros Luco 1337'),
            ('BUE', 'Puerto de Buenos Aires', 'Argentina', 'Av. Ramón S. Castillo'),
            ('MON', 'Puerto de Montevideo', 'Uruguay', 'Rambla 25 de Agosto de 1825'),
            ('STS', 'Puerto de Santos', 'Brasil', 'Av. Conselheiro Rodrigues Alves'),
            ('RIO', 'Puerto de Rio de Janeiro', 'Brasil', 'Av. Rodrigues Alves 10'),
            ('CAR', 'Puerto de Cartagena', 'Colombia', 'Manga, Cartagena de Indias'),
            ('BAR', 'Puerto de Barranquilla', 'Colombia', 'Calle 1 con Carrera 38'),
            ('GUA', 'Puerto de Guayaquil', 'Ecuador', 'Av. 25 de Julio'),
            ('MAN', 'Puerto de Manta', 'Ecuador', 'Av. Malecón y Calle 11'),
            ('PAN', 'Puerto de Balboa', 'Panama', 'Balboa, Ciudad de Panama'),
            ('MIA', 'Puerto de Miami', 'USA', '1015 North America Way, Miami'),
            ('LAX', 'Puerto de Los Angeles', 'USA', '425 S Palos Verdes Street'),
            ('SHA', 'Puerto de Shanghai', 'China', 'Pudong New Area, Shanghai'),
            ('SIN', 'Puerto de Singapur', 'Singapur', 'Maritime Square, Singapore'),
            ('ROT', 'Puerto de Rotterdam', 'Holanda', 'Wilhelminakade 909'),
            ('HAM', 'Puerto de Hamburgo', 'Alemania', 'Bei St. Annen 1'),
            ('ANT', 'Puerto de Amberes', 'Belgica', 'Entrepotkaai 1')
        ]
        
        for codigo, nombre, pais, direccion in puertos_data:
            id_puerto = str(uuid.uuid4())
            
            self.ids['puerto'].append(id_puerto)
            datos.append([
                id_puerto, codigo, nombre, pais, direccion
            ])
        
        return self.guardar_csv(
            '66_puerto.csv',
            datos,
            ['id_puerto', 'codigo', 'nombre', 'pais', 'direccion']
        )
    
    def generar_muelles(self):
        print(f"\nGenerando Muelles...")
        datos = []
        self.ids['muelle'] = []
        codigos_usados = set()
        
        for id_puerto in self.ids['puerto']:
            num_muelles = random.randint(2, 6)
            
            for i in range(num_muelles):
                id_muelle = str(uuid.uuid4())
                
                while True:
                    codigo = f"MUE-{fake.random_number(digits=5):05d}"
                    if codigo not in codigos_usados:
                        codigos_usados.add(codigo)
                        break
                
                ubicacion = f"Zona {random.choice(['Norte', 'Sur', 'Este', 'Oeste'])} - Sector {random.randint(1, 10)}"
                capacidad = random.randint(2, 8)
                disponibilidad = random.choice([True, False])
                
                self.ids['muelle'].append(id_muelle)
                datos.append([
                    id_muelle, codigo, ubicacion, capacidad, disponibilidad, id_puerto
                ])
        
        return self.guardar_csv(
            '67_muelle.csv',
            datos,
            ['id_muelle', 'codigo', 'ubicacion', 'capacidad', 'disponibilidad', 'id_puerto']
        )
    
    def generar_equipos_portuarios(self, cantidad=50):
        print(f"\nGenerando {cantidad} Equipos Portuarios...")
        datos = []
        self.ids['equipo_portuario'] = []
        codigos_usados = set()
        
        ubicaciones = [
            'Patio de Contenedores A', 'Patio de Contenedores B',
            'Muelle 1', 'Muelle 2', 'Muelle 3',
            'Area de Almacenamiento', 'Zona de Carga', 'Zona de Descarga'
        ]
        
        for i in range(cantidad):
            id_equipo = str(uuid.uuid4())
            
            while True:
                codigo = f"EQP-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            capacidad = random.randint(500, 5000)
            id_tipo = random.choice(self.ids['tipo_equipo_portuario'])
            id_estado = random.choice(self.ids['estado_equipo_portuario'])
            ubicacion = random.choice(ubicaciones)
            
            self.ids['equipo_portuario'].append(id_equipo)
            datos.append([
                id_equipo, codigo, capacidad, id_tipo, id_estado, ubicacion
            ])
        
        return self.guardar_csv(
            '68_equipo_portuario.csv',
            datos,
            ['id_equipo_portuario', 'codigo', 'capacidad', 'id_tipo_equipo_portuario',
             'id_estado_equipo_portuario', 'ubicacion']
        )
    
    def generar_trabajadores_portuarios(self):
        print(f"\nGenerando Trabajadores Portuarios...")
        datos = []
        self.ids['trabajador_portuario'] = []
        
        # Seleccionar empleados que no son tripulantes ni agentes
        empleados_usados = set([t for t in self.ids['tripulante']])
        empleados_usados.update([a for a in self.ids['agente_reservas']])
        
        empleados_disponibles = [e for e in self.ids['empleado'] if e not in empleados_usados]
        empleados_trabajadores = random.sample(
            empleados_disponibles, 
            min(30, len(empleados_disponibles))
        )
        
        for id_empleado in empleados_trabajadores:
            id_trabajador = str(uuid.uuid4())
            disponibilidad = random.choice([True, False])
            id_turno = random.choice(self.ids['turno'])
            
            self.ids['trabajador_portuario'].append(id_trabajador)
            datos.append([
                id_trabajador, id_empleado, disponibilidad, id_turno
            ])
        
        return self.guardar_csv(
            '69_trabajador_portuario.csv',
            datos,
            ['id_trabajador_portuario', 'id_empleado', 'disponibilidad', 'id_turno']
        )
    
    def generar_operaciones_portuarias(self):
        print(f"\nGenerando Operaciones Portuarias...")
        datos = []
        self.ids['operacion_portuaria'] = []
        codigos_usados = set()
        
        # Seleccionar operaciones que no tienen asignación específica
        operaciones_usadas = set([om[1] for om in self.ids['operacion_maritima']])
        operaciones_usadas.update([ot[1] for ot in self.ids['operacion_terrestre']])
        
        operaciones_disponibles = [op for op in self.ids['operacion'] if op not in operaciones_usadas][:40]
        
        for id_operacion in operaciones_disponibles:
            id_op_portuaria = str(uuid.uuid4())
            
            while True:
                codigo = f"OPP-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_puerto = random.choice(self.ids['puerto'])
            id_muelle = random.choice(self.ids['muelle'])
            id_tipo = random.choice(self.ids['tipo_operacion_portuaria'])
            id_buque = random.choice(self.ids['buque'])
            
            self.ids['operacion_portuaria'].append(id_op_portuaria)
            datos.append([
                id_op_portuaria, id_operacion, codigo, id_puerto,
                id_muelle, id_tipo, id_buque
            ])
        
        return self.guardar_csv(
            '70_operacion_portuaria.csv',
            datos,
            ['id_operacion_portuaria', 'id_operacion', 'codigo', 'id_puerto',
             'id_muelle', 'id_tipo_operacion_portuaria', 'id_buque']
        )
    
    def generar_inspecciones(self, cantidad=60):
        print(f"\nGenerando {cantidad} Inspecciones...")
        datos = []
        self.ids['inspeccion'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_inspeccion = str(uuid.uuid4())
            
            while True:
                codigo = f"INS-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            fecha = fecha_hora_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
            id_tipo = random.choice(self.ids['tipo_inspeccion'])
            id_estado = random.choice(self.ids['estado_inspeccion'])
            id_prioridad = random.choice(self.ids['prioridad'])
            id_operacion = random.choice(self.ids['operacion'])
            id_usuario = random.choice(self.ids['usuario'])
            
            self.ids['inspeccion'].append(id_inspeccion)
            datos.append([
                id_inspeccion, codigo, fecha.strftime('%Y-%m-%d %H:%M:%S'),
                id_tipo, id_estado, id_prioridad, id_operacion, id_usuario
            ])
        
        return self.guardar_csv(
            '71_inspeccion.csv',
            datos,
            ['id_inspeccion', 'codigo', 'fecha', 'id_tipo_inspeccion',
             'id_estado_inspeccion', 'id_prioridad', 'id_operacion', 'id_usuario']
        )
    
    def generar_hallazgos(self):
        print(f"\nGenerando Hallazgos...")
        datos = []
        codigos_usados = set()
        
        acciones_sugeridas = [
            'Realizar mantenimiento correctivo inmediato',
            'Programar reparacion en el proximo arribo',
            'Reemplazar componente defectuoso',
            'Verificar cumplimiento de normativas',
            'Capacitar al personal involucrado',
            'Mejorar procedimientos de seguridad',
            'Realizar seguimiento periodico',
            'Documentar para auditorias futuras'
        ]
        
        for id_inspeccion in self.ids['inspeccion']:
            # Algunas inspecciones tienen múltiples hallazgos
            num_hallazgos = random.randint(0, 3)
            
            for _ in range(num_hallazgos):
                id_hallazgo = str(uuid.uuid4())
                
                while True:
                    codigo = f"HAL-{fake.random_number(digits=7):07d}"
                    if codigo not in codigos_usados:
                        codigos_usados.add(codigo)
                        break
                
                id_tipo = random.choice(self.ids['tipo_hallazgo'])
                nivel_gravedad = random.randint(1, 5)
                descripcion = fake.paragraph(nb_sentences=2)
                accion_sugerida = random.choice(acciones_sugeridas) if random.random() < 0.8 else ''
                
                datos.append([
                    id_hallazgo, codigo, id_tipo, nivel_gravedad,
                    descripcion, accion_sugerida, id_inspeccion
                ])
        
        return self.guardar_csv(
            '72_hallazgo.csv',
            datos,
            ['id_hallazgo', 'codigo', 'id_tipo_hallazgo', 'nivel_gravedad',
             'descripcion', 'accion_sugerida', 'id_inspeccion']
        )
    
    def generar_tripulante_idioma(self):
        print(f"\nGenerando TripulanteIdioma...")
        datos = []
        registros_unicos = set()
        
        idiomas = [
            'Espanol', 'Ingles', 'Portugues', 'Chino', 
            'Frances', 'Aleman', 'Italiano', 'Japones'
        ]
        
        niveles = ['Básico', 'Intermedio', 'Avanzado', 'Nativo']
        
        for id_tripulante in self.ids['tripulante']:
            num_idiomas = random.randint(1, 3)
            idiomas_seleccionados = random.sample(idiomas, min(num_idiomas, len(idiomas)))
            
            for idioma in idiomas_seleccionados:
                clave = (id_tripulante, idioma)
                if clave not in registros_unicos:
                    id_tripulante_idioma = str(uuid.uuid4())
                    nivel = random.choice(niveles)
                    
                    datos.append([
                        id_tripulante_idioma, id_tripulante, idioma, nivel
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '73_tripulante_idioma.csv',
            datos,
            ['id_tripulante_idioma', 'id_tripulante', 'idioma', 'nivel']
        )
    
    def generar_operacion_maritima_condicion(self):
        print(f"\nGenerando OperacionMaritimaCondicion...")
        datos = []
        registros_unicos = set()
        
        for om in self.ids['operacion_maritima']:
            id_op_maritima = om[0]
            num_condiciones = random.randint(1, 3)
            condiciones = random.sample(
                self.ids['condicion_operativa'], 
                min(num_condiciones, len(self.ids['condicion_operativa']))
            )
            
            for id_condicion in condiciones:
                clave = (id_op_maritima, id_condicion)
                if clave not in registros_unicos:
                    id_om_condicion = str(uuid.uuid4())
                    
                    datos.append([
                        id_om_condicion, id_op_maritima, id_condicion
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '74_operacion_maritima_condicion.csv',
            datos,
            ['id_operacion_maritima_condicion', 'id_operacion_maritima', 'id_condicion_operativa']
        )
    
    def generar_operacion_empleado(self):
        print(f"\nGenerando OperacionEmpleado...")
        datos = []
        registros_unicos = set()
        
        for id_operacion in self.ids['operacion']:
            num_empleados = random.randint(1, 4)
            empleados = random.sample(
                self.ids['empleado'], 
                min(num_empleados, len(self.ids['empleado']))
            )
            
            for id_empleado in empleados:
                fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
                clave = (id_operacion, id_empleado, fecha_asignacion.strftime('%Y-%m-%d'))
                
                if clave not in registros_unicos:
                    id_op_empleado = str(uuid.uuid4())
                    fecha_desasignacion = fecha_asignacion + timedelta(days=random.randint(1, 30)) if random.random() < 0.3 else None
                    
                    datos.append([
                        id_op_empleado, id_operacion, id_empleado,
                        fecha_asignacion.strftime('%Y-%m-%d'),
                        fecha_desasignacion.strftime('%Y-%m-%d') if fecha_desasignacion else ''
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '75_operacion_empleado.csv',
            datos,
            ['id_operacion_empleado', 'id_operacion', 'id_empleado',
             'fecha_asignacion', 'fecha_desasignacion']
        )
    
    def generar_trabajador_portuario_equipo_portuario(self):
        print(f"\nGenerando TrabajadorPortuarioEquipoPortuario...")
        datos = []
        registros_unicos = set()
        
        for id_trabajador in self.ids['trabajador_portuario']:
            num_equipos = random.randint(1, 3)
            equipos = random.sample(
                self.ids['equipo_portuario'], 
                min(num_equipos, len(self.ids['equipo_portuario']))
            )
            
            for id_equipo in equipos:
                clave = (id_trabajador, id_equipo)
                if clave not in registros_unicos:
                    id_trabajador_equipo = str(uuid.uuid4())
                    
                    datos.append([
                        id_trabajador_equipo, id_trabajador, id_equipo
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '76_trabajador_portuario_equipo_portuario.csv',
            datos,
            ['id_trabajador_portuario_equipo_portuario', 'id_trabajador_portuario', 'id_equipo_portuario']
        )
    
    def generar_operacion_contenedor(self):
        print(f"\nGenerando OperacionContenedor...")
        datos = []
        registros_unicos = set()
        
        for id_operacion in self.ids['operacion']:
            if random.random() < 0.6:  # 60% de operaciones tienen contenedores
                num_contenedores = random.randint(1, 5)
                contenedores = random.sample(
                    self.ids['contenedor'], 
                    min(num_contenedores, len(self.ids['contenedor']))
                )
                
                for id_contenedor in contenedores:
                    fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                    clave = (id_operacion, id_contenedor, fecha_asignacion.strftime('%Y-%m-%d'))
                    
                    if clave not in registros_unicos:
                        id_op_contenedor = str(uuid.uuid4())
                        
                        datos.append([
                            id_op_contenedor, id_operacion, id_contenedor,
                            fecha_asignacion.strftime('%Y-%m-%d')
                        ])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '77_operacion_contenedor.csv',
            datos,
            ['id_operacion_contenedor', 'id_operacion', 'id_contenedor', 'fecha_asignacion']
        )
    
    def generar_operacion_equipo_portuario(self):
        print(f"\nGenerando OperacionEquipoPortuario...")
        datos = []
        registros_unicos = set()
        
        for id_op_portuaria in self.ids['operacion_portuaria']:
            num_equipos = random.randint(1, 4)
            equipos = random.sample(
                self.ids['equipo_portuario'], 
                min(num_equipos, len(self.ids['equipo_portuario']))
            )
            
            for id_equipo in equipos:
                fecha_asignacion = fecha_hora_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                clave = (id_op_portuaria, id_equipo, fecha_asignacion.strftime('%Y-%m-%d %H:%M:%S'))
                
                if clave not in registros_unicos:
                    id_op_equipo = str(uuid.uuid4())
                    id_trabajador = random.choice(self.ids['trabajador_portuario'])
                    fecha_devolucion = fecha_asignacion + timedelta(hours=random.randint(2, 48)) if random.random() < 0.7 else None
                    
                    datos.append([
                        id_op_equipo, id_op_portuaria, id_equipo, id_trabajador,
                        fecha_asignacion.strftime('%Y-%m-%d %H:%M:%S'),
                        fecha_devolucion.strftime('%Y-%m-%d %H:%M:%S') if fecha_devolucion else ''
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '78_operacion_equipo_portuario.csv',
            datos,
            ['id_operacion_equipo_portuario', 'id_operacion_portuaria', 'id_equipo_portuario',
             'id_trabajador_portuario', 'fecha_asignacion', 'fecha_devolucion']
        )
    
    def generar_certificacion_aduanera(self, cantidad=15):
        print(f"\nGenerando {cantidad} Certificaciones Aduaneras...")
        datos = []
        self.ids['certificacion_aduanera'] = []
        codigos_usados = set()
        
        certificaciones_adu = [
            ('Certificado de Origen', 'Documento que acredita el origen de la mercancia', 'Peru'),
            ('Declaracion Aduanera', 'Documento de declaracion de mercancia', 'Internacional'),
            ('Certificado Sanitario', 'Certificado de condiciones sanitarias', 'Peru'),
            ('Certificado Fitosanitario', 'Certificado de sanidad vegetal', 'Peru'),
            ('Manifiesto de Carga', 'Listado de mercancia transportada', 'Internacional'),
            ('Bill of Lading', 'Conocimiento de embarque maritimo', 'Internacional'),
            ('Certificado de Fumigacion', 'Certificado de tratamiento fitosanitario', 'Peru'),
            ('Certificado de Calidad', 'Certificado de cumplimiento de estandares', 'Internacional'),
            ('Packing List', 'Lista de empaque de mercancia', 'Internacional'),
            ('Factura Comercial', 'Documento de transaccion comercial', 'Internacional')
        ]
        
        # Usar certificaciones existentes
        cert_ids = random.sample(self.ids['certificacion'], min(cantidad, len(self.ids['certificacion'])))
        
        for i, id_cert in enumerate(cert_ids):
            if i < len(certificaciones_adu):
                nombre, descripcion, pais = certificaciones_adu[i]
            else:
                nombre = f"Certificacion Aduanera {i+1}"
                descripcion = fake.sentence(nb_words=8)
                pais = random.choice(['Peru', 'Chile', 'Internacional'])
            
            while True:
                codigo = f"CADU-{fake.random_number(digits=5):05d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            # CORREGIDO: usar 'now' en lugar de 'today' y trabajar con datetime
            fecha_emision = fecha_hora_entre(BASE_NOW, dias_desde=-2*365, dias_hasta=0)
            fecha_expiracion = fecha_emision + timedelta(days=random.randint(365, 1825))
            
            self.ids['certificacion_aduanera'].append(id_cert)
            datos.append([
                id_cert, codigo, nombre, descripcion, pais,
                fecha_emision.strftime('%Y-%m-%d %H:%M:%S+00'),
                fecha_expiracion.strftime('%Y-%m-%d %H:%M:%S+00')
            ])
        
        return self.guardar_csv(
            '79_certificacion_aduanera.csv',
            datos,
            ['id_certificacion_aduanera', 'codigo', 'nombre', 'descripcion',
            'pais_aplicacion', 'fecha_emision', 'fecha_expiracion']
        )
    
    def generar_ruta_maritima(self):
        print(f"\nGenerando Rutas Maritimas...")
        datos = []
        self.ids['ruta_maritima'] = []
        codigos_usados = set()
        
        # Seleccionar rutas que no tienen asignación
        rutas_disponibles = random.sample(self.ids['ruta'], min(25, len(self.ids['ruta'])))
        
        for id_ruta in rutas_disponibles:
            id_ruta_maritima = str(uuid.uuid4())
            
            while True:
                codigo = f"RMR-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            distancia = round(random.uniform(100.0, 5000.0), 2)
            
            # Seleccionar puertos diferentes
            puertos = random.sample(self.ids['puerto'], 2)
            id_puerto_origen = puertos[0]
            id_puerto_destino = puertos[1]
            
            self.ids['ruta_maritima'].append(id_ruta_maritima)
            datos.append([
                id_ruta_maritima, id_ruta, codigo, distancia,
                id_puerto_origen, id_puerto_destino
            ])
        
        return self.guardar_csv(
            '80_ruta_maritima.csv',
            datos,
            ['id_ruta_maritima', 'id_ruta', 'codigo', 'distancia',
             'id_puerto_origen', 'id_puerto_destino']
        )
    
    def generar_operacion_ruta_maritima(self):
        print(f"\nGenerando OperacionRutaMaritima...")
        datos = []
        
        for om in self.ids['operacion_maritima'][:len(self.ids['ruta_maritima'])]:
            id_op_maritima = om[0]
            id_ruta_maritima = random.choice(self.ids['ruta_maritima'])
            
            # Seleccionar muelles diferentes
            muelles = random.sample(self.ids['muelle'], 2)
            id_muelle_origen = muelles[0]
            id_muelle_destino = muelles[1]
            
            id_op_ruta = str(uuid.uuid4())
            datos.append([
                id_op_ruta, id_op_maritima, id_ruta_maritima,
                id_muelle_origen, id_muelle_destino
            ])
        
        return self.guardar_csv(
            '81_operacion_ruta_maritima.csv',
            datos,
            ['id_operacion_ruta_maritima', 'id_operacion_maritima', 'id_ruta_maritima',
             'id_muelle_origen', 'id_muelle_destino']
        )
    
    def generar_estiba(self):
        print(f"\nGenerando Estiba...")
        datos = []
        
        zonas_buque = [
            'Proa', 'Popa', 'Centro', 'Babor', 'Estribor',
            'Cubierta Superior', 'Cubierta Inferior', 'Bodega 1', 'Bodega 2'
        ]
        
        for id_op_portuaria in self.ids['operacion_portuaria']:
            num_estibas = random.randint(2, 8)
            contenedores = random.sample(
                self.ids['contenedor'], 
                min(num_estibas, len(self.ids['contenedor']))
            )
            
            for idx, id_contenedor in enumerate(contenedores):
                id_estiba = str(uuid.uuid4())
                ubicacion = f"Posicion {chr(65+random.randint(0,5))}{random.randint(1,20)}-{random.randint(1,6)}"
                zona_buque = random.choice(zonas_buque)
                
                datos.append([
                    id_estiba, id_op_portuaria, ubicacion, zona_buque, id_contenedor
                ])
        
        return self.guardar_csv(
            '82_estiba.csv',
            datos,
            ['id_estiba', 'id_operacion_portuaria', 'ubicacion', 'zona_buque', 'id_contenedor']
        )
    
    def generar_trabajador_portuario_equipo_proteccion(self):
        print(f"\nGenerando TrabajadorPortuarioEquipoProteccion...")
        datos = []
        registros_unicos = set()
        
        for id_trabajador in self.ids['trabajador_portuario']:
            num_equipos = random.randint(2, 5)
            equipos = random.sample(
                self.ids['equipo_proteccion'], 
                min(num_equipos, len(self.ids['equipo_proteccion']))
            )
            
            for id_equipo in equipos:
                clave = (id_trabajador, id_equipo)
                if clave not in registros_unicos:
                    id_trabajador_equipo_prot = str(uuid.uuid4())
                    fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-365, dias_hasta=0)
                    
                    datos.append([
                        id_trabajador_equipo_prot, id_trabajador, id_equipo,
                        fecha_asignacion.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '83_trabajador_portuario_equipo_proteccion.csv',
            datos,
            ['id_trabajador_portuario_equipo_proteccion', 'id_trabajador_portuario',
             'id_equipo_proteccion', 'fecha_asignacion']
        )
    
    def generar_ruta_puerto_intermedio(self):
        print(f"\nGenerando RutaPuertoIntermedio...")
        datos = []
        registros_unicos = set()
        
        for id_ruta_maritima in self.ids['ruta_maritima']:
            # Algunas rutas tienen puertos intermedios
            if random.random() < 0.6:
                num_intermedios = random.randint(1, 3)
                puertos = random.sample(
                    self.ids['puerto'], 
                    min(num_intermedios, len(self.ids['puerto']))
                )
                
                for id_puerto in puertos:
                    clave = (id_ruta_maritima, id_puerto)
                    if clave not in registros_unicos:
                        id_ruta_puerto = str(uuid.uuid4())
                        
                        datos.append([
                            id_ruta_puerto, id_ruta_maritima, id_puerto
                        ])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '84_ruta_puerto_intermedio.csv',
            datos,
            ['id_ruta_puerto_intermedio', 'id_ruta_maritima', 'id_puerto']
        )
    
    def generar_operacion_certificacion_aduanera(self):
        print(f"\nGenerando OperacionCertificacionAduanera...")
        datos = []
        registros_unicos = set()
        
        estados = ['PENDIENTE', 'APROBADO', 'RECHAZADO']
        
        for om in self.ids['operacion_maritima']:
            id_op_maritima = om[0]
            num_certificaciones = random.randint(1, 3)
            certificaciones = random.sample(
                self.ids['certificacion_aduanera'], 
                min(num_certificaciones, len(self.ids['certificacion_aduanera']))
            )
            
            for id_cert in certificaciones:
                clave = (id_op_maritima, id_cert)
                if clave not in registros_unicos:
                    id_op_cert = str(uuid.uuid4())
                    estado = random.choice(estados)
                    fecha_aprobacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0) if estado == 'APROBADO' else None
                    
                    datos.append([
                        id_op_cert, id_op_maritima, id_cert, estado,
                        fecha_aprobacion.strftime('%Y-%m-%d') if fecha_aprobacion else ''
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '85_operacion_certificacion_aduanera.csv',
            datos,
            ['id_operacion_certificacion_aduanera', 'id_operacion_maritima',
             'id_certificacion_aduanera', 'estado', 'fecha_aprobacion']
        )
    
    # ============================================
    # SCHEMA: operaciones_terrestres
    # ============================================
    
    def generar_rutas_terrestres(self):
        print(f"\nGenerando Rutas Terrestres...")
        datos = []
        self.ids['ruta_terrestre'] = []
        
        # Seleccionar rutas que no son marítimas
        rutas_maritimas_ids = [rm for rm in self.ids['ruta_maritima']]
        rutas_disponibles = [r for r in self.ids['ruta'] if r not in rutas_maritimas_ids][:30]
        
        for id_ruta in rutas_disponibles:
            id_ruta_terrestre = str(uuid.uuid4())
            
            self.ids['ruta_terrestre'].append(id_ruta_terrestre)
            datos.append([id_ruta_terrestre, id_ruta])
        
        return self.guardar_csv(
            '86_ruta_terrestre.csv',
            datos,
            ['id_ruta_terrestre', 'id_ruta']
        )
    
    def generar_conductores(self):
        print(f"\nGenerando Conductores...")
        datos = []
        self.ids['conductor'] = []
        licencias_usadas = set()
        
        # Seleccionar empleados que no tienen otros roles
        empleados_usados = set(self.ids['tripulante'])
        empleados_usados.update(self.ids['agente_reservas'])
        empleados_usados.update(self.ids['trabajador_portuario'])
        
        empleados_disponibles = [e for e in self.ids['empleado'] if e not in empleados_usados]
        empleados_conductores = random.sample(
            empleados_disponibles, 
            min(35, len(empleados_disponibles))
        )
        
        categorias = ['A-I', 'A-IIa', 'A-IIb', 'A-IIIa', 'A-IIIb', 'A-IIIc']
        
        for id_empleado in empleados_conductores:
            id_conductor = str(uuid.uuid4())
            
            while True:
                licencia = f"LIC-{fake.random_number(digits=9):09d}"
                if licencia not in licencias_usadas:
                    licencias_usadas.add(licencia)
                    break
            
            categoria = random.choice(categorias)
            disponibilidad = random.choice([True, False])
            
            self.ids['conductor'].append(id_conductor)
            datos.append([
                id_conductor, id_empleado, licencia, categoria, disponibilidad
            ])
        
        return self.guardar_csv(
            '87_conductor.csv',
            datos,
            ['id_conductor', 'id_empleado', 'licencia', 'categoria', 'disponibilidad']
        )
    
    def generar_operacion_terrestre_detalle(self):
        print(f"\nGenerando OperacionTerrestreDetalle...")
        datos = []
        
        for ot in self.ids['operacion_terrestre']:
            id_op_terrestre = ot[0]
            id_op_terrestre_detalle = str(uuid.uuid4())
            
            id_vehiculo = random.choice(self.ids['vehiculo'])
            id_ruta_terrestre = random.choice(self.ids['ruta_terrestre'])
            id_conductor = random.choice(self.ids['conductor'])
            
            datos.append([
                id_op_terrestre_detalle, id_op_terrestre, id_vehiculo,
                id_ruta_terrestre, id_conductor
            ])
        
        return self.guardar_csv(
            '88_operacion_terrestre_detalle.csv',
            datos,
            ['id_operacion_terrestre_detalle', 'id_operacion_terrestre', 'id_vehiculo',
             'id_ruta_terrestre', 'id_conductor']
        )
    
    def generar_checklist_despacho(self):
        print(f"\nGenerando ChecklistDespacho...")
        datos = []
        codigos_usados = set()
        
        estados_check = ['OK', 'Regular', 'Deficiente', 'Necesita Revision']
        
        for ot in self.ids['operacion_terrestre']:
            id_op_terrestre = ot[0]
            id_checklist = str(uuid.uuid4())
            
            while True:
                codigo = f"CHK-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            observaciones = fake.sentence(nb_words=10) if random.random() > 0.3 else ''
            combustible = random.choice(estados_check)
            frenos = random.choice(estados_check)
            
            datos.append([
                id_checklist, codigo, observaciones, combustible,
                frenos, id_op_terrestre
            ])
        
        return self.guardar_csv(
            '89_checklist_despacho.csv',
            datos,
            ['id_checklist', 'codigo', 'observaciones', 'combustible',
             'frenos', 'id_operacion_terrestre']
        )
    
    def generar_documentacion_operacion(self, cantidad=80):
        print(f"\nGenerando {cantidad} Documentacion Operacion...")
        datos = []
        self.ids['documento_operacion'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_documento = str(uuid.uuid4())
            
            while True:
                codigo = f"DOC-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = f"Documento_{fake.word()}_{random.randint(100, 999)}.pdf"
            fecha_emision = fecha_entre(BASE_NOW, dias_desde=-365, dias_hasta=0)
            ruta_archivo = f"/documentos/{fecha_emision.year}/{fecha_emision.month:02d}/{nombre}"
            id_tipo = random.choice(self.ids['tipo_documento'])
            
            self.ids['documento_operacion'].append(id_documento)
            datos.append([
                id_documento, codigo, nombre, ruta_archivo,
                fecha_emision.strftime('%Y-%m-%d'), id_tipo
            ])
        
        return self.guardar_csv(
            '90_documentacion_operacion.csv',
            datos,
            ['id_documento', 'codigo', 'nombre', 'ruta_archivo',
             'fecha_emision', 'id_tipo_documento']
        )
    
    def generar_operacion_documento(self):
        print(f"\nGenerando OperacionDocumento...")
        datos = []
        registros_unicos = set()
        
        for id_operacion in self.ids['operacion']:
            num_docs = random.randint(1, 4)
            documentos = random.sample(
                self.ids['documento_operacion'], 
                min(num_docs, len(self.ids['documento_operacion']))
            )
            
            for id_documento in documentos:
                clave = (id_operacion, id_documento)
                if clave not in registros_unicos:
                    datos.append([id_operacion, id_documento])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '91_operacion_documento.csv',
            datos,
            ['id_operacion', 'id_documento']
        )
    
    def generar_reporte_transporte(self):
        print(f"\nGenerando ReporteTransporte...")
        datos = []
        codigos_usados = set()
        
        for ot in self.ids['operacion_terrestre']:
            id_op_terrestre = ot[0]
            id_reporte = str(uuid.uuid4())
            
            while True:
                codigo = f"REP-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_tipo = random.choice(self.ids['tipo_reporte'])
            fecha_generado = fecha_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
            
            datos.append([
                id_reporte, codigo, id_tipo,
                fecha_generado.strftime('%Y-%m-%d'), id_op_terrestre
            ])
        
        return self.guardar_csv(
            '92_reporte_transporte.csv',
            datos,
            ['id_reporte', 'codigo', 'id_tipo_reporte',
             'fecha_generado', 'id_operacion_terrestre']
        )
    
    # ============================================
    # SCHEMA: mantenimiento_logistico
    # ============================================
    
    def generar_tecnicos(self):
        print(f"\nGenerando Tecnicos...")
        datos = []
        self.ids['tecnico'] = []
        
        especialidades_tecnicas = [
            'Mecanica Automotriz', 'Electricidad Industrial', 'Electronica',
            'Hidraulica', 'Neumatica', 'Soldadura', 'Refrigeracion',
            'Mantenimiento Predictivo', 'Instrumentacion'
        ]
        
        # Seleccionar empleados que no tienen otros roles
        empleados_usados = set(self.ids['tripulante'])
        empleados_usados.update(self.ids['agente_reservas'])
        empleados_usados.update(self.ids['trabajador_portuario'])
        empleados_usados.update(self.ids['conductor'])
        
        empleados_disponibles = [e for e in self.ids['empleado'] if e not in empleados_usados]
        empleados_tecnicos = random.sample(
            empleados_disponibles, 
            min(25, len(empleados_disponibles))
        )
        
        for id_empleado in empleados_tecnicos:
            id_tecnico = str(uuid.uuid4())
            especialidad = random.choice(especialidades_tecnicas)
            
            self.ids['tecnico'].append(id_tecnico)
            datos.append([id_tecnico, id_empleado, especialidad])
        
        return self.guardar_csv(
            '93_tecnico.csv',
            datos,
            ['id_tecnico', 'id_empleado', 'especialidad']
        )
    
    def generar_responsables_solicitud(self):
        print(f"\nGenerando Responsables de Solicitud...")
        datos = []
        self.ids['responsable_solicitud'] = []
        
        # Seleccionar empleados que no tienen roles técnicos
        empleados_usados = set(self.ids['tripulante'])
        empleados_usados.update(self.ids['trabajador_portuario'])
        empleados_usados.update(self.ids['conductor'])
        empleados_usados.update(self.ids['tecnico'])
        
        empleados_disponibles = [e for e in self.ids['empleado'] if e not in empleados_usados]
        empleados_responsables = random.sample(
            empleados_disponibles, 
            min(20, len(empleados_disponibles))
        )
        
        for id_empleado in empleados_responsables:
            id_responsable = str(uuid.uuid4())
            
            self.ids['responsable_solicitud'].append(id_responsable)
            datos.append([id_responsable, id_empleado])
        
        return self.guardar_csv(
            '94_responsable_solicitud.csv',
            datos,
            ['id_responsable_solicitud', 'id_empleado']
        )
    
    def generar_repuestos(self, cantidad=70):
        print(f"\nGenerando {cantidad} Repuestos...")
        datos = []
        self.ids['repuesto'] = []
        codigos_usados = set()
        
        nombres_repuestos = [
            'Filtro de Aceite', 'Bujia', 'Correa de Distribucion', 'Pastillas de Freno',
            'Rodamiento', 'Junta', 'Sensor', 'Rele', 'Fusible', 'Cable',
            'Manguera', 'Valvula', 'Tornillo', 'Tuerca', 'Resorte',
            'Amortiguador', 'Disco de Freno', 'Alternador', 'Motor de Arranque'
        ]
        
        for i in range(cantidad):
            id_repuesto = str(uuid.uuid4())
            
            while True:
                codigo = f"REP-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = f"{random.choice(nombres_repuestos)} {random.choice(['Premium', 'Standard', 'Heavy Duty'])} {random.randint(10, 99)}"
            stock = random.randint(0, 200)
            stock_minimo = random.randint(5, 30)
            precio_unitario = round(random.uniform(10.0, 500.0), 2)
            
            self.ids['repuesto'].append(id_repuesto)
            datos.append([
                id_repuesto, codigo, nombre, stock, stock_minimo, precio_unitario
            ])
        
        return self.guardar_csv(
            '95_repuesto.csv',
            datos,
            ['id_repuesto', 'codigo', 'nombre', 'stock', 'stock_minimo', 'precio_unitario']
        )
    
    def generar_planes_mantenimiento(self, cantidad=45):
        print(f"\nGenerando {cantidad} Planes de Mantenimiento...")
        datos = []
        self.ids['plan_mantenimiento'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_plan = str(uuid.uuid4())
            
            while True:
                codigo = f"PLN-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            descripcion = fake.paragraph(nb_sentences=2)
            frecuencia = random.choice([7, 15, 30, 60, 90, 180, 365])  # días
            fecha_creacion = fecha_entre(BASE_NOW, dias_desde=-365, dias_hasta=0)
            id_estado = random.choice(self.ids['estado_plan'])
            id_activo = random.choice(self.ids['activo'])
            
            self.ids['plan_mantenimiento'].append(id_plan)
            datos.append([
                id_plan, codigo, descripcion, frecuencia,
                fecha_creacion.strftime('%Y-%m-%d'), id_estado, id_activo
            ])
        
        return self.guardar_csv(
            '96_plan_mantenimiento.csv',
            datos,
            ['id_plan_mantenimiento', 'codigo', 'descripcion', 'frecuencia',
             'fecha_creacion', 'id_estado_plan', 'id_activo']
        )
    
    def generar_solicitudes_mantenimiento(self, cantidad=50):
        print(f"\nGenerando {cantidad} Solicitudes de Mantenimiento...")
        datos = []
        self.ids['solicitud_mantenimiento'] = []
        codigos_usados = set()
        
        problemas = [
            'Falla mecanica detectada en componente principal',
            'Desgaste prematuro de piezas criticas',
            'Ruido anormal durante operacion',
            'Sobrecalentamiento del sistema',
            'Perdida de eficiencia operativa',
            'Vibraciones excesivas detectadas',
            'Fuga de fluidos en el sistema',
            'Componente electronico defectuoso'
        ]
        
        for i in range(cantidad):
            id_solicitud = str(uuid.uuid4())
            
            while True:
                codigo = f"SOL-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            descripcion = random.choice(problemas) + ". " + fake.sentence(nb_words=12)
            fecha_solicitud = fecha_entre(BASE_NOW, dias_desde=-180, dias_hasta=0)
            id_prioridad = random.choice(self.ids['prioridad'])
            id_estado = random.choice(self.ids['estado_solicitud'])
            id_responsable = random.choice(self.ids['responsable_solicitud'])
            id_activo = random.choice(self.ids['activo'])
            
            self.ids['solicitud_mantenimiento'].append(id_solicitud)
            datos.append([
                id_solicitud, codigo, descripcion,
                fecha_solicitud.strftime('%Y-%m-%d'),
                id_prioridad, id_estado, id_responsable, id_activo
            ])
        
        return self.guardar_csv(
            '97_solicitud_mantenimiento.csv',
            datos,
            ['id_solicitud_mantenimiento', 'codigo', 'descripcion_problema',
             'fecha_solicitud', 'id_prioridad', 'id_estado_solicitud',
             'id_responsable_solicitud', 'id_activo']
        )
    
    def generar_operaciones_mantenimiento(self):
        print(f"\nGenerando Operaciones de Mantenimiento...")
        datos = []
        self.ids['operacion_mantenimiento'] = []
        
        # Seleccionar operaciones que no tienen asignación específica
        operaciones_usadas = set([om[1] for om in self.ids['operacion_maritima']])
        operaciones_usadas.update([ot[1] for ot in self.ids['operacion_terrestre']])
        operaciones_usadas.update([op for op in self.ids['operacion_portuaria']])
        
        operaciones_disponibles = [op for op in self.ids['operacion'] if op not in operaciones_usadas][:50]
        
        for id_operacion in operaciones_disponibles:
            id_op_mantenimiento = str(uuid.uuid4())
            
            # Puede ser plan o solicitud, no ambos
            tipo = random.choice(['plan', 'solicitud'])
            
            if tipo == 'plan' and self.ids['plan_mantenimiento']:
                id_plan = random.choice(self.ids['plan_mantenimiento'])
                id_solicitud = ''
            else:
                id_plan = ''
                id_solicitud = random.choice(self.ids['solicitud_mantenimiento']) if self.ids['solicitud_mantenimiento'] else ''
            
            self.ids['operacion_mantenimiento'].append(id_op_mantenimiento)
            datos.append([
                id_op_mantenimiento, id_operacion, id_plan, id_solicitud
            ])
        
        return self.guardar_csv(
            '98_operacion_mantenimiento.csv',
            datos,
            ['id_operacion_mantenimiento', 'id_operacion',
             'id_plan_mantenimiento', 'id_solicitud_mantenimiento']
        )
    
    def generar_ordenes_mantenimiento(self):
        print(f"\nGenerando Ordenes de Mantenimiento...")
        datos = []
        self.ids['orden_mantenimiento'] = []
        codigos_usados = set()
        
        for id_op_mant in self.ids['operacion_mantenimiento']:
            id_orden = str(uuid.uuid4())
            
            while True:
                codigo = f"ORD-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            fecha_generada = fecha_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
            fecha_programada = fecha_generada + timedelta(days=random.randint(1, 15))
            
            if random.random() < 0.5:
                fecha_cierre = fecha_programada + timedelta(days=random.randint(0, 5))
            else:
                fecha_cierre = None
            
            id_tipo = random.choice(self.ids['tipo_mantenimiento'])
            id_estado = random.choice(self.ids['estado_orden'])
            
            self.ids['orden_mantenimiento'].append(id_orden)
            datos.append([
                id_orden, codigo,
                fecha_generada.strftime('%Y-%m-%d'),
                fecha_programada.strftime('%Y-%m-%d'),
                fecha_cierre.strftime('%Y-%m-%d') if fecha_cierre else '',
                id_tipo, id_estado, id_op_mant
            ])
        
        return self.guardar_csv(
            '99_orden_mantenimiento.csv',
            datos,
            ['id_orden', 'codigo', 'fecha_generada', 'fecha_programada',
             'fecha_cierre', 'id_tipo_mantenimiento', 'id_estado_orden',
             'id_operacion_mantenimiento']
        )
    
    def generar_tareas_mantenimiento(self):
        print(f"\nGenerando Tareas de Mantenimiento...")
        datos = []
        
        descripciones_tareas = [
            'Inspeccion visual de componentes criticos del sistema',
            'Limpieza y lubricacion de mecanismos de transmision',
            'Revision y ajuste de conexiones electricas',
            'Cambio de filtros y fluidos del sistema',
            'Ajuste de parametros operativos y calibracion',
            'Prueba de funcionamiento y verificacion de rendimiento',
            'Calibracion de instrumentos de medicion',
            'Reemplazo de componentes desgastados o danados',
            'Verificacion de sistemas de seguridad',
            'Documentacion de hallazgos y recomendaciones'
        ]
        
        for id_orden in self.ids['orden_mantenimiento']:
            num_tareas = random.randint(2, 6)
            
            for _ in range(num_tareas):
                id_tarea = str(uuid.uuid4())
                descripcion = random.choice(descripciones_tareas)
                id_estado = random.choice(self.ids['estado_tarea'])
                
                datos.append([
                    id_tarea, descripcion, id_estado, id_orden
                ])
        
        return self.guardar_csv(
            '100_tarea_mantenimiento.csv',
            datos,
            ['id_tarea', 'descripcion', 'id_estado_tarea', 'id_orden']
        )
    
    def generar_operacion_mantenimiento_tecnico(self):
        print(f"\nGenerando OperacionMantenimientoTecnico...")
        datos = []
        registros_unicos = set()
        
        for id_op_mant in self.ids['operacion_mantenimiento']:
            num_tecnicos = random.randint(1, 3)
            tecnicos = random.sample(
                self.ids['tecnico'], 
                min(num_tecnicos, len(self.ids['tecnico']))
            )
            
            for id_tecnico in tecnicos:
                clave = (id_op_mant, id_tecnico)
                if clave not in registros_unicos:
                    fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
                    
                    datos.append([
                        id_op_mant, id_tecnico, fecha_asignacion.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '101_operacion_mantenimiento_tecnico.csv',
            datos,
            ['id_operacion_mantenimiento', 'id_tecnico', 'fecha_asignacion']
        )
    
    def generar_operacion_mantenimiento_repuesto(self):
        print(f"\nGenerando OperacionMantenimientoRepuesto...")
        datos = []
        registros_unicos = set()
        
        for id_op_mant in self.ids['operacion_mantenimiento']:
            if random.random() < 0.7:  # 70% de operaciones usan repuestos
                num_repuestos = random.randint(1, 5)
                repuestos = random.sample(
                    self.ids['repuesto'], 
                    min(num_repuestos, len(self.ids['repuesto']))
                )
                
                for id_repuesto in repuestos:
                    fecha_uso = fecha_entre(BASE_NOW,dias_desde=-120, dias_hasta=0)
                    clave = (id_op_mant, id_repuesto, fecha_uso.strftime('%Y-%m-%d'))
                    
                    if clave not in registros_unicos:
                        cantidad = random.randint(1, 10)
                        precio_unitario = round(random.uniform(10.0, 500.0), 2)
                        
                        datos.append([
                            id_op_mant, id_repuesto,
                            fecha_uso.strftime('%Y-%m-%d'),
                            cantidad, precio_unitario
                        ])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '102_operacion_mantenimiento_repuesto.csv',
            datos,
            ['id_operacion_mantenimiento', 'id_repuesto', 'fecha_uso',
             'cantidad', 'precio_unitario']
        )
    
    # ============================================
    # SCHEMA: monitoreo
    # ============================================
    
    def generar_operadores(self):
        print(f"\nGenerando Operadores de Monitoreo...")
        datos = []
        self.ids['operador'] = []
        
        turnos = ['Mañana', 'Tarde', 'Noche']
        
        zonas = [
            'Puerto del Callao', 'Zona Industrial Norte', 'Zona Industrial Sur',
            'Terminal de Contenedores', 'Zona de Almacenamiento A', 'Zona de Almacenamiento B',
            'Area de Carga Internacional', 'Centro de Distribucion'
        ]
        
        # Seleccionar empleados que no tienen otros roles
        empleados_usados = set(self.ids['tripulante'])
        empleados_usados.update(self.ids['agente_reservas'])
        empleados_usados.update(self.ids['trabajador_portuario'])
        empleados_usados.update(self.ids['conductor'])
        empleados_usados.update(self.ids['tecnico'])
        empleados_usados.update(self.ids['responsable_solicitud'])
        
        empleados_disponibles = [e for e in self.ids['empleado'] if e not in empleados_usados]
        empleados_operadores = random.sample(
            empleados_disponibles, 
            min(20, len(empleados_disponibles))
        )
        # Garantizar que el empleado del usuario demo sea operador (acceso a monitoreo)
        if self.ids['empleado'][0] not in empleados_operadores:
            empleados_operadores.insert(0, self.ids['empleado'][0])
        
        for id_empleado in empleados_operadores:
            id_operador = str(uuid.uuid4())
            turno = random.choice(turnos)
            zona_monitoreo = random.choice(zonas)
            
            self.ids['operador'].append(id_operador)
            datos.append([
                id_operador, id_empleado, turno, zona_monitoreo
            ])
        
        return self.guardar_csv(
            '103_operador.csv',
            datos,
            ['id_operador', 'id_empleado', 'turno', 'zona_monitoreo']
        )
    
    def generar_operaciones_monitoreo(self):
        print(f"\nGenerando Operaciones de Monitoreo...")
        datos = []
        self.ids['operacion_monitoreo'] = []
        
        # Seleccionar operaciones que no tienen asignación específica
        operaciones_usadas = set([om[1] for om in self.ids['operacion_maritima']])
        operaciones_usadas.update([ot[1] for ot in self.ids['operacion_terrestre']])
        operaciones_usadas.update([op for op in self.ids['operacion_portuaria']])
        operaciones_usadas.update([om for om in self.ids['operacion_mantenimiento']])
        
        operaciones_disponibles = [op for op in self.ids['operacion'] if op not in operaciones_usadas][:45]
        
        for id_operacion in operaciones_disponibles:
            id_op_monitoreo = str(uuid.uuid4())
            
            self.ids['operacion_monitoreo'].append(id_op_monitoreo)
            datos.append([id_op_monitoreo, id_operacion])
        
        return self.guardar_csv(
            '104_operacion_monitoreo.csv',
            datos,
            ['id_operacion_monitoreo', 'id_operacion']
        )
    
    def generar_sensores(self):
        print(f"\nGenerando Sensores...")
        datos = []
        self.ids['sensor'] = []
        self.ids['sensor_tipo'] = {}
        codigos_usados = set()
        
        nombres_sensores = [
            'GPS Tracker', 'Sensor de Temperatura', 'Sensor de Humedad',
            'Sensor de Presion', 'Acelerometro', 'Giroscopio',
            'RFID Reader', 'Sensor de Movimiento'
        ]
        
        # Asignar sensores a algunos contenedores
        contenedores_con_sensor = random.sample(
            self.ids['contenedor'], 
            min(150, len(self.ids['contenedor']))
        )
        
        for id_contenedor in contenedores_con_sensor:
            # Algunos contenedores tienen múltiples sensores
            num_sensores = random.randint(1, 3)
            
            for _ in range(num_sensores):
                id_sensor = str(uuid.uuid4())
                
                while True:
                    codigo = f"SEN-{fake.random_number(digits=8):08d}"
                    if codigo not in codigos_usados:
                        codigos_usados.add(codigo)
                        break
                
                nombre = f"{random.choice(nombres_sensores)} {random.randint(100, 999)}"
                id_tipo = random.choice(self.ids['tipo_sensor'])
                id_rol = random.choice(self.ids['rol_sensor'])
                
                self.ids['sensor'].append(id_sensor)
                self.ids['sensor_tipo'][id_sensor] = id_tipo
                datos.append([
                    id_sensor, codigo, nombre, id_tipo, id_rol, id_contenedor
                ])
        
        return self.guardar_csv(
            '105_sensor.csv',
            datos,
            ['id_sensor', 'codigo', 'nombre', 'id_tipo_sensor',
             'id_rol_sensor', 'id_contenedor']
        )
    
    def _unidad_y_rango_por_tipo_sensor(self, id_tipo_sensor):
        """Devuelve (unidad, min, max) según el tipo de sensor."""
        try:
            indice = self.ids['tipo_sensor'].index(id_tipo_sensor)
        except ValueError:
            indice = 0
        rangos = [
            ('°', -90.0, 90.0),      # GPS -> coordenadas
            ('°C', 10.0, 35.0),      # Temperatura
            ('%', 30.0, 90.0),       # Humedad
            ('hPa', 980.0, 1040.0),  # Presion
            ('m/s²', 0.0, 9.81),     # Acelerometro
            ('°/s', -90.0, 90.0),    # Giroscopio
            ('unid', 1.0, 100.0),    # RFID
        ]
        unidad, lo, hi = rangos[indice % len(rangos)]
        return unidad, lo, hi
    
    def generar_lecturas_sensor(self):
        print(f"\nGenerando Lecturas de Sensores...")
        datos = []
        # Estado ponderado: mayormente lecturas normales
        pesos_estado = [80, 10, 5, 3, 2]  # Normal, Alerta, Critica, Sin Señal, Calibrando
        
        for id_sensor in self.ids['sensor']:
            num_lecturas = random.randint(20, 100)
            paso_minutos = random.randint(10, 90)
            # La lectura más reciente cae dentro de las últimas 24h
            t_fin = fecha_hora_entre(BASE_NOW, dias_desde=-1, dias_hasta=0)
            unidad, lo, hi = self._unidad_y_rango_por_tipo_sensor(
                self.ids['sensor_tipo'][id_sensor]
            )
            
            for i in range(num_lecturas):
                id_lectura = str(uuid.uuid4())
                # Serie ascendente: la primera es la más antigua
                fecha_hora = t_fin - timedelta(minutes=paso_minutos * (num_lecturas - i))
                valor = round(random.uniform(lo, hi), 2)
                id_estado = random.choices(self.ids['estado_lectura'], weights=pesos_estado, k=1)[0]
                
                datos.append([
                    id_lectura, id_sensor,
                    fecha_hora.strftime('%Y-%m-%d %H:%M:%S'),
                    valor, unidad, id_estado
                ])
        
        return self.guardar_csv(
            '105a_lectura_sensor.csv',
            datos,
            ['id_lectura_sensor', 'id_sensor', 'fecha_hora',
             'valor', 'unidad', 'id_estado_lectura']
        )
    
    def generar_reportes(self, cantidad=80):
        print(f"\nGenerando {cantidad} Reportes...")
        datos = []
        self.ids['reporte'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_reporte = str(uuid.uuid4())
            
            while True:
                codigo = f"REP-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            fecha_reporte = fecha_entre(BASE_NOW, dias_desde=-120, dias_hasta=0)
            detalle = fake.paragraph(nb_sentences=3)
            
            self.ids['reporte'].append(id_reporte)
            datos.append([
                id_reporte, codigo, fecha_reporte.strftime('%Y-%m-%d'), detalle
            ])
        
        return self.guardar_csv(
            '106_reporte.csv',
            datos,
            ['id_reporte', 'codigo', 'fecha_reporte', 'detalle']
        )
    
    def generar_notificaciones(self):
        print(f"\nGenerando Notificaciones...")
        datos = []
        codigos_usados = set()
        
        for id_sensor in self.ids['sensor']:
            # Algunos sensores generan múltiples notificaciones
            num_notificaciones = random.randint(1, 5)
            
            for _ in range(num_notificaciones):
                id_notificacion = str(uuid.uuid4())
                
                while True:
                    codigo = f"NOT-{fake.random_number(digits=8):08d}"
                    if codigo not in codigos_usados:
                        codigos_usados.add(codigo)
                        break
                
                id_tipo = random.choice(self.ids['tipo_notificacion'])
                fecha_hora = fecha_hora_entre(BASE_NOW, dias_desde=-30, dias_hasta=0)
                valor = round(random.uniform(-50.0, 150.0), 2)
                id_reporte = random.choice(self.ids['reporte'])
                
                datos.append([
                    id_notificacion, codigo, id_tipo,
                    fecha_hora.strftime('%Y-%m-%d %H:%M:%S'),
                    valor, id_sensor, id_reporte
                ])
        
        return self.guardar_csv(
            '107_notificacion.csv',
            datos,
            ['id_notificacion', 'codigo', 'id_tipo_notificacion',
             'fecha_hora', 'valor', 'id_sensor', 'id_reporte']
        )
    
    def generar_importadores(self, cantidad=40):
        print(f"\nGenerando {cantidad} Importadores...")
        datos = []
        self.ids['importador'] = []
        ruc_usados = set()
        codigos_usados = set()
        
        for i in range(cantidad):
            id_importador = str(uuid.uuid4())
            
            while True:
                codigo = f"IMP-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            while True:
                ruc = f"{fake.random_number(digits=11):011d}"
                if ruc not in ruc_usados:
                    ruc_usados.add(ruc)
                    break
            
            razon_social = fake.company()
            
            self.ids['importador'].append(id_importador)
            datos.append([
                id_importador, codigo, ruc, razon_social
            ])
        
        return self.guardar_csv(
            '108_importador.csv',
            datos,
            ['id_importador', 'codigo', 'ruc', 'razon_social']
        )
    
    def generar_importador_direccion(self):
        print(f"\nGenerando ImportadorDireccion...")
        datos = []
        
        tipos_direccion = ['Fiscal', 'Comercial', 'Almacen', 'Oficina']
        
        for id_importador in self.ids['importador']:
            num_direcciones = random.randint(1, 3)
            
            for idx in range(num_direcciones):
                id_direccion = str(uuid.uuid4())
                direccion = fake.address().replace('\n', ', ')
                tipo = random.choice(tipos_direccion)
                principal = (idx == 0)  # La primera es principal
                
                datos.append([
                    id_direccion, id_importador, direccion, tipo, principal
                ])
        
        return self.guardar_csv(
            '109_importador_direccion.csv',
            datos,
            ['id_direccion', 'id_importador', 'direccion', 'tipo', 'principal']
        )
    
    def generar_entregas(self, cantidad=100):
        print(f"\nGenerando {cantidad} Entregas...")
        datos = []
        self.ids['entrega'] = []
        codigos_usados = set()
        
        lugares_entrega = [
            'Almacen Central Lima', 'Terminal Portuario Callao',
            'Centro de Distribucion Norte', 'Centro de Distribucion Sur',
            'Almacen Zona Industrial', 'Terminal Terrestre',
            'Deposito Aduanero', 'Zona Franca'
        ]
        
        for i in range(cantidad):
            id_entrega = str(uuid.uuid4())
            
            while True:
                codigo = f"ENT-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_estado = random.choice(self.ids['estado_entrega'])
            fecha_entrega = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
            lugar_entrega = random.choice(lugares_entrega)
            id_contenedor = random.choice(self.ids['contenedor'])
            id_importador = random.choice(self.ids['importador'])
            
            self.ids['entrega'].append(id_entrega)
            datos.append([
                id_entrega, codigo, id_estado,
                fecha_entrega.strftime('%Y-%m-%d'),
                lugar_entrega, id_contenedor, id_importador
            ])
        
        return self.guardar_csv(
            '110_entrega.csv',
            datos,
            ['id_entrega', 'codigo', 'id_estado_entrega', 'fecha_entrega',
             'lugar_entrega', 'id_contenedor', 'id_importador']
        )
    
    def generar_incidencia_reporte(self):
        print(f"\nGenerando IncidenciaReporte...")
        datos = []
        registros_unicos = set()
        
        for id_incidencia in self.ids['incidencia']:
            # Algunas incidencias tienen múltiples reportes
            num_reportes = random.randint(1, 2)
            reportes = random.sample(
                self.ids['reporte'], 
                min(num_reportes, len(self.ids['reporte']))
            )
            
            for id_reporte in reportes:
                clave = (id_incidencia, id_reporte)
                if clave not in registros_unicos:
                    id_inc_reporte = str(uuid.uuid4())
                    
                    datos.append([
                        id_inc_reporte, id_incidencia, id_reporte
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '111_incidencia_reporte.csv',
            datos,
            ['id_incidencia_reporte', 'id_incidencia', 'id_reporte']
        )
    
    def generar_posicion_contenedor(self, cantidad=200):
        print(f"\nGenerando {cantidad} Posiciones de Contenedor...")
        datos = []
        
        for i in range(cantidad):
            id_posicion = str(uuid.uuid4())
            id_contenedor = random.choice(self.ids['contenedor'])
            latitud = round(random.uniform(-90, 90), 6)
            longitud = round(random.uniform(-180, 180), 6)
            fecha_hora = fecha_hora_entre(BASE_NOW, dias_desde=-30, dias_hasta=0)
            
            datos.append([
                id_posicion, id_contenedor, latitud, longitud,
                fecha_hora.strftime('%Y-%m-%d %H:%M:%S')
            ])
        
        return self.guardar_csv(
            '112_posicion_contenedor.csv',
            datos,
            ['id_posicion', 'id_contenedor', 'latitud', 'longitud', 'fecha_hora']
        )
    
    def generar_posicion_vehiculo(self, cantidad=150):
        print(f"\nGenerando {cantidad} Posiciones de Vehiculo...")
        datos = []
        
        for i in range(cantidad):
            id_posicion = str(uuid.uuid4())
            id_vehiculo = random.choice(self.ids['vehiculo'])
            latitud = round(random.uniform(-90, 90), 6)
            longitud = round(random.uniform(-180, 180), 6)
            fecha_hora = fecha_hora_entre(BASE_NOW, dias_desde=-30, dias_hasta=0)
            
            datos.append([
                id_posicion, id_vehiculo, latitud, longitud,
                fecha_hora.strftime('%Y-%m-%d %H:%M:%S')
            ])
        
        return self.guardar_csv(
            '113_posicion_vehiculo.csv',
            datos,
            ['id_posicion', 'id_vehiculo', 'latitud', 'longitud', 'fecha_hora']
        )
    
    def generar_posicion_buque(self, cantidad=120):
        print(f"\nGenerando {cantidad} Posiciones de Buque...")
        datos = []
        
        for i in range(cantidad):
            id_posicion = str(uuid.uuid4())
            id_buque = random.choice(self.ids['buque'])
            latitud = round(random.uniform(-90, 90), 6)
            longitud = round(random.uniform(-180, 180), 6)
            fecha_hora = fecha_hora_entre(BASE_NOW, dias_desde=-30, dias_hasta=0)
            
            datos.append([
                id_posicion, id_buque, latitud, longitud,
                fecha_hora.strftime('%Y-%m-%d %H:%M:%S')
            ])
        
        return self.guardar_csv(
            '114_posicion_buque.csv',
            datos,
            ['id_posicion', 'id_buque', 'latitud', 'longitud', 'fecha_hora']
        )
    
    def generar_operacion_monitoreo_vehiculo(self):
        print(f"\nGenerando OperacionMonitoreoVehiculo...")
        datos = []
        registros_unicos = set()
        
        for id_op_monitoreo in self.ids['operacion_monitoreo']:
            num_vehiculos = random.randint(1, 3)
            vehiculos = random.sample(
                self.ids['vehiculo'], 
                min(num_vehiculos, len(self.ids['vehiculo']))
            )
            
            for id_vehiculo in vehiculos:
                fecha_operacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                clave = (id_op_monitoreo, id_vehiculo, fecha_operacion.strftime('%Y-%m-%d'))
                
                if clave not in registros_unicos:
                    id_om_vehiculo = str(uuid.uuid4())
                    
                    datos.append([
                        id_om_vehiculo, id_op_monitoreo, id_vehiculo,
                        fecha_operacion.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '115_operacion_monitoreo_vehiculo.csv',
            datos,
            ['id_operacion_monitoreo_vehiculo', 'id_operacion_monitoreo',
             'id_vehiculo', 'fecha_operacion']
        )
    
    def generar_operacion_monitoreo_buque(self):
        print(f"\nGenerando OperacionMonitoreoBuque...")
        datos = []
        registros_unicos = set()
        
        for id_op_monitoreo in self.ids['operacion_monitoreo']:
            if random.random() < 0.6:  # 60% tienen buques
                num_buques = random.randint(1, 2)
                buques = random.sample(
                    self.ids['buque'], 
                    min(num_buques, len(self.ids['buque']))
                )
                
                for id_buque in buques:
                    fecha_operacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                    clave = (id_op_monitoreo, id_buque, fecha_operacion.strftime('%Y-%m-%d'))
                    
                    if clave not in registros_unicos:
                        id_om_buque = str(uuid.uuid4())
                        
                        datos.append([
                            id_om_buque, id_op_monitoreo, id_buque,
                            fecha_operacion.strftime('%Y-%m-%d')
                        ])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '116_operacion_monitoreo_buque.csv',
            datos,
            ['id_operacion_monitoreo_buque', 'id_operacion_monitoreo',
             'id_buque', 'fecha_operacion']
        )
    
    def generar_contenedor_vehiculo(self):
        print(f"\nGenerando ContenedorVehiculo...")
        datos = []
        registros_unicos = set()
        
        for id_contenedor in self.ids['contenedor']:
            if random.random() < 0.5:  # 50% de contenedores asignados a vehículos
                num_asignaciones = random.randint(1, 2)
                
                for _ in range(num_asignaciones):
                    id_vehiculo = random.choice(self.ids['vehiculo'])
                    fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                    clave = (id_contenedor, id_vehiculo, fecha_asignacion.strftime('%Y-%m-%d'))
                    
                    if clave not in registros_unicos:
                        id_cont_veh = str(uuid.uuid4())
                        fecha_transporte = fecha_asignacion + timedelta(days=random.randint(0, 5))
                        
                        datos.append([
                            id_cont_veh, id_contenedor, id_vehiculo,
                            fecha_asignacion.strftime('%Y-%m-%d'),
                            fecha_transporte.strftime('%Y-%m-%d')
                        ])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '117_contenedor_vehiculo.csv',
            datos,
            ['id_contenedor_vehiculo', 'id_contenedor', 'id_vehiculo',
             'fecha_asignacion', 'fecha_transporte']
        )
    
    def generar_contenedor_buque(self):
        print(f"\nGenerando ContenedorBuque...")
        datos = []
        registros_unicos = set()
        
        for id_contenedor in self.ids['contenedor']:
            if random.random() < 0.6:  # 60% de contenedores asignados a buques
                num_asignaciones = random.randint(1, 2)
                
                for _ in range(num_asignaciones):
                    id_buque = random.choice(self.ids['buque'])
                    fecha_asignacion = fecha_entre(BASE_NOW, dias_desde=-90, dias_hasta=0)
                    clave = (id_contenedor, id_buque, fecha_asignacion.strftime('%Y-%m-%d'))
                    
                    if clave not in registros_unicos:
                        id_cont_buq = str(uuid.uuid4())
                        fecha_transporte = fecha_asignacion + timedelta(days=random.randint(1, 15))
                        
                        datos.append([
                            id_cont_buq, id_contenedor, id_buque,
                            fecha_asignacion.strftime('%Y-%m-%d'),
                            fecha_transporte.strftime('%Y-%m-%d')
                        ])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '118_contenedor_buque.csv',
            datos,
            ['id_contenedor_buque', 'id_contenedor', 'id_buque',
             'fecha_asignacion', 'fecha_transporte']
        )
    
    def generar_operador_operacion_monitoreo(self):
        print(f"\nGenerando OperadorOperacionMonitoreo...")
        datos = []
        registros_unicos = set()
        
        for id_op_monitoreo in self.ids['operacion_monitoreo']:
            num_operadores = random.randint(1, 2)
            operadores = random.sample(
                self.ids['operador'], 
                min(num_operadores, len(self.ids['operador']))
            )
            
            for id_operador in operadores:
                fecha_realizacion = fecha_entre(BASE_NOW, dias_desde=-60, dias_hasta=0)
                clave = (id_operador, id_op_monitoreo, fecha_realizacion.strftime('%Y-%m-%d'))
                
                if clave not in registros_unicos:
                    id_op_om = str(uuid.uuid4())
                    
                    datos.append([
                        id_op_om, id_operador, id_op_monitoreo,
                        fecha_realizacion.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '119_operador_operacion_monitoreo.csv',
            datos,
            ['id_operador_operacion_monitoreo', 'id_operador',
             'id_operacion_monitoreo', 'fecha_realizacion']
        )
    
    def generar_documentacion(self, cantidad=100):
        print(f"\nGenerando {cantidad} Documentacion...")
        datos = []
        self.ids['documentacion'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_documentacion = str(uuid.uuid4())
            
            while True:
                codigo = f"DOCM-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = f"Documento_Monitoreo_{random.randint(1000, 9999)}.pdf"
            fecha_emision = fecha_entre(BASE_NOW, dias_desde=-365, dias_hasta=0)
            id_tipo = random.choice(self.ids['tipo_documento'])
            
            self.ids['documentacion'].append(id_documentacion)
            datos.append([
                id_documentacion, codigo, nombre,
                fecha_emision.strftime('%Y-%m-%d'), id_tipo
            ])
        
        return self.guardar_csv(
            '120_documentacion.csv',
            datos,
            ['id_documentacion', 'codigo', 'nombre', 'fecha_emision', 'id_tipo_documento']
        )
    
    def generar_documentacion_contenedor(self):
        print(f"\nGenerando DocumentacionContenedor...")
        datos = []
        
        # Seleccionar documentaciones y contenedores únicos
        docs_usadas = set()
        conts_usados = set()
        
        num_documentaciones = min(len(self.ids['documentacion']), len(self.ids['contenedor']))
        
        for i in range(num_documentaciones):
            # Seleccionar documentación y contenedor únicos
            id_documentacion = random.choice([d for d in self.ids['documentacion'] if d not in docs_usadas])
            id_contenedor = random.choice([c for c in self.ids['contenedor'] if c not in conts_usados])
            
            id_doc_cont = str(uuid.uuid4())
            
            datos.append([
                id_doc_cont, id_documentacion, id_contenedor
            ])
            
            docs_usadas.add(id_documentacion)
            conts_usados.add(id_contenedor)
            
            # Si ya no hay más documentaciones o contenedores únicos, salir
            if len(docs_usadas) >= len(self.ids['documentacion']) or len(conts_usados) >= len(self.ids['contenedor']):
                break
        
        return self.guardar_csv(
            '121_documentacion_contenedor.csv',
            datos,
            ['id_documentacion_contenedor', 'id_documentacion', 'id_contenedor']
        )

    def generar_todo(self):
        print("\n" + "="*70)
        print("GENERANDO ARCHIVOS CSV - SISTEMA CONSOLIDADO")
        print("="*70)
        
        # ============================================
        # LOOKUP TABLES SHARED (01-37)
        # ============================================
        print("\n>>> GENERANDO LOOKUP TABLES SHARED...")
        self.generar_especialidad_empleado()
        self.generar_estado_contrato()
        self.generar_estado_operacion()
        self.generar_tipo_telefono()
        self.generar_estado_embarcacion()
        self.generar_rol_usuario()
        self.generar_estado_contenedor()
        self.generar_tipo_contenedor()
        self.generar_tipo_incidencia()
        self.generar_tipo_activo()
        self.generar_estado_activo()
        self.generar_estatus_navegacion()
        self.generar_prioridad()
        self.generar_tipo_vehiculo()
        self.generar_estado_vehiculo()
        self.generar_estado_incidencia()
        self.generar_tipo_documento()
        self.generar_estado_reserva()
        self.generar_tipo_equipo_portuario()
        self.generar_estado_equipo_portuario()
        self.generar_estado_inspeccion()
        self.generar_tipo_inspeccion()
        self.generar_tipo_hallazgo()
        self.generar_tipo_operacion_portuaria()
        self.generar_turno()
        self.generar_equipo_proteccion()
        self.generar_condicion_operativa()
        self.generar_tipo_reporte()
        self.generar_estado_plan()
        self.generar_tipo_mantenimiento()
        self.generar_estado_solicitud()
        self.generar_estado_orden()
        self.generar_estado_tarea()
        self.generar_estado_entrega()
        self.generar_tipo_sensor()
        self.generar_rol_sensor()
        self.generar_tipo_notificacion()
        self.generar_estado_lectura()
        
        # ============================================
        # TABLAS PRINCIPALES SHARED (38-56)
        # ============================================
        print("\n>>> GENERANDO TABLAS PRINCIPALES SHARED...")
        self.generar_contratos(150)
        self.generar_empleados(120)
        self.generar_empleado_telefonos()
        self.generar_usuarios()
        self.generar_operaciones(100)
        self.generar_buques(30)
        self.generar_contenedores(200)
        self.generar_contenedor_mercancia()
        self.generar_certificaciones()
        self.generar_certificacion_buque()
        self.generar_certificacion_empleado()
        self.generar_operaciones_maritimas()
        self.generar_tripulantes()
        self.generar_usuario_operacion()
        self.generar_rutas(50)
        self.generar_operaciones_terrestres()
        self.generar_activos(80)
        self.generar_vehiculos()
        self.generar_incidencias(60)
        
        # ============================================
        # SCHEMA: gestion_reserva (57-64)
        # ============================================
        print("\n>>> GENERANDO SCHEMA: gestion_reserva...")
        self.generar_agentes_reservas()
        self.generar_clientes(50)
        self.generar_cliente_telefonos()
        self.generar_atencion_cliente()
        self.generar_reservas(80)
        self.generar_reserva_contenedor()
        self.generar_reserva_operacion_maritima()
        self.generar_reserva_operacion_terrestre()
        
        # ============================================
        # SCHEMA: personal_tripulacion (65)
        # ============================================
        print("\n>>> GENERANDO SCHEMA: personal_tripulacion...")
        self.generar_buque_tripulante()
        
        # ============================================
        # SCHEMA: gestion_maritima (66-85)
        # ============================================
        print("\n>>> GENERANDO SCHEMA: gestion_maritima...")
        self.generar_puertos(20)
        self.generar_muelles()
        self.generar_equipos_portuarios(50)
        self.generar_trabajadores_portuarios()
        self.generar_operaciones_portuarias()
        self.generar_inspecciones(60)
        self.generar_hallazgos()
        self.generar_tripulante_idioma()
        self.generar_operacion_maritima_condicion()
        self.generar_operacion_empleado()
        self.generar_trabajador_portuario_equipo_portuario()
        self.generar_operacion_contenedor()
        self.generar_operacion_equipo_portuario()
        self.generar_certificacion_aduanera(15)
        self.generar_ruta_maritima()
        self.generar_operacion_ruta_maritima()
        self.generar_estiba()
        self.generar_trabajador_portuario_equipo_proteccion()
        self.generar_ruta_puerto_intermedio()
        self.generar_operacion_certificacion_aduanera()
        
        # ============================================
        # SCHEMA: operaciones_terrestres (86-92)
        # ============================================
        print("\n>>> GENERANDO SCHEMA: operaciones_terrestres...")
        self.generar_rutas_terrestres()
        self.generar_conductores()
        self.generar_operacion_terrestre_detalle()
        self.generar_checklist_despacho()
        self.generar_documentacion_operacion(80)
        self.generar_operacion_documento()
        self.generar_reporte_transporte()
        
        # ============================================
        # SCHEMA: mantenimiento_logistico (93-102)
        # ============================================
        print("\n>>> GENERANDO SCHEMA: mantenimiento_logistico...")
        self.generar_tecnicos()
        self.generar_responsables_solicitud()
        self.generar_repuestos(70)
        self.generar_planes_mantenimiento(45)
        self.generar_solicitudes_mantenimiento(50)
        self.generar_operaciones_mantenimiento()
        self.generar_ordenes_mantenimiento()
        self.generar_tareas_mantenimiento()
        self.generar_operacion_mantenimiento_tecnico()
        self.generar_operacion_mantenimiento_repuesto()
        
        # ============================================
        # SCHEMA: monitoreo (103-121)
        # ============================================
        print("\n>>> GENERANDO SCHEMA: monitoreo...")
        self.generar_operadores()
        self.generar_operaciones_monitoreo()
        self.generar_sensores()
        self.generar_lecturas_sensor()
        self.generar_reportes(80)
        self.generar_notificaciones()
        self.generar_importadores(40)
        self.generar_importador_direccion()
        self.generar_entregas(100)
        self.generar_incidencia_reporte()
        self.generar_posicion_contenedor(200)
        self.generar_posicion_vehiculo(150)
        self.generar_posicion_buque(120)
        self.generar_operacion_monitoreo_vehiculo()
        self.generar_operacion_monitoreo_buque()
        self.generar_contenedor_vehiculo()
        self.generar_contenedor_buque()
        self.generar_operador_operacion_monitoreo()
        self.generar_documentacion(100)
        self.generar_documentacion_contenedor()
        
        print("\n" + "="*70)
        print("GENERACION COMPLETADA")
        print(f"Archivos guardados en: {OUTPUT_DIR}/")
        print(f"Total de archivos generados: 123")
        print("="*70)


if __name__ == "__main__":
    print("""
    ====================================================================
       GENERADOR DE CSV - SISTEMA MARITIMO CONSOLIDADO
       Datos falsos con Faker para PostgreSQL
       Sistema integrado con 6 modulos
    ====================================================================
    """)
    
    generador = GeneradorCSVConsolidado()
    generador.generar_todo()
    
    print("\nPROXIMO PASO:")
    print("   1. Ejecuta el script SQL consolidado.sql")
    print("   2. Importa los archivos CSV en el orden numerico (01-121)")
    print("   3. Verifica los registros con las consultas de verificacion")