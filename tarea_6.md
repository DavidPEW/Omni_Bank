# Actividad 6: Evolucionando el Core bancario

Archivo: `migration_01_core_evolution.sql`

```sql
Create TYPE core.loan_status_enum AS ENUM ('Active', 'PAID', 'DEFAULTED', 'CANCELLED');

BEGIN;

ALTER TABLE Core.Customers
ADD COLUMN credit_score Integer NULL;

ALTER TABLE Core.Customers

ADD Constraint chk_customers_credit_score_range CHECK (Credit_score BETWEEN 300 AND 850);

Alter TABLE Core.accounts
ADD Column iban VARCHAR(34) NULL;

Alter TABLE Core.accounts
ADD CONSTRAINT uq_accounts_iban UNIQUE (iban);

Alter TABLE Core.loans
ALTER COLUMN status TYPE core.loan_status_enum
USING status::core.loan_status_enum;

COMMIT;
```

1. Este bloqueo fue generado por el comando ya que este hacía una validación de todas la millones de transacciones que estan almacenadas provocando el cierre de nuevas solicitudes por lo que cuando alguna terminal intentaba hacer una operación no se completaba y daba error.

2. Para crear un escaneo sin bloqueo

```sql
ALTER TABLE Core.transactions
ADD CONSTRAINT chk_transactions_description_valid CHECK (LENGTH(TRIM(description))>=5)
NOT VALID;

Paso 2: Validacion Posterior

ALTER TABLE Core.transactions
VALIDATE CONSTRAINT chk_transactions_description_valid
-valid
```