import csv
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

# Configuración
fake = Faker('es_ES')
OUTPUT_DIR = 'datos_csv_modulo_1'

# Crear directorio de salida
if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)
    print(f"Directorio '{OUTPUT_DIR}' creado")


class GeneradorCSVReservas:
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
    # TABLAS DE CATÁLOGO (LOOKUP)
    # ============================================
    
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
            '01_tipo_telefono.csv',
            datos,
            ['id_tipo_telefono', 'nombre']
        )
    
    def generar_especialidad_empleado(self):
        print("\nGenerando EspecialidadEmpleado...")
        especialidades = [
            'Agente de Reservas', 
            'Supervisor de Operaciones',
            'Coordinador Logístico',
            'Gestor de Clientes',
            'Analista de Rutas'
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
            '03_estado_contrato.csv',
            datos,
            ['id_estado_contrato', 'nombre']
        )
    
    def generar_estado_contenedor(self):
        print("\nGenerando EstadoContenedor...")
        estados = ['Disponible', 'Reservado', 'En Tránsito', 'En Mantenimiento', 'Fuera de Servicio']
        datos = []
        self.ids['estado_contenedor'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_contenedor'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '04_estado_contenedor.csv',
            datos,
            ['id_estado_contenedor', 'nombre']
        )
    
    def generar_tipo_contenedor(self):
        print("\nGenerando TipoContenedor...")
        tipos = [
            ('DRY-20', 'Contenedor Seco 20 pies', 2500.00),
            ('DRY-40', 'Contenedor Seco 40 pies', 3500.00),
            ('REF-20', 'Refrigerado 20 pies', 4500.00),
            ('REF-40', 'Refrigerado 40 pies', 6500.00),
            ('TANK-20', 'Tanque 20 pies', 5500.00),
            ('OT-40', 'Open Top 40 pies', 4000.00),
            ('HC-40', 'High Cube 40 pies', 3800.00)
        ]
        datos = []
        self.ids['tipo_contenedor'] = []
        
        for codigo, nombre, costo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_contenedor'].append(id_tipo)
            datos.append([id_tipo, codigo, nombre, costo])
        
        return self.guardar_csv(
            '05_tipo_contenedor.csv',
            datos,
            ['id_tipo_contenedor', 'codigo', 'nombre', 'costo']
        )
    
    def generar_estado_embarcacion(self):
        print("\nGenerando EstadoEmbarcacion...")
        estados = ['Operativo', 'En Mantenimiento', 'En Reparación', 'Fuera de Servicio', 'En Inspección']
        datos = []
        self.ids['estado_embarcacion'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_embarcacion'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '06_estado_embarcacion.csv',
            datos,
            ['id_estado_embarcacion', 'nombre']
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
            '07_estado_operacion.csv',
            datos,
            ['id_estado_operacion', 'nombre']
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
            '08_estado_reserva.csv',
            datos,
            ['id_estado_reserva', 'nombre']
        )
    
    # ============================================
    # TABLAS PRINCIPALES
    # ============================================
    
    def generar_contratos(self, cantidad=120):
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
            '09_contrato.csv',
            datos,
            ['id_contrato', 'fecha_emision', 'fecha_vencimiento', 'id_estado_contrato']
        )
    
    def generar_empleados(self, cantidad=80):
        print(f"\nGenerando {cantidad} Empleados...")
        datos = []
        self.ids['empleado'] = []
        dnis_usados = set()
        codigos_usados = set()
        
        # Preparar lista de contratos únicos
        contratos_disponibles = self.ids['contrato'].copy()
        random.shuffle(contratos_disponibles)
        
        for i in range(cantidad):
            id_empleado = str(uuid.uuid4())
            
            # Código único
            while True:
                codigo = f"EMP-{fake.random_number(digits=5):05d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            # DNI único de 8 dígitos
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
            '10_empleado.csv',
            datos,
            ['id_empleado', 'codigo', 'dni', 'nombre', 'apellido', 'direccion',
             'id_especialidad', 'id_contrato']
        )
    
    def generar_empleado_telefonos(self):
        print(f"\nGenerando Teléfonos de Empleados...")
        datos = []
        telefonos_usados = set()
        
        for id_empleado in self.ids['empleado']:
            num_telefonos = random.randint(1, 2)
            for _ in range(num_telefonos):
                id_tel = str(uuid.uuid4())
                
                # Generar teléfono solo con dígitos (7-15 dígitos)
                while True:
                    longitud = random.randint(7, 15)
                    telefono = ''.join([str(random.randint(0, 9)) for _ in range(longitud)])
                    
                    if telefono[0] != '0' and (id_empleado, telefono) not in telefonos_usados:
                        telefonos_usados.add((id_empleado, telefono))
                        break
                
                id_tipo_tel = random.choice(self.ids['tipo_telefono'])
                datos.append([id_tel, id_empleado, telefono, id_tipo_tel])
        
        return self.guardar_csv(
            '11_empleado_telefono.csv',
            datos,
            ['id_empleado_telefono', 'id_empleado', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_agentes_reservas(self):
        print(f"\nGenerando Agentes de Reservas...")
        datos = []
        self.ids['agente_reservas'] = []
        
        # Seleccionar 30-40% de empleados como agentes
        cantidad_agentes = int(len(self.ids['empleado']) * 0.35)
        empleados_agentes = random.sample(self.ids['empleado'], cantidad_agentes)
        
        for id_empleado in empleados_agentes:
            id_agente = str(uuid.uuid4())
            self.ids['agente_reservas'].append(id_agente)
            datos.append([id_agente, id_empleado])
        
        return self.guardar_csv(
            '12_agente_reservas.csv',
            datos,
            ['id_agente_reservas', 'id_empleado']
        )
    
    def generar_clientes(self, cantidad=50):
        print(f"\nGenerando {cantidad} Clientes...")
        datos = []
        self.ids['cliente'] = []
        self.ids['cliente_ruc'] = []
        rucs_usados = set()
        
        for i in range(cantidad):
            id_cliente = str(uuid.uuid4())
            
            # RUC único de 11 dígitos
            while True:
                ruc = f"{random.randint(10000000000, 99999999999)}"
                if ruc not in rucs_usados:
                    rucs_usados.add(ruc)
                    break
            
            razon_social = fake.company()
            direccion = fake.address().replace('\n', ', ')
            email = fake.email() if random.random() > 0.2 else ''  # 80% tiene email
            
            self.ids['cliente'].append(id_cliente)
            self.ids['cliente_ruc'].append(ruc)
            datos.append([id_cliente, ruc, razon_social, direccion, email])
        
        return self.guardar_csv(
            '13_cliente.csv',
            datos,
            ['id_cliente', 'ruc', 'razon_social', 'direccion', 'email']
        )
    
    def generar_cliente_telefonos(self):
        print(f"\nGenerando Teléfonos de Clientes...")
        datos = []
        telefonos_usados = set()
        
        for id_cliente in self.ids['cliente']:
            num_telefonos = random.randint(1, 3)
            for _ in range(num_telefonos):
                id_tel = str(uuid.uuid4())
                
                # Generar teléfono solo con dígitos
                while True:
                    longitud = random.randint(7, 15)
                    telefono = ''.join([str(random.randint(0, 9)) for _ in range(longitud)])
                    
                    if telefono[0] != '0' and (id_cliente, telefono) not in telefonos_usados:
                        telefonos_usados.add((id_cliente, telefono))
                        break
                
                id_tipo_tel = random.choice(self.ids['tipo_telefono'])
                datos.append([id_tel, id_cliente, telefono, id_tipo_tel])
        
        return self.guardar_csv(
            '14_cliente_telefono.csv',
            datos,
            ['id_cliente_telefono', 'id_cliente', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_atencion_cliente(self):
        print(f"\nGenerando Atenciones a Clientes...")
        datos = []
        
        for id_cliente in self.ids['cliente']:
            # Cada cliente tiene entre 1-5 atenciones
            num_atenciones = random.randint(1, 5)
            for _ in range(num_atenciones):
                id_atencion = str(uuid.uuid4())
                id_agente = random.choice(self.ids['agente_reservas'])
                fecha_atencion = fake.date_time_between(start_date='-1y', end_date='now')
                
                datos.append([
                    id_atencion, id_cliente, id_agente,
                    fecha_atencion.strftime('%Y-%m-%d %H:%M:%S')
                ])
        
        return self.guardar_csv(
            '15_atencion_cliente.csv',
            datos,
            ['id_atencion_cliente', 'id_cliente', 'id_agente_reservas', 'fecha_atencion']
        )
    
    def generar_contenedores(self, cantidad=150):
        """Contenedor"""
        print(f"\n📋 Generando {cantidad} Contenedores...")
        datos = []
        self.ids['contenedor'] = []
        codigos_usados = set()
        
        dimensiones_por_tipo = {
            'DRY-20': '20x8x8.5',
            'DRY-40': '40x8x8.5',
            'REF-20': '20x8x8.5',
            'REF-40': '40x8x8.5',
            'TANK-20': '20x8x8.5',
            'OT-40': '40x8x9.5',
            'HC-40': '40x8x9.5'
        }
        
        for i in range(cantidad):
            id_contenedor = str(uuid.uuid4())
            
            while True:
                codigo = f"CONT-{fake.bothify(text='????####').upper()}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            id_tipo = random.choice(self.ids['tipo_contenedor'])
            capacidad = round(random.uniform(15000, 30000), 2)
            peso = round(random.uniform(1000, capacidad * 0.9), 2)  # peso < capacidad
            
            # Obtener dimensiones según tipo (simulado)
            dimensiones = random.choice(list(dimensiones_por_tipo.values()))
            
            id_estado = random.choice(self.ids['estado_contenedor'])
            
            self.ids['contenedor'].append(id_contenedor)
            datos.append([
                id_contenedor, codigo, peso, capacidad,
                dimensiones, id_estado, id_tipo
            ])
        
        return self.guardar_csv(
            '16_contenedor.csv',
            datos,
            ['id_contenedor', 'codigo', 'peso', 'capacidad', 'dimensiones',
             'id_estado_contenedor', 'id_tipo_contenedor']
        )
    
    def generar_contenedor_mercancias(self):
        """ContenedorMercancia"""
        print(f"\n📋 Generando Mercancías de Contenedores...")
        datos = []
        registros_unicos = set()
        
        tipos_mercancia = [
            'Electrónicos', 'Textiles', 'Alimentos Perecederos', 'Químicos',
            'Maquinaria', 'Automóviles', 'Materias Primas', 'Productos Farmacéuticos',
            'Madera', 'Papel', 'Plásticos', 'Metales', 'Granos', 'Frutas',
            'Bebidas', 'Equipos Industriales'
        ]
        
        for id_contenedor in self.ids['contenedor']:
            num_mercancias = random.randint(1, 2)
            mercancias = random.sample(tipos_mercancia, num_mercancias)
            
            for mercancia in mercancias:
                clave = (id_contenedor, mercancia)
                if clave not in registros_unicos:
                    id_cm = str(uuid.uuid4())
                    datos.append([id_cm, id_contenedor, mercancia])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '17_contenedor_mercancia.csv',
            datos,
            ['id_contenedor_mercancia', 'id_contenedor', 'tipo_mercancia']
        )
    
    def generar_buques(self, cantidad=25):
        print(f"\nGenerando {cantidad} Buques...")
        datos = []
        self.ids['buque'] = []
        self.ids['buque_matricula'] = []
        matriculas_usadas = set()
        
        for i in range(cantidad):
            id_buque = str(uuid.uuid4())
            
            while True:
                matricula = f"IMO-{random.randint(1000000, 9999999)}"
                if matricula not in matriculas_usadas:
                    matriculas_usadas.add(matricula)
                    break
            
            nombre = f"{fake.word().upper()} {random.choice(['STAR', 'OCEAN', 'PACIFIC', 'ATLANTIC', 'CARRIER'])}"
            ubicacion_actual = fake.country()
            capacidad = random.randint(5000, 20000)
            peso = round(random.uniform(10000, 100000), 2)
            id_estado = random.choice(self.ids['estado_embarcacion'])
            
            self.ids['buque'].append(id_buque)
            self.ids['buque_matricula'].append(matricula)
            datos.append([id_buque, matricula, nombre, capacidad, id_estado, peso, ubicacion_actual])
        
        return self.guardar_csv(
            '18_buque.csv',
            datos,
            ['id_buque', 'matricula', 'nombre', 'capacidad',
              'id_estado_embarcacion', 'peso', 'ubicacion_actual']
        )
    
    def generar_certificaciones(self, cantidad=15):
        print(f"\nGenerando {cantidad} Certificaciones...")
        datos = []
        self.ids['certificacion'] = []
        
        tipos_cert = [
            'ISO 9001', 'ISO 14001', 'ISPS Code', 'ISM Code',
            'SOLAS', 'MARPOL', 'MLC 2006', 'IMDG Code',
            'Certificado de Arqueo', 'Certificado de Seguridad',
            'Certificado de Prevención', 'Certificado Radio',
            'Certificado Casco', 'Certificado Navegabilidad',
            'Certificado Ambiental'
        ]
        
        for i in range(cantidad):
            id_cert = str(uuid.uuid4())
            nombre = tipos_cert[i] if i < len(tipos_cert) else f"Certificación {fake.word().upper()}"
            descripcion = fake.sentence(nb_words=10)
            
            self.ids['certificacion'].append(id_cert)
            datos.append([id_cert, nombre, descripcion])
        
        return self.guardar_csv(
            '19_certificacion.csv',
            datos,
            ['id_certificacion', 'nombre', 'descripcion']
        )
    
    def generar_certificacion_buques(self):
        print(f"\nGenerando Certificaciones de Buques...")
        datos = []
        registros_unicos = set()
        
        for id_buque in self.ids['buque']:
            num_certs = random.randint(3, 6)
            certificaciones = random.sample(self.ids['certificacion'], 
                                           min(num_certs, len(self.ids['certificacion'])))
            
            for id_cert in certificaciones:
                clave = (id_buque, id_cert)
                if clave not in registros_unicos:
                    id_cb = str(uuid.uuid4())
                    fecha_emision = fake.date_between(start_date='-3y', end_date='-6m')
                    fecha_vencimiento = fake.date_between(start_date=fecha_emision, end_date='+3y')
                    
                    datos.append([
                        id_cb, id_buque, id_cert,
                        fecha_emision.strftime('%Y-%m-%d'),
                        fecha_vencimiento.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '20_certificacion_buque.csv',
            datos,
            ['id_certificacion_buque', 'id_buque', 'id_certificacion',
             'fecha_emision', 'fecha_vencimiento']
        )
    
    def generar_rutas(self, cantidad=25):
        print(f"\nGenerando {cantidad} Rutas...")
        datos = []
        self.ids['ruta'] = []
        codigos_usados = set()
        
        ciudades = [
            'Lima', 'Callao', 'Paita', 'Iquitos', 'Pucallpa',
            'Buenos Aires', 'Valparaíso', 'Santos', 'Cartagena', 'Guayaquil',
            'Los Angeles', 'Shanghai', 'Rotterdam', 'Singapur', 'Hong Kong'
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
            duracion = random.randint(24, 720)  # horas
            tarifa = round(random.uniform(5000, 80000), 2)
            
            self.ids['ruta'].append(id_ruta)
            datos.append([id_ruta, codigo, origen, destino, duracion, tarifa])
        
        return self.guardar_csv(
            '21_ruta.csv',
            datos,
            ['id_ruta', 'codigo', 'origen', 'destino', 'duracion', 'tarifa']
        )
    
    def generar_operaciones(self, cantidad=100):
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
                fecha_fin = fecha_inicio + timedelta(hours=random.randint(4, 168))
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
            '22_operacion.csv',
            datos,
            ['id_operacion', 'codigo', 'fecha_inicio', 'fecha_fin', 'id_estado_operacion']
        )
    
    def generar_operaciones_terrestres(self):
        print(f"\nGenerando Operaciones Terrestres...")
        datos = []
        self.ids['operacion_terrestre'] = []
        codigos_usados = set()
        
        cantidad = int(len(self.ids['operacion']) * 0.4)
        operaciones_terrestres = random.sample(self.ids['operacion'], cantidad)
        
        for id_operacion in operaciones_terrestres:
            id_op_terrestre = str(uuid.uuid4())
            
            while True:
                codigo = f"OT-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            costo = round(random.uniform(500, 15000), 2)
            
            self.ids['operacion_terrestre'].append(id_op_terrestre)
            datos.append([id_op_terrestre, id_operacion, codigo, costo])
        
        return self.guardar_csv(
            '23_operacion_terrestre.csv',
            datos,
            ['id_operacion_terrestre', 'id_operacion', 'codigo', 'costo_operacion_terrestre']
        )
    
    def generar_operaciones_maritimas(self):
        print(f"\nGenerando Operaciones Maritimas...")
        datos = []
        self.ids['operacion_maritima'] = []
        codigos_usados = set()
        
        # Operaciones que no son terrestres
        operaciones_restantes = [op for op in self.ids['operacion'] 
                                if op not in [ot[1] for ot in self.ids['operacion_terrestre']]]
        
        for id_operacion in operaciones_restantes:
            id_op_maritima = str(uuid.uuid4())
            
            while True:
                codigo = f"OM-{fake.random_number(digits=7):07d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            cantidad_contenedores = random.randint(1, 10)
            porcentaje_trayecto = random.randint(10, 100)
            id_buque = random.choice(self.ids['buque'])
            
            self.ids['operacion_maritima'].append(id_op_maritima)
            datos.append([id_op_maritima, id_operacion, codigo, cantidad_contenedores, porcentaje_trayecto, id_buque])
        
        return self.guardar_csv(
            '24_operacion_maritima.csv',
            datos,
            ['id_operacion_maritima', 'id_operacion',
            'codigo', 'cantidad_contenedores', 'porcentaje_trayecto', 'id_buque']
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
            
            fecha_registro = fake.date_between(start_date='-6m', end_date='today')
            id_estado = random.choice(self.ids['estado_reserva'])
            pago_total = round(random.uniform(5000, 100000), 2) if random.random() > 0.1 else ''
            ruc_cliente = random.choice(self.ids['cliente_ruc'])
            id_agente = random.choice(self.ids['agente_reservas'])
            matricula_buque = random.choice(self.ids['buque_matricula'])
            id_ruta = random.choice(self.ids['ruta'])
            
            self.ids['reserva'].append(id_reserva)
            datos.append([
                id_reserva, codigo, fecha_registro.strftime('%Y-%m-%d'),
                id_estado, pago_total, ruc_cliente, id_agente,
                matricula_buque, id_ruta
            ])
        
        return self.guardar_csv(
            '25_reserva.csv',
            datos,
            ['id_reserva', 'codigo', 'fecha_registro', 'id_estado_reserva',
             'pago_total', 'ruc_cliente', 'id_agente_reservas', 'matricula_buque', 'id_ruta']
        )
    
    # ============================================
    # TABLAS ASOCIATIVAS
    # ============================================
    
    def generar_reserva_contenedores(self):
        print(f"\nGenerando Contenedores por Reserva...")
        datos = []
        registros_unicos = set()
        
        for id_reserva in self.ids['reserva']:
            num_contenedores = random.randint(1, 8)
            contenedores = random.sample(self.ids['contenedor'], 
                                        min(num_contenedores, len(self.ids['contenedor'])))
            
            for id_contenedor in contenedores:
                clave = (id_reserva, id_contenedor)
                if clave not in registros_unicos:
                    id_rc = str(uuid.uuid4())
                    fecha_asignacion = fake.date_between(start_date='-6m', end_date='today')
                    cantidad = random.randint(1, 5)
                    
                    datos.append([
                        id_rc, id_reserva, id_contenedor,
                        fecha_asignacion.strftime('%Y-%m-%d'), cantidad
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '26_reserva_contenedor.csv',
            datos,
            ['id_reserva_contenedor', 'id_reserva', 'id_contenedor',
             'fecha_asignacion', 'cantidad']
        )
    
    def generar_reserva_operacion_maritima(self):
        print(f"\nGenerando Operaciones Marítimas por Reserva...")
        datos = []
        registros_unicos = set()
        
        for id_reserva in self.ids['reserva']:
            num_ops = random.randint(1, 3)
            operaciones = random.sample(self.ids['operacion_maritima'], 
                                       min(num_ops, len(self.ids['operacion_maritima'])))
            
            for id_op_maritima in operaciones:
                clave = (id_reserva, id_op_maritima)
                if clave not in registros_unicos:
                    id_rom = str(uuid.uuid4())
                    fecha_vinculacion = fake.date_between(start_date='-6m', end_date='today')
                    
                    datos.append([
                        id_rom, id_reserva, id_op_maritima,
                        fecha_vinculacion.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '27_reserva_operacion_maritima.csv',
            datos,
            ['id_reserva_operacion_maritima', 'id_reserva', 'id_operacion_maritima',
             'fecha_vinculacion']
        )
    
    def generar_reserva_operacion_terrestre(self):
        print(f"\nGenerando Operaciones Terrestres por Reserva...")
        datos = []
        registros_unicos = set()
        
        for id_reserva in self.ids['reserva']:
            # No todas las reservas tienen operaciones terrestres
            if random.random() < 0.6:
                num_ops = random.randint(1, 2)
                operaciones = random.sample(self.ids['operacion_terrestre'], 
                                           min(num_ops, len(self.ids['operacion_terrestre'])))
                
                for id_op_terrestre in operaciones:
                    clave = (id_reserva, id_op_terrestre)
                    if clave not in registros_unicos:
                        id_rot = str(uuid.uuid4())
                        fecha_vinculacion = fake.date_between(start_date='-6m', end_date='today')
                        
                        datos.append([
                            id_rot, id_reserva, id_op_terrestre,
                            fecha_vinculacion.strftime('%Y-%m-%d')
                        ])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '28_reserva_operacion_terrestre.csv',
            datos,
            ['id_reserva_operacion_terrestre', 'id_reserva', 'id_operacion_terrestre',
             'fecha_vinculacion']
        )
    
    # ============================================
    # MÉTODO PRINCIPAL
    # ============================================
    
    def generar_todo(self):
        print("\n" + "="*60)
        print("GENERANDO ARCHIVOS CSV - GESTIÓN DE RESERVAS")
        print("="*60)
        
        # Catálogos
        self.generar_tipo_telefono()
        self.generar_especialidad_empleado()
        self.generar_estado_contrato()
        self.generar_estado_contenedor()
        self.generar_tipo_contenedor()
        self.generar_estado_embarcacion()
        self.generar_estado_operacion()
        self.generar_estado_reserva()
        
        # Tablas principales
        self.generar_contratos(120)
        self.generar_empleados(80)
        self.generar_empleado_telefonos()
        self.generar_agentes_reservas()
        self.generar_clientes(50)
        self.generar_cliente_telefonos()
        self.generar_atencion_cliente()
        self.generar_contenedores(150)
        self.generar_contenedor_mercancias()
        self.generar_buques(20)
        self.generar_certificaciones(15)
        self.generar_certificacion_buques()
        self.generar_rutas(25)
        self.generar_operaciones(100)
        self.generar_operaciones_terrestres()
        self.generar_operaciones_maritimas()
        self.generar_reservas(80)
        
        # Tablas asociativas
        self.generar_reserva_contenedores()
        self.generar_reserva_operacion_maritima()
        self.generar_reserva_operacion_terrestre()
        
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
    ║   GENERADOR DE CSV - GESTIÓN DE RESERVAS                   ║
    ║   Datos falsos con Faker para PostgreSQL                   ║
    ╚════════════════════════════════════════════════════════════╝
    """)
    
    generador = GeneradorCSVReservas()
    generador.generar_todo()
    
    print("\nPRÓXIMO PASO:")
    print("   Importa los archivos CSV en pgAdmin en el orden numérico")