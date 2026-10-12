-- Inicio de la transacción DDL para la estructura central de OmniBank
BEGIN;

-- 1. Tabla de Clientes (Customers)
CREATE TABLE core.customers (
    cliente_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(150) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    tax_id VARCHAR(50) NOT NULL UNIQUE,
    credit_score INTEGER NULL CHECK (credit_score BETWEEN 300 AND 850),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla de Cuentas Bancarias (Accounts)
CREATE TABLE core.accounts (
    cuenta_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cliente_id UUID NOT NULL,
    moneda core.tipo_moneda NOT NULL,
    tipo_cuenta core.tipo_cuenta NOT NULL,
    saldo_actual NUMERIC(15, 2) NOT NULL DEFAULT 0.00 CHECK (saldo_actual >= 0.00),
    limite_credito NUMERIC(15, 2) NOT NULL DEFAULT 0.00,
    iban VARCHAR(34) NULL UNIQUE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_accounts_customer FOREIGN KEY (cliente_id) 
        REFERENCES core.customers(cliente_id) 
        ON DELETE RESTRICT
);

-- 3. Tabla de Préstamos (Loans)
CREATE TABLE core.loans (
    loan_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cliente_id UUID NOT NULL,
    monto_total NUMERIC(15, 2) NOT NULL CHECK (monto_total > 0),
    saldo_pendiente NUMERIC(15, 2) NOT NULL CHECK (saldo_pendiente >= 0),
    tasa_interes NUMERIC(5, 4) NOT NULL,
    status core.loan_status_enum NOT NULL DEFAULT 'ACTIVE',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_loans_customer FOREIGN KEY (cliente_id) 
        REFERENCES core.customers(cliente_id) 
        ON DELETE RESTRICT
);

-- 4. Tabla de Transacciones (Transactions)
CREATE TABLE core.transactions (
    transaccion_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    from_account UUID NOT NULL,
    to_account UUID NOT NULL,
    monto NUMERIC(15, 2) NOT NULL CHECK (monto > 0),
    tipo_transaccion core.tipo_transaccion NOT NULL,
    fecha_completada TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tx_from_account FOREIGN KEY (from_account) 
        REFERENCES core.accounts(cuenta_id) 
        ON DELETE RESTRICT,
    CONSTRAINT fk_tx_to_account FOREIGN KEY (to_account) 
        REFERENCES core.accounts(cuenta_id) 
        ON DELETE RESTRICT
);

-- Confirmación exitosa de la creación de tablas relacionales bajo cumplimiento ACID
COMMIT;