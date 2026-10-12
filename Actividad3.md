# Actividad 3

## 1. Transacciones
| Transaccion_Id | Fecha_tx | Cliente_nombre | Cliente_correo | Cliente_numero |
| :--- | :--- | :--- | :--- | :--- |
| TX-0001 | 20/17/202X | Tax-9a11 | Roberto Soto | 555-9011 |
| TX-0002 | 20/17/202X | Tax-9a11 | Roberto Soto | 555-9011 |

| Cuenta_numero | Moneda | Tipo_cuenta | Saldo_actual | Monto | Suc_codigo | Sucursaldire |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| CTA-100 | USD | Checking | 1300 | 500 | S-CDMX | Av. Juárez #19 |
| CTA-100 | USD | Checking | 1300 | -200 | S-CDMX | Av. Juárez #19 |

---

## 2. Cliente
| Cliente_id (PK) | Cliente_numero | Correo | Cliente_tax_Id | Cliente_nombre |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 555-9011 | rob@gmail.com | TAX-9a11 | Roberto Soto |

---

## 3. Cuentas
| Cuenta_numero (PK) | Tipo_cuenta | Cliente_id (FK) | Saldo |
| :--- | :--- | :--- | :--- |
| CTA-100 | Checking | 1 | 1300 |

---

## 4. Transacciones y Sucursales 

### Transacciones
| Transaccion_Id (PK) | Cuenta_numero (PK) | Monto_tx | Saldo_actual | Moneda | Fecha_tx |
| :--- | :--- | :--- | :--- | :--- | :--- |
| TX-0001 | CTA-100 | 500 | 1300 | USD | 20/7/2026 |
| TX-0002 | CTA-100 | -200 | 1300 | USD | 21/7/2026 |

### Sucursal
| Sucursal_Id | Sucursal_codigo | Sucursal_direccion |
| :--- | :--- | :--- |
| 1 | S-CDMX | Av. Juárez #100 |
| 1 | S-CDMX | Av. Juárez #100 |

### Esquemas de Tablas

#### Cliente
- Cliente_id (PK)
- Número de cliente
- Correo
- Tax_Id
- Nombre

#### Cuentas
- Número de cuenta (PK)
- Tipo de cuenta
- Id de cliente
- Saldo

#### Transacciones
- Transacción_id (PK)
- Número de cuenta (FK)
- Monto
- Saldo actual
- Moneda
- Fecha

#### Sucursales
- Id (PK)
- Sucursal_codigo
- Dirección
