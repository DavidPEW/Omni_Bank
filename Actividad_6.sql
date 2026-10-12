-- 1. Compilación del nuevo Tipo Enumerado en PostgreSQL para el ciclo de vida crediticio[cite: 3, 4]
CREATE TYPE core.loan_status_enum AS ENUM (
    'ACTIVE', 'PAID', 'DEFAULTED', 'CANCELLED'
);

-- 2. Inicio innegociable de transaccionalidad DDL en PostgreSQL[cite: 3, 4]
BEGIN;

-- Transformación 1: Añadir métrica de puntuación crediticia a los titulares bancarios con su constraint en duro[cite: 3, 4]
ALTER TABLE core.customers
ADD COLUMN credit_score INTEGER NULL;

ALTER TABLE core.customers
ADD CONSTRAINT chk_customers_credit_score_range
CHECK (credit_score BETWEEN 300 AND 850);

-- Transformación 2: Estandarización europea de identificación de cuentas bancarias y unicidad[cite: 3, 4]
ALTER TABLE core.accounts
ADD COLUMN iban VARCHAR(34) NULL;

ALTER TABLE core.accounts
ADD CONSTRAINT uq_accounts_iban UNIQUE (iban);

-- Transformación 3: Casteo estructural de columna de texto libre de préstamos al riguroso Enum catalogado[cite: 3, 4]
ALTER TABLE core.loans 
    ALTER COLUMN status DROP DEFAULT;

ALTER TABLE core.loans
ALTER COLUMN status TYPE core.loan_status_enum
USING status::core.loan_status_enum;

ALTER TABLE core.loans 
    ALTER COLUMN status SET DEFAULT 'ACTIVE'::core.loan_status_enum;

-- Confirmación exitosa de los cambios estructurales[cite: 3, 4]
COMMIT;