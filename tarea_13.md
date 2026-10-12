# TAREA 13

```sql
WITH movimientos_por_cuenta AS (SELECT
t.account_id, COUNT(t.transaction_id) AS
total_eventos,
SUM(t.amount) AS volumen_bruto
FROM core.transactions t
WHERE t.amount > 0
Group BY t.account_id),
cuentas_activas AS (SELECT
  a.account_id,
  a.customer_id,
  a.account_number,
  a.account_type,
  a.currency,
  COALESCE(m.total_eventos, 0) AS recuento_eventos,
  COALESCE(m.volumen_bruto, 0.00) AS volumen_bruto
FROM core.accounts a
LEFT JOIN movimientos_por_cuenta m ON
m.account_id = a.account_id
WHERE a.is_active = true),
resumen_por_moneda AS (SELECT
  ca.currency,
  COUNT(ca.account_id) AS total_eventos
  _activas,
  SUM(ca.volumen_bruto) AS volumen_bruto_total,
  ROUND(AVG(ca.volumen_bruto), 2) AS promedio
  _por_cuenta
FROM cuentas_activas ca
Group BY ca.currency)

SELECT
  currency,
  total_cuentas_activas,
  volumen_bruto_total,
  promedio_por_cuenta
FROM resumen_por_moneda
ORDER BY currency ASC;

SELECT COUNT (*) AS total_eventos
-activas
FROM core.accounts
WHERE is_active = true;

SELECT
  SUM(Monto_cuenta) AS volumen_total_semilla,
  COUNT(*) AS denominador_cuentas,
  SUM(Monto_cuenta) / COUNT(*) AS
  promedio_calculado
FROM (
  SELECT
    a.account_number,
    COALESCE(SUM(t.amount), 0) AS monto_cuenta
  FROM core.accounts a
  LEFT JOIN core.transactions t ON
  t.account_id = a.account_id AND t.amount > 0
  WHERE a.is_active = true
  Group BY a.account_number
) sub;
```