SELECT 'Core.customers' AS tabla, COUNT(*) AS total FROM core.customers UNION ALL
SELECT 'Core.accounts',COUNT(*) FROM core.accounts UNION ALL
SELECT 'Core.transactions',COUNT(*) FROM core.transactions;


--2


SELECT
t.transaction_id,
c.first_name,
c.last_name,
a.account_number,
t.tx_type,
t.amount
FROM core.transactions t
JOIN core.accounts a ON t.account_id = a.account_id
JOIN core.customers c ON a.customer_id = c.customer_id
ORDER BY t.tx_timestamp,t.transaction_id;

--3


SELECT
a.account_number,
a.is_active,
CASE WHEN a.is_active = TRUE THEN 'Cuenta activa sin uso registrado'
ELSE 'Cuenta desactivada administrativamente' END AS estado_presentacion
FROM core.accounts a LEFT JOIN core.transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

--4

SELECT
c.email,
a.account_number,
a.balance
FROM core.customers c
LEFT JOIN core.accounts a ON c.customer_id = a.customer_id
WHERE a.balance < 0;