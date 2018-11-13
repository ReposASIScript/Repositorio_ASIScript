select descripcion "Sub-Producto del Banco"
from mg_sub_aplicaciones
start with codigo_aplicacion = 'BIT'
CONNECT BY PRIOR codigo_aplicacion = to_char(codigo_moneda)
/
