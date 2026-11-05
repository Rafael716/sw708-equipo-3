workspace "Sistema de Hapag Lloyd" "Monitoreo de ubicacion en tiempo real y gestion de operaciones maritimas" {

    model {
        !impliedRelationships true

        # ---------- Personas ----------
        operadorMaritimo  = person "Operador de Gestion Maritima" "Gestiona operaciones maritimas, rutas, buques e incidencias."
        operadorMonitoreo = person "Operador de Monitoreo"        "Supervisa posiciones GPS, sensores y entregas en el mapa."
        operadorReservas  = person "Operador de Reservas"         "Gestiona reservas de carga y seguimiento comercial."

        # ---------- Sistemas externos ----------
        mapas = softwareSystem "OpenStreetMap / ArcGIS" "Proveedores de tiles para el mapa interactivo. El browser los consume via Leaflet." "Externo"

        victoriaMetrics = softwareSystem "VictoriaMetrics" "Base de datos de series de tiempo para metricas de sensores IoT." "Externo"

        sensoresIoT = softwareSystem "Sensores IoT / GPS" "Dispositivos que reportan posicion y metricas de contenedores, vehiculos y buques." "Externo"

        # ---------- Sistema principal ----------
        hapag = softwareSystem "Sistema de Hapag Lloyd" "Permite monitorear ubicaciones en tiempo real y gestionar operaciones maritimas." {

            # -- Contenedor: Frontend ------------------------------------------
            frontend = container "Frontend" "Interfaz web para los operadores. Incluye mapa interactivo con Leaflet." "Next.js 16 / React 19"

            # -- Contenedor: Backend NestJS (un solo proceso) -------------------
            # Monitoreo, gestion maritima, reservas, portuaria, etc. corren en el mismo proceso.
            backend = container "Backend API" "API HTTP unica (NestJS). Monolito modular: auth, reservas, operaciones maritimas/portuarias/terrestres, personal y monitoreo." "NestJS / TypeORM" {

                authMod = component "AuthModule" "Login unificado y acceso por roles (JWT)." "NestJS"

                reservasMod = component "GestionReservaModule" "Alta y seguimiento de reservas de carga." "NestJS"

                maritimaMod = component "GestionMaritimaModule" "Buques, atraques, zarpes, estiba y operaciones maritimas." "NestJS"

                portuariaMod = component "GestionPortuariaModule" "Gestion portuaria (muelles, operaciones en puerto)." "NestJS"

                terrestresComp = component "Operaciones terrestres" "Soporte de operaciones terrestres (esquema y entidades propias)." "NestJS / TypeORM"

                tripulacionComp = component "Personal de tripulacion" "Datos de tripulacion (esquema y entidades propias)." "NestJS / TypeORM"

                # --- Rodaja vertical de Incidencias (hexagonal) ---
                incidenciasController = component "IncidenciasController" "Adaptador de entrada HTTP: POST /monitoreo/incidencias." "NestJS Controller"

                registrarIncidenciaUC = component "RegistrarIncidenciaUseCase" "Caso de uso de dominio: valida severidad, tipo, operacion activa, auditoria y notificacion critica." "Dominio"

                incidenciasPort = component "Puerto Incidencias" "Contrato de salida del dominio (existeTipo, obtenerEstadoInicial, operacionEstaActiva, guardar, notificarSupervisores)." "Puerto"

                incidenciasTypeorm = component "IncidenciasTypeormAdapter" "Adaptador de persistencia TypeORM (produccion)." "Infraestructura"

                incidenciasMemoria = component "IncidenciasEnMemoriaAdapter" "Adaptador en memoria para pruebas de dominio." "Infraestructura"

                gpsComp = component "GpsService" "Consulta la ultima posicion GPS por SQL (sin cache en proceso)." "NestJS Service"

                sensoresComp = component "Sensores / VictoriaMetrics" "Lecturas IoT, notificaciones y metricas de series temporales." "NestJS Service"
            }

            # -- Contenedor: un PostgreSQL con varios esquemas logicos ---------
            postgres = container "PostgreSQL" "Un servidor PostgreSQL 16. Esquemas logicos: shared, monitoreo, gestion_maritima, gestion_reserva, operaciones_terrestres, personal_tripulacion, etc." "PostgreSQL 16" "Database"
        }

        # ---------- Relaciones de contenedores ----------
        operadorMaritimo  -> frontend "Usa" "HTTPS"
        operadorMonitoreo -> frontend "Usa" "HTTPS"
        operadorReservas  -> frontend "Usa" "HTTPS"

        frontend -> backend "Consume API REST" "JSON/HTTPS"
        frontend -> mapas   "Carga tiles del mapa interactivo" "HTTPS"

        sensoresIoT -> backend "Reporta telemetria y posiciones (via API / batch)" "HTTPS"

        backend -> postgres         "Lee y escribe por esquemas de dominio" "TypeORM/SQL"
        backend -> victoriaMetrics  "Persiste y consulta metricas de sensores" "HTTP"

        # ---------- Relaciones de componentes (rodaja + backend) ----------
        incidenciasController -> registrarIncidenciaUC "Invoca" "DI (token INCIDENCIAS_PORT)"
        registrarIncidenciaUC -> incidenciasPort "Depende de"
        incidenciasTypeorm -> incidenciasPort "Implementa"
        incidenciasMemoria -> incidenciasPort "Implementa (pruebas)"
        incidenciasTypeorm -> postgres "Persiste incidencias y consulta operacion/estado" "TypeORM/SQL"
        gpsComp -> postgres "SELECT ultima posicion ORDER BY fecha_hora DESC" "SQL"
        sensoresComp -> postgres "Lecturas y notificaciones" "TypeORM/SQL"
        sensoresComp -> victoriaMetrics "Metricas" "HTTP"
        authMod -> postgres "Usuarios y credenciales" "TypeORM/SQL"
        reservasMod -> postgres "Esquema gestion_reserva" "TypeORM/SQL"
        maritimaMod -> postgres "Esquema gestion_maritima + shared" "TypeORM/SQL"
        portuariaMod -> postgres "Gestion portuaria" "TypeORM/SQL"
        terrestresComp -> postgres "Esquema operaciones_terrestres" "TypeORM/SQL"
        tripulacionComp -> postgres "Esquema personal_tripulacion" "TypeORM/SQL"
    }

    views {
        systemContext hapag "Contexto" "Diagrama de contexto (C4 - Nivel 1)" {
            include *
            autoLayout lr
        }

        container hapag "Contenedores" "Diagrama de contenedores (C4 - Nivel 2): Frontend, Backend NestJS unico y PostgreSQL unico" {
            include *
            autoLayout tb
        }

        component backend "Componentes" "Componentes del Backend NestJS (C4 - Nivel 3), con rodaja de Incidencias" {
            include *
            autoLayout tb
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
