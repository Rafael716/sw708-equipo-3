

export interface Incidencia { 
  id_incidencia: string;
  /**
   * Formato `INC-AAMM-NNNN`. `AAMM` es el año y el mes en **UTC**, los mismos de `fecha_hora` (una incidencia del 30 de noviembre a las 23:30 en Lima es `2026-12-01T04:30Z` y lleva `2612`). La secuencia se reinicia cada mes y tiene al menos cuatro dígitos: después de `9999` sigue `10000`. 
   */
  codigo: string;
  id_tipo_incidencia: string;
  descripcion: string;
  grado_severidad: number;
  /**
   * Instante del registro, fijado por el servidor.
   */
  fecha_hora: string;
  /**
   * Estado inicial. En un alta exitosa **siempre** es el UUID del estado `Abierta`. El catálogo de estados se consulta en `GET /monitoreo/incidencias/estados`. 
   */
  id_estado_incidencia: string;
  id_operacion: string;
  /**
   * Usuario autenticado que registró la incidencia. Sale del token.
   */
  id_usuario: string;
}

