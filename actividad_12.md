# Actividad 12

1.-

```
SELECT
  t.transaction_id,
  t.account_id,
  t.amount,
  (SELECT AVG(x.amount) FROM transactions x WHERE x.account_id = t.account_id) AS account_avg
FROM transactions t
WHERE t.amount > (
  SELECT AVG(x.amount)
  FROM transactions x
  WHERE x.account_id = t.account_id)
ORDER BY t.account_id, t.amount DESC;

```

2.-

```
SELECT
  t.transaction_id,
  t.account_id,
  t.amount,
  a_avg.avg_amount
FROM transactions t
JOIN (SELECT account_id, AVG(amount) AS avg_amount
FROM transactions
GROUP BY account_id
) a_avg ON t.account_id = a_avg.account_id
WHERE t.amount > a_avg.avg_amount
ORDER BY t.account_id, t.amount DESC;

```

3.-

```
SELECT
  acc.account_number,
  acc.is_active
FROM accounts acc
WHERE NOT EXISTS ( SELECT 1 FROM transactions x WHERE x.account_id = acc.account_id)
ORDER BY acc.account_number;

```