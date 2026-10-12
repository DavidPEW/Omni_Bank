# TAREA 11

```sql
SELECT
COUNT (a.account_id) As total_cuentas,
COUNT (a.account_id) FILTER (WHERE a.is_active = False)
AS Cuenta_desactivadas,
ROUND(
(COUNT(a.account_id) FILTER (WHERE a.is_active = False))::Numeric / COUNT(a.account_id)::numeric * 100.0, 2)
AS porsentaje desactivadas
FROM Core.account a;

2. SELECT t.transaction_id, t.account_id
t.amount::text AS importante_text
t.tx_timestamp AS Fecha_original,
t.tx_timestamp + INTERVAL '15 days' AS fecha_revision
AGE(TIMESTAMPTZ '2026-10-01 00:00:00+00'
t.tx_tmos
AS Antiguedad_al_corte
EXTRACT (YEAR FROM t.tx_timestamp) AS Year_origin
EXTRACT(MONTH FROM t.tx_timestamp) AS mes_original
FROM core.transactions t
WHERE t.tx_timestamp < TIMESTAMPTZ '2026-09-10 00:00:00+00';
ORDER BY t.transactions_id Asc
```