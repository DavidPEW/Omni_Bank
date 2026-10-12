-- 1. Inserción resiliente e idempotente de Clientes Pioneros de OmniBank
INSERT INTO core.customers (cliente_id, nombre, correo, telefono, tax_id, fecha_nacimiento)
VALUES 
    ('11111111-1111-1111-1111-111111111111', 'John Doe', 'john.doe@email.com', '555-0100', 'TAX-100', '1985-04-12'),
    ('22222222-2222-2222-2222-222222222222', 'Jane Smith', 'jane.smith@email.com', '555-0200', 'TAX-200', '1990-08-22'),
    ('33333333-3333-3333-3333-333333333333', 'Alice Johnson', 'alice.j@email.com', '555-0300', 'TAX-300', '1995-12-05')
ON CONFLICT (correo) DO NOTHING;

-- 2. Apertura protegida ante duplicidades para Cuentas Financieras
INSERT INTO core.accounts (cuenta_id, cliente_id, iban, tipo_cuenta, saldo_actual)
VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'ACCT-1001', 'CHECKING', 5000.00),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 'ACCT-2001', 'SAVINGS', 15000.00),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333', 'ACCT-3001', 'CREDIT', 0.00)
ON CONFLICT (iban) DO NOTHING;

-- 3. Inserción de Operaciones y Movimientos Iniciales de Prueba
INSERT INTO core.transactions (from_account, to_account, monto, tipo_transaccion)
VALUES 
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 150.00, 'TRANSFER'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 300.00, 'TRANSFER'),
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 50.00, 'WITHDRAWAL');

-- 4. Deducción de Comisión con Filtro Inquebrantable WHERE y Extracción al Vuelo con RETURNING
UPDATE core.accounts 
SET saldo_actual = saldo_actual - 50.00,
    updated_at = CURRENT_TIMESTAMP
WHERE iban = 'ACCT-1001'
RETURNING iban, saldo_actual;