-- ShopMax: punto de partida de los demos incrementales desde el día 09.
-- Ejecutar únicamente en una base de práctica ShopMax. No elimina objetos ni datos.
-- El script es atómico e idempotente; las claves fijas identifican la muestra docente.
BEGIN;

DO $$ BEGIN
  IF to_regclass('core.accounts') IS NOT NULL THEN
    RAISE EXCEPTION 'Esta base contiene OmniBank; use una base ShopMax separada';
  END IF;
END $$;

CREATE SCHEMA IF NOT EXISTS store;
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typnamespace='store'::regnamespace AND typname='estado_envio') THEN
    CREATE TYPE store.estado_envio AS ENUM ('PENDIENTE','PAGADO','EN_TRANSITO','ENTREGADO','CANCELADO');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typnamespace='store'::regnamespace AND typname='precio_usd') THEN
    CREATE DOMAIN store.precio_usd AS numeric(10,2) CHECK (VALUE>=0);
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS store.clientes (
  cliente_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre_completo varchar(100) NOT NULL,
  email varchar(150) NOT NULL UNIQUE,
  fecha_registro timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active boolean NOT NULL DEFAULT true
);
CREATE TABLE IF NOT EXISTS store.productos (
  producto_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sku_codigo varchar(25) NOT NULL UNIQUE,
  nombre varchar(120) NOT NULL,
  precio_actual store.precio_usd NOT NULL,
  stock_disponible integer NOT NULL DEFAULT 0 CHECK (stock_disponible>=0)
);
CREATE TABLE IF NOT EXISTS store.ordenes (
  orden_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id uuid NOT NULL REFERENCES store.clientes(cliente_id) ON DELETE RESTRICT,
  fecha_compra timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  estado store.estado_envio NOT NULL DEFAULT 'PENDIENTE'
);
CREATE TABLE IF NOT EXISTS store.ordenes_detalle (
  detalle_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  orden_id uuid NOT NULL REFERENCES store.ordenes(orden_id) ON DELETE CASCADE,
  producto_id uuid NOT NULL REFERENCES store.productos(producto_id) ON DELETE RESTRICT,
  cantidad integer NOT NULL CHECK (cantidad>0),
  precio_facturado store.precio_usd NOT NULL
);
ALTER TABLE store.ordenes ADD COLUMN IF NOT EXISTS monto_total numeric(10,2);
ALTER TABLE store.ordenes ADD COLUMN IF NOT EXISTS tipo_despacho_envio text;
ALTER TABLE store.ordenes ADD COLUMN IF NOT EXISTS numero_guia_envio text;
ALTER TABLE store.productos ADD COLUMN IF NOT EXISTS peso_kg numeric(6,2);
CREATE TABLE IF NOT EXISTS store.pagos_recibidos (
  id_transaccion_pasarela text PRIMARY KEY,
  monto_pago numeric(10,2) NOT NULL CHECK (monto_pago>=0),
  estatus_aprobado boolean NOT NULL
);
CREATE TABLE IF NOT EXISTS store.log_visitas_web (visita_id integer PRIMARY KEY);

INSERT INTO store.clientes(cliente_id,nombre_completo,email)
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1','Ana','ana@shopmax.test'),
       ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2','Luis','luis@shopmax.test'),
       ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3','Mara','mara@shopmax.test')
ON CONFLICT (cliente_id) DO NOTHING;
INSERT INTO store.productos(producto_id,sku_codigo,nombre,precio_actual,stock_disponible,peso_kg)
VALUES ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1','SKU-BOOK','Libro',40,10,0.50),
       ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2','SKU-LAP','Portátil',500,4,2.50),
       ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb3','SKU-GAME','Juego',200,6,1.00)
ON CONFLICT (producto_id) DO NOTHING;
INSERT INTO store.ordenes(orden_id,cliente_id,fecha_compra,estado,monto_total,tipo_despacho_envio,numero_guia_envio)
VALUES ('cccccccc-cccc-cccc-cccc-ccccccccccc1','aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1','2026-09-01 10:00+00','PAGADO',120,'EXPRESS','DHL-1'),
       ('cccccccc-cccc-cccc-cccc-ccccccccccc2','aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1','2026-09-01 10:00+00','PAGADO',80,'STANDARD',NULL),
       ('cccccccc-cccc-cccc-cccc-ccccccccccc3','aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3','2026-09-02 10:00+00','EN_TRANSITO',200,'EXPRESS','DHL-3')
ON CONFLICT (orden_id) DO NOTHING;
INSERT INTO store.ordenes_detalle(detalle_id,orden_id,producto_id,cantidad,precio_facturado)
VALUES ('dddddddd-dddd-dddd-dddd-ddddddddddd1','cccccccc-cccc-cccc-cccc-ccccccccccc1','bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1',3,40),
       ('dddddddd-dddd-dddd-dddd-ddddddddddd2','cccccccc-cccc-cccc-cccc-ccccccccccc2','bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1',2,40),
       ('dddddddd-dddd-dddd-dddd-ddddddddddd3','cccccccc-cccc-cccc-cccc-ccccccccccc3','bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb3',1,200)
ON CONFLICT (detalle_id) DO NOTHING;

-- La vista delimita las filas docentes aunque una base ShopMax contenga otros pedidos.
CREATE OR REPLACE VIEW store.v_pedidos_curso AS
SELECT orden_id,cliente_id,fecha_compra,estado,monto_total,tipo_despacho_envio,numero_guia_envio
FROM store.ordenes
WHERE orden_id IN (
  'cccccccc-cccc-cccc-cccc-ccccccccccc1',
  'cccccccc-cccc-cccc-cccc-ccccccccccc2',
  'cccccccc-cccc-cccc-cccc-ccccccccccc3',
  'cccccccc-cccc-cccc-cccc-ccccccccccc4'
);
CREATE OR REPLACE VIEW store.v_clientes_curso AS
SELECT cliente_id,nombre_completo,email,is_active FROM store.clientes
WHERE cliente_id IN ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
                     'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
                     'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3');

DO $$ BEGIN
  IF (SELECT COUNT(*) FROM store.v_clientes_curso)<>3
     OR (SELECT COUNT(*) FROM store.v_pedidos_curso) NOT IN (3,4)
     OR EXISTS (SELECT 1 FROM store.v_pedidos_curso WHERE monto_total IS NULL)
     OR NOT EXISTS (SELECT 1 FROM store.productos WHERE producto_id='bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2' AND stock_disponible IN (3,4)) THEN
    RAISE EXCEPTION 'ShopMax no coincide con la muestra docente; revise la base antes de continuar';
  END IF;
END $$;
COMMIT;