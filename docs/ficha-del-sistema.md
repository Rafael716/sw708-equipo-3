# Ficha del sistema - Entregable

1. **Nombre del sistema:**
    Sistema de gestion de operaciones - Hapag Lloyd
2. **Origen:**
    Curso: Diseño de base de datos SI501U, se llevo en el 5to ciclo. El trabajo fue durante todo el ciclo con entregables constantes.
3. **Integrantes que participaron:**
    * Romel Rodrigo Chumpitaz Flores
    * Rafael Adriano Olivos Gallardo
    * David Luza Ccorimanya
4. **Que hace:** El sistema gestiona las operaciones logísticas de contenedores de Hapag-Lloyd, desde la reserva del pedido en un contenedor hasta su entrega final. Cubre 5 módulos: reservas de pedidos marítimos, operaciones portuarias, operaciones marítimas, operaciones terrestres y monitoreo de entregas en tiempo real.
5. **Lenguaje y stack:** El lenguaje de programacion fue typescript tanto para el backend como para el frontend, los frameworks para el backend fue nestjs y para el frontend fue nextjs, la base de datos fue hecho en posgresql y la herramienta de construccion npm.
6. **Repositorio:** [Link del repositorio](https://github.com/Bluethem/dbdgrupo5-25-2/)   
7. **Tres reglas de negocio:** 
    * Cada reserva tiene un **código único** que el sistema no permite duplicar (validación en el servicio de reservas).
    * Al **confirmar** una reserva, los contenedores asociados pasan a estado "En tránsito"; si la reserva se **cancela**, se liberan y vuelven a "Disponible".
    * Solo se puede reservar un buque si tiene **espacio disponible y certificaciones vigentes**, y se aplica **descuento por volumen** (5% a partir de 5 contenedores, 10% a partir de 10).
8. **Como se levanta hoy:** 
    1. Clonar el repositorio y entrar a la carpeta `app/`.
    2. Base de datos: crear la BD en PostgreSQL y ejecutar los scripts DDL de `scripts/ddl/tablas/*.sql` y el poblamiento de `scripts/poblamiento_datos/scriptSQL/*.sql`.
    3. Backend (`app/backend/`): `npm install`, crear `.env` (variables `DATABASE_HOST/PORT/USER/PASSWORD/NAME` o `DATABASE_URL`), y `npm run start:dev` (queda en el puerto 3001).
    4. Frontend (`app/frontend/`): `npm install` y `npm run dev` (queda en el puerto 3000). Nota: el frontend apunta al backend en `http://localhost:3001`.
9. **Que le falta o que le duele:** 
    * Los módulos de **Operaciones Terrestres** y **Personal/Tripulación** existen como carpetas y en la documentación, pero **no están implementados** ni registrados en `app.module.ts`.
    * El frontend **hardcodea `http://localhost:3001`** en más de 50 archivos (no usa una variable de entorno/baseURL central), lo que rompe en producción.
    * El backend usa `synchronize: false` y **no tiene sistema de migraciones**: el esquema solo se levanta a mano con los scripts DDL.
    * La sección "Cambios respecto al prototipo" del README de la app **sigue vacía** (pendiente del grupo).
    * La lógica de **login/autenticación está duplicada por módulo** (reservas, marítimo, portuario) en lugar de un auth único.
