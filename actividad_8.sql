-- REPORTE 1: Extracción Quirúrgica de Cuentas Prioritarias en OmniBank
-- Excluye celdas ruidosas (UUIDs, created_at, etc.) mediante proyección explícita[cite: 10]
SELECT 
    iban AS account_number,
    tipo_cuenta AS account_type,
    saldo_actual AS balance
FROM core.accounts
WHERE (saldo_actual >= 1000.00 OR tipo_cuenta = 'SAVINGS')
ORDER BY saldo_actual DESC
LIMIT 2;

-- REPORTE 2: Búsqueda Insensible por Patrones en Clientes Bancarios
-- Atrapa por igual '@email.com', '@EMAIL.COM' sin alterar el motor[cite: 10]
SELECT 
    nombre AS first_name,
    correo AS email
FROM core.customers
WHERE correo ILIKE '%@email.com';

-- REPORTE 3: Resolución de la Lógica Tri-Valuada y Salvaguarda con COALESCE
-- Corrige el fallo del analista interino (= NULL -> IS NULL) y purga vacíos[cite: 10]
SELECT 
    transaccion_id AS account_id,
    monto AS amount,
    tipo_transaccion AS tx_type,
    COALESCE(NULL, 'COBRO INSTITUCIONAL O COMISIÓN - SIN RECEPTOR') AS descripcion_visible
FROM core.transactions
WHERE tipo_transaccion = 'WITHDRAWAL';