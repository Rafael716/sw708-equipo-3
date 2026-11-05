# Particiones

## Particion A

![particiones](/semana-09/assests/particiones.png)


## Particion B

A diferencia de la Partición A (donde se separaba técnicamente Frontend de Backend), en la **Partición B cada módulo corta verticalmente el sistema**, agrupando su propia interfaz de usuario, lógica de backend y esquemas de base de datos según el área funcional:

### Módulos resultantes de la Partición B

#### 1. Módulo de Gestión de Reservas
* **Responsabilidad de negocio:** Alta y seguimiento comercial de las reservas de carga, registro de clientes, cotización de fletes y consulta de tarifas.
* **Qué entra:**
  * **Frontend:** Vistas y formularios en `frontend/app/gestion-reservas/`.
  * **Backend:** Controladores y servicios de `backend/src/gestion_reserva/`. 
  * **Datos:** Esquema relacional `gestion_reserva` en PostgreSQL.

#### 2. Módulo de Operaciones Marítimas y Portuarias
* **Responsabilidad de negocio:** Coordinación de la travesía náutica, asignación de muelles, programación de atraques y zarpes de buques, maniobras de estiba y control de grúas/equipos portuarios.
* **Qué entra:**
  * **Frontend:** Vistas en `frontend/app/operaciones-portuarias/` y `frontend/app/operaciones-maritimas/`.
  * **Backend:** Controladores y entidades en `backend/src/gestion_portuaria/` y `backend/src/gestion_maritima/`.
  * **Datos:** Esquema `gestion_maritima` en PostgreSQL.

#### 3. Módulo de Operaciones Terrestres
* **Responsabilidad de negocio:** Despacho de carga por tierra, asignación de camiones/vehículos a estaciones de transferencia y seguimiento del trayecto terrestre previo o posterior al embarque marítimo.
* **Qué entra:**
  * **Backend:** Servicios y entidades en `backend/src/operaciones_terrestres/`.
  * **Datos:** Esquema `operaciones_terrestres` en PostgreSQL.

#### 4. Módulo de Personal y Tripulación
* **Responsabilidad de negocio:** Control de dotación operativa: capitanes de buque, tripulantes asignados a travesías y cuadrillas de trabajadores portuarios.
* **Qué entra:**
  * **Backend:** Servicios y entidades en `backend/src/personal_tripulacion/` y tablas de soporte `shared/entities/empleado.entity.ts`.
  * **Datos:** Tablas de asignación de tripulantes y personal.

#### 5. Módulo de Monitoreo y Telemetría en Tiempo Real
* **Responsabilidad de negocio:** Supervisión 24/7 de activos (contenedores y buques) mediante señales satelitales GPS, ingesta de telemetría IoT (temperatura, aceleración), visualización de mapas y detección/gestión de incidencias operativas.
* **Qué entra:**
  * **Frontend:** Vistas de mapas interactivos con Leaflet en `frontend/app/monitoreo/`.
  * **Backend:** Controladores y servicios en `backend/src/monitoreo/`.
  * **Datos:** Esquema `monitoreo` en PostgreSQL + base de datos de series temporales (VictoriaMetrics / Timescale).

---

### Palabra: reserva

#### La palabra que cambia

- Para el módulo de gestion de reservas: Se necesita los datos del cliente, mercancia a transportar, fecha y hora en que desea la entrega.

- Para el módulo de gestión de operaciones marítimas: Se necesita la fecha en que partira la reserva, el buque donde sera transportado, el puerto de donde saldra, el puerto donde hay que llevarlo.

- Para el módulo de gestión de operaciones terrestres: Se necesita el camion donde se llevara la reserva, la estacion desde donde saldra, la estacion donde hay que llevarlo.

- Para el módulo de tripulacion: Se necesita saber que tripulacion que llevara la reserva.

- Para el módulo de monitoreo: Se necesita saber donde se encuentra exactamente la reserva y que incidentes tuvo junto con la fecha respectiva.


#### Cambian Juntas

Se evidencia que cuando el equipo hace un cambio, modifica al mismo tiempo el frontend y el backend de una sola área, sin tocar las demás:

- Para el módulo de monitoreo: En el commit 4494a9c ("Implementacion base de datos noSQL"), cambiaron juntos los servicios de sensores y base de datos con las pantallas del mapa en el frontend.

- Para el módulo de gestión de reservas: En los commits ea984eb y f772a44 ("update"), se modificaron juntos exclusivamente los controladores y servicios de reservas junto con sus paginas

- Para el módulo de gestión de operaciones portuarias / marítimas: En los commits 32205fc y 969faa1, cambiaron juntos los controladores portuarios con sus vistas de interfaz

#### Dueños distintos

- Para el módulo de gestion de reservas: personal de recepción de reservas.

- Para el módulo de gestion de operaciones marítimas: tripulantes, personal de logística.

- Para el módulo de gestión de operaciones terrestres: conductores, personal de logística 

- Para el módulo de tripulacion: capitan de la tripulación. 

- Para el módulo de monitoreo: personal de monitoreo, control y aseguramiento de calidad.

#### Ciclos distintos

- Para el módulo de gestión de reservas: Es la consulta que más se repite en el sistema, porque es el inicio de todo el flujo de la reserva.

- Para el módulo de gestión de operaciones marítimas: Se consulta con fecuencia media durante el traslado marítimo.

- Para el módulo de gestión de operaciones terrestres: Se consulta con frecuencia media durante el traslado terrestre.

- Para el módulo de tripulacion: Se consulta con poca frecuencia durante el traslado de la mercancia y para auditoria. 

- Para el módulo de monitoreo: El GPS se consulta constantemente y se maneja mediante la extension de TimeScale para PostgreSQL. 
 

## Confrontación de escenarios

Objetivo: que decida el escenario de calidad, no el gusto.

Se confrontan la **Partición A** (división horizontal por capas técnicas reflejada en `particiones.png`: `Backend` y `Frontend`) y la **Partición B** (corte vertical por capacidades de negocio) frente a los escenarios de calidad definidos en la Semana 2 (`semana-02/docs/escenario.md`), respondiendo a las cuatro preguntas arquitectónicas:

### Cuadro comparativo por escenario

| Escenario de Calidad (Semana 2) | Pregunta de Evaluación | Partición A (Capas Técnicas - Backend / Frontend) | Partición B (Capacidades de Negocio) | Ganador |
| :--- | :--- | :--- | :--- | :---: |
| **1. Mantenibilidad**<br>*(Agregar nuevo sensor IoT o cambiar umbral en < 1 día sin downtime)* | • **¿Cuántos módulos toca?**<br>• **¿Datos del otro lado?**<br>• **¿Escala solo?**<br>• **¿Se prueba aislado?** | **Mala (3 módulos):** Toca `frontend/app/monitoreo/`, `backend/src/monitoreo/` (`sensores.service.ts`, `vm-demo.controller.ts`) y esquemas en BD.<br>**Mala:** Requiere consultar y modificar esquemas compartidos en `shared`.<br>**Mala:** La carga del nuevo procesamiento cae en el proceso común de la API NestJS.<br>**Mala:** Requiere levantar frontend, backend y PostgreSQL juntos. | **Buena (1 módulo):** Afecta únicamente al módulo vertical de **Monitoreo y Telemetría**.<br>**Buena:** No, la configuración de sensores y umbrales es interna del dominio.<br>**Buena:** Sí, el worker/servicio de telemetría IoT escala de forma focalizada con VictoriaMetrics.<br>**Buena:** Sí, con pruebas unitarias sobre `sensores.service.ts` usando mocks. | **B** |
| **2. Fiabilidad**<br>*(Pérdida de señal satelital GPS en alta mar; retener última posición y auto-reconexión)* | • **¿Cuántos módulos toca?**<br>• **¿Datos del otro lado?**<br>• **¿Escala solo?**<br>• **¿Se prueba aislado?** | **Mala (3 módulos):** Backend (`gps.service.ts`), BD (`posicion-buque.entity.ts`) y Frontend (`MapHeader.tsx`).<br>**Mala:** Consulta directa a tablas de buques y viajes sin contrato explícito.<br>**Mala:** La ráfaga de reconexión compite con el tráfico de reservas y puertos en el mismo proceso de Node.js.<br>**Mala:** Requiere levantar toda la suite de servicios. | **Buena (1 módulo):** Afecta únicamente al módulo de **Monitoreo y Telemetría** (`GpsService`).<br>**Buena:** No; solo recibe el `activo_id` bajo contrato explícito.<br>**Buena:** Sí, la ingesta GPS absorbe las reconexiones de forma aislada.<br>**Buena:** Sí, mediante pruebas unitarias simulando desconexión satelital contra el servicio. | **B** |
| **3. Interoperabilidad**<br>*(Buque atraca en Operaciones Marítimas y se refleja en Monitoreo sin intervención)* | • **¿Cuántos módulos toca?**<br>• **¿Datos del otro lado?**<br>• **¿Escala solo?**<br>• **¿Se prueba aislado?** | **Mala:** Corta por el medio entre capas sin frontera clara.<br>**Mala:** Evidenciada en `monitoreo.module.ts` (L33-36), que importa directamente entidades de `../gestion_maritima/entities/` (`Puerto`, `Muelle`, `RutaMaritima`).<br>**Mala:** Consultas masivas al dashboard saturan la BD transaccional de atraques.<br>**Mala:** Se requiere desplegar frontend y backend completos. | **Buena (2 módulos con frontera):** Emisor (**Operaciones Marítimas**) y Receptor (**Monitoreo**).<br>**Buena:** Solo mediante contrato explícito (evento o DTO de cambio de estado), eliminando los imports cruzados de entidades.<br>**Buena:** Monitoreo escala lecturas masivas sin afectar el registro de atraques.<br>**Buena:** Sí, se prueba Monitoreo inyectando un evento mock de atraque. | **B** |
| **4. Seguridad / Auditoría**<br>*(Incidencia crítica con log cifrado y notificación a responsables en < 24h)* | • **¿Cuántos módulos toca?**<br>• **¿Datos del otro lado?**<br>• **¿Escala solo?**<br>• **¿Se prueba aislado?** | **Mala (3 o más):** Lógica dispersa entre controladores, guardias JWT (`auth/guards/jwt-auth.guard.ts`) y esquemas en BD.<br>**Mala:** Acceso indiscriminado a tablas de personal y usuarios sin contrato.<br>**Mala:** La sobrecarga del cifrado y auditoría impacta a todo el backend.<br>**Mala:** Requiere levantar todos los contenedores para validar auditoría. | **Buena (1 módulo con frontera):** Se resuelve en **Monitoreo e Incidencias** coordinando con Personal.<br>**Buena:** Contrato explícito con el token de sesión y DTO de incidencia.<br>**Buena:** El servicio de registro/auditoría escala de forma independiente.<br>**Buena:** Sí, cuenta con `dominio/incidencias.port.ts` y su adaptador de prueba `infraestructura/incidencias-en-memoria.adapter.ts`. | **B** |
| **5. Capacidad de Interacción**<br>*(Identificar estado crítico de operación en mapa en < 10s con código de colores)* | • **¿Cuántos módulos toca?**<br>• **¿Datos del otro lado?**<br>• **¿Escala solo?**<br>• **¿Se prueba aislado?** | **Mala (2 módulos acoplados):** Frontend (`app/monitoreo`) depende de múltiples endpoints dispersos del backend para armar la vista.<br>**Mala:** El frontend debe orquestar datos de tablas distintas.<br>**Mala:** No escala de forma independiente.<br>**Mala:** Requiere tener la API corriendo con datos de prueba cargados. | **Buena (1 módulo vertical):** La vista Leaflet y el servicio de telemetría conviven en **Monitoreo**.<br>**Buena:** El frontend consume una proyección consolidada de su propio módulo.<br>**Buena:** Sí, la entrega de mapa y tiles escala con cache estático.<br>**Buena:** Sí, mediante pruebas visuales de componentes con fixtures mockeados. | **B** |

---

### Chequeo contra las 4 señales del monolito distribuido

Para garantizar que la Partición B no degenere en un monolito distribuido (lo que la descartaría automáticamente), se evalúan las cuatro señales críticas sobre el código real de la aplicación:

1. **¿Exige despliegues coordinados? (Acoplamiento de despliegue)**
   * **No a nivel de arquitectura distribuida.** Al tratarse de un **monolito modular** (ADR-001), físicamente el backend se compila y levanta en un solo proceso (`npm run start:dev` / contenedor Docker), por lo que un nuevo despliegue actualiza el contenedor completo. Sin embargo, **no sufre del antipatrón de despliegues coordinados en red**: no existen servicios distribuidos independientes que exijan sincronización forzada de versiones. Las fronteras modulares garantizan que modificar la lógica interna de sensores IoT en `backend/src/monitoreo/services/sensores.service.ts` no rompa el contrato ni obligue a coordinar cambios de código con los desarrolladores de reservas o puertos.
2. **¿Existe base de datos compartida sin dueño claro?**
   * **No.** En la Partición A, `monitoreo.module.ts` importaba entidades de `gestion_maritima` y `operaciones_terrestres`. En la **Partición B**, cada capacidad es dueña estricta de su esquema PostgreSQL (`gestion_reserva`, `gestion_maritima`, `operaciones_terrestres`, `monitoreo`), relegando el esquema `shared` exclusivamente a identidades mínimas compartidas.
3. **¿Hay comunicación conversadora en cascada (Chatty calls)?**
   * **No.** Las consultas del mapa interactivo y los dashboards se atienden mediante proyecciones consolidadas desde el propio módulo de monitoreo, evitando cadenas de llamadas HTTP síncronas entre módulos para dibujar un contenedor o buque.
4. **¿Hay duplicación o fuga de lógica de dominio?**
   * **No.** Las reglas de cálculo de incidencias y alertas pertenecen exclusivamente a `Monitoreo` (`dominio/registrar-incidencia.use-case.ts`); las reglas de tarifas pertenecen a `gestion_reserva`; y la asignación de atraques a `gestion_portuaria`. No hay lógica duplicada en la capa web ni en otros módulos.

---


## Elección y sustentación de la partición

### Partición elegida: Partición B (Capacidades de Negocio)

Descartamos la **Partición A** porque cualquier cambio nuevo (un sensor o una alerta) obliga a modificar tres capas a la vez (frontend, backend y base de datos) y genera dependencias cruzadas entre tablas que no deberían conocerse.

#### 1. Qué gana
* **Cambios localizados:** Cada requerimiento se resuelve dentro de su propio módulo (pantalla, lógica y tablas), cumpliendo con hacer cambios en menos de 1 día y sin downtime.
* **Aislamiento de carga:** La telemetría satelital/IoT de alta frecuencia no compite por recursos ni frena los procesos transaccionales de reservas o puertos.
* **Pruebas independientes:** Podemos probar la lógica de negocio con dobles de prueba en memoria sin tener que levantar toda la base de datos ni todo el sistema.
* **Trabajo en paralelo:** Cada integrante puede avanzar en su módulo sin pisar esquemas de BD ni generar conflictos en Git.

#### 2. Qué pierde
* **Consultas cruzadas más trabajosas:** No se pueden hacer JOINs directos entre tablas de distintos dominios; exige definir contratos (DTOs) o vistas agregadas.
* **Duplicación mínima:** Para mantener el desacoplamiento, algunos datos básicos (como el nombre del buque) se repiten en eventos y proyecciones.
* **Exige disciplina:** Si alguien se descuida e importa entidades de otro módulo por atajo, el monolito modular se degrada a una bola de barro.

#### 3. Qué tendría que pasar para cambiar de idea
* **Para volver a la Partición A (Capas técnicas):** Que el sistema se vuelva un CRUD básico y estático mantenido por una sola persona, donde mantener contratos y esquemas separados sea puro trabajo extra sin beneficio.