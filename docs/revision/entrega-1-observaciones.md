# Observaciones del docente: Entrega 1

Revisión del 20 de octubre de 2026 sobre el commit `69a5daf`, el que declara el informe, y sobre el submódulo `src/repo` en el commit que ese commit fija (`a4a342f`). Los ocho commits que llegaron a `main` después de la hora límite (el 17 de octubre por la noche, hasta `bb22353`) no se consideraron.

La nota ya está en UNIVIRTUAL. Este archivo es el detalle de por qué, y sirve para la entrega final.

**Cómo se cierra.** Respondan en un comentario de este pull request qué van a hacer con cada viñeta de las secciones 1 a 8. Lo que decidan no hacer también vale, siempre que quede escrito el porqué. Cuando hayan respondido todas, intégrenlo con **Squash and merge** (no con *Close pull request*), como vimos en el taller: así este archivo queda en `docs/revision/` y el issue se cierra solo. La rama está en mi fork, así que no tienen que borrarla.

## Lo que está bien hecho

- **La rodaja de Incidencias es lo más avanzado de su entrega.** `RegistrarIncidenciaUseCase` no importa Nest ni TypeORM, y la misma suite de dominio corre con el adaptador en memoria y con el de TypeORM.
- **La regla de arquitectura funciona.** dependency-cruiser pasó en verde en GitHub Actions, y comprobé que sí detecta un import prohibido.
- **El C4 sale de un `workspace.dsl` versionado**, con las relaciones etiquetadas.
- **Los cinco escenarios nombran su instrumento**, los dos ADR tienen formato Nygard y el ADR-0001 se apoya en el cuadro del costo del cambio.

## 1. Escenarios de calidad

- **La prioridad contradice su propio criterio.** El texto dice que la prioridad sale del impacto, pero E4 tiene impacto 3 y quedó en Media.
- **La decisión de E2 cita mecanismos que no están en el código**: la «caché de la última posición» no existe (`gps.service.ts` solo consulta la última posición por SQL) y el adaptador en memoria es para pruebas, no un mecanismo de resiliencia.
- **La rodaja no cubre lo que exige E3**: el caso de uso no implementa el registro inmutable, la notificación a supervisores ni la validación de operación activa.

## 2. Modelo C4

- **Monitoreo y Gestión Marítima corren en el mismo proceso NestJS**, así que no son dos contenedores. Lo mismo con los tres esquemas de un mismo PostgreSQL.
- **Faltan partes del backend**: los módulos de reservas (`GestionReservaModule`) y portuario (`GestionPortuariaModule`), que registra `app.module.ts`, y las áreas de operaciones terrestres y personal de tripulación, que tienen esquema propio y entidades que el código ya usa.
- **El nivel de componentes no muestra la rodaja**: ni el caso de uso, ni el puerto, ni los adaptadores.

## 3. Decisiones de arquitectura

- **El enunciado pide tres ADR y entregaron dos.** Además, el anexo del informe cambió el criterio a «Dos ADR». La rúbrica no se modifica.
- Escriban el tercero sobre puertos y adaptadores: es una decisión que ya está en su código y no tiene ADR.
- En el informe, el ADR-0002 no tiene fecha y cita una ruta que no existe (`src/repo/app.module.ts`). Además, las fichas de los ADR citan `docs/adr/0001-...md` y `docs/adr/0002-...md`, que tampoco existen: los archivos están en `semana-04-05/docs/adr/`.

## 4. Rodaja vertical

- **El caso de uso se arma con `new` dentro del controlador**, que recibe la clase concreta `IncidenciasTypeormAdapter` en lugar de pedir el puerto por un token de inyección. Cambiar de adaptador obliga a editar el controlador.
- **`obtenerEstadoInicial` del adaptador TypeORM toma cualquier estado** (`findOne` sin condición), no necesariamente «abierta».
- **El dominio no valida que la operación esté activa**, aunque el informe dice que sí.
- **El código y la CI viven en otro repositorio** (el submódulo `Bluethem/dbdgrupo5-25-2`), y `sw708-equipo-3` no tiene workflows propios. Para la entrega final, la CI tiene que correr en `sw708-equipo-3`: pueden mantener el submódulo si el workflow lo clona (`submodules: true` en `actions/checkout`) y corre ahí las pruebas y la regla, o traer el código al repositorio.

## 5. Informe y repositorio

- **Errores de ortografía**: «la interfaz válida forma», «el dominio válida significado», «Qué válida cada lado» y «Lo que la interfaz válida» (es *valida*); «6.3 Puerta de salida» (es *Puerto*); «Perdida de señal» (es *Pérdida*); «Nuevo sensores» (es *Nuevos*); y «Corimanya» en el registro de versiones (es *Ccorimanya*).
- **Marcadores sin completar**: «último run: enlace», «Enlace al workflow: click» y «link» en los ADR.
- **En el commit revisado, el README de la raíz no explicaba cómo construir**: solo listaba a los integrantes. El que subieron a `main` después de la hora límite (`247ac4d`) ya lo explica; corrijan ahí el usuario de Pablo, que figura como `Pablo-Dev` (su cuenta es `PabloDev-eng`), y la carpeta `docs/`, que menciona y no existe.
- No hay `docs/arquitectura.md` ni `docs/adr/` en la raíz: los documentos están repartidos por semana. Para la entrega final, sigan la estructura del enunciado.

## 6. Git, con lo que vimos en el taller

Lo bueno: más de la mitad de sus commits ya usan prefijo (26 de los 49 que no son merge). Lo que falta:

- **El código del proyecto entra directo a `main`**: en el submódulo, los 22 commits hasta `a4a342f` (la rodaja y la CI incluidas) se subieron sin rama ni pull request, y en `sw708-equipo-3` solo dos pull requests llegaron a `main`. Los laboratorios pueden ir sin rama; el código, no.
- No hay rama `develop`, como pide la Guía de Git (sección 3).
- Los merges del tipo «Merge branch 'main' of ...» aparecen cuando alguien hizo commits sobre una copia desactualizada de `main` y Git tuvo que fusionar al traer los cambios. Empiecen siempre con `git pull`.
- Las ramas no siguen `tipo/numero-de-issue-descripcion`, en minúsculas y con guiones (por ejemplo, `Costo_Cambio`), y `docs/Evidencia_Rafael` lleva el nombre de un integrante.
- No hay `.gitignore` en la raíz de `sw708-equipo-3`.
- Mensajes como «bitacora», «bitacora con 2 lineas» o «completando recuadro» no dicen qué cambió, y «update(src)» no es un prefijo de la convención.
- Henry tiene solo dos commits: cada integrante sube lo suyo, desde su cuenta.

## 7. Identidad unificada

Cada usuario de GitHub, a quién pertenece y cómo aparece hoy en el historial (en este repositorio y en el submódulo):

| Integrante | Usuario de GitHub | Cómo aparece en los commits | Qué corregir |
|---|---|---|---|
| Olivos Gallardo, Adriano Rafael | @Rafael716 | «Rafael716» y, en lo hecho desde GitHub, «Rafael» (el nombre de su perfil) | Su nombre completo, como figura en la matrícula |
| Chumpitaz Flores, Romel Rodrigo | @RomelCF | «RomelCF» y, en lo hecho desde GitHub, «Romel Rodrigo Chumpitaz Flores» | Su nombre completo también en `git config` |
| Luza Ccorimanya, David | @Bluethem | «Bluethem», con el correo privado de GitHub, y «bluethem», con el @uni.pe | Su nombre completo y un solo correo |
| Medina Malpartida, Henry Javier | @h3nr7M3d | «h3nr7M3d», con un correo personal | Su nombre completo y su correo @uni.pe |
| Muñoz Bolaños, Pablo Antonio | @PabloDev-eng | «Pablo Muñoz» y «PabloMuñoz», con el @uni.pe y con un correo personal | Un solo nombre y su correo @uni.pe |

Además, la rodaja se atribuye a @Rafael716 en el informe, pero los commits del submódulo son de @Bluethem (David). Si trabajaron en pareja, que cada uno haga commit desde su propia cuenta.

Cada integrante, en su máquina, con su nombre completo y su correo @uni.pe:

```bash
git config --global user.name "Nombres Apellidos"
git config --global user.email "su.correo@uni.pe"
```

En GitHub, pongan ese mismo nombre en su perfil (los merges hechos desde la web toman el nombre del perfil) y agreguen su correo @uni.pe en *Settings > Emails*, para que sus próximos commits queden enlazados a su cuenta.

Para juntar lo que ya está en el historial, agreguen un archivo `.mailmap` en la raíz, con una línea por cada identidad vieja:

```text
Nombres Apellidos <su.correo@uni.pe> Nombre-viejo <correo-viejo>
```

Eso ordena `git log` y `git shortlog`; la web de GitHub sigue mostrando el nombre original de cada commit.

## 8. Sus reglas de negocio actuales

Agreguen `docs/reglas-de-negocio.md` con las reglas de negocio que el sistema cumple hoy. Para cada una: qué dice la regla, dónde vive en el código (archivo y función) y qué prueba la verifica, o «sin prueba». Con eso se revisan la rodaja y los escenarios de la entrega final.

## Prioridad sugerida

| Orden | Punto | Por qué primero |
|---|---|---|
| 1 | El tercer ADR, sobre puertos y adaptadores (3) | Es el criterio que más bajó en esta entrega |
| 2 | Código y CI en el repositorio del proyecto (4) | La evidencia tiene que estar en un solo lugar |
| 3 | `docs/reglas-de-negocio.md` y las reglas de E3 en el dominio (8 y 1) | Es lo que el informe promete y el código no hace |
| 4 | C4 corregido contra el código (2) | El modelo tiene que coincidir con el código |
| 5 | Ortografía, marcadores y README (5) | Son cambios rápidos |
