-- 1. Conteo global optimizado de registros principales mediante subconsultas escalares
SELECT (SELECT COUNT(*) FROM core.customers) AS customers,
       (SELECT COUNT(*) FROM core.accounts) AS accounts,
       (SELECT COUNT(*) FROM core.transactions) AS movements;

-- 2. Reporte unificado de transacciones detalladas con información de cuentas y titulares
SELECT t.transaction_id, c.first_name, c.last_name, a.account_number, t.tx_type, t.amount
FROM core.transactions t
JOIN core.accounts a ON a.account_id = t.account_id
JOIN core.customers c ON c.customer_id = a.customer_id
ORDER BY t.tx_timestamp, t.transaction_id;

-- 3. Identificación precisa de cuentas sin movimientos transaccionales registrados
SELECT a.account_number, a.is_active,
       CASE WHEN a.is_active THEN 'ACTIVA SIN MOVIMIENTOS'
            ELSE 'DESACTIVADA SIN MOVIMIENTOS' END AS estado
FROM core.accounts a
LEFT JOIN core.transactions t ON t.account_id = a.account_id
WHERE t.transaction_id IS NULL
ORDER BY a.account_number;

-- 4. Auditoría de saldos positivos asociados a clientes mediante cruce controlado en el LEFT JOIN
SELECT c.email, a.account_number, a.balance
FROM core.customers c
LEFT JOIN core.accounts a
  ON a.customer_id = c.customer_id AND a.balance > 0
ORDER BY c.email, a.account_number;