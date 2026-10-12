# Tarea 8

1~

```sql
WHERE (amount >= 10000.00 AND tx_type IN ('TRANSFER', 'WITDRAW') OR ILIKE '%Crypto%', ILIKE '%offshore%' OR description IS NULL AND tx_type = 'DEPOSIT')
```

2~

```sql
WHERE (Amount >= 10000.00 AND tx_type IN('TRANSFER', 'WHITDRAW') OR ('description ILIKE '%Crypto%', OR description ILIKE '%offshore%' OR description ILIKE '%Shell%' OR description ILIKE '%Casino%' OR (NULLIF (TRIM (description)) IS NULL AND Ty_type != 'Deposit')
```

3~

```sql
SELECT
  transaction_id,
  amount,
  tx_type,
  tx_timestamp
  COALESCE (description, 'EXCLUSION OPORTUNAM DETECTADA SIN MOTIVO DE PAGO')
FROM Core.transactions
```

```sql
WHERE (amount >= 10000.00 AND tx_type IN ('TRANSFER', 'WHITDRAW'))
OR (description ILIKE '%Crypto%'
OR description ILIKE '%offshore%'
OR description ILIKE '%Shell%'
OR description ILIKE '%Casino%'
OR (NULLIF (TRIM(description)) IS NULL
AND tx_type != 'DEPOSIT'))
ORDER BY amount DESC;
```

El desastre previo ocurrio porque la falta de parentesis bien colocados en el Where Provocando los errores, modificamos el Codigo para blindar el Sistema para que Pueda verificar de manera correcta Si cumple con las restricciones