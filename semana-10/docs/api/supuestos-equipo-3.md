# Lista de supuestos (paso 02) — contrato ajeno «Reservar boleto»

**Equipo consumidor:** Equipo 3 · **Proveedor:** Grupo de Suazo  
**Contrato evaluado:** API de boletos (`openapi_suazoo.yaml`, entregado por el otro equipo)  
**Endpoint:** `POST /v1/funciones/{funcion_id}/boletos` · **Operación:** `reservarBoleto`

Llamada que escribimos con el contrato ajeno:

```bash
curl -i -X POST http://localhost:8000/v1/funciones/FUNC-001/boletos \
  -H "Content-Type: application/json" \
  -d '{"asiento": "A5", "nombre_cliente": "Carlos Chávez"}'
```

| Nº | Supuesto | Sustento |
|----|----------|----------|
| 1 | No hace falta autenticación (ni token ni API key); basta con la llamada anterior. | El contrato no define `security` ni encabezados de autorización, pero tampoco dice que no se necesiten. |
| 2 | Si envío `asiento: "a5"` (minúscula) o `"A100"`, recibo 400 `DATOS_INVALIDOS`; el servidor no lo corrige ni lo normaliza. | El `pattern` exige una letra mayúscula y uno o dos dígitos, pero no dice si el servidor normaliza o rechaza. |
| 3 | Si mando un campo extra en el cuerpo (por ejemplo `email`), la respuesta es 400 `DATOS_INVALIDOS`, no se ignora. | El esquema tiene `additionalProperties: false`, pero la descripción del 400 no menciona los campos desconocidos. |
| 4 | Un `asiento` válido por formato (por ejemplo `Z99`) se reserva sin problema aunque no exista en la sala. | El contrato solo valida el formato del asiento. No habla de la distribución de la sala ni de qué asientos existen. |
| 5 | Si recibo 500, puedo reintentar sin riesgo de duplicar el boleto. Si hay timeout sin respuesta, no sé si se reservó y tendría que reintentar y esperar un 409. | El 500 dice "No se guardó ningún boleto", pero no se indica qué pasa ante un corte de red. Además, el 409 al repetir la llamada no distingue si el asiento lo ocupé yo o alguien más. |
| 6 | `funcion_id` con espacios o caracteres especiales (por ejemplo `FUNC 001/2`) se debe codificar en la URL, y el servidor lo acepta mientras mida de 1 a 50. | El contrato solo da longitud y un ejemplo (`FUNC-001`). No define qué caracteres son válidos ni si se aplica codificación de URL. |
