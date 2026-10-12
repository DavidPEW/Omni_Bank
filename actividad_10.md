# Actividad 10: tablero de saldos y actividad

```sql
SELECT account_type,
COUNT AS cantidad_cuentas, SUM (balance)
AS saldo_total, MIN (balance)
AS saldo_minimo, MAX (balance) AS saldo_maximo
AVG (balance) AS saldo_promedio
FROM core.accounts
WHERE is_active = TRUE
GROUP BY account_type
ORDER BY saldo_total;

SELECT c.customer_id,
Count (t.transaction_id) AS movimientos,
COALESCE (SUM (t.amount), 0)
AS volumen_bruto
FROM core.customers c
LEFT JOIN core.accounts a ON a.customer_id
= c.customer_id
LEFT JOIN core.transactions t ON
t.account_id = a.account_id
GROUP BY c.customer_id
HAVING COUNT (t.transaction_id) >= 2
OR COALESCE (SUM (t.amount), 0) >= 100
ORDER BY volumen_bruto DESC, c.customer_id;

SELECT
COUNT (transaction_id) AS movimientos,
SUM (amount) AS volumen_bruto
FROM core.transactions
```