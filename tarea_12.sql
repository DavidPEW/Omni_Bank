SELECT a.account_number, a.account_type, a.balance
FROM core.accounts a
WHERE a.is_active
  AND NOT EXISTS (
    SELECT 1 FROM core.transactions t WHERE t.account_id = a.account_id
  )
ORDER BY a.account_number;


SELECT a.account_number, a.is_active
FROM core.accounts a
WHERE NOT EXISTS (
  SELECT 1 FROM core.transactions t
  WHERE t.account_id = a.account_id AND t.tx_type = 'DEPOSIT'
)
ORDER BY a.account_number;