import csv
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

# Configuración
fake = Faker('es_ES')
OUTPUT_DIR = 'datos_csv_modulo_3'

# Crear directorio de salida
if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)
    print(f"Directorio '{OUTPUT_DIR}' creado")


class GeneradorCSVMaritima:
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
    # TABLAS DE CATÁLOGO
    # ============================================
    
    def generar_estado_operacion(self):
        print("\nGenerando EstadoOperacion...")
        estados = ['En Planificación', 'En Progreso', 'Completada', 'Cancelada', 'En Espera']
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
    
    def generar_estatus_navegacion(self):
        print("\nGenerando EstatusNavegacion...")
        estatus = ['En Puerto', 'Navegando', 'Llegando', 'Atracado']
        datos = []
        self.ids['estatus_navegacion'] = []
        
        for est in estatus:
            id_estatus = str(uuid.uuid4())
            self.ids['estatus_navegacion'].append(id_estatus)
            datos.append([id_estatus, est])
        
        return self.guardar_csv(
            '02_estatus_navegacion.csv',
            datos,
            ['id_estatus_navegacion', 'nombre']
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
            '03_estado_embarcacion.csv',
            datos,
            ['id_estado_embarcacion', 'nombre']
        )
    
    def generar_estado_contenedor(self):
        print("\nGenerando EstadoContenedor...")
        estados = ['Disponible', 'En Uso', 'En Tránsito', 'En Mantenimiento', 'Dañado']
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
            ('DRY-20', 'Contenedor Seco 20 pies', 2000.00),
            ('DRY-40', 'Contenedor Seco 40 pies', 3000.00),
            ('REF-20', 'Refrigerado 20 pies', 4000.00),
            ('REF-40', 'Refrigerado 40 pies', 6000.00),
            ('TANK-20', 'Tanque 20 pies', 5000.00),
            ('OT-40', 'Open Top 40 pies', 3500.00)
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
    
    def generar_tipo_equipo_portuario(self):
        print("\nGenerando TipoEquipoPortuario...")
        tipos = ['Grúa Pórtico', 'Montacargas', 'Reach Stacker', 'Tractor Terminal', 'Grúa Móvil']
        datos = []
        self.ids['tipo_equipo_portuario'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_equipo_portuario'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '06_tipo_equipo_portuario.csv',
            datos,
            ['id_tipo_equipo_portuario', 'nombre']
        )
    
    def generar_estado_equipo_portuario(self):
        print("\nGenerando EstadoEquipoPortuario...")
        estados = ['Operativo', 'En Mantenimiento', 'Averiado', 'Reservado', 'Fuera de Servicio']
        datos = []
        self.ids['estado_equipo_portuario'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_equipo_portuario'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '07_estado_equipo_portuario.csv',
            datos,
            ['id_estado_equipo_portuario', 'nombre']
        )
    
    def generar_estado_inspeccion(self):
        print("\nGenerando EstadoInspeccion...")
        estados = ['Programada', 'En Curso', 'Completada', 'Cancelada', 'Observada']
        datos = []
        self.ids['estado_inspeccion'] = []
        
        for estado in estados:
            id_estado = str(uuid.uuid4())
            self.ids['estado_inspeccion'].append(id_estado)
            datos.append([id_estado, estado])
        
        return self.guardar_csv(
            '08_estado_inspeccion.csv',
            datos,
            ['id_estado_inspeccion', 'nombre']
        )
    
    def generar_tipo_inspeccion(self):
        print("\nGenerando TipoInspeccion...")
        tipos = ['Seguridad', 'Ambiental', 'Estructural', 'Sanitaria', 'Certificación']
        datos = []
        self.ids['tipo_inspeccion'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_inspeccion'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '09_tipo_inspeccion.csv',
            datos,
            ['id_tipo_inspeccion', 'nombre']
        )
    
    def generar_tipo_hallazgo(self):
        print("\nGenerando TipoHallazgo...")
        tipos = ['Menor', 'Mayor', 'Crítico', 'Observación', 'Recomendación']
        datos = []
        self.ids['tipo_hallazgo'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_hallazgo'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '10_tipo_hallazgo.csv',
            datos,
            ['id_tipo_hallazgo', 'nombre']
        )
    
    def generar_tipo_operacion_portuaria(self):
        print("\nGenerando TipoOperacionPortuaria...")
        tipos = ['Carga', 'Descarga', 'Transbordo', 'Almacenamiento', 'Inspección']
        datos = []
        self.ids['tipo_operacion_portuaria'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_operacion_portuaria'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '11_tipo_operacion_portuaria.csv',
            datos,
            ['id_tipo_operacion_portuaria', 'nombre']
        )
    
    def generar_turno(self):
        print("\nGenerando Turno...")
        turnos = ['Mañana', 'Tarde', 'Noche', 'Madrugada']
        datos = []
        self.ids['turno'] = []
        
        for turno in turnos:
            id_turno = str(uuid.uuid4())
            self.ids['turno'].append(id_turno)
            datos.append([id_turno, turno])
        
        return self.guardar_csv(
            '12_turno.csv',
            datos,
            ['id_turno', 'nombre']
        )
    
    def generar_equipo_proteccion(self):
        print("\nGenerando EquipoProteccion...")
        equipos = ['Casco', 'Chaleco Reflectante', 'Botas de Seguridad', 'Guantes', 'Gafas de Seguridad', 'Arnés']
        datos = []
        self.ids['equipo_proteccion'] = []
        
        for equipo in equipos:
            id_equipo = str(uuid.uuid4())
            self.ids['equipo_proteccion'].append(id_equipo)
            datos.append([id_equipo, equipo])
        
        return self.guardar_csv(
            '13_equipo_proteccion.csv',
            datos,
            ['id_equipo_proteccion', 'nombre']
        )
    
    def generar_condicion_operativa(self):
        print("\nGenerando CondicionOperativa...")
        condiciones = ['Condiciones Normales', 'Lluvia', 'Niebla Densa', 'Viento Fuerte', 'Mar Agitado']
        datos = []
        self.ids['condicion_operativa'] = []
        
        for cond in condiciones:
            id_cond = str(uuid.uuid4())
            self.ids['condicion_operativa'].append(id_cond)
            datos.append([id_cond, cond])
        
        return self.guardar_csv(
            '14_condicion_operativa.csv',
            datos,
            ['id_condicion_operativa', 'nombre']
        )
    
    def generar_prioridad(self):
        print("\nGenerando Prioridad...")
        prioridades = ['Baja', 'Media', 'Alta', 'Urgente', 'Crítica']
        datos = []
        self.ids['prioridad'] = []
        
        for prio in prioridades:
            id_prio = str(uuid.uuid4())
            self.ids['prioridad'].append(id_prio)
            datos.append([id_prio, prio])
        
        return self.guardar_csv(
            '15_prioridad.csv',
            datos,
            ['id_prioridad', 'nombre']
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
            '16_estado_contrato.csv',
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
            '17_tipo_telefono.csv',
            datos,
            ['id_tipo_telefono', 'nombre']
        )
    
    def generar_rol_usuario(self):
        print("\nGenerando RolUsuario...")
        roles = ['Administrador', 'Supervisor', 'Operador', 'Inspector', 'Trabajador']
        datos = []
        self.ids['rol_usuario'] = []
        
        for rol in roles:
            id_rol = str(uuid.uuid4())
            self.ids['rol_usuario'].append(id_rol)
            datos.append([id_rol, rol])
        
        return self.guardar_csv(
            '18_rol_usuario.csv',
            datos,
            ['id_rol_usuario', 'nombre']
        )
    
    def generar_especialidad_empleado(self):
        print("\nGenerando EspecialidadEmpleado...")
        especialidades = ['Capitán', 'Oficial de Cubierta', 'Ingeniero Marino', 'Operador Portuario', 
                         'Inspector', 'Trabajador Portuario']
        datos = []
        self.ids['especialidad_empleado'] = []
        
        for esp in especialidades:
            id_esp = str(uuid.uuid4())
            self.ids['especialidad_empleado'].append(id_esp)
            datos.append([id_esp, esp])
        
        return self.guardar_csv(
            '19_especialidad_empleado.csv',
            datos,
            ['id_especialidad_empleado', 'nombre']
        )
    
    def generar_tipo_incidencia(self):
        print("\nGenerando TipoIncidencia...")
        tipos = ['Accidente', 'Avería', 'Retraso', 'Daño a Carga', 'Incumplimiento', 'Seguridad']
        datos = []
        self.ids['tipo_incidencia'] = []
        
        for tipo in tipos:
            id_tipo = str(uuid.uuid4())
            self.ids['tipo_incidencia'].append(id_tipo)
            datos.append([id_tipo, tipo])
        
        return self.guardar_csv(
            '20_tipo_incidencia.csv',
            datos,
            ['id_tipo_incidencia', 'nombre']
        )
    
    # ============================================
    # TABLAS PRINCIPALES
    # ============================================
    
    def generar_puertos(self, cantidad=15):
        print(f"\nGenerando {cantidad} Puertos...")
        datos = []
        self.ids['puerto'] = []
        codigos_usados = set()
        
        puertos_reales = [
            ('PECLL', 'Puerto del Callao', 'Perú'),
            ('CLSAI', 'Puerto San Antonio', 'Chile'),
            ('BRSUA', 'Puerto Santos', 'Brasil'),
            ('COPBL', 'Puerto Buenaventura', 'Colombia'),
            ('ECLGQ', 'Puerto Guayaquil', 'Ecuador'),
        ]
        
        for i in range(cantidad):
            id_puerto = str(uuid.uuid4())
            
            if i < len(puertos_reales):
                codigo, nombre, pais = puertos_reales[i]
            else:
                while True:
                    codigo = fake.bothify(text='??###').upper()
                    if codigo not in codigos_usados:
                        codigos_usados.add(codigo)
                        break
                nombre = f"Puerto {fake.city()}"
                pais = fake.country()
            
            direccion = fake.address().replace('\n', ', ')
            
            self.ids['puerto'].append(id_puerto)
            datos.append([id_puerto, codigo, nombre, pais, direccion])
        
        return self.guardar_csv(
            '21_puerto.csv',
            datos,
            ['id_puerto', 'codigo', 'nombre', 'pais', 'direccion']
        )
    
    def generar_muelles(self, cantidad=30):
        print(f"\nGenerando {cantidad} Muelles...")
        datos = []
        self.ids['muelle'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_muelle = str(uuid.uuid4())
            
            while True:
                codigo = f"MU-{fake.random_number(digits=4):04d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            ubicacion = f"Zona {chr(65 + random.randint(0, 5))}, Sector {random.randint(1, 10)}"
            capacidad = random.randint(2, 10)
            disponibilidad = random.choice([True, True, True, False])  # 75% disponible
            id_puerto = random.choice(self.ids['puerto'])
            
            self.ids['muelle'].append(id_muelle)
            datos.append([id_muelle, codigo, ubicacion, capacidad, disponibilidad, id_puerto])
        
        return self.guardar_csv(
            '22_muelle.csv',
            datos,
            ['id_muelle', 'codigo', 'ubicacion', 'capacidad', 'disponibilidad', 'id_puerto']
        )
    
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
            '23_contrato.csv',
            datos,
            ['id_contrato', 'fecha_emision', 'fecha_vencimiento', 'id_estado_contrato']
        )
    
    def generar_empleados(self, cantidad=100):
        print(f"\nGenerando {cantidad} Empleados...")
        datos = []
        self.ids['empleado'] = []
        dnis_usados = set()
        
        # IMPORTANTE: Crear más contratos que empleados para evitar quedarse sin contratos
        if len(self.ids['contrato']) < cantidad:
            print(f"Advertencia: Se necesitan al menos {cantidad} contratos. Generando más...")
            contratos_adicionales = cantidad - len(self.ids['contrato']) + 10
            for _ in range(contratos_adicionales):
                id_contrato = str(uuid.uuid4())
                fecha_emision = fake.date_between(start_date='-2y', end_date='today')
                fecha_vencimiento = fake.date_between(start_date=fecha_emision, end_date='+2y')
                id_estado = random.choice(self.ids['estado_contrato'])
                self.ids['contrato'].append(id_contrato)
        
        # Crear una copia de la lista de contratos para ir sacando uno por uno
        contratos_disponibles = self.ids['contrato'].copy()
        random.shuffle(contratos_disponibles)  # Mezclar para aleatoriedad
        
        for i in range(cantidad):
            id_empleado = str(uuid.uuid4())
            codigo = f"EMP-{fake.unique.random_number(digits=6):06d}"
            
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
            '24_empleado.csv',
            datos,
            ['id_empleado', 'codigo', 'dni', 'nombre', 'apellido', 'direccion',
            'id_especialidad_empleado', 'id_contrato']
        )
    
    def generar_empleado_telefonos(self):
        print(f"\nGenerando Teléfonos de Empleados...")
        datos = []
        telefonos_usados = set()
        
        for id_empleado in self.ids['empleado']:
            num_telefonos = random.randint(1, 3)
            for _ in range(num_telefonos):
                id_tel = str(uuid.uuid4())
                
                while True:
                    # Generar número aleatorio entre 7 y 15 dígitos
                    longitud = random.randint(7, 15)
                    telefono = ''.join([str(random.randint(0, 9)) for _ in range(longitud)])
                    
                    # Asegurar que no empiece con 0 y sea único
                    if telefono[0] != '0' and (id_empleado, telefono) not in telefonos_usados:
                        telefonos_usados.add((id_empleado, telefono))
                        break
                
                id_tipo_tel = random.choice(self.ids['tipo_telefono'])
                
                datos.append([id_tel, id_empleado, telefono, id_tipo_tel])
        
        return self.guardar_csv(
            '25_empleado_telefono.csv',
            datos,
            ['id_empleado_telefono', 'id_empleado', 'telefono', 'id_tipo_telefono']
        )
    
    def generar_buques(self, cantidad=25):
        print(f"\nGenerando {cantidad} Buques...")
        datos = []
        self.ids['buque'] = []
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
            datos.append([id_buque, matricula, nombre, capacidad, id_estado, peso, ubicacion_actual])
        
        return self.guardar_csv(
            '26_buque.csv',
            datos,
            ['id_buque', 'matricula', 'nombre', 'capacidad', 'id_estado_embarcacion', 'peso', 'ubicacion_actual']
        )
    
    def generar_contenedores(self, cantidad=200):
        print(f"\nGenerando {cantidad} Contenedores...")
        datos = []
        self.ids['contenedor'] = []
        
        for i in range(cantidad):
            id_contenedor = str(uuid.uuid4())
            codigo = f"CONT-{fake.unique.bothify(text='????########').upper()}"
            peso = round(random.uniform(1000, 30000), 2)
            capacidad = round(random.uniform(20, 80), 2)
            dimensiones = f"{random.randint(2, 12)}x{random.randint(2, 3)}x{random.randint(2, 3)}"
            id_tipo = random.choice(self.ids['tipo_contenedor'])
            id_estado = random.choice(self.ids['estado_contenedor'])
            
            self.ids['contenedor'].append(id_contenedor)
            datos.append([id_contenedor, codigo, peso, capacidad, dimensiones, id_estado, id_tipo])
        
        return self.guardar_csv(
            '27_contenedor.csv',
            datos,
            ['id_contenedor', 'codigo', 'peso', 'capacidad', 'dimensiones', 'id_estado_contenedor', 'id_tipo_contenedor']
        )
    
    def generar_tripulantes(self, cantidad=80):
        print(f"\nGenerando {cantidad} Tripulantes...")
        datos = []
        self.ids['tripulante'] = []
        self.ids['tripulante_empleado'] = {}
        
        empleados_disponibles = random.sample(self.ids['empleado'], min(cantidad, len(self.ids['empleado'])))
        
        for id_empleado in empleados_disponibles:
            id_tripulante = str(uuid.uuid4())
            disponibilidad = random.choice([True, True, True, False])  # 75% disponible
            nacionalidad = fake.country()
            self.ids['tripulante'].append(id_tripulante)
            self.ids['tripulante_empleado'][id_tripulante] = id_empleado
            datos.append([
                id_tripulante, id_empleado, disponibilidad, nacionalidad
            ])
        
        return self.guardar_csv(
            '28_tripulante.csv',
            datos,
            ['id_tripulante', 'id_empleado', 'disponibilidad', 'nacionalidad']
        )
    
    def generar_trabajadores_portuarios(self, cantidad=60):
        print(f"\nGenerando {cantidad} Trabajadores Portuarios...")
        datos = []
        self.ids['trabajador_portuario'] = []
        self.ids['trabajador_empleado'] = {}
        
        # Asegurarse de no repetir empleados ya usados como tripulantes
        empleados_restantes = [e for e in self.ids['empleado'] 
                              if e not in self.ids['tripulante_empleado'].values()]
        empleados_disponibles = random.sample(empleados_restantes, 
                                              min(cantidad, len(empleados_restantes)))
        
        for id_empleado in empleados_disponibles:
            id_trabajador = str(uuid.uuid4())

            id_turno = random.choice(self.ids['turno'])
            disponibilidad = random.choice([True, True, True, False])  # 75% disponible
            self.ids['trabajador_portuario'].append(id_trabajador)
            self.ids['trabajador_empleado'][id_trabajador] = id_empleado
            datos.append([id_trabajador, id_empleado, disponibilidad, id_turno])
        
        return self.guardar_csv(
            '29_trabajador_portuario.csv',
            datos,
            ['id_trabajador_portuario', 'id_empleado', 'disponibilidad', 'id_turno']
        )
    
    def generar_equipos_portuarios(self, cantidad=40):
        print(f"\nGenerando {cantidad} Equipos Portuarios...")
        datos = []
        self.ids['equipo_portuario'] = []
        
        for i in range(cantidad):
            id_equipo = str(uuid.uuid4())
            codigo = f"EQ-{fake.unique.random_number(digits=6):06d}"
            capacidad = round(random.uniform(5, 50), 2)
            id_tipo = random.choice(self.ids['tipo_equipo_portuario'])
            id_estado = random.choice(self.ids['estado_equipo_portuario'])
            ubicacion = f"Zona {chr(65 + random.randint(0, 5))}, Sector {random.randint(1, 10)}"
            
            self.ids['equipo_portuario'].append(id_equipo)
            datos.append([id_equipo, codigo, capacidad, id_tipo, id_estado, ubicacion])
        
        return self.guardar_csv(
            '30_equipo_portuario.csv',
            datos,
            ['id_equipo_portuario', 'codigo', 'capacidad',
             'id_tipo_equipo_portuario', 'id_estado_equipo_portuario', 'ubicacion']
        )
    
    def generar_certificaciones(self, cantidad=20):
        print(f"\nGenerando {cantidad} Certificaciones...")
        datos = []
        self.ids['certificacion'] = []
        
        tipos_cert = [
            'ISO 9001', 'ISO 14001', 'ISPS Code', 'ISM Code', 
            'SOLAS', 'MARPOL', 'MLC 2006', 'IMDG Code',
            'Certificado de Seguridad', 'Certificado Ambiental'
        ]
        
        for i in range(cantidad):
            id_cert = str(uuid.uuid4())
            nombre = random.choice(tipos_cert) if i < len(tipos_cert) else f"Certificación {fake.word().upper()}"
            descripcion = fake.sentence(nb_words=10)
            
            self.ids['certificacion'].append(id_cert)
            datos.append([id_cert, nombre, descripcion])
        
        return self.guardar_csv(
            '31_certificacion.csv',
            datos,
            ['id_certificacion', 'nombre', 'descripcion']
        )
    
    def generar_certificaciones_aduaneras(self, cantidad=15):
        print(f"\nGenerando {cantidad} Certificaciones Aduaneras...")
        datos = []
        self.ids['certificacion_aduanera'] = []
        codigos_usados = set()
        
        tipos_cert_aduanera = [
            'DUA - Documento Único Aduanero',
            'Certificado de Origen',
            'Certificado Fitosanitario',
            'Certificado Zoosanitario',
            'Licencia de Importación',
            'Certificado de Conformidad',
            'Declaración de Valor en Aduana',
            'Certificado de Libre Venta',
            'Certificado CITES',
            'Manifiesto de Carga'
        ]
        
        # Usar subset de certificaciones existentes
        certificaciones_base = random.sample(
            self.ids['certificacion'],
            min(cantidad, len(self.ids['certificacion']))
        )
        
        for i, id_cert_base in enumerate(certificaciones_base):
            while True:
                codigo = f"ADU-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = tipos_cert_aduanera[i] if i < len(tipos_cert_aduanera) else f"Cert. Aduanera {fake.word().upper()}"
            descripcion = fake.sentence(nb_words=12)
            pais = fake.country()
            fecha_emision = fake.date_time_between(start_date='-1y', end_date='now')
            fecha_expiracion = fecha_emision + timedelta(days=random.randint(180, 1095))
            
            self.ids['certificacion_aduanera'].append(id_cert_base)
            datos.append([
                id_cert_base, codigo, nombre, descripcion, pais,
                fecha_emision.strftime('%Y-%m-%d %H:%M:%S%z'),
                fecha_expiracion.strftime('%Y-%m-%d %H:%M:%S%z')
            ])
        
        return self.guardar_csv(
            '53_certificacion_aduanera.csv',
            datos,
            ['id_certificacion_aduanera', 'codigo', 'nombre', 'descripcion',
            'pais_aplicacion', 'fecha_emision', 'fecha_expiracion']
        )
    
    def generar_rutas(self, cantidad=30):
        print(f"\nGenerando {cantidad} Rutas...")
        datos = []
        self.ids['ruta'] = []
        codigos_usados = set()
        
        for i in range(cantidad):
            id_ruta = str(uuid.uuid4())
            
            while True:
                codigo = f"RT-{fake.random_number(digits=5):05d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            origen = fake.city()
            destino = fake.city()
            duracion = random.randint(12, 240)  # horas
            tarifa = round(random.uniform(5000, 50000), 2)
            
            self.ids['ruta'].append(id_ruta)
            datos.append([id_ruta, codigo, origen, destino, duracion, tarifa])
        
        return self.guardar_csv(
            '50_ruta.csv',
            datos,
            ['id_ruta', 'codigo', 'origen', 'destino', 'duracion', 'tarifa']
        )
    
    def generar_rutas_maritimas(self):
        print(f"\nGenerando Rutas Marítimas...")
        datos = []
        self.ids['ruta_maritima'] = []
        codigos_usados = set()
        
        for id_ruta in self.ids['ruta']:
            id_ruta_maritima = str(uuid.uuid4())
            
            while True:
                codigo = f"RM-{fake.random_number(digits=5):05d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            distancia = round(random.uniform(50, 5000), 2)  # millas náuticas
            
            # Seleccionar puertos diferentes
            id_puerto_origen = random.choice(self.ids['puerto'])
            id_puerto_destino = random.choice([p for p in self.ids['puerto'] if p != id_puerto_origen])
            
            self.ids['ruta_maritima'].append(id_ruta_maritima)
            datos.append([
                id_ruta_maritima, id_ruta, codigo, distancia,
                id_puerto_origen, id_puerto_destino
            ])
        
        return self.guardar_csv(
            '51_ruta_maritima.csv',
            datos,
            ['id_ruta_maritima', 'id_ruta', 'codigo', 'distancia',
            'id_puerto_origen', 'id_puerto_destino']
        )
    
    def generar_operaciones(self, cantidad=80):
        print(f"\nGenerando {cantidad} Operaciones...")
        datos = []
        self.ids['operacion'] = []
        
        for i in range(cantidad):
            id_operacion = str(uuid.uuid4())
            codigo = f"OP-{fake.unique.random_number(digits=8):08d}"
            fecha_inicio = fake.date_time_between(start_date='-6m', end_date='now')
            
            if random.random() < 0.7:
                fecha_fin = fecha_inicio + timedelta(hours=random.randint(4, 72))
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
            '32_operacion.csv',
            datos,
            ['id_operacion', 'codigo', 'fecha_inicio', 'fecha_fin',
             'id_estado_operacion']
        )
    
    def generar_operaciones_maritimas(self):
        print(f"\nGenerando Operaciones Marítimas...")
        datos = []
        self.ids['operacion_maritima'] = []
        
        # 60% de operaciones son marítimas
        operaciones_maritimas = random.sample(
            self.ids['operacion'],
            int(len(self.ids['operacion']) * 0.6)
        )
        
        for id_operacion in operaciones_maritimas:
            id_op_maritima = str(uuid.uuid4())
            codigo = f"OM-{fake.unique.random_number(digits=8):08d}"
            cantidad_contenedores = random.randint(1, 100)
            id_buque = random.choice(self.ids['buque'])
            id_estatus = random.choice(self.ids['estatus_navegacion'])
            porcentaje_trayecto = random.randint(10, 100)
            
            self.ids['operacion_maritima'].append(id_op_maritima)
            datos.append([
                id_op_maritima, id_operacion, codigo, cantidad_contenedores,
                  id_estatus, porcentaje_trayecto, id_buque
            ])
        
        return self.guardar_csv(
            '33_operacion_maritima.csv',
            datos,
            ['id_operacion_maritima', 'id_operacion', 'codigo', 'cantidad_contenedores', 
             'id_estatus_navegacion', 'porcentaje_trayecto', 'id_buque']
        )
    
    def generar_operaciones_portuarias(self):
        print(f"\nGenerando Operaciones Portuarias...")
        datos = []
        self.ids['operacion_portuaria'] = []
        
        # 40% de operaciones son portuarias
        operaciones_restantes = [o for o in self.ids['operacion'] 
                                if o not in [om[1] for om in self.ids['operacion_maritima']]]
        
        for id_operacion in operaciones_restantes:
            id_op_portuaria = str(uuid.uuid4())
            id_tipo = random.choice(self.ids['tipo_operacion_portuaria'])
            id_muelle = random.choice(self.ids['muelle'])
            id_puerto = random.choice(self.ids['puerto'])
            id_buque = random.choice(self.ids['buque'])
            codigo = f"OPP-{fake.unique.random_number(digits=8):08d}"
            
            self.ids['operacion_portuaria'].append(id_op_portuaria)
            datos.append([
                id_op_portuaria, id_operacion, codigo, id_puerto,
                id_muelle, id_tipo, id_buque
            ])
        
        return self.guardar_csv(
            '34_operacion_portuaria.csv',
            datos,
            ['id_operacion_portuaria', 'id_operacion', 'codigo', 'id_puerto', 'id_muelle',
             'id_tipo_operacion_portuaria', 'id_buque']
        )
    
    def generar_inspecciones(self, cantidad=60):
        print(f"\nGenerando {cantidad} Inspecciones...")
        datos = []
        self.ids['inspeccion'] = []
        
        for i in range(cantidad):
            id_inspeccion = str(uuid.uuid4())
            codigo = f"INSP-{fake.unique.random_number(digits=7):07d}"
            fecha = fake.date_between(start_date='-6m', end_date='today')
            id_tipo = random.choice(self.ids['tipo_inspeccion'])
            id_estado = random.choice(self.ids['estado_inspeccion'])
            id_prioridad = random.choice(self.ids['prioridad'])
            id_operacion = random.choice(self.ids['operacion'])
            id_usuario = random.choice(self.ids['usuario'])
            
            self.ids['inspeccion'].append(id_inspeccion)
            datos.append([
                id_inspeccion, codigo, fecha.strftime('%Y-%m-%d'),
                id_tipo, id_estado, id_prioridad, id_operacion, id_usuario
            ])
        
        return self.guardar_csv(
            '35_inspeccion.csv',
            datos,
            ['id_inspeccion', 'codigo', 'fecha', 'id_tipo_inspeccion', 'id_estado_inspeccion',
             'id_prioridad', 'id_operacion', 'id_usuario']
        )
    
    def generar_hallazgos(self):
        print(f"\nGenerando Hallazgos...")
        datos = []
        self.ids['hallazgo'] = []
        
        for id_inspeccion in self.ids['inspeccion']:
            num_hallazgos = random.randint(0, 4)
            for _ in range(num_hallazgos):
                id_hallazgo = str(uuid.uuid4())
                codigo = f"HALL-{fake.unique.random_number(digits=6):06d}"
                descripcion = fake.sentence(nb_words=12)
                gravedad = random.randint(1, 5)
                accion_sugerida = fake.sentence(nb_words=8)
                id_tipo = random.choice(self.ids['tipo_hallazgo'])
                
                self.ids['hallazgo'].append(id_hallazgo)
                datos.append([id_hallazgo, codigo, id_tipo, gravedad, 
                              descripcion, accion_sugerida, id_inspeccion])
        
        return self.guardar_csv(
            '36_hallazgo.csv',
            datos,
            ['id_hallazgo', 'codigo', 'id_tipo_hallazgo', 'nivel_gravedad', 'descripcion',
             'accion_sugerida', 'id_inspeccion']
        )
    
    def generar_usuarios(self):
        print(f"\nGenerando Usuarios...")
        datos = []
        self.ids['usuario'] = []
        
        # Crear usuarios para trabajadores portuarios
        for id_trabajador in self.ids['trabajador_portuario']:
            id_usuario = str(uuid.uuid4())
            id_empleado = self.ids['trabajador_empleado'][id_trabajador]
            correo = fake.email()
            contrasena = fake.password(length=12)
            id_rol = random.choice(self.ids['rol_usuario'])
            
            self.ids['usuario'].append(id_usuario)
            datos.append([id_usuario, correo, contrasena, id_rol, id_empleado])
        
        return self.guardar_csv(
            '37_usuario.csv',
            datos,
            ['id_usuario', 'correo_electronico', 'contrasena', 'id_rol_usuario', 'id_empleado']
        )
    
    def generar_incidencias(self, cantidad=50):
        print(f"\nGenerando {cantidad} Incidencias...")
        datos = []
        self.ids['incidencia'] = []
        
        for i in range(cantidad):
            id_incidencia = str(uuid.uuid4())
            codigo = f"INC-{fake.unique.random_number(digits=7):07d}"
            descripcion = fake.paragraph(nb_sentences=3)
            fecha_hora = fake.date_time_between(start_date='-3m', end_date='now')
            gravedad = random.randint(1, 5)
            id_tipo = random.choice(self.ids['tipo_incidencia'])
            id_operacion = random.choice(self.ids['operacion'])
            id_usuario = random.choice(self.ids['usuario'])
            
            self.ids['incidencia'].append(id_incidencia)
            datos.append([
                id_incidencia, codigo, id_tipo, descripcion,
                gravedad, fecha_hora.strftime('%Y-%m-%d %H:%M:%S'), id_operacion, id_usuario
            ])
        
        return self.guardar_csv(
            '38_incidencia.csv',
            datos,
            ['id_incidencia', 'codigo', 'id_tipo_incidencia', 'descripcion',
             'grado_severidad', 'fecha_hora', 'id_operacion', 'id_usuario']
        )
    
    def generar_operacion_ruta_maritima(self):
        print(f"\nGenerando Rutas de Operaciones Marítimas...")
        datos = []
        
        for id_op_maritima in self.ids['operacion_maritima']:
            id_orm = str(uuid.uuid4())
            id_ruta_maritima = random.choice(self.ids['ruta_maritima'])
            
            # Seleccionar muelles diferentes
            id_muelle_origen = random.choice(self.ids['muelle'])
            id_muelle_destino = random.choice([m for m in self.ids['muelle'] if m != id_muelle_origen])
            
            datos.append([
                id_orm, id_op_maritima, id_ruta_maritima,
                id_muelle_origen, id_muelle_destino
            ])
        
        return self.guardar_csv(
            '55_operacion_ruta_maritima.csv',
            datos,
            ['id_operacion_ruta_maritima', 'id_operacion_maritima', 'id_ruta_maritima',
            'id_muelle_origen', 'id_muelle_destino']
        )
    
    def generar_estibas(self):
        print(f"\nGenerando Estibas...")
        datos = []
        
        zonas_buque = ['Proa', 'Popa', 'Babor', 'Estribor', 'Centro', 'Cubierta Superior']
        
        for id_op_portuaria in self.ids['operacion_portuaria']:
            num_estibas = random.randint(3, 15)
            contenedores_estiba = random.sample(
                self.ids['contenedor'],
                min(num_estibas, len(self.ids['contenedor']))
            )
            
            for i, id_contenedor in enumerate(contenedores_estiba):
                id_estiba = str(uuid.uuid4())
                ubicacion = f"Bodega {random.randint(1, 5)}, Nivel {random.randint(1, 4)}, Pos {random.randint(1, 20):02d}"
                zona = random.choice(zonas_buque)
                
                datos.append([id_estiba, id_op_portuaria, ubicacion, zona, id_contenedor])
        
        return self.guardar_csv(
            '56_estiba.csv',
            datos,
            ['id_estiba', 'id_operacion_portuaria', 'ubicacion', 'zona_buque', 'id_contenedor']
        )

    # ============================================
    # TABLAS ASOCIATIVAS
    # ============================================

    def generar_contenedor_mercancias(self):
        print(f"\nGenerando Mercancías de Contenedores...")
        datos = []
        registros_unicos = set()
        
        tipos_mercancia = [
            'Electrónicos', 'Textiles', 'Alimentos Perecederos', 'Químicos',
            'Maquinaria', 'Automóviles', 'Materias Primas', 'Productos Farmacéuticos',
            'Madera', 'Papel', 'Plásticos', 'Metales', 'Granos', 'Frutas'
        ]
        
        for id_contenedor in self.ids['contenedor']:
            num_mercancias = random.randint(1, 3)
            mercancias = random.sample(tipos_mercancia, num_mercancias)
            
            for mercancia in mercancias:
                clave = (id_contenedor, mercancia)
                if clave not in registros_unicos:
                    id_cm = str(uuid.uuid4())
                    datos.append([id_cm, id_contenedor, mercancia])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '48_contenedor_mercancia.csv',
            datos,
            ['id_contenedor_mercancia', 'id_contenedor', 'tipo_mercancia']
        )
    
    def generar_trabajador_equipo_proteccion(self):
        print(f"\nGenerando Equipos de Protección de Trabajadores...")
        datos = []
        registros_unicos = set()
        
        for id_trabajador in self.ids['trabajador_portuario']:
            # Cada trabajador debe tener al menos casco y chaleco
            equipos_obligatorios = self.ids['equipo_proteccion'][:2]
            # Más algunos opcionales
            num_opcionales = random.randint(1, 3)
            equipos_opcionales = random.sample(self.ids['equipo_proteccion'][2:], 
                                            min(num_opcionales, len(self.ids['equipo_proteccion'])-2))
            
            todos_equipos = equipos_obligatorios + equipos_opcionales
            
            for id_equipo in todos_equipos:
                clave = (id_trabajador, id_equipo)
                if clave not in registros_unicos:
                    id_tep = str(uuid.uuid4())
                    fecha_asig = fake.date_between(start_date='-1y', end_date='today')
                    datos.append([id_tep, id_trabajador, id_equipo, fecha_asig.strftime('%Y-%m-%d')])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '49_trabajador_portuario_equipo_proteccion.csv',
            datos,
            ['id_trabajador_portuario_equipo_proteccion', 'id_trabajador_portuario',
            'id_equipo_proteccion', 'fecha_asignacion']
        )
    
    def generar_ruta_puerto_intermedio(self):
        print(f"\nGenerando Puertos Intermedios de Rutas...")
        datos = []
        registros_unicos = set()
        
        for id_ruta_maritima in self.ids['ruta_maritima']:
            num_intermedios = random.randint(0, 3)
            if num_intermedios > 0:
                puertos_intermedios = random.sample(
                    self.ids['puerto'],
                    min(num_intermedios, len(self.ids['puerto']))
                )
                
                for id_puerto in puertos_intermedios:
                    clave = (id_ruta_maritima, id_puerto)
                    if clave not in registros_unicos:
                        id_rpi = str(uuid.uuid4())
                        datos.append([id_rpi, id_ruta_maritima, id_puerto])
                        registros_unicos.add(clave)
        
        return self.guardar_csv(
            '52_ruta_puerto_intermedio.csv',
            datos,
            ['id_ruta_puerto_intermedio', 'id_ruta_maritima', 'id_puerto']
        )
    
    def generar_certificaciones_aduaneras(self, cantidad=15):
        print(f"\nGenerando {cantidad} Certificaciones Aduaneras...")
        datos = []
        self.ids['certificacion_aduanera'] = []
        codigos_usados = set()
        
        tipos_cert_aduanera = [
            'DUA - Documento Único Aduanero',
            'Certificado de Origen',
            'Certificado Fitosanitario',
            'Certificado Zoosanitario',
            'Licencia de Importación',
            'Certificado de Conformidad',
            'Declaración de Valor en Aduana',
            'Certificado de Libre Venta',
            'Certificado CITES',
            'Manifiesto de Carga'
        ]
        
        # Usar subset de certificaciones existentes
        certificaciones_base = random.sample(
            self.ids['certificacion'],
            min(cantidad, len(self.ids['certificacion']))
        )
        
        for i, id_cert_base in enumerate(certificaciones_base):
            while True:
                codigo = f"ADU-{fake.random_number(digits=6):06d}"
                if codigo not in codigos_usados:
                    codigos_usados.add(codigo)
                    break
            
            nombre = tipos_cert_aduanera[i] if i < len(tipos_cert_aduanera) else f"Cert. Aduanera {fake.word().upper()}"
            descripcion = fake.sentence(nb_words=12)
            pais = fake.country()
            fecha_emision = fake.date_time_between(start_date='-1y', end_date='now')
            fecha_expiracion = fecha_emision + timedelta(days=random.randint(180, 1095))
            
            self.ids['certificacion_aduanera'].append(id_cert_base)
            datos.append([
                id_cert_base, codigo, nombre, descripcion, pais,
                fecha_emision.strftime('%Y-%m-%d %H:%M:%S%z'),
                fecha_expiracion.strftime('%Y-%m-%d %H:%M:%S%z')
            ])
        
        return self.guardar_csv(
            '53_certificacion_aduanera.csv',
            datos,
            ['id_certificacion_aduanera', 'codigo', 'nombre', 'descripcion',
            'pais_aplicacion', 'fecha_emision', 'fecha_expiracion']
        )
    
    def generar_operacion_certificacion_aduanera(self):
        print(f"\nGenerando Certificaciones Aduaneras de Operaciones...")
        datos = []
        registros_unicos = set()
        estados = ['PENDIENTE', 'APROBADO', 'RECHAZADO']
        
        for id_op_maritima in self.ids['operacion_maritima']:
            num_certs = random.randint(1, 3)
            certificaciones = random.sample(
                self.ids['certificacion_aduanera'],
                min(num_certs, len(self.ids['certificacion_aduanera']))
            )
            
            for id_cert in certificaciones:
                clave = (id_op_maritima, id_cert)
                if clave not in registros_unicos:
                    id_oca = str(uuid.uuid4())
                    estado = random.choice(estados)
                    fecha_aprobacion = ''
                    if estado == 'APROBADO':
                        fecha_aprobacion = fake.date_between(start_date='-3m', end_date='today').strftime('%Y-%m-%d')
                    
                    datos.append([id_oca, id_op_maritima, id_cert, estado, fecha_aprobacion])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '54_operacion_certificacion_aduanera.csv',
            datos,
            ['id_operacion_certificacion_aduanera', 'id_operacion_maritima',
            'id_certificacion_aduanera', 'estado', 'fecha_aprobacion']
        )

    def generar_tripulante_idiomas(self):
        print(f"\nGenerando Idiomas de Tripulantes...")
        datos = []
        idiomas = ['Español', 'Inglés', 'Portugués', 'Francés', 'Mandarín']
        niveles = ['Básico', 'Intermedio', 'Avanzado', 'Nativo']
        
        for id_tripulante in self.ids['tripulante']:
            num_idiomas = random.randint(1, 3)
            idiomas_tripulante = random.sample(idiomas, num_idiomas)
            
            for idioma in idiomas_tripulante:
                id_ti = str(uuid.uuid4())
                nivel = random.choice(niveles)
                datos.append([id_ti, id_tripulante, idioma, nivel])
        
        return self.guardar_csv(
            '39_tripulante_idioma.csv',
            datos,
            ['id_tripulante_idioma', 'id_tripulante', 'idioma', 'nivel']
        )
    
    def generar_operacion_maritima_condiciones(self):
        print(f"\nGenerando Condiciones de Operaciones Marítimas...")
        datos = []
        
        for id_op_maritima in self.ids['operacion_maritima']:
            num_condiciones = random.randint(1, 2)
            condiciones = random.sample(self.ids['condicion_operativa'], num_condiciones)
            
            for id_condicion in condiciones:
                id_omc = str(uuid.uuid4())
                datos.append([id_omc, id_op_maritima, id_condicion])
        
        return self.guardar_csv(
            '40_operacion_maritima_condicion.csv',
            datos,
            ['id_operacion_maritima_condicion', 'id_operacion_maritima', 'id_condicion_operativa']
        )
    
    def generar_operacion_empleados(self):
        print(f"\nGenerando Asignación de Empleados a Operaciones...")
        datos = []
        registros_unicos = set()
        
        for id_operacion in self.ids['operacion']:
            num_empleados = random.randint(2, 5)
            empleados = random.sample(self.ids['empleado'], min(num_empleados, len(self.ids['empleado'])))
            
            for id_empleado in empleados:
                fecha_asig = fake.date_between(start_date='-3m', end_date='today')
                clave = (id_operacion, id_empleado, fecha_asig.strftime('%Y-%m-%d'))
                
                if clave not in registros_unicos:
                    id_oe = str(uuid.uuid4())
                    fecha_desasig = ''
                    if random.random() < 0.3:
                        fecha_desasig = fake.date_between(start_date=fecha_asig, end_date='today').strftime('%Y-%m-%d')
                    
                    datos.append([
                        id_oe, id_operacion, id_empleado,
                        fecha_asig.strftime('%Y-%m-%d'), fecha_desasig
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '41_operacion_empleado.csv',
            datos,
            ['id_operacion_empleado', 'id_operacion', 'id_empleado',
             'fecha_asignacion', 'fecha_desasignacion']
        )
    
    def generar_usuario_operaciones(self):
        print(f"\nGenerando Asignación de Usuarios a Operaciones...")
        datos = []
        registros_unicos = set()
        
        for id_operacion in self.ids['operacion'][:40]:  # Solo algunas operaciones
            num_usuarios = random.randint(1, 2)
            usuarios = random.sample(self.ids['usuario'], min(num_usuarios, len(self.ids['usuario'])))
            
            for id_usuario in usuarios:
                clave = (id_usuario, id_operacion)
                if clave not in registros_unicos:
                    id_uo = str(uuid.uuid4())
                    fecha_asig = fake.date_between(start_date='-3m', end_date='today')
                    rol = random.choice(['Supervisor', 'Operador', 'Inspector'])
                    
                    datos.append([
                        id_uo, id_usuario, id_operacion,
                        fecha_asig.strftime('%Y-%m-%d'), rol
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '42_usuario_operacion.csv',
            datos,
            ['id_usuario_operacion', 'id_usuario', 'id_operacion',
             'fecha_asignacion', 'rol_en_operacion']
        )
    
    def generar_trabajador_equipo_portuario(self):
        print(f"\nGenerando Asignación de Equipos a Trabajadores...")
        datos = []
        registros_unicos = set()
        
        for id_trabajador in self.ids['trabajador_portuario']:
            num_equipos = random.randint(1, 3)
            equipos = random.sample(self.ids['equipo_portuario'], 
                                   min(num_equipos, len(self.ids['equipo_portuario'])))
            
            for id_equipo in equipos:
                clave = (id_trabajador, id_equipo)
                if clave not in registros_unicos:
                    id_tep = str(uuid.uuid4())
                    datos.append([id_tep, id_trabajador, id_equipo])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '43_trabajador_portuario_equipo_portuario.csv',
            datos,
            ['id_trabajador_portuario_equipo_portuario', 'id_trabajador_portuario', 
             'id_equipo_portuario']
        )
    
    def generar_certificacion_empleados(self):
        print(f"\nGenerando Certificaciones de Empleados...")
        datos = []
        registros_unicos = set()
        
        for id_empleado in self.ids['empleado'][:50]:  # Solo algunos empleados
            num_certs = random.randint(1, 3)
            certificaciones = random.sample(self.ids['certificacion'], 
                                           min(num_certs, len(self.ids['certificacion'])))
            
            for id_cert in certificaciones:
                clave = (id_empleado, id_cert)
                if clave not in registros_unicos:
                    id_ce = str(uuid.uuid4())
                    fecha_emision = fake.date_between(start_date='-3y', end_date='-1y')
                    fecha_venc = fake.date_between(start_date=fecha_emision, end_date='+5y')
                    
                    datos.append([
                        id_ce, id_empleado, id_cert,
                        fecha_emision.strftime('%Y-%m-%d'),
                        fecha_venc.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '44_certificacion_empleado.csv',
            datos,
            ['id_certificacion_empleado', 'id_empleado', 'id_certificacion',
             'fecha_emision', 'fecha_vencimiento']
        )
    
    def generar_certificacion_buques(self):
        print(f"\nGenerando Certificaciones de Buques...")
        datos = []
        registros_unicos = set()
        
        for id_buque in self.ids['buque']:
            num_certs = random.randint(2, 5)
            certificaciones = random.sample(self.ids['certificacion'], 
                                           min(num_certs, len(self.ids['certificacion'])))
            
            for id_cert in certificaciones:
                clave = (id_buque, id_cert)
                if clave not in registros_unicos:
                    id_cb = str(uuid.uuid4())
                    fecha_emision = fake.date_between(start_date='-2y', end_date='-6m')
                    fecha_venc = fake.date_between(start_date=fecha_emision, end_date='+3y')
                    
                    datos.append([
                        id_cb, id_buque, id_cert,
                        fecha_emision.strftime('%Y-%m-%d'),
                        fecha_venc.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '45_certificacion_buque.csv',
            datos,
            ['id_certificacion_buque', 'id_buque', 'id_certificacion',
             'fecha_emision', 'fecha_vencimiento']
        )
    
    def generar_operacion_contenedores(self):
        print(f"\nGenerando Asignación de Contenedores a Operaciones...")
        datos = []
        registros_unicos = set()
        
        for id_operacion in self.ids['operacion']:
            num_contenedores = random.randint(1, 10)
            contenedores = random.sample(self.ids['contenedor'], 
                                        min(num_contenedores, len(self.ids['contenedor'])))
            
            for id_contenedor in contenedores:
                fecha_asig = fake.date_between(start_date='-3m', end_date='today')
                clave = (id_operacion, id_contenedor, fecha_asig.strftime('%Y-%m-%d'))
                
                if clave not in registros_unicos:
                    id_oc = str(uuid.uuid4())
                    datos.append([
                        id_oc, id_operacion, id_contenedor,
                        fecha_asig.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '46_operacion_contenedor.csv',
            datos,
            ['id_operacion_contenedor', 'id_operacion', 'id_contenedor', 'fecha_asignacion']
        )
    
    def generar_operacion_equipo_portuario(self):
        print(f"\nGenerando Asignación de Equipos a Operaciones Portuarias...")
        datos = []
        registros_unicos = set()
        
        for id_op_portuaria in self.ids['operacion_portuaria']:
            num_equipos = random.randint(1, 3)
            equipos = random.sample(self.ids['equipo_portuario'], 
                                   min(num_equipos, len(self.ids['equipo_portuario'])))
            
            for id_equipo in equipos:
                fecha_asig = fake.date_time_between(start_date='-3m', end_date='now')
                clave = (id_op_portuaria, id_equipo, fecha_asig.strftime('%Y-%m-%d %H:%M:%S'))
                
                if clave not in registros_unicos:
                    id_oep = str(uuid.uuid4())
                    id_trabajador = random.choice(self.ids['trabajador_portuario'])
                    fecha_dev = ''
                    if random.random() < 0.6:
                        fecha_dev = (fecha_asig + timedelta(hours=random.randint(2, 12))).strftime('%Y-%m-%d %H:%M:%S')
                    
                    datos.append([
                        id_oep, id_op_portuaria, id_equipo, id_trabajador,
                        fecha_asig.strftime('%Y-%m-%d %H:%M:%S'), fecha_dev
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '47_operacion_equipo_portuario.csv',
            datos,
            ['id_operacion_equipo_portuario', 'id_operacion_portuaria', 'id_equipo_portuario',
             'id_trabajador_portuario', 'fecha_asignacion', 'fecha_devolucion']
        )
    
    # ============================================
    # MÉTODO PRINCIPAL
    # ============================================
    
    def generar_todo(self):
        """Genera todos los archivos CSV"""
        print("\n" + "="*60)
        print("GENERANDO ARCHIVOS CSV - GESTIÓN MARÍTIMA")
        print("="*60)
        
        # Catálogos
        self.generar_estado_operacion()
        self.generar_estatus_navegacion()
        self.generar_estado_embarcacion()
        self.generar_estado_contenedor()
        self.generar_tipo_contenedor()
        self.generar_tipo_equipo_portuario()
        self.generar_estado_equipo_portuario()
        self.generar_estado_inspeccion()
        self.generar_tipo_inspeccion()
        self.generar_tipo_hallazgo()
        self.generar_tipo_operacion_portuaria()
        self.generar_turno()
        self.generar_equipo_proteccion()
        self.generar_condicion_operativa()
        self.generar_prioridad()
        self.generar_estado_contrato()
        self.generar_tipo_telefono()
        self.generar_rol_usuario()
        self.generar_especialidad_empleado()
        self.generar_tipo_incidencia()
        
        # Tablas principales
        self.generar_puertos(15)
        self.generar_muelles(30)
        self.generar_contratos(120)
        self.generar_empleados(100)
        self.generar_empleado_telefonos()
        self.generar_buques(25)
        self.generar_contenedores(200)
        self.generar_tripulantes(80)
        self.generar_trabajadores_portuarios(60)
        self.generar_equipos_portuarios(40)
        self.generar_certificaciones(20)
        self.generar_operaciones(80)
        self.generar_operaciones_maritimas()
        self.generar_operaciones_portuarias()
        self.generar_usuarios()
        self.generar_inspecciones(60)
        self.generar_hallazgos()
        self.generar_incidencias(50)
        
        # Tablas asociativas
        self.generar_tripulante_idiomas()
        self.generar_operacion_maritima_condiciones()
        self.generar_operacion_empleados()
        self.generar_usuario_operaciones()
        self.generar_trabajador_equipo_portuario()
        self.generar_certificacion_empleados()
        self.generar_certificacion_buques()
        self.generar_operacion_contenedores()
        self.generar_operacion_equipo_portuario()

        # Tablas adicionales faltantes
        self.generar_contenedor_mercancias()
        self.generar_trabajador_equipo_proteccion()
        self.generar_rutas(30)
        self.generar_rutas_maritimas()
        self.generar_ruta_puerto_intermedio()
        self.generar_certificaciones_aduaneras(15)
        self.generar_operacion_certificacion_aduanera()
        self.generar_operacion_ruta_maritima()
        self.generar_estibas()
        
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
    ║   GENERADOR DE CSV - GESTIÓN MARÍTIMA                      ║
    ║   Datos falsos con Faker para PostgreSQL                   ║
    ╚════════════════════════════════════════════════════════════╝
    """)
    
    generador = GeneradorCSVMaritima()
    generador.generar_todo()
    
    print("\nPRÓXIMO PASO:")
    print("   Importa los archivos CSV en pgAdmin en el orden numérico")