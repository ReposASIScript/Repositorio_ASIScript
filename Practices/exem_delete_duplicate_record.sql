-- borrar todos los registros duplicados menos 1
DELETE FROM MG_PERSONAS_POLITIAMENTE_EXPU a
  WHERE a.ROWID > ANY (SELECT b.ROWID
                         FROM MG_PERSONAS_POLITIAMENTE_EXPU b
						WHERE a.codigo_identificacion = b.codigo_identificacion)
/