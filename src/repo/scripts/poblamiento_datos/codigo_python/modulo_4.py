import csv
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

# Configuración
fake = Faker('es_ES')
OUTPUT_DIR = 'datos_csv_modulo_4'

# Crear directorio de salida
if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)
    print(f"Directorio '{OUTPUT_DIR}' creado")


class GeneradorCSVTerrestres:
    def __init__(self):
        self.ids = {}  # Almacenar IDs generados
        
    def guardar_csv(self, nombre_archivo, datos, encabezados):
        filepath = os.path.join(OUTPUT_DIR, nombre_archivo)
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(encabezados)
            writer.writerows(datos)
        print(f"  ✓ {nombre_archivo} - {len(datos)} registros")
        return filepath
    
    # ============================================
    # TABLAS DE DOMINIO (LOOKUP)
    # ============================================
    
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
            '01_estado_operacion.csv',
            datos,
            ['id_estado_operacion', 'nombre']
        )
    
    def generar_tipo_activo(self):
        print("\nGenerando TipoActivo...")
        tipos = ['Vehículo', 'Equipo de Carga', 'Herramienta', 'Contenedor', 'Maquinaria']
        datos = []
        self.ids['tipo_activo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_activo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '02_tipo_activo.csv',
            datos,
            ['id_tipo_activo', 'nombre']
        )
    
    def generar_estado_activo(self):
        print("\nGenerando EstadoActivo...")
        estados = ['Operativo', 'En Mantenimiento', 'Fuera de Servicio', 'En Reparación', 'Disponible']
        datos = []
        self.ids['estado_activo'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_activo'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '03_estado_activo.csv',
            datos,
            ['id_estado_activo', 'nombre']
        )
    
    def generar_tipo_vehiculo(self):
        print("\nGenerando TipoVehiculo...")
        tipos = ['Camión', 'Camioneta', 'Tráiler', 'Furgoneta', 'Tractocamión']
        datos = []
        self.ids['tipo_vehiculo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_vehiculo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '04_tipo_vehiculo.csv',
            datos,
            ['id_tipo_vehiculo', 'nombre']
        )
    
    def generar_estado_vehiculo(self):
        print("\nGenerando EstadoVehiculo...")
        estados = ['Disponible', 'En Ruta', 'En Mantenimiento', 'Fuera de Servicio', 'En Revisión']
        datos = []
        self.ids['estado_vehiculo'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_vehiculo'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '05_estado_vehiculo.csv',
            datos,
            ['id_estado_vehiculo', 'nombre']
        )
    
    def generar_especialidad_empleado(self):
        print("\nGenerando EspecialidadEmpleado...")
        especialidades = [
            'Conductor Profesional',
            'Mecánico',
            'Supervisor de Operaciones',
            'Coordinador Logístico',
            'Operador de Carga',
            'Inspector de Vehículos'
        ]
        datos = []
        self.ids['especialidad_empleado'] = []
        
        for esp in especialidades:
            id_esp = str(uuid.uuid4())
            self.ids['especialidad_empleado'].append(id_esp)
            datos.append([id_esp, esp])
        
        return self.guardar_csv(
            '06_especialidad_empleado.csv',
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
            '07_estado_contrato.csv',
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
            '08_tipo_telefono.csv',
            datos,
            ['id_tipo_telefono', 'nombre']
        )
    
    def generar_tipo_incidencia(self):
        print("\nGenerando TipoIncidencia...")
        tipos = ['Accidente', 'Avería Mecánica', 'Retraso', 'Daño a Carga', 'Robo', 'Incumplimiento']
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
    
    def generar_estado_incidencia(self):
        print("\nGenerando EstadoIncidencia...")
        estados = ['Reportada', 'En Investigación', 'Resuelta', 'Cerrada', 'Pendiente']
        datos = []
        self.ids['estado_incidencia'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_incidencia'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '10_estado_incidencia.csv',
            datos,
            ['id_estado_incidencia', 'nombre']
        )
    
    def generar_tipo_documento(self):
        print("\nGenerando TipoDocumento...")
        tipos = ['Guía de Remisión', 'Factura', 'Orden de Transporte', 'Certificado', 'Manifiesto', 'Póliza']
        datos = []
        self.ids['tipo_documento'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_documento'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '11_tipo_documento.csv',
            datos,
            ['id_tipo_documento', 'nombre']
        )
    
    def generar_tipo_reporte(self):
        print("\nGenerando TipoReporte...")
        tipos = ['Operacional', 'Incidencias', 'Combustible', 'Mantenimiento', 'Rendimiento']
        datos = []
        self.ids['tipo_reporte'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_reporte'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '12_tipo_reporte.csv',
            datos,
            ['id_tipo_reporte', 'nombre']
        )
    
    def generar_rol_usuario(self):
        print("\nGenerando RolUsuario...")
        roles = ['Administrador', 'Supervisor', 'Operador', 'Conductor', 'Inspector']
        datos = []
        self.ids['rol_usuario'] = []
        
        for rol in roles:
            id_rol = str(uuid.uuid4())
            self.ids['rol_usuario'].append(id_rol)
            datos.append([id_rol, rol])
        
        return self.guardar_csv(
            '13_rol_usuario.csv',
            datos,
            ['id_rol_usuario', 'nombre']
        )
    
    # ============================================
    # TABLAS PRINCIPALES
    # ============================================
    
    def generar_contratos(self, cantidad=100):
        print(f"\nGenerando {cantidad} Contratos...")
        datos = []
        self.ids['contrato'] = []
        
        for i in range(cantidad):
            id_contrato = str(uuid.uuid4())
            fecha_emision = fake.date_between(start_date='-2y', end_date='today')
            fecha_vencimiento = fake.date_between(start_date=fecha_emision, end_date='+3y')
            id_estado = random.choice(self.ids['estado_contrato'])
            
            self.ids['contrato'].append(id_contrato)
            datos.append([
                id_contrato,
                fecha_emision.strftime('%Y-%m-%d'),
                fecha_vencimiento.strftime('%Y-%m-%d'),
                id_estado
            ])
        
        return self.guardar_csv(
            '14_contrato.csv',
            datos,
            ['id_contrato', 'fecha_emision', 'fecha_vencimiento', 'id_estado_contrato']
        )
    
    def generar_empleados(self, cantidad=70):
        print(f"\nGenerando {cantidad} Empleados...")
        datos = []
        self.ids['empleado'] = []
        dnis_usados = set()
        codigos_usados = set()
        
        contratos_disponibles = self.ids['contrato'].copy()
        random.shuffle(contratos_disponibles)
        
        for i in range(cantidad):
            id_empleado = str(uuid.uuid4())
            
            while True:
                codigo = f"EMP-{fake.random_number(digits=5):05d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            while True:
                dni = f"{random.randint(10000000, 99999999)}"
                if dni not in dnis_usados:
                    dnis_usados.add(dni)
                    break
            
            nombre = fake.first_name()
            apellido = fake.last_name()
            direccion = fake.address().replace('\n', ', ')
            id_especialidad = random.choice(self.ids['especialidad_empleado'])
            id_contrato = contratos_disponibles.pop()
            
            self.ids['empleado'].append(id_empleado)
            datos.append([
                id_empleado, codigo, dni, nombre, apellido,
                direccion, id_especialidad, id_contrato
            ])
        
        return self.guardar_csv(
            '15_empleado.csv',
            datos,
            ['id_empleado', 'codigo', 'dni', 'nombre', 'apellido', 'direccion',
             'id_especialidad_empleado', 'id_contrato']
        )
    
    def generar_empleado_telefonos(self):
        print(f"\nGenerando Teléfonos de Empleados...")
        datos = []
        telefonos_usados = set()
        
        for id_empleado in self.ids['empleado']:
            num_telefonos = random.randint(1, 2)
            for _ in range(num_telefonos):
                id_tel = str(uuid.uuid4())
                
                while True:
                    longitud = random.randint(7, 15)
                    telefono = ''.join([str(random.randint(0, 9)) for _ in range(longitud)])
                    
                    if telefono[0] != '0' and (id_empleado, telefono) not in telefonos_usados:
                        telefonos_usados.add((id_empleado, telefono))
                        break
                
                id_tipo_tel = random.choice(self.ids['tipo_telefono'])
                datos.append([id_tel, id_empleado, telefono, id_tipo_tel])
        
        return self.guardar_csv(
            '16_empleado_telefono.csv',
            datos,
            ['id_empleado_telefono', 'id_empleado', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_usuarios(self):
        print(f"\nGenerando Usuarios...")
        datos = []
        self.ids['usuario'] = []
        
        cantidad_usuarios = int(len(self.ids['empleado']) * 0.4)
        empleados_usuarios = random.sample(self.ids['empleado'], cantidad_usuarios)
        
        for id_empleado in empleados_usuarios:
            id_usuario = str(uuid.uuid4())
            correo = fake.email()
            contrasena = fake.password(length=12)
            id_rol = random.choice(self.ids['rol_usuario'])
            
            self.ids['usuario'].append(id_usuario)
            datos.append([id_usuario, id_empleado, correo, contrasena, id_rol])
        
        return self.guardar_csv(
            '17_usuario.csv',
            datos,
            ['id_usuario', 'id_empleado', 'correo_electronico', 'contrasena', 'id_rol_usuario']
        )
    
    def generar_operaciones(self, cantidad=80):
        print(f"\nGenerando {cantidad} Operaciones...")
        datos = []
        self.ids['operacion'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_operacion = str(uuid.uuid4())
            
            while True:
                codigo = f"OP-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            fecha_inicio = fake.date_time_between(start_date='-6m', end_date='now')
            
            if random.random() < 0.7:
                fecha_fin = fecha_inicio + timedelta(hours=random.randint(2, 72))
                fecha_fin_str = fecha_fin.strftime('%Y-%m-%d %H:%M:%S')
            else:
                fecha_fin_str = ''
            
            id_estado = random.choice(self.ids['estado_operacion'])
            
            self.ids['operacion'].append(id_operacion)
            datos.append([
                id_operacion, codigo,
                fecha_inicio.strftime('%Y-%m-%d %H:%M:%S'),
                fecha_fin_str, id_estado
            ])
        
        return self.guardar_csv(
            '18_operacion.csv',
            datos,
            ['id_operacion', 'codigo', 'fecha_inicio', 'fecha_fin', 'id_estado_operacion']
        )
    
    def generar_rutas(self, cantidad=30):
        print(f"\nGenerando {cantidad} Rutas...")
        datos = []
        self.ids['ruta'] = []
        codigos_usados = set()
        
        ciudades = [
            'Lima', 'Callao', 'Arequipa', 'Trujillo', 'Chiclayo',
            'Piura', 'Cusco', 'Ica', 'Huancayo', 'Tacna',
            'Puno', 'Ayacucho', 'Cajamarca', 'Pucallpa', 'Iquitos'
        ]
        
        for i in range(cantidad):
            id_ruta = str(uuid.uuid4())
            
            while True:
                codigo = f"RT-{fake.random_number(digits=5):05d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            origen = random.choice(ciudades)
            destino = random.choice([c for c in ciudades if c != origen])
            duracion = random.randint(2, 48)  # horas
            tarifa = round(random.uniform(500, 15000), 2)
            
            self.ids['ruta'].append(id_ruta)
            datos.append([id_ruta, codigo, origen, destino, duracion, tarifa])
        
        return self.guardar_csv(
            '19_ruta.csv',
            datos,
            ['id_ruta', 'codigo', 'origen', 'destino', 'duracion', 'tarifa']
        )
    
    def generar_rutas_terrestres(self):
        print(f"\nGenerando Rutas Terrestres...")
        datos = []
        self.ids['ruta_terrestre'] = []
        
        for id_ruta in self.ids['ruta']:
            id_ruta_terrestre = str(uuid.uuid4())
            self.ids['ruta_terrestre'].append(id_ruta_terrestre)
            datos.append([id_ruta_terrestre, id_ruta])
        
        return self.guardar_csv(
            '20_ruta_terrestre.csv',
            datos,
            ['id_ruta_terrestre', 'id_ruta']
        )
    
    def generar_activos(self, cantidad=60):
        print(f"\nGenerando {cantidad} Activos...")
        datos = []
        self.ids['activo'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_activo = str(uuid.uuid4())
            
            while True:
                codigo = f"ACT-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = f"Activo {fake.word().upper()} {random.randint(100, 999)}"
            id_tipo = random.choice(self.ids['tipo_activo'])
            id_estado = random.choice(self.ids['estado_activo'])
            ubicacion = fake.city()
            
            self.ids['activo'].append(id_activo)
            datos.append([id_activo, codigo, nombre, id_tipo, id_estado, ubicacion])
        
        return self.guardar_csv(
            '21_activo.csv',
            datos,
            ['id_activo', 'codigo', 'nombre', 'id_tipo_activo', 'id_estado_activo', 'ubicacion']
        )
    
    def generar_vehiculos(self):
        print(f"\nGenerando Vehículos...")
        datos = []
        self.ids['vehiculo'] = []
        placas_usadas = set()
        
        cantidad_vehiculos = int(len(self.ids['activo']) * 0.7)
        activos_vehiculos = random.sample(self.ids['activo'], cantidad_vehiculos)
        
        for id_activo in activos_vehiculos:
            id_vehiculo = str(uuid.uuid4())
            
            while True:
                placa = fake.bothify(text='???-###').upper()
                if placa not in placas_usadas:
                    placas_usadas.add(placa)
                    break
            
            capacidad_ton = round(random.uniform(2, 40), 2)
            id_tipo = random.choice(self.ids['tipo_vehiculo'])
            id_estado = random.choice(self.ids['estado_vehiculo'])
            
            self.ids['vehiculo'].append(id_vehiculo)
            datos.append([id_vehiculo, id_activo, placa, capacidad_ton, id_tipo, id_estado])
        
        return self.guardar_csv(
            '22_vehiculo.csv',
            datos,
            ['id_vehiculo', 'id_activo', 'placa', 'capacidad_ton',
             'id_tipo_vehiculo', 'id_estado_vehiculo']
        )
    
    def generar_conductores(self):
        print(f"\nGenerando Conductores...")
        datos = []
        self.ids['conductor'] = []
        licencias_usadas = set()
        
        # Seleccionar 30-40 empleados como conductores
        cantidad_conductores = random.randint(30, 40)
        empleados_conductores = random.sample(self.ids['empleado'], 
                                             min(cantidad_conductores, len(self.ids['empleado'])))
        
        categorias = ['A-I', 'A-II-A', 'A-II-B', 'A-III-A', 'A-III-B', 'A-III-C']
        
        for id_empleado in empleados_conductores:
            id_conductor = str(uuid.uuid4())
            
            while True:
                licencia = f"L{random.randint(10000000, 99999999)}"
                if licencia not in licencias_usadas:
                    licencias_usadas.add(licencia)
                    break
            
            categoria = random.choice(categorias)
            disponibilidad = random.choice([True, True, True, False])  # 75% disponible
            
            self.ids['conductor'].append(id_conductor)
            datos.append([id_conductor, id_empleado, licencia, categoria, disponibilidad])
        
        return self.guardar_csv(
            '23_conductor.csv',
            datos,
            ['id_conductor', 'id_empleado', 'licencia', 'categoria', 'disponibilidad']
        )
    
    def generar_operaciones_terrestres(self):
        print(f"\nGenerando Operaciones Terrestres...")
        datos = []
        self.ids['operacion_terrestre'] = []
        codigos_usados = set()
        
        for id_operacion in self.ids['operacion']:
            id_op_terrestre = str(uuid.uuid4())
            
            while True:
                codigo = f"OT-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_vehiculo = random.choice(self.ids['vehiculo'])
            id_ruta_terrestre = random.choice(self.ids['ruta_terrestre'])
            id_conductor = random.choice(self.ids['conductor'])
            costo = round(random.uniform(500, 20000), 2)
            
            self.ids['operacion_terrestre'].append(id_op_terrestre)
            datos.append([
                id_op_terrestre, id_operacion, codigo, id_vehiculo,
                id_ruta_terrestre, id_conductor, costo
            ])
        
        return self.guardar_csv(
            '24_operacion_terrestre.csv',
            datos,
            ['id_operacion_terrestre', 'id_operacion', 'codigo', 'id_vehiculo',
             'id_ruta_terrestre', 'id_conductor', 'costo_operacion_terrestre']
        )
    
    def generar_checklist_despacho(self):
        print(f"\nGenerando Checklists de Despacho...")
        datos = []
        codigos_usados = set()
        
        estados_check = ['OK', 'Regular', 'Deficiente']
        
        for id_op_terrestre in self.ids['operacion_terrestre']:
            id_checklist = str(uuid.uuid4())
            
            while True:
                codigo = f"CHK-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            observaciones = fake.sentence(nb_words=8) if random.random() > 0.5 else ''
            combustible = random.choice(estados_check)
            frenos = random.choice(estados_check)
            
            datos.append([
                id_checklist, codigo, observaciones, combustible,
                frenos, id_op_terrestre
            ])
        
        return self.guardar_csv(
            '25_checklist_despacho.csv',
            datos,
            ['id_checklist', 'codigo', 'observaciones', 'combustible',
             'frenos', 'id_operacion_terrestre']
        )
    
    def generar_incidencias(self, cantidad=40):
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
            fecha_hora = fake.date_time_between(start_date='-3m', end_date='now')
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
            '26_incidencia.csv',
            datos,
            ['id_incidencia', 'codigo', 'id_tipo_incidencia', 'descripcion',
             'grado_severidad', 'fecha_hora', 'id_estado_incidencia',
             'id_operacion', 'id_usuario']
        )
    
    def generar_documentacion_operacion(self, cantidad=100):
        print(f"\nGenerando {cantidad} Documentos...")
        datos = []
        self.ids['documento'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_documento = str(uuid.uuid4())
            
            while True:
                codigo = f"DOC-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = f"Documento_{fake.word()}_{random.randint(100, 999)}.pdf"
            
            fecha_emision = fake.date_between(start_date='-1y', end_date='today')
            ruta_archivo = f"/documentos/{fecha_emision.year}/{nombre}"
            
            id_tipo = random.choice(self.ids['tipo_documento'])
            
            self.ids['documento'].append(id_documento)
            datos.append([
                id_documento, codigo, nombre, ruta_archivo,
                fecha_emision.strftime('%Y-%m-%d'), id_tipo
            ])
        
        return self.guardar_csv(
            '27_documentacion_operacion.csv',
            datos,
            ['id_documento', 'codigo', 'nombre', 'ruta_archivo',
            'fecha_emision', 'id_tipo_documento']
        )
    
    def generar_operacion_documento(self):
        print(f"\nGenerando Relación Operación-Documento...")
        datos = []
        registros_unicos = set()
        
        for id_operacion in self.ids['operacion']:
            num_docs = random.randint(1, 4)
            documentos = random.sample(self.ids['documento'], 
                                      min(num_docs, len(self.ids['documento'])))
            
            for id_documento in documentos:
                clave = (id_operacion, id_documento)
                if clave not in registros_unicos:
                    datos.append([id_operacion, id_documento])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '28_operacion_documento.csv',
            datos,
            ['id_operacion', 'id_documento']
        )
    
    def generar_reporte_transporte(self):
        print(f"\nGenerando Reportes de Transporte...")
        datos = []
        codigos_usados = set()
        
        for id_op_terrestre in self.ids['operacion_terrestre']:
            id_reporte = str(uuid.uuid4())
            
            while True:
                codigo = f"REP-{fake.random_number(digits=8):08d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_tipo = random.choice(self.ids['tipo_reporte'])
            fecha_generado = fake.date_between(start_date='-3m', end_date='today')
            
            datos.append([
                id_reporte, codigo, id_tipo,
                fecha_generado.strftime('%Y-%m-%d'), id_op_terrestre
            ])
        
        return self.guardar_csv(
            '29_reporte_transporte.csv',
            datos,
            ['id_reporte', 'codigo', 'id_tipo_reporte',
             'fecha_generado', 'id_operacion_terrestre']
        )
    
    # ============================================
    # MÉTODO PRINCIPAL
    # ============================================
    
    def generar_todo(self):
        print("\n" + "="*60)
        print("GENERANDO ARCHIVOS CSV - OPERACIONES TERRESTRES")
        print("="*60)
        
        # Catálogos
        self.generar_estado_operacion()
        self.generar_tipo_activo()
        self.generar_estado_activo()
        self.generar_tipo_vehiculo()
        self.generar_estado_vehiculo()
        self.generar_especialidad_empleado()
        self.generar_estado_contrato()
        self.generar_tipo_telefono()
        self.generar_tipo_incidencia()
        self.generar_estado_incidencia()
        self.generar_tipo_documento()
        self.generar_tipo_reporte()
        self.generar_rol_usuario()
        
        # Tablas principales
        self.generar_contratos(100)
        self.generar_empleados(70)
        self.generar_empleado_telefonos()
        self.generar_usuarios()
        self.generar_operaciones(80)
        self.generar_rutas(30)
        self.generar_rutas_terrestres()
        self.generar_activos(60)
        self.generar_vehiculos()
        self.generar_conductores()
        self.generar_operaciones_terrestres()
        self.generar_checklist_despacho()
        self.generar_incidencias(40)
        self.generar_documentacion_operacion(100)
        self.generar_operacion_documento()
        self.generar_reporte_transporte()
        
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
    ║   GENERADOR DE CSV - OPERACIONES TERRESTRES                ║
    ║   Datos falsos con Faker para PostgreSQL                   ║
    ╚════════════════════════════════════════════════════════════╝
    """)
    
    generador = GeneradorCSVTerrestres()
    generador.generar_todo()
    
    print("\nPRÓXIMO PASO:")
    print("   Importa los archivos CSV en pgAdmin en el orden numérico")