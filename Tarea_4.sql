-- Dominio estricto de monedas admitidas por la institución
CREATE TYPE core.tipo_moneda AS ENUM ('USD', 'EUR', 'MXN', 'GBP');

-- Dominio para la clasificación de cuentas bancarias de los clientes
CREATE TYPE core.tipo_cuenta AS ENUM ('CHECKING', 'SAVINGS', 'CREDIT');

-- Catálogo oficial de tipos de transacciones financieras permitidas
CREATE TYPE core.tipo_transaccion AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER');