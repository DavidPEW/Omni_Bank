# TAREA 9

```sql
SELECT 
  (SELECT COUNT(*) FROM customers) AS total_customers,
  (SELECT COUNT(*) FROM accounts) AS total_accounts,
  (SELECT COUNT(*) FROM transactions) AS total_transactions,
  ((SELECT COUNT(*) FROM customers) * (SELECT COUNT(*) FROM accounts) * (SELECT COUNT(*) FROM transactions)) AS cartesian_product_total;

SELECT
  c.email AS customer_email,
  a.account_number,
  t.transaction_type,
  t.amount,
  t.transaction_date
FROM transactions t
INNER JOIN accounts a
  ON t.account_id = a.account_id
INNER JOIN customers c
  ON a.customer_id = c.customer_id
WHERE c.status = 'ACTIVE'
  AND t.amount >= 100.00
ORDER BY t.transaction_date ASC, t.transaction_id ASC;
```

La diferencia entre las 80 combinaciones del producto cartesiano y los 3 eventos finales se debe a dos efectos independientes: primero, aplicar las dos condiciones de clave faltantes reduce drásticamente el resultado de 80 a 4 filas al descartar asociaciones falsas; segundo, los filtros del WHERE descartan un registro más, acotando el reporte final a 3 eventos reales.