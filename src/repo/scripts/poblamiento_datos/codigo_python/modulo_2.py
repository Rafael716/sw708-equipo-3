import csv
import random
from faker import Faker
from datetime import datetime, timedelta
import uuid
import os

fake = Faker('es_ES')
OUTPUT_DIR = 'datos_csv_modulo_2'

if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)
    print(f"Directorio '{OUTPUT_DIR}' creado")


class GeneradorCSVPersonalTripulacion:
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
    
    def generar_especialidad_empleado(self):
        print("\nGenerando EspecialidadEmpleado...")
        especialidades = [
            'Capitan', 'Oficial de Cubierta', 'Ingeniero Naval',
            'Oficial de Maquinas', 'Contramaestre', 'Marinero',
            'Cocinero', 'Medico de Bordo', 'Radio Operador'
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
            '02_estatus_navegacion.csv',
            datos,
            ['id_estatus_navegacion', 'nombre']
        )
    
    def generar_rol_usuario(self):
        print("\nGenerando RolUsuario...")
        roles = [
            'Administrador', 'Supervisor', 'Operador',
            'Coordinador', 'Consultor'
        ]
        datos = []
        self.ids['rol_usuario'] = []
        
        for rol in roles:
            id_rol = str(uuid.uuid4())
            self.ids['rol_usuario'].append(id_rol)
            datos.append([id_rol, rol])
        
        return self.guardar_csv(
            '03_rol_usuario.csv',
            datos,
            ['id_rol_usuario', 'nombre']
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
            '04_estado_operacion.csv',
            datos,
            ['id_estado_operacion', 'nombre']
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
            '06_estado_contrato.csv',
            datos,
            ['id_estado_contrato', 'nombre']
        )
    
    def generar_certificacion(self):
        print("\nGenerando Certificacion...")
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
            ('Manejo de Gruas', 'Operacion de equipos de carga')
        ]
        datos = []
        self.ids['certificacion'] = []
        
        for nombre, descripcion in certificaciones:
            id_cert = str(uuid.uuid4())
            self.ids['certificacion'].append(id_cert)
            datos.append([id_cert, nombre, descripcion])
        
        return self.guardar_csv(
            '07_certificacion.csv',
            datos,
            ['id_certificacion', 'nombre', 'descripcion']
        )
    
    def generar_contratos(self, cantidad=80):
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
            '08_contrato.csv',
            datos,
            ['id_contrato', 'fecha_emision', 'fecha_vencimiento', 'id_estado_contrato']
        )
    
    def generar_empleados(self, cantidad=70):
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
            anios_experiencia = random.randint(0, 30)
            id_contrato = self.ids['contrato'][i]
            
            self.ids['empleado'].append(id_empleado)
            datos.append([
                id_empleado, codigo, dni, nombre, apellido,
                direccion, id_especialidad, anios_experiencia, id_contrato
            ])
        
        return self.guardar_csv(
            '09_empleado.csv',
            datos,
            ['id_empleado', 'codigo', 'dni', 'nombre', 'apellido',
             'direccion', 'id_especialidad_empleado', 'anios_experiencia', 'id_contrato']
        )
    
    def generar_usuarios(self):
        print(f"\nGenerando Usuarios...")
        datos = []
        self.ids['usuario'] = []
        correos_usados = set()
        
        for id_empleado in self.ids['empleado']:
            id_usuario = str(uuid.uuid4())
            
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
            '10_usuario.csv',
            datos,
            ['id_usuario', 'correo_electronico', 'contrasena', 
             'id_rol_usuario', 'id_empleado']
        )
    
    def generar_buques(self, cantidad=25):
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
            '11_buque.csv',
            datos,
            ['id_buque', 'matricula', 'nombre', 'capacidad',
             'id_estado_embarcacion', 'peso', 'ubicacion_actual']
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
            '12_operacion.csv',
            datos,
            ['id_operacion', 'codigo', 'fecha_inicio', 'fecha_fin', 'id_estado_operacion']
        )
    
    def generar_operaciones_maritimas(self):
        print(f"\nGenerando Operaciones Maritimas...")
        datos = []
        self.ids['operacion_maritima'] = []
        codigos_usados = set()
        
        for id_operacion in self.ids['operacion']:
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
            
            self.ids['operacion_maritima'].append(id_op_maritima)
            datos.append([
                id_op_maritima, id_operacion, codigo, cantidad_contenedores,
                id_estatus, porcentaje_trayecto, id_buque
            ])
        
        return self.guardar_csv(
            '13_operacion_maritima.csv',
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
            'Ecuatoriana', 'Brasilena', 'Mexicana', 'Filipina'
        ]
        
        empleados_tripulantes = random.sample(
            self.ids['empleado'], 
            min(50, len(self.ids['empleado']))
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
            '14_tripulante.csv',
            datos,
            ['id_tripulante', 'id_empleado', 'disponibilidad', 'nacionalidad']
        )
    
    def generar_usuario_operacion(self):
        print(f"\nGenerando UsuarioOperacion...")
        datos = []
        registros_unicos = set()
        
        roles_operacion = [
            'Coordinador', 'Supervisor', 'Ejecutor',
            'Auditor', 'Responsable de Seguridad'
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
                    fecha_asignacion = fake.date_between(start_date='-3m', end_date='today')
                    rol_en_operacion = random.choice(roles_operacion)
                    
                    datos.append([
                        id_usuario_operacion, id_usuario, id_operacion,
                        fecha_asignacion.strftime('%Y-%m-%d'), rol_en_operacion
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '15_usuario_operacion.csv',
            datos,
            ['id_usuario_operacion', 'id_usuario', 'id_operacion',
             'fecha_asignacion', 'rol_en_operacion']
        )
    
    def generar_certificacion_empleado(self):
        print(f"\nGenerando CertificacionEmpleado...")
        datos = []
        registros_unicos = set()
        
        for id_empleado in self.ids['empleado']:
            num_certificaciones = random.randint(1, 5)
            certificaciones = random.sample(
                self.ids['certificacion'], 
                min(num_certificaciones, len(self.ids['certificacion']))
            )
            
            for id_certificacion in certificaciones:
                clave = (id_empleado, id_certificacion)
                if clave not in registros_unicos:
                    id_cert_empleado = str(uuid.uuid4())
                    fecha_emision = fake.date_between(start_date='-5y', end_date='today')
                    fecha_vencimiento = fecha_emision + timedelta(days=random.randint(730, 1825))
                    
                    datos.append([
                        id_cert_empleado, id_empleado, id_certificacion,
                        fecha_emision.strftime('%Y-%m-%d'),
                        fecha_vencimiento.strftime('%Y-%m-%d')
                    ])
                    registros_unicos.add(clave)
        
        return self.guardar_csv(
            '16_certificacion_empleado.csv',
            datos,
            ['id_certificacion_empleado', 'id_empleado', 'id_certificacion',
             'fecha_emision', 'fecha_vencimiento']
        )
    
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
                fecha_asignacion = fake.date_between(start_date='-1y', end_date='today')
                hora_asignacion = fake.time()
                
                datos.append([
                    id_buque_tripulante, id_buque, id_tripulante,
                    fecha_asignacion.strftime('%Y-%m-%d'), hora_asignacion
                ])
        
        return self.guardar_csv(
            '17_buque_tripulante.csv',
            datos,
            ['id_buque_tripulante', 'id_buque', 'id_tripulante',
             'fecha_asignacion', 'hora_asignacion']
        )
    
    def generar_todo(self):
        print("\n" + "="*70)
        print("GENERANDO ARCHIVOS CSV - PERSONAL Y TRIPULACION")
        print("="*70)
        
        self.generar_especialidad_empleado()
        self.generar_estatus_navegacion()
        self.generar_rol_usuario()
        self.generar_estado_operacion()
        self.generar_estado_embarcacion()
        self.generar_estado_contrato()
        self.generar_certificacion()
        
        self.generar_contratos(80)
        self.generar_empleados(70)
        self.generar_usuarios()
        self.generar_buques(25)
        self.generar_operaciones(60)
        self.generar_operaciones_maritimas()
        self.generar_tripulantes()
        self.generar_usuario_operacion()
        self.generar_certificacion_empleado()
        self.generar_buque_tripulante()
        
        print("\n" + "="*70)
        print("GENERACION COMPLETADA")
        print(f"Archivos guardados en: {OUTPUT_DIR}/")
        print("="*70)


if __name__ == "__main__":
    print("""
    ====================================================================
       GENERADOR DE CSV - PERSONAL Y TRIPULACION
       Datos falsos con Faker para PostgreSQL
    ====================================================================
    """)
    
    generador = GeneradorCSVPersonalTripulacion()
    generador.generar_todo()
    
    print("\nPROXIMO PASO:")
    print("   Importa los archivos CSV en pgAdmin en el orden numerico")