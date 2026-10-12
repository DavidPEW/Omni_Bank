CREATE DOMAIN texto_obligatorio CHECK (VALUE <> '' AND LENGTH(TRIM(VALUE)) > 0)

CREATE DOMAIN monto_financiero CHECK(monto >= 0.00)

--monto financiero se utilizara para
-- -Saldo actual
-- -monto_tx