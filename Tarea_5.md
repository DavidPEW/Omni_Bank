Tarea 5 - Índices y Optimización de Rendimiento (PostgreSQL)
1. Justificación de la Indexación (Performance & NFRs)
Para garantizar el cumplimiento de los Requerimientos No Funcionales (NFR) de latencia (< 10 ms en consultas frecuentes de banca en línea y terminales POS), implementamos índices estratégicos basados en los patrones de acceso más recurrentes del sistema OmniBank:

Búsqueda de Clientes por Identificación Fiscal (tax_id): Es una consulta crítica utilizada en procesos de KYC (Know Your Customer) y cumplimiento AML. Un índice B-Tree único acelera la localización del cliente sin requerir escaneos secuenciales en tabla completa (Seq Scan).

Filtrado de Cuentas por Titular (cliente_id): Al consultar el panel del usuario o listar sus productos financieros, el índice sobre la llave foránea evita bloqueos y reduce drásticamente el costo de las uniones (JOIN) entre customers y accounts.

Rango de Fechas e Historial Transaccional: Las consultas de estados de cuenta filtran masivamente por un intervalo de tiempo (fecha_completada). Un índice compuesto o por fecha optimiza la paginación y el ordenamiento cronológico.

2. Script SQL de Creación de Índices
SQL
-- Inicio de la transacción DDL para la indexación del core
BEGIN;

-- 1. Índice único y de alta velocidad para la búsqueda de clientes por su Tax ID
CREATE UNIQUE INDEX idx_customers_tax_id 
ON core.customers (tax_id);

-- 2. Índice para acelerar las consultas de cuentas asociadas a un cliente específico
CREATE INDEX idx_accounts_cliente_id 
ON core.accounts (cliente_id);

-- 3. Índice para optimizar la búsqueda y validación de cuentas por su código IBAN
CREATE UNIQUE INDEX idx_accounts_iban 
ON core.accounts (iban) 
WHERE iban IS NOT NULL;

-- 4. Índice compuesto para acelerar el historial de transacciones por cuenta de origen y fecha
CREATE INDEX idx_transactions_from_date 
ON core.transactions (from_account, fecha_completada DESC);

-- 5. Índice compuesto para acelerar el historial de transacciones por cuenta de destino y fecha
CREATE INDEX idx_transactions_to_date 
ON core.transactions (to_account, fecha_completada DESC);

-- 6. Índice en préstamos para filtrar rápidamente los créditos activos de un cliente
CREATE INDEX idx_loans_client_status 
ON core.loans (cliente_id, status);

-- Confirmación y aplicación exitosa de los índices en el motor
COMMIT;