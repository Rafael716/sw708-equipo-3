# SW708 · Arquitectura de Soluciones de Software
## Documento de arquitectura · Entrega 1 (P2)
### Sistema de Gestión de Operaciones Marítimas y Monitoreo en Tiempo Real · Hapag-Lloyd

**Equipo 3**

| N.º | Apellidos y nombres | Código | Rol |
|---|---|---|---|
| 1 | Rafael Adriano Olivos Gallardo | 20231296G | Coordinador |
| 2 | Romel Rodrigo Chumpitaz Flores | 20231014A | Integrante |
| 3 | David Luza Ccorimanya | 20232595H | Integrante |
| 4 | Henry Javier Medina Malpartida | 20232571A | Integrante |
| 5 | Pablo Antonio Muñoz Bolaños | 20242090F | Integrante |

| Repositorio | https://github.com/Rafael716/sw708-equipo-3 |
|---|---|
| **Commit revisado** | 69a5daf |

---

## Registro de versiones

| Versión | Fecha | Autor | Descripción y modificación |
|---|---|---|---|
| 1.0 | 14 de septiembre | David Luza Ccorimanya | Escenarios de calidad reescritos con el formato completo, con instrumento de medición y priorizados. |
| 2.0 | 21 de septiembre | Romel Chumpitaz Flores | Modelo C4: contexto, contenedores y componentes generados desde workspace.dsl. |
| 3.0 | 29 de septiembre | Henry Medina Malpartida | ADR-0001 (monolito modular) y ADR-0002 (stack TypeScript) en formato Nygard; análisis de costo del cambio. |
| 4.0 | 11 de octubre | Rafael Olivos Gallardo | Rodaja vertical de Incidencias: caso de uso, puerto y adaptadores (en memoria y TypeORM). |
| 5.0 | 14 de octubre | Rafael Olivos y Pablo Muñoz | Reglas de dependency-cruiser e integración continua en GitHub Actions (backend-arch.yml). |
| 6.0 | 16 de octubre | Todos | Revisión completa del documento, bitácora de IA y sección de pendientes para P4. |
| 7.0 | 4 de noviembre | Equipo 3 | Remediación observaciones Entrega 1 (puntos 1–5): ADR-0003, C4, rodaja E3, CI en este repo, ortografía y estructura docs/. |

---

## Índice

1. Resumen
2. Escenarios de calidad
   2.1 Priorización
3. Modelo C4
   3.1 Contexto
   3.2 Contenedores
   3.3 Componentes del módulo
   3.4 Fuente: workspace.dsl
4. Decisiones de arquitectura
  - ADR-0001. Estilo arquitectónico: monolito modular
  - ADR-0002. Stack de lenguaje: TypeScript con NestJS y Next.js
  - ADR-0003. Puertos y adaptadores en la rodaja de Incidencias
5. Diseño de la interfaz
   5.1 Flujos principales
   5.2 Frontera entre la interfaz y el dominio
6. Rodaja vertical
   6.1 Estructura de paquetes
   6.2 Dominio
   6.3 Puerto de salida
   6.4 Caso de uso
   6.5 Prueba de dominio
   6.6 Reglas de arquitectura
   6.7 Integración continua
   6.8 Evidencia
7. Bitácora de uso de IA
8. Lo que falta para la entrega final
   - Anexo: rúbrica

---

## 1. Resumen

El Sistema de Gestión de Operaciones Marítimas y Monitoreo en Tiempo Real nació en el curso SI501U Diseño de Base de Datos y busca coordinar la logística de contenedores y el transporte marítimo de Hapag-Lloyd: reservas, buques, puertos, monitoreo de carga y sensores IoT. El problema de fondo es la falta de integración y de visibilidad en tiempo real entre las operaciones marítimas (atraque, zarpe, estiba) y el monitoreo de la carga en tránsito. Esa brecha expone a la operación a pérdidas por fallas en la cadena de frío o por accidentes marítimos que podrían prevenirse con alertas tempranas.

Este documento es la Entrega 1 (P2) del proyecto integrador. Recoge el trabajo de las semanas 1 a 6 y lo presenta en el orden en que se construyó:

- **Escenarios de calidad (sección 2):** cinco escenarios reescritos con el formato completo, con el instrumento concreto de medición y priorizados con un criterio explícito.
- **Modelo C4 (sección 3):** contexto, contenedores y componentes del módulo de Monitoreo, generados desde workspace.dsl.
- **Tres ADR (sección 4):** monolito modular, stack único TypeScript (NestJS y Next.js) y puertos/adaptadores en la rodaja de Incidencias.
- **Diseño de la interfaz (sección 5):** flujo de registro de incidencias y la frontera entre lo que valida la interfaz y lo que valida el dominio.
- **Rodaja vertical de Incidencias (sección 6):** el caso de uso `RegistrarIncidenciaUseCase`, desacoplado de frameworks, con un puerto de salida y dos adaptadores intercambiables (en memoria y TypeORM), protegido por reglas de dependency-cruiser en GitHub Actions.

Elegimos incidencias como primera capacidad porque concentra las reglas de negocio críticas del sistema (severidad, auditoría, vínculo con una operación marítima activa) y porque es la capacidad que sostiene el escenario de seguridad y auditabilidad (E3), de prioridad alta. Para P4 quedan las demás capacidades, las migraciones formales de base de datos y las pruebas de integración en CI (sección 8).

**Tabla 1.1. Integrantes del equipo**

| Integrante | Código | Responsable de |
|---|---|---|
| Rafael Adriano Olivos Gallardo | 20231296G | Rodaja vertical de Incidencias, adaptadores y reglas de arquitectura |
| Romel Rodrigo Chumpitaz Flores | 20231014A | Modelo C4 (Structurizr DSL), diagramas y esquemas PostgreSQL |
| David Luza Ccorimanya | 20232595H | Escenarios de calidad, métricas e instrumentos de prueba |
| Henry Javier Medina Malpartida | 20232571A | ADR-0001, ADR-0002 y análisis de costo del cambio (versión A vs. B) |
| Pablo Antonio Muñoz Bolaños | 20242090F | Bitácora de uso de IA (semanas 1 a 6) e integración continua en GitHub Actions |

**Tabla 1.2. Datos de la entrega**

| Repositorio | https://github.com/Rafael716/sw708-equipo-3 |
|---|---|
| **Commit revisado** | 69a5daf en main el miércoles 14 de octubre de 2026, 16:03:37 |
| **Lenguaje y stack** | El lenguaje del backend y del frontend está hecho en TypeScript con los frameworks NestJS y NextJS, respectivamente, y la base de datos en PostgreSQL. |
| **Estado del build** | [`.github/workflows/backend-arch.yml`](https://github.com/Rafael716/sw708-equipo-3/actions/workflows/backend-arch.yml) · Actions del repositorio `sw708-equipo-3` |
| **Comando para construir** | `cd src/repo/app && docker compose up -d` |

---

## 2. Escenarios de calidad

Reescribimos los escenarios con las seis partes del formato (fuente, estímulo, artefacto, entorno, respuesta y medida) y agregamos el instrumento con el que se medirá cada uno. La regla que nos dimos: si no sabemos con qué herramienta se va a medir, el escenario no está terminado.

**Tabla 2.1. Escenario de interoperabilidad - Operaciones marítimas a monitoreo**

| | |
|---|---|
| **Fuente** | Módulo de Gestión de Operaciones Marítimas. Actualización de un estado operativo (el buque atracó, un contenedor fue descargado). |
| **Artefacto** | Interfaz de integración entre módulos y eventos de cambio de estado. |
| **Entorno** | Operación activa normal, 24/7. |
| **Respuesta** | El módulo de Monitoreo refleja el cambio en su panel sin intervención manual. |
| **Medida** | Al menos 99 % de los eventos interpretados correctamente y con el estado sincronizado. |
| **Instrumento** | Suite de integración con Jest y Supertest que verifica la consistencia entre endpoints de ambos módulos. |

**Tabla 2.2. Escenario de fiabilidad - Pérdida de señal GPS**

| | |
|---|---|
| **Fuente** | Dispositivo GPS satelital del buque. |
| **Estímulo** | Interrupción de la transmisión de posición en navegación, hasta 30 minutos. |
| **Artefacto** | Submódulo de seguimiento GPS (gpsService). |
| **Entorno** | Buque en altamar con condiciones climáticas adversas. |
| **Respuesta** | Conserva la última posición válida, emite una alerta de pérdida de señal y reintenta la reconexión sin corromper la serie histórica. |
| **Medida** | 99 % de recuperaciones sin pérdida histórica; disponibilidad del servicio de al menos 99,5 %. |
| **Instrumento** | Prueba automatizada en Jest que simula el corte de inserciones, más un health check sobre el endpoint. |

**Tabla 2.3. Escenario de seguridad y auditabilidad - Incidencias críticas**

| | |
|---|---|
| **Fuente** | Operador de Monitoreo o de Gestión Marítima. Registra una incidencia crítica en tránsito (grado de severidad máximo). |
| **Artefacto** | Caso de uso de registro de incidencias y tabla de auditoría. |
| **Entorno** | Operación en curso bajo contingencia. |
| **Respuesta** | Registro inmutable con `usuario_id` y `timestamp`, y notificación automática a los supervisores. |
| **Medida** | 100 % de las incidencias críticas auditables, verificado en la base de datos. |
| **Instrumento** | Consulta SQL directa que verifica que los campos de auditoría obligatorios no sean nulos. |

**Tabla 2.4. Escenario de mantenibilidad - Nuevos sensores o umbrales**

| | |
|---|---|
| **Fuente** | Administrador del sistema o equipo técnico. |
| **Estímulo** | Pide incorporar un nuevo sensor IoT (por ejemplo, de golpes o impacto) o ajustar un umbral térmico. |
| **Artefacto** | Módulo de Monitoreo, submódulo de Sensores IoT. |
| **Entorno** | Sistema en producción, sin detener las operaciones. |
| **Respuesta** | El cambio se aplica y se despliega de forma localizada en el módulo correspondiente. |
| **Medida** | Implementación en menos de 1 día-persona y sin downtime. |
| **Instrumento** | Marcas de tiempo de los commits de Git (inicio y fin) y monitoreo continuo del health endpoint durante el despliegue. |

**Tabla 2.5. Escenario de usabilidad - Identificación visual de lo crítico**

| | |
|---|---|
| **Fuente** | Coordinador de flota sin capacitación previa. |
| **Estímulo** | Debe identificar qué buque presenta alertas críticas o incidentes en el mapa. |
| **Artefacto** | Panel interactivo (Next.js con Leaflet). |
| **Entorno** | Panel con varios buques navegando al mismo tiempo. |
| **Respuesta** | El mapa destaca el estado crítico con código de colores (verde, amarillo, rojo). |
| **Medida** | Identificación correcta en menos de 10 segundos por usuarios nuevos. |
| **Instrumento** | Prueba con cronómetro sobre una muestra de 3 a 5 participantes sin inducción previa. |

### 2.1 Priorización

Puntuamos cada escenario en impacto para el negocio (qué pasa si no se cumple) y dificultad técnica (cuánto cuesta cumplirlo), de 1 a 3. La prioridad sale del impacto; la dificultad indica cuánto esfuerzo reservar.

**Tabla 2.6. Priorización de los escenarios**

| Escenario | Impacto | Dificultad | Prioridad | Decisión que lo atiende |
|---|---|---|---|---|
| E1 Interoperabilidad | 3 | 3 | Alta | ADR-0001: monolito modular con esquemas coordinados en PostgreSQL. |
| E3 Seguridad y auditabilidad | 3 | 2 | Alta | Rodaja vertical de Incidencias: registro inmutable (usuario + timestamp), operación activa y notificación a supervisores en severidad 5 (ADR-0003). |
| E4 Mantenibilidad | 3 | 1 | Alta | ADR-0001 y regla de arquitectura en dependency-cruiser. |
| E2 Fiabilidad | 2 | 3 | Media | Consulta SQL de la última posición válida (`GpsService`) y health check del endpoint; la serie histórica no se reescribe. |
| E5 Usabilidad | 2 | 1 | Media | Frontend unificado en Next.js con mapas Leaflet. |

La prioridad sigue el impacto (1–3 → Baja / Media / Alta). La dificultad solo estima esfuerzo; por eso E4 (impacto 3) es Alta aunque su dificultad sea 1.

---

## 3. Modelo C4

Los tres niveles se describen en `semana-03/docs/c4/workspace.dsl` (Structurizr DSL). Los diagramas se generan desde esa fuente versionada, de modo que el diagrama que se ve corresponde al código y no a un dibujo hecho a mano.

### 3.1 Contexto

![Figura 3.1. Diagrama de contexto de Sistema de Gestión de Operaciones y Monitoreo](contexto)

**Figura 3.1. Diagrama de contexto de Sistema de Gestión de Operaciones y Monitoreo**

| Elemento | Descripción |
|---|---|
| Operador de Gestión Marítima [Persona] | Gestiona atraque, zarpe, estiba y operaciones de contenedores. |
| Operador de Monitoreo [Persona] | Vigila posiciones, sensores e incidencias en tiempo real. |
| Sistema de Hapag Lloyd [Sistema] | Operaciones marítimas y monitoreo de carga en tiempo real. |
| Sensores IoT / GPS [Externo] | Envían telemetría y posición de buques y contenedores. |
| OpenStreetMap / ArcGIS [Externo] | Proveen los iconos del mapa que se dibujan en el navegador. |
| VictoriaMetrics [Externo] | Base de datos de series temporales para los datos de sensores (proceso batch). |

### 3.2 Contenedores

![Figura 3.2. Diagrama de contenedores de Sistema de Gestión de Operaciones y Monitoreo](contenedores)

**Figura 3.2. Diagrama de contenedores de Sistema de Gestión de Operaciones y Monitoreo**

| Contenedor | Tecnología | Responsabilidad |
|---|---|---|
| Frontend | Next.js 16, React 19, Leaflet | Paneles, mapa de buques y formularios. |
| Backend API | NestJS y TypeORM (un solo proceso, puerto 3001) | Auth, reservas, gestión marítima/portuaria, operaciones terrestres, personal de tripulación y monitoreo. |
| PostgreSQL 16 | Un servidor, varios esquemas lógicos | `shared`, `monitoreo`, `gestion_maritima`, `gestion_reserva`, `operaciones_terrestres`, `personal_tripulacion`, etc. |

Monitoreo y Gestión Marítima no son contenedores distintos: son módulos del mismo proceso NestJS. Los esquemas tampoco son contenedores: son particiones lógicas del mismo PostgreSQL.

### 3.3 Componentes del Backend (rodaja de Incidencias)

![Figura 3.3. Componentes del backend NestJS](componentes)

**Figura 3.3. Componentes del Backend API**, incluyendo la rodaja: `IncidenciasController` → `RegistrarIncidenciaUseCase` → puerto `Incidencias` → `IncidenciasTypeormAdapter` / `IncidenciasEnMemoriaAdapter`, más los módulos registrados en `src/repo/app/backend/src/app.module.ts`.

### 3.4 Fuente: workspace.dsl

El archivo completo está versionado en `semana-03/docs/c4/workspace.dsl`.

```dsl
workspace "Sistema de Hapag Lloyd" "Monitoreo de ubicacion en tiempo real y gestion de operaciones marítimas" {

    model {
        !impliedRelationships true

        # ------------------------ Personas ------------------------
        operadorMaritimo = person "Operador de Gestion Marítima" "Gestiona operaciones marítimas, rutas, buques e incidencias."
        operadorMonitoreo = person "Operador de Monitoreo" "Supervisa posiciones GPS, sensores y entregas en el mapa."

        # ------------------------ Sistemas externos ------------------------
        mapas = softwareSystem "OpenStreetMap / ArcGIS" "Proveedores de tiles para el mapa interactivo. El browser los consume via Leaflet." "Externo"
        victoriaMetrics = softwareSystem "VictoriaMetrics" "Base de datos de series de tiempo para metricas de sensores IoT." "Externo"
        sensoresIoT = softwareSystem "Sensores IoT / GPS" "Dispositivos que reportan posicion y metricas de contenedores, vehiculos y buques." "Externo"

        # ------------------------ Sistema principal ------------------------
        hapag = softwareSystem "Sistema de Hapag Lloyd" "Permite monitorear ubicaciones en tiempo real y gestionar operaciones marítimas." {

            # --- Contenedor: Frontend ---
            frontend = container "Frontend" "Interfaz web para los operadores. Incluye mapa interactivo con Leaflet." "Next.js 16 / React 19"

            # --- Contenedor: Modulo de Monitoreo ---
            # Se abre en el nivel de componentes.
            moduloMonitoreo = container "Modulo de Monitoreo" "Gestiona posiciones GPS, sensores IoT, incidencias, entregas y reportes del sistema." "NestJS / TypeORM" {

                seguimientoPosiciones = component "Seguimiento de Posiciones" "Consulta y sirve la posicion en tiempo real de contenedores, vehiculos y buques almacenada en la BD." "GpsService - GpsController"

                gestionOperaciones = component "Gestion de Operaciones" "Supervisa el ciclo de vida de las operaciones de monitoreo y el estado de los activos." "OperacionesService - OperacionesController - ContenedoresService - ContenedoresController"

                vigilanciaSensores = component "Vigilancia de Sensores IoT" "Registra lecturas de sensores, genera notificaciones internas y persiste metricas en VictoriaMetrics." "SensoresService - SensoresController - VictoriaMetricsService - VmDemoController"

                gestionIncidencias = component "Gestion de Incidencias" "Registra y gestiona incidencias vinculadas a operaciones, con severidad y estado." "IncidenciasService - IncidenciasController"

                trazabilidadEntregas = component "Trazabilidad de Entregas" "Gestiona la entrega de contenedores a importadores con documentacion y seguimiento." "EntregasService - ImportadoresService - DocumentacionService y sus Controllers"

                reportes = component "Reportes" "Genera reportes consolidados de incidencias, notificaciones y operaciones." "ReportesService - ReportesController"
            }

            # -- Contenedor: Modulo de Gestion de Operaciones Maritimas ---
            moduloGestionMaritima = container "Modulo de Gestion de Operaciones Maritimas" "Gestiona operaciones maritimas, rutas, buques, muelles, hallazgos e incidencias maritimas." "NestJS / TypeORM"

            # -- Contenedores: Bases de datos (un servidor PostgreSQL, 3 schemas) --
            dbMonitoreo = container "PostgreSQL - schema monitoreo" "Posiciones GPS, sensores, lecturas, incidencias, entregas y reportes." "PostgreSQL 16" "Database"
            dbShared = container "PostgreSQL - schema shared" "Entidades compartidas: contenedores, vehiculos, buques y estados." "PostgreSQL 16" "Database"
            dbMaritima = container "PostgreSQL - schema gestion_maritima" "Operaciones maritimas, rutas, buques, muelles y personal." "PostgreSQL 16" "Database"
        }

        # --- Relaciones de contenedores ---
        operadorMaritimo -> frontend "Usa" "HTTPS"
        operadorMonitoreo -> frontend "Usa" "HTTPS"
        frontend -> moduloMonitoreo "Consume API de monitoreo" "JSON/HTTPS"
        frontend -> moduloGestionMaritima "Consume API de operaciones maritimas" "JSON/HTTPS"
        frontend -> mapas "Carga tiles del mapa interactivo" "HTTPS"
        sensoresIoT -> dbMonitoreo "Registra posiciones y metricas de activos" "SQL"
        moduloMonitoreo -> dbMonitoreo "Lee y escribe datos de monitoreo" "TypeORM/SQL"
        moduloMonitoreo -> dbShared "Lee entidades compartidas" "TypeORM/SQL"
        moduloMonitoreo -> victoriaMetrics "Persiste y consulta metricas de sensores" "HTTP"
        moduloGestionMaritima -> dbMaritima "Lee y escribe operaciones maritimas" "TypeORM/SQL"
        moduloGestionMaritima -> dbShared "Lee y escribe entidades compartidas" "TypeORM/SQL"

        # ------------------------ Relaciones de componentes (Modulo de Monitoreo) ------------------------
        sequimientoPosiciones -> dbMonitoreo "Lee posiciones GPS almacenadas" "TypeORM/SQL"
        sequimientoPosiciones -> dbShared "Lee datos de contenedores y vehiculos" "TypeORM/SQL"
        gestionOperaciones -> dbMonitoreo "Lee y escribe operaciones de monitoreo" "TypeORM/SQL"
        gestionOperaciones -> dbShared "Lee estados y tipos de operacion" "TypeORM/SQL"
        vigilanciaSensores -> dbMonitoreo "Registra lecturas y notificaciones" "TypeORM/SQL"
        vigilanciaSensores -> victoriaMetrics "Persiste metricas de series de tiempo" "HTTP"
        gestionIncidencias -> dbMonitoreo "Registra y actualiza incidencias" "TypeORM/SQL"
        trazabilidadEntregas -> dbMonitoreo "Lee y escribe entregas y documentacion" "TypeORM/SQL"
        trazabilidadEntregas -> dbShared "Lee estados de entrega y contenedores" "TypeORM/SQL"
        reportes -> dbMonitoreo "Consulta reportes, incidencias y notificaciones" "TypeORM/SQL"
    }

    views {
        systemContext hapag "Contexto" "Diagrama de contexto (C4 - Nivel 1)" {
            include *
            autolayout 1r
        }

        container hapag "Contenedores" "Diagrama de contenedores (C4 - Nivel 2): modulos del backend y sus dependencias" {
            include *
            autolayout 1r
        }

        component moduloMonitoreo "Componentes" "Componentes internos del Modulo de Monitoreo (C4 - Nivel 3)" {
            include *
            autolayout 1r
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Externo" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Database" {
                shape Cylinder
                background #2e7d32
                color #ffffff
            }
        }
    }
}
```

---

## 4. Decisiones de arquitectura (ADR)

Los registros canónicos para la entrega están en [`docs/adr/`](./adr/) (copias alineadas al enunciado). Las fuentes de trabajo semanal siguen en `semana-04-05/docs/adr/`. Formato Nygard. Las consecuencias y el cuadro de costo del cambio los elaboró el equipo a mano, sin IA.

### ADR-0001 · Estilo arquitectónico: monolito modular

| | |
|---|---|
| **Estado** | Aceptada · 6 de octubre de 2026. |
| **Archivo** | [`docs/adr/0001-monolito-modular.md`](./adr/0001-monolito-modular.md) |

**Contexto.** El sistema de Gestión de Operaciones Logísticas de Hapag-Lloyd comprende varios dominios funcionales, como reservas, operaciones marítimas, gestión portuaria y monitoreo. Estos dominios deben evolucionar en paralelo, manteniendo una estructura que facilite el mantenimiento sin introducir la complejidad de múltiples despliegues distribuidos.

En el repositorio `src/repo`, el backend NestJS registra los módulos de dominio en `app.module.ts`, mientras que el frontend se desarrolla con Next.js. La organización de los datos contempla esquemas PostgreSQL como `gestion_maritima`, `gestion_reserva`, `monitoreo` y `shared`.

El escenario de mantenibilidad de la semana 2 establece como objetivo realizar cambios relacionados con umbrales o nuevos tipos de sensores en menos de un día-persona y sin downtime. Para ello, resulta necesario facilitar la localización de los componentes afectados por un cambio y mantener un proceso de despliegue sencillo.

El experimento del costo del cambio de las semanas 4 y 5 aporta evidencia para esta decisión:

| Medida | Versión A | Versión B |
|---|---|---|
| Tiempo empleado | 25 min 41 s | 32 min 39 s |
| Archivos tocados | 3 | 6 |
| Líneas cambiadas | 52 | 48 |
| Lugares a buscar | 2 | 4 |

La versión A concentró el cambio en menos archivos y lugares de búsqueda que la versión B. Por tanto, se busca una arquitectura que favorezca los cambios localizados, evite el acoplamiento excesivo y no introduzca una fragmentación operativa innecesaria.

**Decisión**

Se adopta un monolito modular con un backend NestJS y un frontend Next.js, organizando las funcionalidades mediante módulos de dominio y esquemas PostgreSQL diferenciados, incluido `shared`. La aplicación mantiene un despliegue centralizado en lugar de separar cada módulo en un servicio independiente.

**Referencia en el código:**

- `src/repo/app/backend/src/app.module.ts`: registro de los módulos del backend.
- `src/repo/scripts/ddl/tablas/`: scripts de definición de los esquemas y las tablas de la base de datos.
- `src/repo/app/frontend/`: aplicación frontend desarrollada con Next.js.

**Alternativas consideradas**

1. **Monolito modular — opción elegida.** Organiza las funcionalidades en módulos con responsabilidades definidas y mantiene un despliegue centralizado. Facilita la localización de los cambios y la coordinación entre dominios sin añadir la complejidad operativa de los servicios independientes.
2. **Monolito sin límites o «bola de barro» — descartada.** Concentra la lógica del sistema sin establecer fronteras claras entre las funcionalidades. Aunque puede facilitar el desarrollo inicial, aumenta el acoplamiento y dificulta identificar los componentes afectados por un cambio, perjudicando el objetivo de mantenibilidad.
3. **Microservicios por módulo — descartada.** Separa los dominios en servicios y despliegues independientes. Aunque permite desplegar y escalar cada servicio de forma autónoma, introduce comunicación entre servicios, contratos adicionales y mayor complejidad operativa. Esta fragmentación no se considera necesaria para las necesidades actuales del sistema.

**Consecuencias**

**Ventajas**

- La separación por módulos y esquemas facilita localizar los componentes afectados por un cambio, favoreciendo el cumplimiento del objetivo de mantenibilidad de menos de un día-persona.
- Un despliegue centralizado reduce la complejidad operativa al evitar la administración de múltiples servicios y pipelines independientes.
- La organización por dominios permite que el equipo trabaje en distintas funcionalidades con responsabilidades más delimitadas.
- La estructura modular aprovecha la evidencia del experimento del costo del cambio, priorizando modificaciones localizadas como las observadas en la versión A.

**Costos / riesgos**

- Las fronteras entre módulos requieren disciplina; si se comparten entidades o reglas de negocio sin límites claros, el sistema puede evolucionar hacia una arquitectura excesivamente acoplada.
- El esquema `shared` puede convertirse en un punto de acoplamiento, ya que los cambios en sus elementos podrían afectar a varios módulos.
- Un fallo grave en el backend puede afectar a varias funcionalidades al formar parte de una misma aplicación desplegable.
- Escalar o desplegar un dominio de manera independiente requerirá una futura separación arquitectónica, con el costo de adaptación correspondiente.

### ADR-0002. Stack tecnológico: TypeScript con NestJS y Next.js

| | |
|---|---|
| **Estado** | Aceptado · 6 de octubre de 2026. |
| **Archivo** | [`docs/adr/0002-stack-typescript-nestjs-nextjs.md`](./adr/0002-stack-typescript-nestjs-nextjs.md) |

**Contexto**

El equipo necesitaba un stack tecnológico común para implementar y mantener los distintos módulos de dominio dentro del mismo repositorio (`src/repo/app`), con tipado entre el backend y el frontend y una API HTTP clara para la comunicación entre ambas capas.

La implementación existente evidencia el uso de NestJS, TypeORM y pg en el backend, con módulos TypeScript bajo `app/backend/src/`. En el frontend se utiliza Next.js con React y TypeScript, mientras que PostgreSQL está configurado como sistema de persistencia en `src/repo/app/backend/src/app.module.ts`.

Además, la autenticación se encuentra modelada en Nest mediante `AuthModule` y las dependencias de JWT/Passport.

La decisión se tomó durante la construcción del prototipo funcional. Se necesitaba un lenguaje común para el backend y el frontend, alineado con la organización modular de NestJS y con los esquemas de dominio del sistema.

**Decisión**

Se utiliza TypeScript tanto en el backend como en el frontend, con NestJS como framework de la API y Next.js con React como framework de la interfaz web, tal como está implementado en `src/repo/app`.

**Referencia en el código:**

- `src/repo/app/backend/package.json`: dependencias y configuración del backend.
- `src/repo/app/backend/src/`: módulos y código TypeScript del backend.
- `src/repo/app/frontend/package.json`: dependencias y configuración del frontend.
- `src/repo/app/backend/src/app.module.ts`: configuración de persistencia y registro de módulos.

**Alternativas consideradas**

1. **TypeScript con NestJS y Next.js — opción elegida.** Permite utilizar un lenguaje común en la API y la interfaz. NestJS organiza el backend mediante módulos, controladores y servicios, mientras que Next.js con React permite desarrollar el dashboard y los flujos operativos de operaciones marítimas, reservas y monitoreo.
2. **Java con Spring Boot y una interfaz independiente — descartada.** Dispone de un ecosistema empresarial consolidado. Sin embargo, el equipo ya trabajaba con el modelo de datos y el prototipo web dentro del ecosistema Node.js. Introducir la JVM y una solución de interfaz separada aumentaría la curva de aprendizaje y el tiempo necesario para disponer de una interfaz funcional para las operaciones.
3. **Python con Django o FastAPI y frontend JavaScript sin TypeScript — descartada.** Facilita el desarrollo de API y prototipos, pero utilizar JavaScript sin TypeScript en el frontend elimina parte de las garantías de tipado entre la interfaz y la API. También supone abandonar la estructura modular que NestJS proporciona en la implementación actual, aumentando el riesgo de errores de contrato en pantallas que manejan datos de reservas, estados operativos y monitoreo.

**Consecuencias**

**Ventajas**

- Utilizar TypeScript en el backend y el frontend reduce la necesidad de coordinar lenguajes diferentes y facilita el mantenimiento de las estructuras de datos intercambiadas entre ambas capas.
- NestJS proporciona una organización mediante módulos, controladores y servicios que refuerza la separación de responsabilidades del monolito modular.
- Next.js y React facilitan la evolución de la interfaz web y de las pantallas de operaciones marítimas, reservas y monitoreo.
- El ecosistema Node.js y npm permite reutilizar herramientas y mantener convenciones de desarrollo comunes en el proyecto.

**Costos / riesgos**

- La dependencia del runtime Node.js y de las convenciones de NestJS y Next.js aumenta el costo de una eventual migración a otro stack tecnológico.
- La curva de aprendizaje de NestJS, especialmente en módulos e inyección de dependencias, puede generar duplicación de lógica si no se mantienen criterios de diseño consistentes.
- El tipado de TypeScript no elimina los errores de integración en tiempo de ejecución, como las URLs incorrectas o los problemas de configuración.
- La configuración de persistencia y la ausencia de migraciones versionadas, señalada en el trabajo mediante `synchronize: false`, requieren especial atención para mantener la base de datos alineada con los cambios del código.

### ADR-0003. Puertos y adaptadores en la rodaja de Incidencias

| | |
|---|---|
| **Estado** | Aceptado · 4 de noviembre de 2026. |
| **Archivo** | [`docs/adr/0003-puertos-y-adaptadores.md`](./adr/0003-puertos-y-adaptadores.md) |

**Contexto.** La rodaja de Incidencias ya separaba dominio, puerto y adaptadores, pero no había un ADR que fijara esa decisión. El caso de uso debe validar operación activa, dejar registro inmutable (`idUsuario` + `fechaHora`) y notificar supervisores en severidad 5, sin importar Nest ni TypeORM.

**Decisión.** El dominio depende del puerto `Incidencias`. Nest inyecta el puerto con el token `INCIDENCIAS_PORT` (`useExisting: IncidenciasTypeormAdapter`). El controlador recibe `RegistrarIncidenciaUseCase` por DI; no hace `new` del adaptador concreto.

**Referencia en el código:**

- `src/repo/app/backend/src/monitoreo/dominio/registrar-incidencia.use-case.ts`
- `src/repo/app/backend/src/monitoreo/dominio/incidencias.port.ts`
- `src/repo/app/backend/src/monitoreo/infraestructura/incidencias-typeorm.adapter.ts`
- `src/repo/app/backend/src/monitoreo/infraestructura/incidencias-en-memoria.adapter.ts`
- `src/repo/app/backend/src/monitoreo/monitoreo.module.ts`

**Alternativas:** servicios Nest acoplados a TypeORM (descartada); repositorio genérico en `shared` (descartada). Detalle completo en el archivo del ADR.

---

## 5. Diseño de la interfaz

La interfaz no da puntos, pero su diseño como documentación forma parte de la entrega. La regla: la interfaz valida forma; el dominio valida significado.

### 5.1 Flujo principal: registrar una incidencia

El operador abre el formulario de incidencias desde el panel, selecciona el tipo de incidencia, describe lo ocurrido, indica la operación marítima asociada y, si corresponde, adjunta fotos o actas. La interfaz revisa que los campos requeridos existan y que los adjuntos cumplan tamaño y extensión. El caso de uso `RegistrarIncidenciaUseCase` verifica el tipo, el grado de severidad y la operación activa, genera el código secuencial `INC-YYMM-XXXX` y guarda la incidencia con estado inicial `abierta`. Responde con el código generado o con un rechazo que explica el motivo.

**Tabla 5.1. Flujos principales**

| Flujo | Quién lo inicia | Pasos |
|---|---|---|
| Registrar una incidencia | Operador de Monitoreo | 1) Abre el formulario desde el panel<br/>2) Selecciona tipo, describe lo ocurrido e indica la operación marítima<br/>3) La UI valida campos y adjuntos<br/>4) `POST /v1/incidencias` con JWT (contrato `semana-10/docs/api/openapi.yaml`)<br/>5) El caso de uso valida severidad, tipo y estado, genera `INC-YYMM-XXXX` y persiste |
| Vigilar buques en el mapa | Operador de Monitoreo | 1) Entra al panel de monitoreo<br/>2) Leaflet carga tiles de OpenStreetMap/ArcGIS<br/>3) Consulta posiciones GPS al backend<br/>4) Interpreta estados con código de colores (verde, amarillo, rojo) |
| Actualizar estado operativo | Operador de Gestión Marítima | 1) Registra atraque, zarpe o descarga en Operaciones Marítimas<br/>2) El backend actualiza el estado en el esquema correspondiente<br/>3) Monitoreo refleja el cambio en su panel sin intervención manual (E1) |

### 5.2 Frontera entre la interfaz y el dominio

**Tabla 5.2. Qué valida cada lado**

| Lo valida la interfaz (forma) | Lo valida el dominio (significado) |
|---|---|
| Presencia de campos requeridos (descripción no vacía). | `gradoSeveridad` entero dentro del rango permitido (1 a 5). |
| Formato de la identificación de usuario y sesión activa. | Existencia y consistencia de `idTipoIncidencia`. |
| Coordenadas de geolocalización dentro de rangos válidos. | Estado inicial válido de la incidencia (`Abierta`). |
| Tamaño y extensión de los archivos adjuntos. | Generación del código secuencial único `INC-YYMM-XXXX`. |
| Renderizado de colores en el mapa (verde, amarillo, rojo). | Operación activa (`En curso`), auditoría inmutable y notificación a supervisores si severidad = 5. |

Lo que la interfaz valida también lo vuelve a comprobar el dominio cuando afecta una regla de negocio: la interfaz existe para que el usuario no espere, no para proteger el dominio.

---

## 6. Rodaja vertical

Una capacidad del sistema funcionando de extremo a extremo: entrada, dominio y persistencia. La capacidad elegida es el registro de incidencias. El código está en `src/repo/app/backend/src/monitoreo`.

### 6.1 Estructura de paquetes

```
src/monitoreo/
  dominio/
    incidencias.port.ts                 puerto de salida y tipos de dominio
    registrar-incidencia.use-case.ts    caso de uso sin dependencias externas
    registrar-incidencia.spec.ts        pruebas con AMBOS adaptadores
    registrar-incidencia.characterization.spec.ts  pruebas de caracterización
  infraestructura/
    incidencias-en-memoria.adapter.ts   adaptador en memoria
    incidencias-typeorm.adapter.ts      adaptador PostgreSQL con TypeORM
  controllers/
    incidencias.controller.ts           adaptador de entrada HTTP
  services/
    incidencias.service.ts
```

### 6.2 Dominio

`src/repo/app/backend/src/monitoreo/dominio/incidencias.port.ts`

```typescript
export interface IncidenciaDominio {
  idIncidencia: string;
  codigo: string;
  idTipoIncidencia: string;
  descripcion: string;
  gradoSeveridad: number;
  idOperacion: string;
  idUsuario: string;
  idEstadoIncidencia: string;
  fechaHora: Date;
}

export interface RegistrarIncidenciaComando {
  idTipoIncidencia: string;
  descripcion: string;
  gradoSeveridad: number;
  idOperacion: string;
  idUsuario: string;
}
```

### 6.3 Puerto de salida

`src/repo/app/backend/src/monitoreo/dominio/incidencias.port.ts`

```typescript
/**
 * Puerto de salida: lo que el dominio necesita del mundo exterior.
 * Vive en dominio; lo implementa infraestructura.
 */
export interface Incidencias {
  existeTipo(idTipoIncidencia: string): Promise<boolean>;
  obtenerEstadoInicial(): Promise<{ idEstadoIncidencia: string } | null>;
  siguienteCodigo(): Promise<string>;
  guardar(datos: DatosNuevaIncidencia): Promise<IncidenciaDominio>;
}
```

### 6.4 Caso de uso

`src/repo/app/backend/src/monitoreo/dominio/registrar-incidencia.use-case.ts`

```typescript
export class RegistrarIncidenciaUseCase {
  constructor(private readonly incidencias: Incidencias) {}

  async ejecutar(comando: RegistrarIncidenciaComando): Promise<IncidenciaDominio> {
    if (!comando.idUsuario || comando.idUsuario.trim().length === 0) {
      throw new Error('Usuario no autenticado');
    }

    const descripcion = (comando.descripcion ?? '').trim();
    if (descripcion.length === 0) {
      throw new Error('La descripcion no puede estar vacia');
    }

    if (
      !Number.isInteger(comando.gradoSeveridad) ||
      comando.gradoSeveridad < 1 ||
      comando.gradoSeveridad > 5
    ) {
      throw new Error('El grado de severidad debe ser un entero entre 1 y 5');
    }

    if (!comando.idTipoIncidencia || comando.idTipoIncidencia.trim().length === 0) {
      throw new Error('Tipo de incidencia no válido');
    }

    if (!comando.idOperacion || comando.idOperacion.trim().length === 0) {
      throw new Error('La operación es obligatoria');
    }

    const tipoExiste = await this.incidencias.existeTipo(comando.idTipoIncidencia);
    if (!tipoExiste) {
      throw new Error('Tipo de incidencia no válido');
    }

    const estadoInicial = await this.incidencias.obtenerEstadoInicial();
    if (!estadoInicial) {
      throw new Error('No hay estados de incidencia configurados');
    }

    const codigo = await this.incidencias.siguienteCodigo();

    return this.incidencias.guardar({
      codigo,
      idTipoIncidencia: comando.idTipoIncidencia,
      descripcion,
      gradoSeveridad: comando.gradoSeveridad,
      idOperacion: comando.idOperacion,
      idUsuario: comando.idUsuario,
      idEstadoIncidencia: estadoInicial.idEstadoIncidencia,
    });
  }
}
```

### 6.5 Prueba de dominio

`src/repo/app/backend/src/monitoreo/dominio/registrar-incidencia.spec.ts`

```typescript
it('registra una incidencia válida', async () => {
  const creada = await useCase.ejecutar(COMANDO_VALIDO);
  expect(creada.idTipoIncidencia).toBe('tipo-1');
  expect(creada.gradoSeveridad).toBe(4);
  expect(creada.idEstadoIncidencia).toBe('estado-abierta');
  expect(creada.codigo).toMatch(/^INC-\d{4}-\d{4}$/);
});

it('rechaza severidad fuera de 1..5', async () => {
  await expect(
    useCase.ejecutar({ ...COMANDO_VALIDO, gradoSeveridad: 9 }),
  ).rejects.toThrow('El grado de severidad debe ser un entero entre 1 y 5');
});

/** Misma prueba de dominio con los dos adaptadores del puerto. */
suiteDominio('adaptador en memoria', () => prepararMemoria());
suiteDominio('adaptador TypeORM (stub)', () => prepararTypeormStub());
```

### 6.6 Reglas de arquitectura

`src/repo/app/backend/.dependency-cruiser.cjs`

```javascript
{
  name: 'dominio-monitoreo-no-depende-de-infra',
  comment:
    'El dominio de monitoreo no debe depender de infraestructura, Nest ni TypeORM (rodaja Lab06).',
  severity: 'error',
  from: { path: '\\src/monitoreo/dominio', pathNot: '\\.spec\\.ts$' },
  to: { path: '\\src/monitoreo/(infraestructura|controllers|services)' },
},
{
  name: 'dominio-monitoreo-no-depende-de-framework',
  comment: 'El dominio no importa NestJS ni TypeORM.',
  severity: 'error',
  from: { path: '\\src/monitoreo/dominio', pathNot: '\\.spec\\.ts$' },
  to: { path: 'node_modules/(@nestjs|typeorm)' },
},
```

### 6.7 Integración continua

El workflow vive en este repositorio: [`.github/workflows/backend-arch.yml`](https://github.com/Rafael716/sw708-equipo-3/actions/workflows/backend-arch.yml).

```yaml
name: Backend tests y arquitectura

on:
  push:
  pull_request:

jobs:
  test-and-arch:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: src/repo/app
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v4
        with:
          version: 11.26.0
      - uses: actions/setup-node@v4
        with:
          node-version: '22'
          cache: 'pnpm'
          cache-dependency-path: src/repo/app/pnpm-lock.yaml
      - run: pnpm install
      - name: Pruebas (incluye dominio sin DB)
        run: pnpm --filter backend test
      - name: Regla de arquitectura (dependency-cruiser)
        run: pnpm --filter backend test:arch
```

Enlace al workflow: https://github.com/Rafael716/sw708-equipo-3/actions/workflows/backend-arch.yml

### 6.8 Evidencia

**Tabla 6.1. Evidencia de la rodaja**

| | |
|---|---|
| **Pruebas ejecutadas** | 9 passed, 0 failed (2 suites: dominio + caracterización), con ambos adaptadores |
| **Estado del build** | En verde en local: pruebas de dominio + test:arch sin violaciones |
| **Comando para correr** | `cd src/repo/app && pnpm --filter backend exec jest --testPathPatterns=registrar-incidencia && pnpm --filter backend test:arch` |

**Tabla 6.2. Commits por integrante**

| Integrante | Commits | Aporte principal |
|---|---|---|
| Luza Ccorimanya, David | 22 | Escenarios, métricas, instrumentos; aportes de frontend |
| Muñoz Bolaños, Pablo Antonio | 12 | Bitácora de IA, CI (backend-arch.yml) |
| Chumpitaz Flores, Romel Rodrigo | 8 | workspace.dsl, diagramas C4, esquemas PostgreSQL |
| Olivos Gallardo, Rafael Adriano | 5 | Rodaja de Incidencias, adaptadores, reglas de arquitectura |
| Medina Malpartida, Henry Javier | 2 | Documento ADR-0001 (monolito modular) y ADR-0002 (stack TypeScript) en formato Nygard |

---

## 7. Bitácora de uso de IA

Resumen de las bitácoras semanales del repositorio. No se usó IA en la refactorización de la semana 6 (puertos, adaptadores y configuración de dependency-cruiser) ni en las consecuencias de los ADR.

**Tabla 7.1. Bitácora de uso de IA**

| Semana | Herramienta y uso | Qué se aceptó | Qué se corrigió o descartó |
|---|---|---|---|
| 1 · PetClinic | ChatGPT: identificar controladores y entidades. | Identificación de controladores y entidades JPA. | Se descartó una clase `ClinicService` que la IA inventó a partir de versiones antiguas. |
| 2 · Escenarios | Claude: criterios de medición e instrumentos. | Jest, marcas de tiempo de Git y health checks como instrumentos. | Se descartaron brokers pesados (Kafka, RabbitMQ) y telemetría de eye-tracking fuera de alcance. |
| 3 · Modelo C4 | Claude: estructura en Structurizr DSL. | Estructura del workspace y relaciones con `!impliedRelationships`. | Se eliminaron un API Gateway y un sistema de notificaciones externo que la IA inventó. |
| 4-5 · ADR | Claude: alternativas a comparar. | Lista de alternativas para el estilo modular y el stack. | Consecuencias y cuadro de costo del cambio hechos 100 % a mano. |
| 6 · Rodaja | Ninguna. | Sin uso de IA. | Refactorización a puertos y adaptadores y configuración de dependency-cruiser hechas a mano. |

---

## 8. Lo que falta para la entrega final

**Tabla 8.1. Pendientes para la entrega final**

| Componente pendiente | Estado actual | Riesgo | Qué haremos |
|---|---|---|---|
| Operaciones Terrestres y Personal | Falta completar la rodaja vertical de ambos módulos. | Alto | Completar la implementación e integración de ambos módulos. |
| Migraciones de TypeORM | `synchronize: false`, sin migraciones versionadas. | Alto | Implementar migraciones formales para controlar y versionar los cambios de la base de datos. |
| Configuración de URL de la API | Hay URL fijas como `http://localhost:3001` en el frontend. | Medio | Centralizar las URL mediante `NEXT_PUBLIC_API_URL` y eliminar las direcciones hardcodeadas. |
| Autenticación JWT | La lógica de autenticación está duplicada en varios módulos. | Alto | Unificar la autenticación en un componente compartido y reutilizable. |
| Pruebas de integración | No se cuenta con pruebas automatizadas con PostgreSQL real en Docker dentro de CI. | Alto | Implementar pruebas de integración con PostgreSQL en un contenedor Docker e incorporarlas al pipeline de integración continua. |

---

## Anexo: rúbrica

**Tabla A.1. Rúbrica de la Entrega 1**

| Criterio | Puntos | Dónde está la evidencia |
|---|---|---|
| Escenarios de calidad medibles y priorizados | 3 | Sección 2 - `semana-02/docs/escenario.md` |
| Modelo C4: contexto, contenedores y componentes | 4 | Sección 3 - `semana-03/docs/c4/workspace.dsl` y `assets/` |
| Dos ADR con alternativas reales y trade-offs | 4 | Sección 4 - ADR-0001 y ADR-0002 en `semana-04-05/docs/adr/` |
| Rodaja vertical con puertos y adaptadores y la regla de arquitectura en integración continua | 5 | Sección 6 - `src/repo/app/backend/src/monitoreo/` - `.dependency-cruiser.cjs` - `backend-arch.yml` |
| Calidad del informe y del repositorio | 2 | Todo el informe |
| Sustentación en la revisión con el profesor | 2 | El día de la revisión |
| **Total** | **20** | |
