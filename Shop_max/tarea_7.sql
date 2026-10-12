-- Guion Oficial para Sincronización KYC en OmniBank mediante Upsert (DO UPDATE)
INSERT INTO core.customers (nombre, correo, telefono, tax_id)
VALUES 
    ('Humberto López', 'hlopez@email.com', '+52-55-4433-2211', 'TAX-990011')
ON CONFLICT (correo) 
DO UPDATE SET 
    nombre       = EXCLUDED.nombre,
    telefono     = EXCLUDED.telefono,
    -- Mantenemos la integridad del registro intacta y aseguramos la reactivación lógica si es necesario
    is_active    = true
RETURNING cliente_id, correo, is_active;