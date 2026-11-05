import csv
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

# Configuración
fake = Faker('es_ES')
OUTPUT_DIR = 'datos_csv_modulo_5'

# Crear directorio de salida
if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)
    print(f"Directorio '{OUTPUT_DIR}' creado")


class GeneradorCSV:
    def __init__(self):
        self.ids = {}  # Almacenar IDs generados
        
    def guardar_csv(self, nombre_archivo, datos, encabezados):
        filepath = os.path.join(OUTPUT_DIR, nombre_archivo)
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(encabezados)
            writer.writerows(datos)
        print(f" {nombre_archivo} - {len(datos)} registros")
        return filepath
    
    # ============================================
    # TABLAS DE DOMINIO
    # ============================================
    
    def generar_estado_operacion(self):
        print("\nGenerando EstadoOperacion...")
        estados = ['Programada', 'En Curso', 'Completada', 'Cancelada', 'Suspendida']
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
    
    def generar_especialidad_empleado(self):
        print("\nGenerando EspecialidadEmpleado...")
        especialidades = [
            'Operador de Monitoreo',
            'Conductor',
            'Mecánico',
            'Técnico de Sensores',
            'Supervisor',
            'Ingeniero de Logística'
        ]
        datos = []
        self.ids['especialidad_empleado'] = []
        
        for esp in especialidades:
            id_esp = str(uuid.uuid4())
            self.ids['especialidad_empleado'].append(id_esp)
            datos.append([id_esp, esp])
        
        return self.guardar_csv(
            '02_especialidad_empleado.csv',
            datos,
            ['id_especialidad_empleado', 'nombre']
        )
    
    def generar_estado_contenedor(self):
        print("\nGenerando EstadoContenedor...")
        estados = ['Disponible', 'En Tránsito', 'En Almacén', 'En Mantenimiento', 'Dañado']
        datos = []
        self.ids['estado_contenedor'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_contenedor'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '03_estado_contenedor.csv',
            datos,
            ['id_estado_contenedor', 'nombre']
        )
    
    def generar_tipo_contenedor(self):
        print("\nGenerando TipoContenedor...")
        tipos = [
            ('DRY-20', 'Contenedor Seco 20 pies', 2500.00),
            ('DRY-40', 'Contenedor Seco 40 pies', 3500.00),
            ('REF-20', 'Contenedor Refrigerado 20 pies', 4500.00),
            ('REF-40', 'Contenedor Refrigerado 40 pies', 6500.00),
            ('OT-20', 'Contenedor Open Top 20 pies', 3000.00),
            ('TANK-20', 'Contenedor Tanque 20 pies', 5500.00)
        ]
        datos = []
        self.ids['tipo_contenedor'] = []
        
        for codigo, nombre, costo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_contenedor'].append(id_tipo)
            datos.append([id_tipo, codigo, nombre, costo])
        
        return self.guardar_csv(
            '04_tipo_contenedor.csv',
            datos,
            ['id_tipo_contenedor', 'codigo', 'nombre', 'costo']
        )
    
    def generar_tipo_documento(self):
        print("\nGenerando TipoDocumento...")
        tipos = ['DNI', 'Pasaporte', 'Carnet de Extranjería', 'RUC']
        datos = []
        self.ids['tipo_documento'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_documento'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '05_tipo_documento.csv',
            datos,
            ['id_tipo_documento', 'nombre']
        )
    
    def generar_estado_entrega(self):
        print("\nGenerando EstadoEntrega...")
        estados = ['Pendiente', 'En Proceso', 'Completada', 'Cancelada', 'Rechazada']
        datos = []
        self.ids['estado_entrega'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_entrega'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '06_estado_entrega.csv',
            datos,
            ['id_estado_entrega', 'nombre']
        )
    
    def generar_tipo_sensor(self):
        print("\nGenerando TipoSensor...")
        tipos = ['GPS', 'Temperatura', 'Humedad', 'Presión', 'Acelerómetro', 'Cámara']
        datos = []
        self.ids['tipo_sensor'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_sensor'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '07_tipo_sensor.csv',
            datos,
            ['id_tipo_sensor', 'nombre']
        )
    
    def generar_rol_sensor(self):
        print("\nGenerando RolSensor...")
        roles = ['Principal', 'Secundario', 'Respaldo']
        datos = []
        self.ids['rol_sensor'] = []
        
        for rol in roles:
            id_rol = str(uuid.uuid4())
            self.ids['rol_sensor'].append(id_rol)
            datos.append([id_rol, rol])
        
        return self.guardar_csv(
            '08_rol_sensor.csv',
            datos,
            ['id_rol_sensor', 'nombre']
        )
    
    def generar_tipo_notificacion(self):
        print("\nGenerando TipoNotificacion...")
        tipos = ['Alerta', 'Advertencia', 'Información', 'Crítica', 'Emergencia']
        datos = []
        self.ids['tipo_notificacion'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_notificacion'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '09_tipo_notificacion.csv',
            datos,
            ['id_tipo_notificacion', 'nombre']
        )
    
    def generar_tipo_incidencia(self):
        print("\nGenerando TipoIncidencia...")
        tipos = ['Retraso', 'Daño Físico', 'Fallo de Sensor', 'Temperatura Anormal', 'Robo', 'Accidente']
        datos = []
        self.ids['tipo_incidencia'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_incidencia'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '10_tipo_incidencia.csv',
            datos,
            ['id_tipo_incidencia', 'nombre']
        )
    
    def generar_estado_embarcacion(self):
        print("\nGenerando EstadoEmbarcacion...")
        estados = ['Operativo', 'En Mantenimiento', 'En Puerto', 'En Tránsito', 'Fuera de Servicio']
        datos = []
        self.ids['estado_embarcacion'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_embarcacion'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '11_estado_embarcacion.csv',
            datos,
            ['id_estado_embarcacion', 'nombre']
        )
    
    def generar_tipo_vehiculo(self):
        print("\nGenerando TipoVehiculo...")
        tipos = ['Camión', 'Tráiler', 'Furgoneta', 'Camión Refrigerado']
        datos = []
        self.ids['tipo_vehiculo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_vehiculo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '12_tipo_vehiculo.csv',
            datos,
            ['id_tipo_vehiculo', 'nombre']
        )
    
    def generar_estado_vehiculo(self):
        print("\nGenerando EstadoVehiculo...")
        estados = ['Operativo', 'En Mantenimiento', 'En Reparación', 'Disponible', 'Fuera de Servicio']
        datos = []
        self.ids['estado_vehiculo'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_vehiculo'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '13_estado_vehiculo.csv',
            datos,
            ['id_estado_vehiculo', 'nombre']
        )
    
    def generar_estado_incidencia(self):
        print("\nGenerando EstadoIncidencia...")
        estados = ['Reportada', 'En Investigación', 'Resuelta', 'Cerrada', 'Escalada']
        datos = []
        self.ids['estado_incidencia'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_incidencia'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '14_estado_incidencia.csv',
            datos,
            ['id_estado_incidencia', 'nombre']
        )
    
    def generar_rol_usuario(self):
        print("\nGenerando RolUsuario...")
        roles = ['Administrador', 'Operador', 'Supervisor', 'Analista', 'Cliente']
        datos = []
        self.ids['rol_usuario'] = []
        
        for rol in roles:
            id_rol = str(uuid.uuid4())
            self.ids['rol_usuario'].append(id_rol)
            datos.append([id_rol, rol])
        
        return self.guardar_csv(
            '15_rol_usuario.csv',
            datos,
            ['id_rol_usuario', 'nombre']
        )
    
    def generar_tipo_activo(self):
        print("\nGenerando TipoActivo...")
        tipos = ['Vehículo', 'Contenedor', 'Sensor', 'Equipo GPS']
        datos = []
        self.ids['tipo_activo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_activo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '16_tipo_activo.csv',
            datos,
            ['id_tipo_activo', 'nombre']
        )
    
    def generar_estado_activo(self):
        print("\nGenerando EstadoActivo...")
        estados = ['Activo', 'Inactivo', 'En Mantenimiento', 'Dado de Baja']
        datos = []
        self.ids['estado_activo'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_activo'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '17_estado_activo.csv',
            datos,
            ['id_estado_activo', 'nombre']
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
            '18_estado_contrato.csv',
            datos,
            ['id_estado_contrato', 'nombre']
        )
    
    def generar_tipo_telefono(self):
        print("\nGenerando TipoTelefono...")
        tipos = ['Móvil', 'Fijo', 'Trabajo', 'Emergencia']
        datos = []
        self.ids['tipo_telefono'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_telefono'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '19_tipo_telefono.csv',
            datos,
            ['id_tipo_telefono', 'nombre']
        )
    
    # ============================================
    # TABLAS PRINCIPALES
    # ============================================
    
    def generar_contratos(self, cantidad=50):
        print(f"\nGenerando {cantidad} Contratos...")
        datos = []
        self.ids['contrato'] = []
        
        for i in range(cantidad):
            id_contrato = str(uuid.uuid4())
            fecha_emision = fake.date_between(start_date='-2y', end_date='today')
            fecha_vencimiento = fake.date_between(start_date=fecha_emision, end_date='+2y')
            id_estado = random.choice(self.ids['estado_contrato'])
            
            self.ids['contrato'].append(id_contrato)
            datos.append([
                id_contrato,
                fecha_emision.strftime('%Y-%m-%d'),
                fecha_vencimiento.strftime('%Y-%m-%d'),
                id_estado
            ])
        
        return self.guardar_csv(
            '20_contrato.csv',
            datos,
            ['id_contrato', 'fecha_emision', 'fecha_vencimiento', 'id_estado_contrato']
        )
    
    def generar_empleados(self, cantidad=100):
        print(f"\nGenerando {cantidad} Empleados...")
        datos = []
        self.ids['empleado'] = []
        dnis_usados = set()
        
        for i in range(cantidad):
            id_empleado = str(uuid.uuid4())
            codigo = f"EMP-{fake.unique.random_number(digits=6):06d}"
            
            # DNI único
            while True:
                dni = f"{random.randint(10000000, 99999999)}"
                if dni not in dnis_usados:
                    dnis_usados.add(dni)
                    break
            
            nombre = fake.first_name()
            apellido = fake.last_name()
            direccion = fake.address().replace('\n', ', ')
            id_especialidad = random.choice(self.ids['especialidad_empleado'])
            id_contrato = random.choice(self.ids['contrato'])
            
            self.ids['empleado'].append(id_empleado)
            datos.append([
                id_empleado, codigo, dni, nombre, apellido,
                direccion, id_especialidad, id_contrato
            ])
        
        return self.guardar_csv(
            '21_empleado.csv',
            datos,
            ['id_empleado', 'codigo', 'dni', 'nombre', 'apellido', 'direccion',
             'id_especialidad_empleado', 'id_contrato']
        )
    
    def generar_empleado_telefonos(self):
        print(f"\nGenerando Teléfonos de Empleados...")
        datos = []
        
        for id_empleado in self.ids['empleado']:
            num_telefonos = random.randint(1, 3)
            for _ in range(num_telefonos):
                id_tel = str(uuid.uuid4())
                telefono = fake.phone_number()
                id_tipo_tel = random.choice(self.ids['tipo_telefono'])
                
                datos.append([id_tel, id_empleado, telefono, id_tipo_tel])
        
        return self.guardar_csv(
            '22_empleado_telefono.csv',
            datos,
            ['id_empleado_telefono', 'id_empleado', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_operadores(self, cantidad=30):
        print(f"\nGenerando {cantidad} Operadores...")
        datos = []
        self.ids['operador'] = []
        self.ids['operador_empleado'] = {}
        turnos = ['Mañana', 'Tarde', 'Noche']
        zonas = ['Lima Centro', 'Lima Norte', 'Lima Sur', 'Callao', 'Lima Este']
        
        empleados_disponibles = random.sample(
            self.ids['empleado'],
            min(cantidad, len(self.ids['empleado']))
        )
        
        for id_empleado in empleados_disponibles:
            id_operador = str(uuid.uuid4())
            turno = random.choice(turnos)
            zona = random.choice(zonas)
            
            self.ids['operador'].append(id_operador)
            self.ids['operador_empleado'][id_operador] = id_empleado
            datos.append([id_operador, id_empleado, turno, zona])
        
        return self.guardar_csv(
            '23_operador.csv',
            datos,
            ['id_operador', 'id_empleado', 'turno', 'zona_monitoreo']
        )
    
    def generar_operaciones(self, cantidad=50):
        print(f"\nGenerando {cantidad} Operaciones...")
        datos = []
        self.ids['operacion'] = []
        
        for i in range(cantidad):
            id_operacion = str(uuid.uuid4())
            codigo = f"OP-{fake.unique.random_number(digits=8):08d}"
            fecha_inicio = fake.date_time_between(start_date='-6m', end_date='now')
            
            # 70% tienen fecha fin
            if random.random() < 0.7:
                fecha_fin = (fecha_inicio + timedelta(hours=random.randint(1, 72))).strftime('%Y-%m-%d %H:%M:%S')
            else:
                fecha_fin = ''  # NULL
            
            id_estado = random.choice(self.ids['estado_operacion'])
            
            self.ids['operacion'].append(id_operacion)
            datos.append([
                id_operacion,
                codigo,
                fecha_inicio.strftime('%Y-%m-%d %H:%M:%S'),
                fecha_fin,
                id_estado
            ])
        
        return self.guardar_csv(
            '24_operacion.csv',
            datos,
            ['id_operacion', 'codigo', 'fecha_inicio', 'fecha_fin', 'id_estado_operacion']
        )
    
    def generar_operacion_monitoreo(self):
        print(f"\nGenerando OperacionMonitoreo...")
        datos = []
        self.ids['operacion_monitoreo'] = []
        
        # 80% de las operaciones
        operaciones_monitoreo = random.sample(
            self.ids['operacion'],
            int(len(self.ids['operacion']) * 0.8)
        )
        
        for id_operacion in operaciones_monitoreo:
            id_om = str(uuid.uuid4())
            self.ids['operacion_monitoreo'].append(id_om)
            datos.append([id_om, id_operacion])
        
        return self.guardar_csv(
            '25_operacion_monitoreo.csv',
            datos,
            ['id_operacion_monitoreo', 'id_operacion']
        )
    
    def generar_contenedores(self, cantidad=200):
        print(f"\nGenerando {cantidad} Contenedores...")
        datos = []
        self.ids['contenedor'] = []
        
        for i in range(cantidad):
            id_contenedor = str(uuid.uuid4())
            codigo = f"CONT-{fake.unique.bothify(text='????-########').upper()}"
            peso = round(random.uniform(1000, 30000), 2)
            capacidad = random.randint(50000, 100000)  # ← AGREGAR ESTA LÍNEA
            dimensiones = random.choice(['20x20x20', '40x40x40', '60x60x60'])  # ← AGREGAR ESTA LÍNEA
            id_tipo = random.choice(self.ids['tipo_contenedor'])
            id_estado = random.choice(self.ids['estado_contenedor'])
            
            self.ids['contenedor'].append(id_contenedor)
            datos.append([id_contenedor, codigo, peso, capacidad, dimensiones, id_estado, id_tipo])  # ← MODIFICAR ESTA LÍNEA
        
        return self.guardar_csv(
            '26_contenedor.csv',
            datos,
            ['id_contenedor', 'codigo', 'peso', 'capacidad', 'dimensiones', 'id_estado_contenedor', 'id_tipo_contenedor']  # ← MODIFICAR ESTA LÍNEA
        )
    
    def generar_documentacion(self, cantidad=150):
        print(f"\nGenerando {cantidad} Documentaciones...")
        datos = []
        self.ids['documentacion'] = []
        
        for i in range(cantidad):
            id_doc = str(uuid.uuid4())
            codigo = f"DOC-{fake.unique.random_number(digits=8):08d}"
            nombre = fake.sentence(nb_words=4)
            fecha_emision = fake.date_between(start_date='-1y', end_date='today')
            id_tipo = random.choice(self.ids['tipo_documento'])
            
            self.ids['documentacion'].append(id_doc)
            datos.append([
                id_doc, codigo, nombre,
                fecha_emision.strftime('%Y-%m-%d'), id_tipo
            ])
        
        return self.guardar_csv(
            '38_documentacion.csv',
            datos,
            ['id_documentacion', 'codigo', 'nombre', 'fecha_emision', 'id_tipo_documento']
        )

    def generar_documentacion_contenedor(self):
        print(f"\nGenerando DocumentacionContenedor...")
        datos = []
        
        # Usar subset de documentaciones y contenedores
        cantidad = min(len(self.ids['documentacion']), len(self.ids['contenedor']))
        
        for i in range(cantidad):
            id_dc = str(uuid.uuid4())
            id_doc = self.ids['documentacion'][i]
            id_cont = self.ids['contenedor'][i]
            
            datos.append([id_dc, id_doc, id_cont])
        
        return self.guardar_csv(
            '39_documentacion_contenedor.csv',
            datos,
            ['id_documentacion_contenedor', 'id_documentacion', 'id_contenedor']
        )

    def generar_sensores(self):
        print(f"\nGenerando Sensores...")
        datos = []
        self.ids['sensor'] = []
        
        for id_contenedor in self.ids['contenedor']:
            num_sensores = random.randint(2, 4)
            for j in range(num_sensores):
                id_sensor = str(uuid.uuid4())
                codigo = f"SENS-{fake.unique.random_number(digits=8):08d}"
                nombre = f"Sensor {fake.word()}"
                id_tipo = random.choice(self.ids['tipo_sensor'])
                id_rol = random.choice(self.ids['rol_sensor'])
                
                self.ids['sensor'].append(id_sensor)
                datos.append([id_sensor, codigo, nombre, id_tipo, id_rol, id_contenedor])
        
        return self.guardar_csv(
            '40_sensor.csv',
            datos,
            ['id_sensor', 'codigo', 'nombre', 'id_tipo_sensor', 'id_rol_sensor', 'id_contenedor']
        )

    def generar_reportes(self, cantidad=100):
        print(f"\nGenerando {cantidad} Reportes...")
        datos = []
        self.ids['reporte'] = []
        
        for i in range(cantidad):
            id_reporte = str(uuid.uuid4())
            codigo = f"REP-{fake.unique.random_number(digits=8):08d}"
            fecha_reporte = fake.date_between(start_date='-3m', end_date='today')
            detalle = fake.paragraph(nb_sentences=3)
            
            self.ids['reporte'].append(id_reporte)
            datos.append([
                id_reporte, codigo,
                fecha_reporte.strftime('%Y-%m-%d'), detalle
            ])
        
        return self.guardar_csv(
            '41_reporte.csv',
            datos,
            ['id_reporte', 'codigo', 'fecha_reporte', 'detalle']
        )

    def generar_notificaciones(self, cantidad=300):
        print(f"\nGenerando {cantidad} Notificaciones...")
        datos = []
        
        for i in range(cantidad):
            id_notif = str(uuid.uuid4())
            codigo = f"NOT-{fake.unique.random_number(digits=8):08d}"
            id_tipo = random.choice(self.ids['tipo_notificacion'])
            fecha_hora = fake.date_time_between(start_date='-3m', end_date='now')
            valor = round(random.uniform(0, 100), 2)
            id_sensor = random.choice(self.ids['sensor'])
            id_reporte = random.choice(self.ids['reporte'])
            
            datos.append([
                id_notif, codigo, id_tipo,
                fecha_hora.strftime('%Y-%m-%d %H:%M:%S'),
                valor, id_sensor, id_reporte
            ])
        
        return self.guardar_csv(
            '42_notificacion.csv',
            datos,
            ['id_notificacion', 'codigo', 'id_tipo_notificacion', 'fecha_hora',
            'valor', 'id_sensor', 'id_reporte']
        )

    def generar_usuarios(self):
        print(f"\nGenerando Usuarios...")
        datos = []
        self.ids['usuario'] = []
        
        # Usar los empleados que SÍ son operadores
        for id_operador in self.ids['operador']:
            id_usuario = str(uuid.uuid4())
            id_empleado = self.ids['operador_empleado'][id_operador]  # ← USAR LA RELACIÓN CORRECTA
            correo = fake.email()
            contrasena = fake.password(length=12)
            id_rol = random.choice(self.ids['rol_usuario'])
            
            self.ids['usuario'].append(id_usuario)
            datos.append([id_usuario, id_empleado, correo, contrasena, id_rol])
        
        return self.guardar_csv(
            '43_usuario.csv',
            datos,
            ['id_usuario', 'id_empleado', 'correo_electronico', 'contrasena', 'id_rol_usuario']
        )

    def generar_incidencias(self, cantidad=80):
        print(f"\nGenerando {cantidad} Incidencias...")
        datos = []
        self.ids['incidencia'] = []
        
        for i in range(cantidad):
            id_incidencia = str(uuid.uuid4())
            codigo = f"INC-{fake.unique.random_number(digits=8):08d}"
            id_tipo = random.choice(self.ids['tipo_incidencia'])
            descripcion = fake.paragraph(nb_sentences=2)
            grado_severidad = random.randint(1, 5)
            fecha_hora = fake.date_time_between(start_date='-3m', end_date='now')
            id_estado = random.choice(self.ids['estado_incidencia'])
            id_operacion = random.choice(self.ids['operacion'])
            id_usuario = random.choice(self.ids['usuario'])
            
            self.ids['incidencia'].append(id_incidencia)
            datos.append([
                id_incidencia, codigo, id_tipo, descripcion, grado_severidad,
                fecha_hora.strftime('%Y-%m-%d %H:%M:%S'),
                id_estado, id_operacion, id_usuario
            ])
        
        return self.guardar_csv(
            '44_incidencia.csv',
            datos,
            ['id_incidencia', 'codigo', 'id_tipo_incidencia', 'descripcion',
            'grado_severidad', 'fecha_hora', 'id_estado_incidencia',
            'id_operacion', 'id_usuario']
        )

    def generar_incidencia_reporte(self):
        print(f"\nGenerando IncidenciaReporte...")
        datos = []
        registros_unicos = set()
        
        for id_incidencia in self.ids['incidencia']:
            num_reportes = random.randint(1, 2)
            reportes_seleccionados = random.sample(
                self.ids['reporte'],
                min(num_reportes, len(self.ids['reporte']))
            )
            
            for id_reporte in reportes_seleccionados:
                clave = (id_incidencia, id_reporte)
                if clave not in registros_unicos:
                    id_ir = str(uuid.uuid4())
                    datos.append([id_ir, id_incidencia, id_reporte])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '45_incidencia_reporte.csv',
            datos,
            ['id_incidencia_reporte', 'id_incidencia', 'id_reporte']
        )

    def generar_importadores(self, cantidad=50):
        print(f"\nGenerando {cantidad} Importadores...")
        datos = []
        self.ids['importador'] = []
        rucs_usados = set()
        
        for i in range(cantidad):
            id_importador = str(uuid.uuid4())
            codigo = f"IMP-{fake.unique.random_number(digits=6):06d}"
            
            # RUC único de 11 dígitos
            while True:
                ruc = f"{random.randint(10000000000, 99999999999)}"
                if ruc not in rucs_usados:
                    rucs_usados.add(ruc)
                    break
            
            razon_social = fake.company()
            
            self.ids['importador'].append(id_importador)
            datos.append([id_importador, codigo, ruc, razon_social])
        
        return self.guardar_csv(
            '46_importador.csv',
            datos,
            ['id_importador', 'codigo', 'ruc', 'razon_social']
        )

    def generar_importador_direcciones(self):
        print(f"\nGenerando Direcciones de Importadores...")
        datos = []
        
        for id_importador in self.ids['importador']:
            num_direcciones = random.randint(1, 3)
            for i in range(num_direcciones):
                id_dir = str(uuid.uuid4())
                direccion = fake.address().replace('\n', ', ')
                tipo = random.choice(['Fiscal', 'Comercial', 'Almacén', 'Oficina'])
                principal = (i == 0)  # Primera dirección es principal
                
                datos.append([id_dir, id_importador, direccion, tipo, principal])
        
        return self.guardar_csv(
            '47_importador_direccion.csv',
            datos,
            ['id_direccion', 'id_importador', 'direccion', 'tipo', 'principal']
        )

    def generar_entregas(self, cantidad=120):
        print(f"\nGenerando {cantidad} Entregas...")
        datos = []
        contenedores_usados = set()
        
        for i in range(cantidad):
            id_entrega = str(uuid.uuid4())
            codigo = f"ENT-{fake.unique.random_number(digits=8):08d}"
            id_estado = random.choice(self.ids['estado_entrega'])
            fecha_entrega = fake.date_between(start_date='-2m', end_date='+1m')
            lugar_entrega = fake.city()
            
            # Contenedor único
            id_contenedor = random.choice(
                [c for c in self.ids['contenedor'] if c not in contenedores_usados]
            )
            contenedores_usados.add(id_contenedor)
            
            id_importador = random.choice(self.ids['importador'])
            
            datos.append([
                id_entrega, codigo, id_estado,
                fecha_entrega.strftime('%Y-%m-%d'),
                lugar_entrega, id_contenedor, id_importador
            ])
        
        return self.guardar_csv(
            '48_entrega.csv',
            datos,
            ['id_entrega', 'codigo', 'id_estado_entrega', 'fecha_entrega',
            'lugar_entrega', 'id_contenedor', 'id_importador']
        )

    def generar_activos(self, cantidad=100):
        print(f"\nGenerando {cantidad} Activos...")
        datos = []
        self.ids['activo'] = []
        
        for i in range(cantidad):
            id_activo = str(uuid.uuid4())
            codigo = f"ACT-{fake.unique.random_number(digits=8):08d}"
            nombre = fake.sentence(nb_words=6)
            id_tipo = random.choice(self.ids['tipo_activo'])
            id_estado = random.choice(self.ids['estado_activo'])
            ubicacion = fake.city()
            
            self.ids['activo'].append(id_activo)
            datos.append([
                id_activo, codigo, nombre, id_tipo, id_estado,
                ubicacion
            ])
        
        return self.guardar_csv(
            '27_activo.csv',
            datos,
            ['id_activo', 'codigo', 'nombre', 'id_tipo_activo', 'id_estado_activo',
             'ubicacion']
        )
    
    def generar_vehiculos(self, cantidad=50):
        print(f"\nGenerando {cantidad} Vehículos...")
        datos = []
        self.ids['vehiculo'] = []
        placas_usadas = set()
        
        activos_disponibles = random.sample(
            self.ids['activo'],
            min(cantidad, len(self.ids['activo']))
        )
        
        for id_activo in activos_disponibles:
            id_vehiculo = str(uuid.uuid4())
            
            # Placa única
            while True:
                placa = fake.bothify(text='???-###').upper()
                if placa not in placas_usadas:
                    placas_usadas.add(placa)
                    break
            
            capacidad = round(random.uniform(5.0, 40.0), 2)
            id_tipo = random.choice(self.ids['tipo_vehiculo'])
            id_estado = random.choice(self.ids['estado_vehiculo'])
            
            self.ids['vehiculo'].append(id_vehiculo)
            datos.append([id_vehiculo, id_activo, placa, capacidad, id_tipo, id_estado])
        
        return self.guardar_csv(
            '28_vehiculo.csv',
            datos,
            ['id_vehiculo', 'id_activo', 'placa', 'capacidad_ton',
             'id_tipo_vehiculo', 'id_estado_vehiculo']
        )
    
    def generar_buques(self, cantidad=20):
        print(f"\nGenerando {cantidad} Buques...")
        datos = []
        self.ids['buque'] = []
        matriculas_usadas = set()
        
        for i in range(cantidad):
            id_buque = str(uuid.uuid4())
            
            # Matrícula única
            while True:
                matricula = f"IMO-{random.randint(1000000, 9999999)}"
                if matricula not in matriculas_usadas:
                    matriculas_usadas.add(matricula)
                    break
            
            nombre = f"{fake.word().upper()} {random.choice(['CARRIER', 'NAVIGATOR', 'VOYAGER', 'STAR', 'OCEAN'])}"
            capacidad = random.randint(1000, 20000)
            peso = round(random.uniform(50000, 200000), 2)
            ubicacion = fake.city()
            id_estado = random.choice(self.ids['estado_embarcacion'])
            
            self.ids['buque'].append(id_buque)
            datos.append([id_buque, matricula, nombre, capacidad, id_estado, peso, ubicacion])
        
        return self.guardar_csv(
            '29_buque.csv',
            datos,
            ['id_buque', 'matricula', 'nombre', 'capacidad',
             'id_estado_embarcacion', 'peso', 'ubicacion_actual']
        )
    
    def generar_posiciones_contenedor(self, num_por_contenedor=5):
        print(f"\nGenerando Posiciones de Contenedores...")
        datos = []
        lat_base, lon_base = -12.0464, -77.0428
        
        # Solo primeros 50 contenedores
        for id_contenedor in self.ids['contenedor'][:50]:
            fecha_base = fake.date_time_between(start_date='-30d', end_date='now')
            
            for j in range(num_por_contenedor):
                id_pos = str(uuid.uuid4())
                latitud = round(lat_base + random.uniform(-5, 5), 6)
                longitud = round(lon_base + random.uniform(-5, 5), 6)
                fecha_hora = (fecha_base + timedelta(hours=j*6)).strftime('%Y-%m-%d %H:%M:%S')
                
                datos.append([id_pos, id_contenedor, latitud, longitud, fecha_hora])
        
        return self.guardar_csv(
            '30_posicion_contenedor.csv',
            datos,
            ['id_posicion', 'id_contenedor', 'latitud', 'longitud', 'fecha_hora']
        )
    
    def generar_posiciones_vehiculo(self, num_por_vehiculo=10):
        print(f"\nGenerando Posiciones de Vehículos...")
        datos = []
        lat_base, lon_base = -12.0464, -77.0428
        
        for id_vehiculo in self.ids['vehiculo'][:30]:
            fecha_base = fake.date_time_between(start_date='-7d', end_date='now')
            
            for j in range(num_por_vehiculo):
                id_pos = str(uuid.uuid4())
                latitud = round(lat_base + random.uniform(-2, 2), 6)
                longitud = round(lon_base + random.uniform(-2, 2), 6)
                fecha_hora = (fecha_base + timedelta(hours=j*2)).strftime('%Y-%m-%d %H:%M:%S')
                
                datos.append([id_pos, id_vehiculo, latitud, longitud, fecha_hora])
        
        return self.guardar_csv(
            '31_posicion_vehiculo.csv',
            datos,
            ['id_posicion', 'id_vehiculo', 'latitud', 'longitud', 'fecha_hora']
        )
    
    def generar_posiciones_buque(self, num_por_buque=15):
        print(f"\nGenerando Posiciones de Buques...")
        datos = []
        lat_base, lon_base = -12.0464, -77.0428
        
        for id_buque in self.ids['buque'][:15]:
            fecha_base = fake.date_time_between(start_date='-15d', end_date='now')
            
            for j in range(num_por_buque):
                id_pos = str(uuid.uuid4())
                latitud = round(lat_base + random.uniform(-10, 10), 6)
                longitud = round(lon_base + random.uniform(-15, 15), 6)
                fecha_hora = (fecha_base + timedelta(hours=j*12)).strftime('%Y-%m-%d %H:%M:%S')
                
                datos.append([id_pos, id_buque, latitud, longitud, fecha_hora])
        
        return self.guardar_csv(
            '32_posicion_buque.csv',
            datos,
            ['id_posicion', 'id_buque', 'latitud', 'longitud', 'fecha_hora']
        )
    
    # ============================================
    # TABLAS ASOCIATIVAS
    # ============================================
    
    def generar_operacion_monitoreo_vehiculo(self):
        print(f"\nGenerando OperacionMonitoreoVehiculo...")
        datos = []
        registros_unicos = set()
        
        for id_om in self.ids['operacion_monitoreo'][:30]:
            num_vehiculos = random.randint(1, 3)
            vehiculos = random.sample(
                self.ids['vehiculo'],
                min(num_vehiculos, len(self.ids['vehiculo']))
            )
            
            for id_vehiculo in vehiculos:
                fecha_op = fake.date_between(start_date='-3m', end_date='today').strftime('%Y-%m-%d')
                clave = (id_om, id_vehiculo, fecha_op)
                
                if clave not in registros_unicos:
                    id_omv = str(uuid.uuid4())
                    datos.append([id_omv, id_om, id_vehiculo, fecha_op])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '33_operacion_monitoreo_vehiculo.csv',
            datos,
            ['id_operacion_monitoreo_vehiculo', 'id_operacion_monitoreo',
             'id_vehiculo', 'fecha_operacion']
        )
    
    def generar_operacion_monitoreo_buque(self):
        print(f"\nGenerando OperacionMonitoreoBuque...")
        datos = []
        registros_unicos = set()
        
        for id_om in self.ids['operacion_monitoreo'][:20]:
            num_buques = random.randint(1, 2)
            buques = random.sample(
                self.ids['buque'],
                min(num_buques, len(self.ids['buque']))
            )
            
            for id_buque in buques:
                fecha_op = fake.date_between(start_date='-3m', end_date='today').strftime('%Y-%m-%d')
                clave = (id_om, id_buque, fecha_op)
                
                if clave not in registros_unicos:
                    id_omb = str(uuid.uuid4())
                    datos.append([id_omb, id_om, id_buque, fecha_op])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '34_operacion_monitoreo_buque.csv',
            datos,
            ['id_operacion_monitoreo_buque', 'id_operacion_monitoreo',
             'id_buque', 'fecha_operacion']
        )
    
    def generar_contenedor_vehiculo(self):
        print(f"\nGenerando ContenedorVehiculo...")
        datos = []
        registros_unicos = set()
        
        for _ in range(100):
            id_contenedor = random.choice(self.ids['contenedor'])
            id_vehiculo = random.choice(self.ids['vehiculo'])
            fecha_asig = fake.date_between(start_date='-2m', end_date='today')
            fecha_trans = fake.date_between(start_date=fecha_asig, end_date='+7d')
            
            clave = (id_contenedor, id_vehiculo, fecha_asig.strftime('%Y-%m-%d'))
            
            if clave not in registros_unicos:
                id_cv = str(uuid.uuid4())
                datos.append([
                    id_cv, id_contenedor, id_vehiculo,
                    fecha_asig.strftime('%Y-%m-%d'),
                    fecha_trans.strftime('%Y-%m-%d')
                ])
                registros_unicos.add(clave)
        
        return self.guardar_csv(
            '35_contenedor_vehiculo.csv',
            datos,
            ['id_contenedor_vehiculo', 'id_contenedor', 'id_vehiculo',
             'fecha_asignacion', 'fecha_transporte']
        )
    
    def generar_contenedor_buque(self):
        print(f"\nGenerando ContenedorBuque...")
        datos = []
        registros_unicos = set()
        
        for _ in range(150):
            id_contenedor = random.choice(self.ids['contenedor'])
            id_buque = random.choice(self.ids['buque'])
            fecha_asig = fake.date_between(start_date='-3m', end_date='today')
            fecha_trans = fake.date_between(start_date=fecha_asig, end_date='+15d')
            
            clave = (id_contenedor, id_buque, fecha_asig.strftime('%Y-%m-%d'))
            
            if clave not in registros_unicos:
                id_cb = str(uuid.uuid4())
                datos.append([
                    id_cb, id_contenedor, id_buque,
                    fecha_asig.strftime('%Y-%m-%d'),
                    fecha_trans.strftime('%Y-%m-%d')
                ])
                registros_unicos.add(clave)
        
        return self.guardar_csv(
            '36_contenedor_buque.csv',
            datos,
            ['id_contenedor_buque', 'id_contenedor', 'id_buque',
             'fecha_asignacion', 'fecha_transporte']
        )
    
    def generar_operador_operacion_monitoreo(self):
        print(f"\nGenerando OperadorOperacionMonitoreo...")
        datos = []
        registros_unicos = set()
        
        for id_om in self.ids['operacion_monitoreo']:
            num_operadores = random.randint(1, 2)
            operadores = random.sample(
                self.ids['operador'],
                min(num_operadores, len(self.ids['operador']))
            )
            
            for id_operador in operadores:
                fecha_real = fake.date_between(start_date='-3m', end_date='today').strftime('%Y-%m-%d')
                clave = (id_operador, id_om, fecha_real)
                
                if clave not in registros_unicos:
                    id_oom = str(uuid.uuid4())
                    datos.append([id_oom, id_operador, id_om, fecha_real])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '37_operador_operacion_monitoreo.csv',
            datos,
            ['id_operador_operacion_monitoreo', 'id_operador',
             'id_operacion_monitoreo', 'fecha_realizacion']
        )
    
    # ============================================
    # MÉTODO PRINCIPAL
    # ============================================

    def generar_todo(self):
        """Genera todos los archivos CSV"""
        print("\n" + "="*60)
        print("GENERANDO ARCHIVOS CSV CON FAKER")
        print("="*60)
        
        # Tablas de dominio
        self.generar_estado_operacion()
        self.generar_especialidad_empleado()
        self.generar_estado_contenedor()
        self.generar_tipo_contenedor()
        self.generar_tipo_documento()
        self.generar_estado_entrega()
        self.generar_tipo_sensor()
        self.generar_rol_sensor()
        self.generar_tipo_notificacion()
        self.generar_tipo_incidencia()
        self.generar_estado_embarcacion()
        self.generar_tipo_vehiculo()
        self.generar_estado_vehiculo()
        self.generar_estado_incidencia()
        self.generar_rol_usuario()
        self.generar_tipo_activo()
        self.generar_estado_activo()
        self.generar_estado_contrato()
        self.generar_tipo_telefono()
        
        # Tablas principales
        self.generar_contratos(50)
        self.generar_empleados(100)
        self.generar_empleado_telefonos()
        self.generar_operadores(30)
        self.generar_operaciones(50)
        self.generar_operacion_monitoreo()
        self.generar_contenedores(200)
        self.generar_documentacion(150)
        self.generar_documentacion_contenedor()
        self.generar_sensores()
        self.generar_reportes(100)
        self.generar_notificaciones(300)
        self.generar_usuarios()
        self.generar_incidencias(80)
        self.generar_incidencia_reporte()
        self.generar_importadores(50)
        self.generar_importador_direcciones()
        self.generar_entregas(120)
        self.generar_activos(100)
        self.generar_vehiculos(50)
        self.generar_buques(20)
        
        # Posiciones
        self.generar_posiciones_contenedor(5)
        self.generar_posiciones_vehiculo(10)
        self.generar_posiciones_buque(15)
        
        # Tablas asociativas
        self.generar_operacion_monitoreo_vehiculo()
        self.generar_operacion_monitoreo_buque()
        self.generar_contenedor_vehiculo()
        self.generar_contenedor_buque()
        self.generar_operador_operacion_monitoreo()
        
        print("\n" + "="*60)
        print("GENERACIÓN COMPLETADA")
        print(f"Archivos guardados en: {OUTPUT_DIR}/")
        print("="*60)


# ============================================
# EJECUCIÓN
# ============================================

if __name__ == "__main__":
    print("""
    ╔════════════════════════════════════════════════════════════╗
    ║   GENERADOR DE CSV - SISTEMA DE MONITOREO                  ║
    ║   Datos falsos con Faker para PostgreSQL                   ║
    ╚════════════════════════════════════════════════════════════╝
    """)
    
    generador = GeneradorCSV()
    generador.generar_todo()
    
    print("\nPRÓXIMO PASO:")
    print("   Importa los archivos CSV en pgAdmin en el orden numérico")
    print("   (01_estado_operacion.csv primero, 48_operador_operacion_monitoreo.csv último)")