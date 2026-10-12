# Tarea 10: Promedios con NULL y reporte

```sql
WITH sample_data AS (
SELECT val FROM (VALUES (1000.0),(0.0),(0.0),(NULL))
AS t (val)
)
SELECT
AVG (val) AS AVG_ignoring_null,
Count (val) AS Count_ignoring_null,
AVG (COALESCE (val, 0)) AS avg_with_coalesce,
Count (COALESCE (val, 0)) AS count_with_coalesce
FROM sample_data;

SELECT
a.account_id,
a.balance,
COUNT (t.transaction_id) AS volumen_bruto_registrado
FROM accounts a
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE a.account_type = 'CREDIT'
AND a.is_active = TRUE
GROUP BY a.account_id, a.balance
Having COUNT (t.transaction_id) = 0
OR COALESCE (SUM (t.amount), 0) >= 300;
```