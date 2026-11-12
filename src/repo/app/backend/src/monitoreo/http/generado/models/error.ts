

export interface ModelError { 
  /**
   * Identificador estable y legible por máquina. Decidir siempre por este campo.
   */
  codigo: ModelError.CodigoEnum;
  /**
   * Texto para humanos. Puede cambiar sin subir la versión del contrato.
   */
  mensaje: string;
  /**
   * Nombre del campo de la petición que causó el error (desde 1.1.0). Solo viene en errores 400 asociados a un campo; el cliente lo usa en lugar de leer `mensaje`. 
   */
  campo?: string;
}
export namespace ModelError {
  export const CodigoEnum = {
    Validacion: 'VALIDACION',
    DescripcionVacia: 'DESCRIPCION_VACIA',
    SeveridadInvalida: 'SEVERIDAD_INVALIDA',
    NoAutenticado: 'NO_AUTENTICADO',
    OperacionNoActiva: 'OPERACION_NO_ACTIVA',
    TipoInexistente: 'TIPO_INEXISTENTE',
    OperacionInexistente: 'OPERACION_INEXISTENTE',
    ErrorInterno: 'ERROR_INTERNO',
  } as const;
  export type CodigoEnum = typeof CodigoEnum[keyof typeof CodigoEnum];
}


