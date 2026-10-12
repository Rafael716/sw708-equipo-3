# Cuadro del costo del cambio

| Medida | Versión A | Versión B |
|---|---|---|
| **Minutos** | 25:41 | 32:39 |
| **Archivos tocados** | 3 | 6 |
| **Líneas cambiadas** | 52 | 48 |
| **Pruebas que se rompieron** | 4 (`presta_un_equipo_libre`, `no_presta_un_equipo_que_ya_esta_prestado`, `al_devolver_el_equipo_queda_libre`, `el_urgente_tambien_exige_quien_autoriza`) | 4 (`presta_un_equipo_libre`, `no_presta_un_equipo_que_ya_esta_prestado`, `al_devolver_el_equipo_queda_libre`, `guarda_y_recupera_por_id`) |
| **Lugares donde hubo que buscar** | `PrestamoService`, `Prestamo` | `ReglasDePrestamo`, `PrestamoService`, `Prestamo`, `RepositorioDePrestamos` |

**Detalle de las pruebas rotas:** 

**Version A**

Durante el desarrollo de la versión A fallaron cuatro pruebas por errores introducidos en el código. Primero, presta_un_equipo_libre, no_presta_un_equipo_que_ya_esta_prestado y al_devolver_el_equipo_queda_libre no compilaban porque se usó .equals(false) sobre un boolean primitivo, lo que generó el error Cannot invoke equals(boolean) on the primitive type boolean. Se corrigió reemplazando esa comparación por una expresión válida para booleanos, y las tres pruebas pasaron a ejecutarse correctamente. Después, la única que siguió fallando fue el_urgente_tambien_exige_quien_autoriza, porque el método prestarUrgente() usaba una variable contador que nunca se declaró (contador cannot be resolved to a variable). Todos estos errores se detectaron ejecutando las pruebas con Maven y se fueron corrigiendo durante el proceso.

**Version B**

En la versión B se rompieron las pruebas del servicio de préstamos y del repositorio en memoria, en cuatro casos. presta_un_equipo_libre, no_presta_un_equipo_que_ya_esta_prestado y al_devolver_el_equipo_queda_libre fallaron primero porque la llamada a validar no coincidía con la firma definida en ReglasDePrestamo. Al corregir eso, volvieron a fallar porque ReglasDePrestamo accedía directamente a los campos codigoAlumno y devuelto del record Prestamo, cuando debía usar sus accesores codigoAlumno() y devuelto(). Por otro lado, guarda_y_recupera_por_id falló porque el record Prestamo no tenía el constructor de seis parámetros que usaba la prueba, y se resolvió agregando un constructor compatible. Al final, las 5 pruebas de la versión B quedaron en verde, con 0 fallos y 0 errores.

## Conclusión

En los cambios solicitados, A fue más rápida (25:41 vs 32:39) y tocó la mitad de archivos (3 vs 6), con un volumen de líneas similar (52 vs 48). B repartió el cambio entre más archivos y exigió buscar en más lugares.

---

## Anexo: resultados de los comandos de git

Ejecutados desde `version-a`, por eso los archivos de `version-b` aparecen con la ruta `../version-b/`.

### `git status --short`

```
PS C:\Users\Jordan\Documents\GitHub\sw708-caso-costo-del-cambio\version-a> git status --short
 M src/main/java/pe/uni/fiis/prestamos/Prestamo.java
 M src/main/java/pe/uni/fiis/prestamos/PrestamoService.java
 M ../version-b/src/main/java/pe/uni/fiis/prestamos/dominio/Prestamo.java
 M ../version-b/src/main/java/pe/uni/fiis/prestamos/dominio/PrestamoService.java
 M ../version-b/src/main/java/pe/uni/fiis/prestamos/dominio/ReglasDePrestamo.java
 M ../version-b/src/main/java/pe/uni/fiis/prestamos/dominio/RepositorioDePrestamos.java
 M ../version-b/src/test/java/pe/uni/fiis/prestamos/dominio/PrestamoServiceTest.java
 M ../version-b/src/test/java/pe/uni/fiis/prestamos/infraestructura/RepositorioEnMemoriaTest.java
```

### `git diff --stat`

```
PS C:\Users\Jordan\Documents\GitHub\sw708-caso-costo-del-cambio\version-a> git diff --stat
 .../main/java/pe/uni/fiis/prestamos/Prestamo.java  |  6 ++--
 .../pe/uni/fiis/prestamos/PrestamoService.java     | 34 ++++++++++++++++++----
 .../pe/uni/fiis/prestamos/PrestamoServiceTest.java | 12 ++++----
 .../pe/uni/fiis/prestamos/dominio/Prestamo.java    |  4 +--
 .../fiis/prestamos/dominio/PrestamoService.java    | 14 ++++-----
 .../fiis/prestamos/dominio/ReglasDePrestamo.java   | 14 ++++++++-
 .../prestamos/dominio/RepositorioDePrestamos.java  |  2 +-
 .../prestamos/dominio/PrestamoServiceTest.java     | 12 ++++----
 .../infraestructura/RepositorioEnMemoriaTest.java  |  2 +-
 9 files changed, 69 insertions(+), 31 deletions(-)
```

