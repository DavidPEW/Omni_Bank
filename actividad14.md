# Actividad 14

```sql
SELECT
t1.account_id,
t1.transaction_id AS txn_actual_id,
t1.timestamp AS txn_actual_time,
t2.transaction_id AS txn_siguiente_id,
t2.timestamp AS txn_siguiente_time,
EXTRACT(EPOCH FROM (t2.timestamp - t1.timestamp)) / 3600 AS hora_diferencia
FROM transactions t1
JOIN transactions t2
ON t1.account_id = t2.account_id
WHERE t1.transaction_id < t2.transaction_id
AND t2.timestamp >= t1.timestamp
AND t2.timestamp <= t1.timestamp + INTERVAL '48 hours';

WITH client_tipo_matrix AS (SELECT
c.client_id,
c.client_name,
tc.tipo_cuenta
FROM clients c
CROSS JOIN (
SELECT UNNEST(ARRAY['AHORRO', 'CORRIENTE', 'INVERSION']) AS tipo_cuenta) tc)
SELECT
m.client_name, m.tipo_cuenta AS tipo_cuenta_faltante
FROM cliente_tipo_matrix m WHERE NOT EXISTS(SELECT 1 FROM accounts a
WHERE a.client_id = m.client_id
AND a.tipo_cuenta = m.tipo_cuenta) ORDER BY m.client_name, m.tipo_cuenta;