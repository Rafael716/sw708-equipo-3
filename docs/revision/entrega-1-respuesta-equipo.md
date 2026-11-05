# Respuesta del Equipo 3 a las observaciones de Entrega 1

Documento para el comentario del [PR #7](https://github.com/Rafael716/sw708-equipo-3/pull/7) (`docs/revision/entrega-1-observaciones.md`).  
Las correcciones van en ramas propias (p. ej. `fix/ajustes-entrega1`), no en el PR del docente.

**Estado:** varias viñetas ya están implementadas en `fix/ajustes-entrega1`; el resto queda planificado como se indica abajo.

---

## 1. Escenarios de calidad

| Viñeta | Qué haremos |
|---|---|
| Prioridad de E4 contradice el criterio (impacto 3 → Media) | **Corregir.** E4 pasa a prioridad **Alta** (la prioridad sigue el impacto). Ya aplicado en `docs/arquitectura.md`. |
| E2 cita caché y adaptador en memoria que no existen como resiliencia | **Corregir el texto.** La decisión de E2 queda alineada al código: consulta SQL de la última posición en `GpsService` + health check. El adaptador en memoria se describe solo como herramienta de pruebas. |
| E3 no está en el dominio (inmutable, supervisores, operación activa) | **Implementar en el dominio.** En `RegistrarIncidenciaUseCase`: validación de operación activa (`En curso`), registro con `idUsuario` + `fechaHora`, y `notificarSupervisores` si severidad = 5. Cubierto con pruebas. |

---

## 2. Modelo C4

| Viñeta | Qué haremos |
|---|---|
| Monitoreo y Gestión Marítima no son dos contenedores; lo mismo con los esquemas de PostgreSQL | **Corregir el DSL.** Contenedores reales: Frontend, **un** Backend NestJS, **un** PostgreSQL. Ya en `semana-03/docs/c4/workspace.dsl`. |
| Faltan reservas, portuario, terrestres y tripulación | **Incluirlos** como componentes/áreas del Backend alineados a `app.module.ts` y a los esquemas del código. |
| El nivel de componentes no muestra la rodaja | **Mostrar la rodaja:** `IncidenciasController` → `RegistrarIncidenciaUseCase` → puerto `Incidencias` → adaptadores TypeORM y memoria. |

*Pendiente operativo:* regenerar las imágenes PNG en `assets/` desde el DSL actualizado.

---

## 3. Decisiones de arquitectura

| Viñeta | Qué haremos |
|---|---|
| Falta el tercer ADR | **Escribir ADR-0003** (puertos y adaptadores). Hecho: `docs/adr/0003-puertos-y-adaptadores.md` y `semana-04-05/docs/adr/003-…`. |
| ADR-0002 sin fecha / ruta inexistente / fichas apuntan a `docs/adr/` que no existía | **Corregir.** Fecha en ADR-0002; ruta a `src/repo/app/backend/src/app.module.ts`; carpeta canónica `docs/adr/` con 0001–0003. |

No modificamos la rúbrica ni el criterio de «tres ADR».

---

## 4. Rodaja vertical

| Viñeta | Qué haremos |
|---|---|
| `new` del use case / adaptador concreto en el controlador | **Corregir DI.** Token `INCIDENCIAS_PORT` + `RegistrarIncidenciaUseCase` por factory; el controlador ya no instancia el adaptador. |
| `obtenerEstadoInicial` toma cualquier estado | **Corregir.** TypeORM busca el estado con nombre **«Abierta»**. |
| Dominio no valida operación activa | **Corregir.** Puerto `operacionEstaActiva`; TypeORM exige estado **«En curso»**. |
| Código y CI en otro repo / submódulo | **Traer el código a este repo** (ya no submódulo) y workflows en `.github/workflows/` de `sw708-equipo-3` (`backend-arch.yml`, etc.). |

---

## 5. Informe y repositorio

| Viñeta | Qué haremos |
|---|---|
| Ortografía (valida, Puerto, Pérdida, Nuevos, Ccorimanya) | **Corregir** en el informe canónico `docs/arquitectura.md`. |
| Marcadores `[enlace]` / `[click]` / `[link]` | **Completar** con URLs al workflow de Actions de este repositorio y a `docs/adr/`. |
| README: usuario de Pablo y carpeta `docs/` | **Corregir.** `PabloDev-eng`; README describe `docs/` real y cómo construir. |
| Falta `docs/arquitectura.md` y `docs/adr/` | **Crear** según el enunciado. Hecho. |

---

## 6. Git (taller)

| Viñeta | Qué haremos |
|---|---|
| Código directo a `main` sin PR | **Atender.** Protección de `main` (Require PR) la configura un admin del repo; en `.github/` ya hay plantilla de PR y `pr-guard.yml` (nombre de rama). |
| No hay rama `develop` | **Crear `develop`** a partir de `main` y usarla como base de integración. |
| Merges «Merge branch 'main' of …» | **Práctica de equipo:** siempre `git pull` (o rebase) antes de trabajar/push. No requiere cambio de código. |
| Nombres de rama fuera de convención | **Atender de aquí en adelante** con `tipo/numero-descripcion` (el guard de PR lo refuerza). No renombraremos ramas históricas remotas. |
| No hay `.gitignore` en la raíz | **Agregar.** Hecho en la rama de ajustes. |
| Mensajes de commit pobres / `update(src)` | **Atender de aquí en adelante** con prefijos `feat|fix|docs|chore|…` y mensajes que digan qué cambió. No reescribiremos el historial viejo. |
| Henry con pocos commits | **Atender.** Cada integrante sube lo suyo desde su cuenta; Henry participa con commits propios en las correcciones de entrega final. |

---

## 7. Identidad unificada

| Viñeta | Qué haremos |
|---|---|
| Cada uno: nombre completo + `@uni.pe` en `git config` y perfil GitHub | **Atender (acción individual).** David ya dejó `David Luza Ccorimanya` / `david.luza.c@uni.pe`. El resto del equipo aplica el mismo patrón en su máquina y en GitHub (*Settings → Emails*). |
| Archivo `.mailmap` | **Agregar.** Hecho en la raíz, con aliases históricos → `Nombres Apellidos <correo@uni.pe>`. Henry actualizará a `@uni.pe` cuando lo tenga. |
| Atribución rodaja informe vs commits | **Aclarar en el informe** el trabajo en pareja y que los commits futuros salgan de la cuenta de quien implementa. |

---

## 8. Reglas de negocio

| Viñeta | Qué haremos |
|---|---|
| Agregar `docs/reglas-de-negocio.md` | **Agregar.** Hecho: regla → archivo/función → prueba (o «sin prueba»), incluyendo las de E3. |

---

## Cierre de este PR del docente (#7)

1. Publicamos este contenido como **comentario** en el PR #7.  
2. Hacemos **Squash and merge** del PR #7 para que `docs/revision/entrega-1-observaciones.md` quede en `main`.  
3. Las correcciones continúan en PRs propios (p. ej. desde `fix/ajustes-entrega1`), no en la rama del fork del docente.
