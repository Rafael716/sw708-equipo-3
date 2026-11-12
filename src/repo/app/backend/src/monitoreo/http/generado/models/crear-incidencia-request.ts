

export interface CrearIncidenciaRequest { 
  /**
   * Id de un tipo de incidencia existente; los valores válidos se consultan en `GET /monitoreo/incidencias/tipos`. Ausente, null o no UUID: 400 `VALIDACION`. Si no existe, 422 `TIPO_INEXISTENTE`. 
   */
  id_tipo_incidencia: string;
  /**
   * Texto con al menos un carácter que no sea espacio. Saneamiento: el servidor quita primero los espacios de los extremos y **después** mide el largo; el límite es de 1000 caracteres sobre el texto ya recortado. Se guarda y se devuelve recortado. Ausente, null, vacía o solo espacios: 400 `DESCRIPCION_VACIA`. Más de 1000 caracteres o tipo distinto de texto: 400 `VALIDACION`. 
   */
  descripcion: string;
  /**
   * Entero de 1 a 5. Ausente, null, texto (`\"4\"`), decimal (`4.5`) o fuera de rango: 400 `SEVERIDAD_INVALIDA`. El valor 5 dispara la notificación a supervisores. 
   */
  grado_severidad: number;
  /**
   * Id de una operación existente y en estado `En curso`; las operaciones se consultan en `GET /monitoreo/operaciones`. Ausente, null o no UUID: 400 `VALIDACION`. Si no existe, 422 `OPERACION_INEXISTENTE`; si existe pero no está `En curso` (`Pendiente`, `Completada` o `Cancelada`), 409 `OPERACION_NO_ACTIVA`. 
   */
  id_operacion: string;
}

