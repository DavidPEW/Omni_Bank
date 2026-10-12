CREATE SCHEMA IF NOT EXISTS core;

CREATE TABLE core.customers(customer_id UUID DEFAULT gen_random_uuid(), nombre_completo VARCHAR(150) NOT NULL, 
telefono VARCHAR(150) NOT NULL,
created_at TIMESTAMPZ DEFAULT current timestamp,
is_active BOOLEAN DEFAULT TRUE,

CONSTRAINT pk_customers PRIMARY KEY (customer_id),
CONSTRAINT uq_customers_email UNIQUE (email),
CONSTRAINT uq_customers_nombre UNIQUE (nombre_completo)
);

CREATE TABLE core.accounts(
    account_id UUID DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    tipo_cuenta VARCHAR(10) NOT NULL,
    saldo VARCHAR(15,2)

    CONSTRAINT FOREING KEY core.customers(customer_id)
);

CREATE TABLE core.loans(

transaccion_id UUID get_random_uuid(),
customer_id UUID NOT NULL,
monto_prestamo NUMERIC(15,2) CHECK (AMOUNT > 0),
tasa_interes NUMERIC(5,4)
estado VARCHAR(15));

CREATE core.transactions(

    account_id UUID NOT NULL,
    amount NUMERIC(15,2),
    tipo core.tipo_transaccion TIMESTAMPTZ

    CONSTRAINT FOREIGN KEY core.customers(account_id)
),