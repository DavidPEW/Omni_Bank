# Actividad 11

1.
```sql
SELECT
  a.account_id, a.account_number, c.email,
  a.is_active,
  CONCAT(
    UPPER(TRIM(c.first_name)), ' ',
    UPPER(TRIM(c.last_name)), ' ACC-...',
    RIGHT(a.account_number, 4)
  ) AS etiqueta_presentacion, a.account_type,
  a.balance AS saldo_almacenado
FROM core.accounts a
JOIN Core.Customers c ON c.Customer_id = a.Customer_id
ORDER BY a.account_id ASC;
```

2.
```sql
SELECT
  t.transaction_id, t.account_id,
  t.amount::text AS importe_texto,
  t.tx_timestamp AS fecha_original,
  t.tx_timestamp + INTERVAL '15 days' AS Fecha_revision,
  AGE(TIMESTAMPTZ '2026-10-01 00:00:00+00', t.tx_timestamp) AS Antiguedad_al_corte,
  EXTRACT(YEAR FROM t.tx_timestamp) AS anio_original,
  EXTRACT(MONTH FROM t.tx_timestamp) AS mes_original
FROM Core.transaction t
WHERE t.tx_timestamp >= TIMESTAMPTZ '2026-09-10 00:00:00+00'
ORDER BY t.transaction_id ASC;
```

3.
```sql
SELECT COUNT(account_id) AS total_cuentas
FROM CORe.accounts;

SELECT COUNT(transaction_id) AS total_eventos
FROM Core.transactions
WHERE tx_timestamp < TIMESTAMPTZ '2026-09-10 00:00:00+00';
```