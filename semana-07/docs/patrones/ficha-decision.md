# Ficha de decisión 

# Fragmento A

## Problema que se repite
Cada tipo nuevo de comprobante obliga a editar el mismo if.

## Patrón evaluado

Patron estructural Strategy. 

Alternativa mirada: tabla de
funciones indexada por tipo.

## Decisión

SE APLICA 

## Motivo, en una frase

Libera la saturación del if empleado y ayuda a la escalabilidad del sistema.

## Qué se pierde al aplicarlo

Tres archivos más y un salto de indirección para leer el flujo completo.


# Fragmento B

## Problema que se repite
Se repite la mayor parte de la logica y estructura de las clases empleadas para comunicarse con proveedores distintos.

## Patrón evaluado

Patron Adapter. 

Alternativa mirada: Template Method.

## Decisión
SE APLICA 

## Motivo, en una frase

Lo que cambia es la forma de conectarse con los proveedores no la funcionalidad en sí, por lo que se prefiere al adapter antes que el template method.

## Qué se pierde al aplicarlo

Duplicidad de código en la logica de las clases similares.

# Fragmento C

Aquí no hay ningún patron aplicable ni ningún problema que resolver en primera instancia, pues que una zona del codigo tenga un numero de lineas grande y que nadie ha revisado hace años puesto que funciona bien no necesariamente quiere decir que se le deba aplicar un patron siempre y cuando cumpla con los principios SOLID.


