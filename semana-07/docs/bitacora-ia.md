## Bitacora IA

### Fragmento A 


| Patrón evaluado         | Motivo de rechazo |
| ----------------------- |--------------------------------------- |
| Factory Method          | Se centra en delegar la creación de objetos, pero no resuelve la variación de los algoritmos de procesamiento para los comprobantes.   |
| Simple Factory          | Agrupa la creación de objetos, pero habría que modificarlo al agregar nuevos tipos. |
| Abstract Factory        | Es ineficiente si únicamente se necesita intercambiar el comportamiento de los comprobantes y no crear familias de objetos relacionados. |
| Command                 | Encapsular cada operación como objeto no es necesario si el sistema no necesita colas, historial, deshacer operaciones, etc.                     |
| Registry de estrategias | Puede complementar Strategy, pero añade un mecanismo de registro que no es necesario si las estrategias pueden seleccionarse de forma sencilla.                     |
| Tabla de funciones      | Es una opción más sencilla, pero menos adecuada si cada comprobante necesita datos y comportamientos propios. |

### Fragmento B 

| Patrón evaluado         | Motivo de rechazo |
| ----------------------- |--------------------------------------- |
| Template Method  | Reduce duplicación mediante una estructura de pasos común, pero no resuelve directamente las incompatibilidades entre las interfaces de los proveedores.                     |
| Strategy         | Permite intercambiar implementaciones, pero no adapta interfaces incompatibles.   |
| Bridge           | Introduce una estructura adicional que no es necesaria si el objetivo principal es compatibilizar interfaces existentes.|
| Facade           | No garantiza que las interfaces incompatibles de los proveedores se conviertan en una interfaz común. |
| Decorator        | No está diseñado principalmente para resolver incompatibilidades de interfaces.      |
| Factory Method   | Facilita la creación de implementaciones, pero no elimina las diferencias de interfaz entre los proveedores. |
| Abstract Factory | Está orientado a crear familias de objetos relacionados, y el problema no requiere eso |

### Fragmento C

| Patrón evaluado         | Motivo de rechazo |
| ----------------------- |--------------------------------------- |
| Facade              | No se ha identificado una complejidad de acceso que justifique crear una interfaz simplificada.  |
| Adapter             | No existen incompatibilidades de interfaces que deban resolverse. |
| Decorator           | No se necesita extender el comportamiento actual.  |
| Proxy               | No se requiere controlar el acceso al componente, retrasar su inicialización ni gestionar su uso mediante un intermediario.  |
| Strategy            | No se han identificado algoritmos intercambiables ni variaciones de comportamiento que justifiquen separar estrategias. |
| Template Method     | No se ha señalado duplicación entre procesos ni una estructura común con pasos variables que convenga abstraer.  |
| Observer            | No existe una necesidad identificada de notificar automáticamente a otros objetos cuando cambia el estado del componente. |
| Singleton           | No hay necesidad de garantizar una única instancia|
