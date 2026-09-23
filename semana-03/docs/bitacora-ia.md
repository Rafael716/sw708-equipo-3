# Bitácora de uso de IA — Semana 03

## Qué se le pidió a la IA

Se usó IA (Claude) para ayudar a traducir el modelo C4 diseñado previamente en papel y en los diagramas generados con Structurizr a la sintaxis del **Structurizr DSL**. Las solicitudes principales fueron:

1. Traducir el diagrama de contexto (personas, sistema principal y sistemas externos) a bloques `person`, `softwareSystem` y relaciones en DSL.
2. Traducir el diagrama de contenedores (frontend, módulos del backend y bases de datos) a bloques `container` con tecnología y relaciones con protocolo.
3. Identificar las tecnologías reales de cada contenedor leyendo el `package.json` del frontend, el `package.json` del backend y el `docker-compose.yml`.
4. Generar la vista de componentes del **Módulo de Monitoreo** identificando agrupaciones de responsabilidad a partir de los `services` y `controllers` del código fuente.
5. Comparar la versión del DSL del equipo con la generada por la IA para identificar diferencias conceptuales y decidir qué conservar de cada una.
6. Corregir errores de estructura cuando el workspace tenía dos bloques `workspace` duplicados.

## Qué se aceptó

- La estructura general del archivo DSL (`model` arriba, `views` abajo) con las tres vistas (`systemContext`, `container`, `component`).
- El uso de `!impliedRelationships true` para evitar declarar manualmente las relaciones de nivel sistema a partir de las relaciones de contenedor.
- La separación de los tres schemas de PostgreSQL como contenedores distintos (`monitoreo`, `shared`, `gestion_maritima`), ya que corresponden a dominios de datos independientes confirmados en el código.
- Los seis componentes del Módulo de Monitoreo agrupados por responsabilidad (no por carpeta), que coinciden con los `services` y `controllers` reales del módulo.
- La corrección de la dirección de la relación de los sensores: en el código, el `GpsService` solo lee de la base de datos local, por lo que la flecha correcta es `sensoresIoT -> dbMonitoreo`, no al revés.
- Las tecnologías reales de cada contenedor identificadas leyendo el código: `"Next.js 16 / React 19"` para el frontend (`app/frontend/package.json`), `"NestJS / TypeORM"` para los módulos del backend (`app/backend/package.json`) y `"PostgreSQL 16"` para las bases de datos (`docker-compose.yml`).

## Qué se corrigió

- **API Gateway eliminado**: la IA propuso inicialmente un contenedor `API Gateway` entre el frontend y los módulos del backend. Al revisar el `docker-compose.yml` se confirmó que no existe: el frontend llama directamente al backend en el puerto 3001. Se eliminó.
- **Sistema de Notificaciones eliminado**: la IA incluyó un sistema externo de notificaciones. Al revisar el código se encontró que la entidad `Notificacion` vive en el schema `monitoreo` de la base de datos local y ningún servicio hace llamadas HTTP a un sistema externo de notificaciones.
- **VictoriaMetrics reubicado**: la IA lo colocó primero como `softwareSystem` externo. Al no estar en el `docker-compose.yml` y ser referenciado por URL, se mantuvo como sistema externo; sin embargo, en versiones anteriores se había modelado incorrectamente como contenedor interno.
- **Tecnologías corregidas**: la IA usó `"Servicio de aplicacion"` y `"SPA"` como tecnología de los módulos. Se corrigió a `"NestJS / TypeORM"` y `"Next.js 16 / React 19"` según el `package.json` real de cada parte.
- **Mapa como dependencia del frontend**: la IA no incluyó la dependencia hacia OpenStreetMap / ArcGIS. Al revisar `MapComponent.tsx` se encontró que Leaflet carga tiles directamente desde el browser, por lo que se agregó `frontend -> mapas`.
- **Dos contenedores separados corregidos a módulos de un solo backend**: la IA modeló inicialmente `gestionMaritima` y `monitoreo` como dos contenedores independientes (dos procesos). Al revisar el `docker-compose.yml` se confirmó que existe un único servicio `backend` en el puerto 3001, por lo que ambos módulos son contenedores lógicos dentro del mismo proceso NestJS.
- **Nombre del módulo corregido**: la IA usó `"Módulo de Gestión Marítima"` como nombre del contenedor. El equipo lo corrigió a `"Módulo de Gestión de Operaciones Marítimas"` para que coincida con el nombre real del módulo en el proyecto.
