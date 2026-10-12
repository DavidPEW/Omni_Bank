# Actividad 3 - Normalización de Tablas (3NF)

## 1. Sucursales
*(Elimina la redundancia transitiva de direcciones de sucursales repetidas)*

| sucursal_id (PK) | direccion |
| :--- | :--- |
| S-CDMX | Av. Juárez #100 |

## 2. Clientes
*(Elimina la duplicidad de datos del cliente en cada transacción o cuenta)*

| cliente_id (PK) | nombre | email | telefono |
| :--- | :--- | :--- | :--- |
| TAX-9a11 | Roberto Soto | rob@gmail.com | 555-9011 |

## 3. Cuentas
*(Dependencia directa de la cuenta hacia el cliente y la sucursal correspondiente)*

| cuenta_numero (PK) | cliente_id (FK) | sucursal_id (FK) | moneda | tipo_cuenta | saldo_actual |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CTA-100 | TAX-9a11 | S-CDMX | USD | Checking | 1300.00 |

## 4. Transacciones
*(Registro atómico exclusivo de cada evento financiero)*

| transaccion_id (PK) | cuenta_numero (FK) | fecha_tx | monto_tx |
| :--- | :--- | :--- | :--- |
| TX-0001 | CTA-100 | 20/07/2026 | 500.00 |
| TX-0002 | CTA-100 | 21/07/2026 | -200.00 |

---

## Esquemas de Tablas (3NF)

### Sucursales
- sucursal_id (PK)
- direccion

### Clientes
- cliente_id (PK)
- nombre
- email
- telefono

### Cuentas
- cuenta_numero (PK)
- cliente_id (FK -> Clientes)
- sucursal_id (FK -> Sucursales)
- moneda
- tipo_cuenta
- saldo_actual

### Transacciones
- transaccion_id (PK)
- cuenta_numero (FK -> Cuentas)
- fecha_tx
- monto_tx