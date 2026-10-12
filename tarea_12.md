# Tarea 12

```
SELECT
  acc.account_number,
  acc.is_active
FROM accounts acc
WHERE acc.is_active = 1
AND NOT EXISTS (SELECT 1 FROM transactions x
WHERE x.account_id = acc.account_id)
ORDER BY acc.account_number;

```

2.-

```
SELECT
  acc.account_number,
  acc.is_active
FROM accounts acc
WHERE NOT EXISTS (SELECT 1 FROM transactions x WHERE x.account_id = acc.account_id
AND x.transaction_type = 'DEPOSIT')
ORDER BY acc.account_number;

```

3.-

```
WITH sample_data(val) AS (
  SELECT 10 UNION ALL
  SELECT 20 UNION ALL
  SELECT NULL
)
SELECT 'con NOT IN (falla)' AS test_case, val
FROM sample_data
WHERE val NOT IN (SELECT val FROM sample_data);

```