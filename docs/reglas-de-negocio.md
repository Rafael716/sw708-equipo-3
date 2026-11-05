# Reglas de negocio actuales

Reglas que el sistema **cumple hoy** (rodaja de Incidencias y piezas relacionadas). Formato pedido por la revisión docente: enunciado · ubicación en código · prueba.

| ID | Qué dice la regla | Dónde vive (archivo y función) | Qué prueba la verifica |
|---|---|---|---|
| RN-01 | El registro de incidencia exige usuario autenticado (`idUsuario` no vacío). | `src/repo/app/backend/src/monitoreo/dominio/registrar-incidencia.use-case.ts` · `RegistrarIncidenciaUseCase.ejecutar` | `registrar-incidencia.characterization.spec.ts` · «rechaza sin usuario» |
| RN-02 | La descripción de la incidencia no puede estar vacía (tras trim). | Mismo use case · `ejecutar` | sin prueba dedicada (se cubre en el flujo de registro válido) |
| RN-03 | El grado de severidad es un entero entre 1 y 5 inclusive. | Mismo use case · `ejecutar` | `registrar-incidencia.spec.ts` · «rechaza severidad fuera de 1..5» |
| RN-04 | El tipo de incidencia debe existir en el catálogo. | Use case · `ejecutar` + puerto `Incidencias.existeTipo` (TypeORM / memoria) | `registrar-incidencia.characterization.spec.ts` · «rechaza tipo inexistente» |
| RN-05 | Toda incidencia se vincula a una operación; la operación debe estar **activa** (estado «En curso»). | Use case · `ejecutar` + `Incidencias.operacionEstaActiva` · TypeORM: `incidencias-typeorm.adapter.ts` · `operacionEstaActiva` | `registrar-incidencia.spec.ts` · «rechaza operación que no está activa» |
| RN-06 | El estado inicial de una incidencia nueva es «Abierta». | Puerto `obtenerEstadoInicial` · TypeORM filtra `nombre: 'Abierta'` en `incidencias-typeorm.adapter.ts` | `registrar-incidencia.spec.ts` · espera `idEstadoIncidencia` sembrado como estado-abierta |
| RN-07 | Cada incidencia recibe un código único `INC-YYMM-####` secuencial del mes. | Use case · `ejecutar` + `Incidencias.siguienteCodigo` | `registrar-incidencia.spec.ts` y characterization · patrón `/^INC-\d{4}-\d{4}$/` |
| RN-08 | El alta es un registro de auditoría inmutable: siempre guarda `idUsuario` y `fechaHora`; el caso de uso de dominio no actualiza esos campos. | Use case · `ejecutar` (post-`guardar`) + `Incidencias.guardar` | `registrar-incidencia.spec.ts` · comprueba `idUsuario` y `fechaHora` en el resultado |
| RN-09 | Si la severidad es crítica (5), se notifica a supervisores. | Use case · `ejecutar` + `Incidencias.notificarSupervisores` · constante `SEVERIDAD_CRITICA` | `registrar-incidencia.spec.ts` · «notifica… severidad es crítica» / «no notifica… no es crítica» |
| RN-10 | El dominio de Incidencias no depende de NestJS ni TypeORM. | Paquete `monitoreo/dominio/` · regla dependency-cruiser | `pnpm --filter backend test:arch` (CI: `.github/workflows/backend-arch.yml`) |
| RN-11 | La última posición GPS se obtiene por consulta SQL ordenada por `fecha_hora` (no hay caché en proceso). | `src/repo/app/backend/src/monitoreo/services/gps.service.ts` · `getUltimaPosicionContenedor` (y análogos) | sin prueba |

## Fuera de la rodaja (aún no como reglas de dominio hexagonal)

Otras capacidades del monolito (reservas, atraque/zarpe, sensores IoT, entregas) existen como módulos Nest/CRUD, pero **no** están documentadas aquí como reglas de negocio verificadas por suite de dominio. Se irán agregando cuando tengan caso de uso + prueba.
