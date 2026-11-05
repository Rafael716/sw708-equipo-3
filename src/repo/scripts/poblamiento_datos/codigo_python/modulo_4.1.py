import csv
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

fake = Faker('es_ES')
OUTPUT_DIR = 'datos_csv_modulo_4.1'

if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)
    print(f"Directorio '{OUTPUT_DIR}' creado")


class GeneradorCSVMantenimiento:
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
    
    def generar_estado_operacion(self):
        print("\nGenerando EstadoOperacion...")
        estados = ['Pendiente', 'En Progreso', 'Completada', 'Cancelada']
        datos = []
        self.ids['estado_operacion'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_operacion'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '01_estado_operacion.csv',
            datos,
            ['id_estado_operacion', 'nombre']
        )
    
    def generar_estado_plan(self):
        print("\nGenerando EstadoPlan...")
        estados = ['Activo', 'Inactivo', 'En Revision', 'Suspendido']
        datos = []
        self.ids['estado_plan'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_plan'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '02_estado_plan.csv',
            datos,
            ['id_estado_plan', 'nombre']
        )
    
    def generar_estado_solicitud(self):
        print("\nGenerando EstadoSolicitud...")
        estados = ['Solicitada', 'Aprobada', 'Rechazada', 'En Proceso', 'Cerrada']
        datos = []
        self.ids['estado_solicitud'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_solicitud'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '03_estado_solicitud.csv',
            datos,
            ['id_estado_solicitud', 'nombre']
        )
    
    def generar_estado_orden(self):
        print("\nGenerando EstadoOrden...")
        estados = ['Generada', 'Programada', 'En Ejecucion', 'Completada', 'Cancelada']
        datos = []
        self.ids['estado_orden'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_orden'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '04_estado_orden.csv',
            datos,
            ['id_estado_orden', 'nombre']
        )
    
    def generar_estado_tarea(self):
        print("\nGenerando EstadoTarea...")
        estados = ['Pendiente', 'En Progreso', 'Completada', 'Cancelada']
        datos = []
        self.ids['estado_tarea'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_tarea'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '05_estado_tarea.csv',
            datos,
            ['id_estado_tarea', 'nombre']
        )
    
    def generar_tipo_activo(self):
        print("\nGenerando TipoActivo...")
        tipos = ['Vehiculo', 'Maquinaria Pesada', 'Equipo Electronico', 'Mobiliario', 'Herramienta']
        datos = []
        self.ids['tipo_activo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_activo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '06_tipo_activo.csv',
            datos,
            ['id_tipo_activo', 'nombre']
        )
    
    def generar_estado_activo(self):
        print("\nGenerando EstadoActivo...")
        estados = ['Operativo', 'En Mantenimiento', 'Fuera de Servicio', 'Dado de Baja']
        datos = []
        self.ids['estado_activo'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_activo'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '07_estado_activo.csv',
            datos,
            ['id_estado_activo', 'nombre']
        )
    
    def generar_tipo_mantenimiento(self):
        print("\nGenerando TipoMantenimiento...")
        tipos = ['Preventivo', 'Correctivo', 'Predictivo', 'Emergencia']
        datos = []
        self.ids['tipo_mantenimiento'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_mantenimiento'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '08_tipo_mantenimiento.csv',
            datos,
            ['id_tipo_mantenimiento', 'nombre']
        )
    
    def generar_prioridad(self):
        print("\nGenerando Prioridad...")
        prioridades = ['Baja', 'Media', 'Alta', 'Critica']
        datos = []
        self.ids['prioridad'] = []
        
        for prioridad in prioridades:
            id_prioridad = str(uuid.uuid4())
            self.ids['prioridad'].append(id_prioridad)
            datos.append([id_prioridad, prioridad])
        
        return self.guardar_csv(
            '09_prioridad.csv',
            datos,
            ['id_prioridad', 'nombre']
        )
    
    def generar_especialidad_empleado(self):
        print("\nGenerando EspecialidadEmpleado...")
        especialidades = [
            'Mecanica', 'Electricidad', 'Electronica', 
            'Hidraulica', 'Neumatica', 'Administracion', 'Supervision'
        ]
        datos = []
        self.ids['especialidad_empleado'] = []
        
        for esp in especialidades:
            id_esp = str(uuid.uuid4())
            self.ids['especialidad_empleado'].append(id_esp)
            datos.append([id_esp, esp])
        
        return self.guardar_csv(
            '10_especialidad_empleado.csv',
            datos,
            ['id_especialidad_empleado', 'nombre']
        )
    
    def generar_estado_contrato(self):
        print("\nGenerando EstadoContrato...")
        estados = ['Vigente', 'Vencido', 'Por Vencer', 'Rescindido']
        datos = []
        self.ids['estado_contrato'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_contrato'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '11_estado_contrato.csv',
            datos,
            ['id_estado_contrato', 'nombre']
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
            '12_tipo_telefono.csv',
            datos,
            ['id_tipo_telefono', 'nombre']
        )
    
    def generar_contratos(self, cantidad=60):
        print(f"\nGenerando {cantidad} Contratos...")
        datos = []
        self.ids['contrato'] = []
        
        for i in range(cantidad):
            id_contrato = str(uuid.uuid4())
            fecha_emision = fake.date_between(start_date='-3y', end_date='today')
            fecha_vencimiento = fecha_emision + timedelta(days=random.randint(365, 1095))
            
            if random.random() < 0.7:
                id_estado = self.ids['estado_contrato'][0]
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
            '13_contrato.csv',
            datos,
            ['id_contrato', 'fecha_emision', 'fecha_vencimiento', 'id_estado_contrato']
        )
    
    def generar_empleados(self, cantidad=50):
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
            '14_empleado.csv',
            datos,
            ['id_empleado', 'codigo', 'dni', 'nombre', 'apellido',
             'direccion', 'id_especialidad_empleado', 'id_contrato']
        )
    
    def generar_empleado_telefonos(self):
        print(f"\nGenerando Telefonos de Empleados...")
        datos = []
        
        for id_empleado in self.ids['empleado']:
            num_telefonos = random.randint(1, 3)
            
            for _ in range(num_telefonos):
                id_empleado_telefono = str(uuid.uuid4())
                telefono = fake.phone_number()
                id_tipo = random.choice(self.ids['tipo_telefono'])
                
                datos.append([
                    id_empleado_telefono, id_empleado, telefono, id_tipo
                ])
        
        return self.guardar_csv(
            '15_empleado_telefono.csv',
            datos,
            ['id_empleado_telefono', 'id_empleado', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_tecnicos(self):
        print(f"\nGenerando Tecnicos...")
        datos = []
        self.ids['tecnico'] = []
        
        especialidades_tecnicas = [
            'Mecanica', 'Electricidad', 'Electronica', 
            'Hidraulica', 'Neumatica'
        ]
        
        empleados_tecnicos = [
            emp_id for emp_id in self.ids['empleado']
            if random.random() < 0.4
        ][:30]
        
        for id_empleado in empleados_tecnicos:
            id_tecnico = str(uuid.uuid4())
            especialidad = random.choice(especialidades_tecnicas)
            
            self.ids['tecnico'].append(id_tecnico)
            datos.append([id_tecnico, id_empleado, especialidad])
        
        return self.guardar_csv(
            '16_tecnico.csv',
            datos,
            ['id_tecnico', 'id_empleado', 'especialidad']
        )
    
    def generar_responsables_solicitud(self):
        print(f"\nGenerando Responsables de Solicitud...")
        datos = []
        self.ids['responsable_solicitud'] = []
        
        empleados_responsables = [
            emp_id for emp_id in self.ids['empleado']
            if emp_id not in [self.ids['empleado'][i] for i, _ in enumerate(self.ids['tecnico'])]
        ][:20]
        
        for id_empleado in empleados_responsables:
            id_responsable = str(uuid.uuid4())
            
            self.ids['responsable_solicitud'].append(id_responsable)
            datos.append([id_responsable, id_empleado])
        
        return self.guardar_csv(
            '17_responsable_solicitud.csv',
            datos,
            ['id_responsable_solicitud', 'id_empleado']
        )
    
    def generar_activos(self, cantidad=40):
        print(f"\nGenerando {cantidad} Activos...")
        datos = []
        self.ids['activo'] = []
        codigos_usados = set()
        
        ubicaciones = [
            'Almacen Central', 'Planta Norte', 'Planta Sur',
            'Deposito A', 'Deposito B', 'Oficinas Principales'
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
            '18_activo.csv',
            datos,
            ['id_activo', 'codigo', 'nombre', 'id_tipo_activo', 
             'id_estado_activo', 'ubicacion']
        )
    
    def generar_repuestos(self, cantidad=50):
        print(f"\nGenerando {cantidad} Repuestos...")
        datos = []
        self.ids['repuesto'] = []
        codigos_usados = set()
        
        nombres_repuestos = [
            'Filtro de Aceite', 'Bujia', 'Correa de Distribucion', 'Pastillas de Freno',
            'Rodamiento', 'Junta', 'Sensor', 'Rele', 'Fusible', 'Cable',
            'Manguera', 'Valvula', 'Tornillo', 'Tuerca', 'Resorte'
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
            
            self.ids['repuesto'].append(id_repuesto)
            datos.append([
                id_repuesto, codigo, nombre, stock, stock_minimo
            ])
        
        return self.guardar_csv(
            '19_repuesto.csv',
            datos,
            ['id_repuesto', 'codigo', 'nombre', 'stock', 'stock_minimo']
        )
    
    def generar_planes_mantenimiento(self, cantidad=35):
        print(f"\nGenerando {cantidad} Planes de Mantenimiento...")
        datos = []
        self.ids['plan_mantenimiento'] = []
        codigos_usados = set()
        
        frecuencias = ['Diaria', 'Semanal', 'Quincenal', 'Mensual', 
                      'Trimestral', 'Semestral', 'Anual']
        
        for i in range(cantidad):
            id_plan = str(uuid.uuid4())
            
            while True:
                codigo = f"PLN-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_estado = random.choice(self.ids['estado_plan'])
            frecuencia = random.choice(frecuencias)
            fecha_inicio = fake.date_between(start_date='-1y', end_date='today')
            id_activo = random.choice(self.ids['activo'])
            
            self.ids['plan_mantenimiento'].append(id_plan)
            datos.append([
                id_plan, codigo, id_estado, frecuencia, 
                fecha_inicio.strftime('%Y-%m-%d'), id_activo
            ])
        
        return self.guardar_csv(
            '20_plan_mantenimiento.csv',
            datos,
            ['id_plan_mantenimiento', 'codigo', 'id_estado_plan', 
             'frecuencia', 'fecha_inicio', 'id_activo']
        )
    
    def generar_solicitudes_mantenimiento(self, cantidad=45):
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
            'Vibraciones excesivas',
            'Fuga de fluidos',
            'Componente electronico defectuoso'
        ]
        
        for i in range(cantidad):
            id_solicitud = str(uuid.uuid4())
            
            while True:
                codigo = f"SOL-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            descripcion = random.choice(problemas) + ". " + fake.sentence(nb_words=10)
            fecha_solicitud = fake.date_between(start_date='-6m', end_date='today')
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
            '21_solicitud_mantenimiento.csv',
            datos,
            ['id_solicitud_mantenimiento', 'codigo', 'descripcion_problema',
             'fecha_solicitud', 'id_prioridad', 'id_estado_solicitud',
             'id_responsable_solicitud', 'id_activo']
        )
    
    def generar_operaciones(self, cantidad=60):
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
            
            fecha_inicio = fake.date_time_between(start_date='-4m', end_date='now')
            
            if random.random() < 0.6:
                fecha_fin = fecha_inicio + timedelta(hours=random.randint(1, 72))
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
            '22_operacion.csv',
            datos,
            ['id_operacion', 'codigo', 'fecha_inicio', 'fecha_fin', 'id_estado_operacion']
        )
    
    def generar_operaciones_mantenimiento(self):
        print(f"\nGenerando Operaciones de Mantenimiento...")
        datos = []
        self.ids['operacion_mantenimiento'] = []
        
        for id_operacion in self.ids['operacion']:
            id_op_mantenimiento = str(uuid.uuid4())
            
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
            '23_operacion_mantenimiento.csv',
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
            
            fecha_generada = fake.date_between(start_date='-4m', end_date='today')
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
            '24_orden_mantenimiento.csv',
            datos,
            ['id_orden', 'codigo', 'fecha_generada', 'fecha_programada',
             'fecha_cierre', 'id_tipo_mantenimiento', 'id_estado_orden',
             'id_operacion_mantenimiento']
        )
    
    def generar_tareas_mantenimiento(self):
        print(f"\nGenerando Tareas de Mantenimiento...")
        datos = []
        
        descripciones_tareas = [
            'Inspeccion visual de componentes criticos',
            'Limpieza y lubricacion de mecanismos',
            'Revision de conexiones electricas',
            'Cambio de filtros y fluidos',
            'Ajuste de parametros operativos',
            'Prueba de funcionamiento',
            'Calibracion de instrumentos',
            'Reemplazo de componentes desgastados'
        ]
        
        for id_orden in self.ids['orden_mantenimiento']:
            num_tareas = random.randint(2, 6)
            
            for _ in range(num_tareas):
                id_tarea = str(uuid.uuid4())
                descripcion = random.choice(descripciones_tareas) + ". " + fake.sentence(nb_words=8)
                id_estado = random.choice(self.ids['estado_tarea'])
                
                datos.append([
                    id_tarea, descripcion, id_estado, id_orden
                ])
        
        return self.guardar_csv(
            '25_tarea_mantenimiento.csv',
            datos,
            ['id_tarea', 'descripcion', 'id_estado_tarea', 'id_orden']
        )
    
    def generar_operacion_mantenimiento_tecnico(self):
        print(f"\nGenerando Asignacion Operaciones-Tecnicos...")
        datos = []
        
        for id_op_mant in self.ids['operacion_mantenimiento']:
            num_tecnicos = random.randint(1, 3)
            tecnicos = random.sample(self.ids['tecnico'], 
                                    min(num_tecnicos, len(self.ids['tecnico'])))
            
            for id_tecnico in tecnicos:
                fecha_asignacion = fake.date_between(start_date='-3m', end_date='today')
                
                datos.append([
                    id_op_mant, id_tecnico, fecha_asignacion.strftime('%Y-%m-%d')
                ])
        
        return self.guardar_csv(
            '26_operacion_mantenimiento_tecnico.csv',
            datos,
            ['id_operacion_mantenimiento', 'id_tecnico', 'fecha_asignacion']
        )
    
    def generar_operacion_mantenimiento_repuesto(self):
        print(f"\nGenerando Uso de Repuestos...")
        datos = []
        
        for id_op_mant in self.ids['operacion_mantenimiento']:
            if random.random() < 0.7:
                num_repuestos = random.randint(1, 5)
                repuestos = random.sample(self.ids['repuesto'], 
                                         min(num_repuestos, len(self.ids['repuesto'])))
                
                for id_repuesto in repuestos:
                    fecha_uso = fake.date_between(start_date='-3m', end_date='today')
                    cantidad = random.randint(1, 10)
                    precio_unitario = round(random.uniform(10.0, 500.0), 2)
                    
                    datos.append([
                        id_op_mant, id_repuesto, 
                        fecha_uso.strftime('%Y-%m-%d'),
                        cantidad, precio_unitario
                    ])
        
        return self.guardar_csv(
            '27_operacion_mantenimiento_repuesto.csv',
            datos,
            ['id_operacion_mantenimiento', 'id_repuesto', 'fecha_uso',
             'cantidad', 'precio_unitario']
        )
    
    def generar_todo(self):
        print("\n" + "="*70)
        print("GENERANDO ARCHIVOS CSV - MANTENIMIENTO LOGISTICO")
        print("="*70)
        
        self.generar_estado_operacion()
        self.generar_estado_plan()
        self.generar_estado_solicitud()
        self.generar_estado_orden()
        self.generar_estado_tarea()
        self.generar_tipo_activo()
        self.generar_estado_activo()
        self.generar_tipo_mantenimiento()
        self.generar_prioridad()
        self.generar_especialidad_empleado()
        self.generar_estado_contrato()
        self.generar_tipo_telefono()
        
        self.generar_contratos(60)
        self.generar_empleados(50)
        self.generar_empleado_telefonos()
        self.generar_tecnicos()
        self.generar_responsables_solicitud()
        self.generar_activos(40)
        self.generar_repuestos(50)
        self.generar_planes_mantenimiento(35)
        self.generar_solicitudes_mantenimiento(45)
        self.generar_operaciones(60)
        self.generar_operaciones_mantenimiento()
        self.generar_ordenes_mantenimiento()
        self.generar_tareas_mantenimiento()
        self.generar_operacion_mantenimiento_tecnico()
        self.generar_operacion_mantenimiento_repuesto()
        
        print("\n" + "="*70)
        print("GENERACION COMPLETADA")
        print(f"Archivos guardados en: {OUTPUT_DIR}/")
        print("="*70)


if __name__ == "__main__":
    print("""
    ╔════════════════════════════════════════════════════════════╗
    ║   GENERADOR DE CSV - MANTENIMIENTO LOGISTICO               ║
    ║   Datos falsos con Faker para PostgreSQL                   ║
    ╚════════════════════════════════════════════════════════════╝
    """)
    
    generador = GeneradorCSVMantenimiento()
    generador.generar_todo()
    
    print("\nPROXIMO PASO:")
    print("   Importa los archivos CSV en pgAdmin en el orden numerico")