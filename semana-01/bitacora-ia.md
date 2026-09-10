# Bitácora IA — Semana 01

## Prompt utilizado

> Explícame cómo está organizado el código de Spring PetClinic: paquetes principales, responsabilidades de cada uno, y cómo se atiende la petición GET /owners/1 de punta a punta.

---

## Respuesta de la IA (ChatGPT)

Spring PetClinic está organizado en cinco paquetes principales dentro de `org.springframework.samples.petclinic`:

- **model**: Contiene las clases base de persistencia: `BaseEntity`, `NamedEntity`, `Person` y `Clinic`. De aquí heredan todas las entidades del sistema.
- **owner**: Maneja todo lo relacionado a dueños y mascotas: `Owner`, `Pet`, `PetType` y sus controladores. Las visitas (`Visit`) tienen su propio subpaquete dentro de este módulo.
- **vet**: Gestiona veterinarios y especialidades (`Vet`, `Specialty`, `VetController`).
- **service**: Aquí vive `ClinicService`, que actúa como capa intermedia entre los controladores y los repositorios. Centraliza la lógica de negocio para que los controladores no accedan directamente a la base de datos.
- **system**: Configuración general de la aplicación, caché y manejo de errores.

Para la petición `GET /owners/1`, el flujo es el siguiente:

1. Spring MVC recibe la petición y la enruta a `OwnerController`.
2. `OwnerController` llama a `ClinicService.findOwnerById(1)`.
3. `ClinicService` delega en `OwnerRepository`, que extiende `CrudRepository` y ejecuta `findByLastName` para localizar al dueño.
4. El resultado se empaqueta en un modelo y se renderiza con la vista `owners/ownerDetails`.

---

## Tabla de verificación

| # | Afirmación de la IA | Veredicto | Evidencia en el código |
|---|---|---|---|
| 1 | El paquete `model` contiene `BaseEntity`, `NamedEntity`, `Person` y `Clinic` | **Falsa** | Solo existen `BaseEntity`, `NamedEntity` y `Person`. No hay ninguna clase `Clinic` en ese paquete. Verificado en `src/main/java/.../model/`. |
| 2 | Existe un paquete `service` con una clase `ClinicService` | **Falsa** | No existe ningún paquete `service` ni clase `ClinicService` en la versión actual. Los controladores inyectan los repositorios directamente. |
| 3 | `OwnerController` llama a `ClinicService` como intermediario | **Falsa** | `OwnerController` inyecta `OwnerRepository` directamente en su constructor (`OwnerController.java`, línea 55). No hay ninguna capa de servicio. |
| 4 | `OwnerRepository` extiende `CrudRepository` | **Falsa** | `OwnerRepository` extiende `JpaRepository<Owner, Integer>` (`OwnerRepository.java`, línea 36). |
| 5 | El repositorio usa `findByLastName` para buscar un dueño | **Falsa** | El método que existe es `findByLastNameStartingWith(String, Pageable)`, que además devuelve un `Page<Owner>`, no un único resultado. Para buscar por id se usa `findById(Integer)`. |
| 6 | `OwnerController` recibe la petición y busca al dueño | **Cierta** | El método `showOwner(@PathVariable int ownerId)` en `OwnerController.java` (línea 170) hace exactamente eso. |
| 7 | La vista que se renderiza es `owners/ownerDetails` | **Cierta** | `OwnerController.java` línea 171: `new ModelAndView("owners/ownerDetails")`. |
| 8 | Las visitas (`Visit`) tienen su propio subpaquete | **Falsa** | `Visit.java` y `VisitController.java` están dentro del paquete `owner`, no en un subpaquete separado. |
| 9 | El sistema está diseñado para soportar múltiples bases de datos | **No verificable** | El `schema.sql` existe tanto para H2 como para MySQL/PostgreSQL, pero eso no implica soporte simultáneo. El diagrama solo lo menciona como alternativa de despliegue. |

---

## Error principal encontrado

**La IA inventó una capa de servicio que no existe en esta versión.**

La respuesta menciona que `OwnerController` llama a `ClinicService.findOwnerById(1)` y que esa clase centraliza la lógica de negocio. Esto era real en versiones antiguas de PetClinic (antes de la 3.x), donde existía la interfaz `ClinicService` con una implementación `ClinicServiceImpl`. En la versión actual (4.0.0-SNAPSHOT), esa capa fue eliminada por completo.

Lo que realmente hace `OwnerController` es inyectar `OwnerRepository` directamente:

```java
// OwnerController.java — línea 53-56
private final OwnerRepository owners;

public OwnerController(OwnerRepository owners) {
    this.owners = owners;
}
```

Y para atender `GET /owners/1` llama al repositorio sin ningún intermediario:

```java
// OwnerController.java — línea 172-174
Optional<Owner> optionalOwner = this.owners.findById(ownerId);
Owner owner = optionalOwner.orElseThrow(() -> new IllegalArgumentException(
        "Owner not found with id: " + ownerId + ". Please ensure the ID is correct "));
```

La IA mezcló información de versiones distintas y describió una arquitectura de tres capas (Controller → Service → Repository) que en el código actual no existe. El flujo real es de dos capas: Controller → Repository.
