workspace "Sistema de Hapag Lloyd" "Monitoreo de ubicacion en tiempo real y gestion de operaciones maritimas" {

    model {
        !impliedRelationships true

        # ---------- Personas ----------
        operadorMaritimo  = person "Operador de Gestion Maritima" "Gestiona operaciones maritimas, rutas, buques e incidencias."
        operadorMonitoreo = person "Operador de Monitoreo"        "Supervisa posiciones GPS, sensores y entregas en el mapa."

        # ---------- Sistemas externos ----------
        mapas = softwareSystem "OpenStreetMap / ArcGIS" "Proveedores de tiles para el mapa interactivo. El browser los consume via Leaflet." "Externo"

        victoriaMetrics = softwareSystem "VictoriaMetrics" "Base de datos de series de tiempo para metricas de sensores IoT." "Externo"

        sensoresIoT = softwareSystem "Sensores IoT / GPS" "Dispositivos que reportan posicion y metricas de contenedores, vehiculos y buques." "Externo"

        # ---------- Sistema principal ----------
        hapag = softwareSystem "Sistema de Hapag Lloyd" "Permite monitorear ubicaciones en tiempo real y gestionar operaciones maritimas." {

            # -- Contenedor: Frontend ------------------------------------------
            frontend = container "Frontend" "Interfaz web para los operadores. Incluye mapa interactivo con Leaflet." "Next.js 16 / React 19"

            # -- Contenedor: Modulo de Monitoreo -------------------------------
            # Se abre en el nivel de componentes.
            moduloMonitoreo = container "Modulo de Monitoreo" "Gestiona posiciones GPS, sensores IoT, incidencias, entregas y reportes del sistema." "NestJS / TypeORM" {

                seguimientoPosiciones = component "Seguimiento de Posiciones" "Consulta y sirve la posicion en tiempo real de contenedores, vehiculos y buques almacenada en la BD." "GpsService · GpsController"

                gestionOperaciones = component "Gestion de Operaciones" "Supervisa el ciclo de vida de las operaciones de monitoreo y el estado de los activos." "OperacionesService · OperacionesController · ContenedoresService · ContenedoresController"

                vigilanciaSensores = component "Vigilancia de Sensores IoT" "Registra lecturas de sensores, genera notificaciones internas y persiste metricas en VictoriaMetrics." "SensoresService · SensoresController · VictoriaMetricsService · VmDemoController"

                gestionIncidencias = component "Gestion de Incidencias" "Registra y gestiona incidencias vinculadas a operaciones, con severidad y estado." "IncidenciasService · IncidenciasController"

                trazabilidadEntregas = component "Trazabilidad de Entregas" "Gestiona la entrega de contenedores a importadores con documentacion y seguimiento." "EntregasService · ImportadoresService · DocumentacionService y sus Controllers"

                reportes = component "Reportes" "Genera reportes consolidados de incidencias, notificaciones y operaciones." "ReportesService · ReportesController"
            }

            # -- Contenedor: Modulo de Gestion de Operaciones Maritimas --------
            moduloGestionMaritima = container "Modulo de Gestion de Operaciones Maritimas" "Gestiona operaciones maritimas, rutas, buques, muelles, hallazgos e incidencias maritimas." "NestJS / TypeORM"

            # -- Contenedores: Bases de datos (un servidor PostgreSQL, 3 schemas) --
            dbMonitoreo = container "PostgreSQL - schema monitoreo"       "Posiciones GPS, sensores, lecturas, incidencias, entregas y reportes." "PostgreSQL 16" "Database"
            dbShared    = container "PostgreSQL - schema shared"          "Entidades compartidas: contenedores, vehiculos, buques y estados."    "PostgreSQL 16" "Database"
            dbMaritima  = container "PostgreSQL - schema gestion_maritima" "Operaciones maritimas, rutas, buques, muelles y personal."           "PostgreSQL 16" "Database"
        }

        # ---------- Relaciones de contenedores ----------
        operadorMaritimo  -> frontend "Usa" "HTTPS"
        operadorMonitoreo -> frontend "Usa" "HTTPS"

        frontend -> moduloMonitoreo       "Consume API de monitoreo"          "JSON/HTTPS"
        frontend -> moduloGestionMaritima "Consume API de operaciones maritimas" "JSON/HTTPS"
        frontend -> mapas                 "Carga tiles del mapa interactivo"  "HTTPS"

        sensoresIoT -> dbMonitoreo "Registra posiciones y metricas de activos" "SQL"

        moduloMonitoreo -> dbMonitoreo    "Lee y escribe datos de monitoreo"        "TypeORM/SQL"
        moduloMonitoreo -> dbShared       "Lee entidades compartidas"               "TypeORM/SQL"
        moduloMonitoreo -> victoriaMetrics "Persiste y consulta metricas de sensores" "HTTP"

        moduloGestionMaritima -> dbMaritima "Lee y escribe operaciones maritimas" "TypeORM/SQL"
        moduloGestionMaritima -> dbShared   "Lee y escribe entidades compartidas" "TypeORM/SQL"

        # ---------- Relaciones de componentes (Modulo de Monitoreo) ----------
        seguimientoPosiciones -> dbMonitoreo "Lee posiciones GPS almacenadas"        "TypeORM/SQL"
        seguimientoPosiciones -> dbShared    "Lee datos de contenedores y vehiculos" "TypeORM/SQL"

        gestionOperaciones -> dbMonitoreo "Lee y escribe operaciones de monitoreo" "TypeORM/SQL"
        gestionOperaciones -> dbShared    "Lee estados y tipos de operacion"       "TypeORM/SQL"

        vigilanciaSensores -> dbMonitoreo    "Registra lecturas y notificaciones"     "TypeORM/SQL"
        vigilanciaSensores -> victoriaMetrics "Persiste metricas de series de tiempo" "HTTP"

        gestionIncidencias -> dbMonitoreo "Registra y actualiza incidencias" "TypeORM/SQL"

        trazabilidadEntregas -> dbMonitoreo "Lee y escribe entregas y documentacion" "TypeORM/SQL"
        trazabilidadEntregas -> dbShared    "Lee estados de entrega y contenedores"  "TypeORM/SQL"

        reportes -> dbMonitoreo "Consulta reportes, incidencias y notificaciones" "TypeORM/SQL"
    }

    views {
        systemContext hapag "Contexto" "Diagrama de contexto (C4 - Nivel 1)" {
            include *
            autoLayout lr
        }

        container hapag "Contenedores" "Diagrama de contenedores (C4 - Nivel 2): modulos del backend y sus dependencias" {
            include *
            autoLayout lr
        }

        component moduloMonitoreo "Componentes" "Componentes internos del Modulo de Monitoreo (C4 - Nivel 3)" {
            include *
            autoLayout lr
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
