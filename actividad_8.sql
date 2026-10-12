Select account_number, account_type, balance
FROM core.accounts
WHERE balance >= 1000.00 OR account_type = 'SAVINGS'
ORDER BY balance DESC
LIMIT 2;

SELECT First_name, last_name, email
FROM core.costumers
WHERE email ILIKE '%@email.com';

SELECT tx_type, COALESCE (description, 'COBRO INSTITUCIONAL O COMISION - SIN RECEPTOR') AS descripcion Visible
FROM core.transactions
WHERE description IS NULL
AND tx_type = 'WITHDRAWAL';
