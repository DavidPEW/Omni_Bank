CREATE TYPE tipo_Moneda AS ENUM('USD','EUR','MXN')
CREATE TYPE tipo_Cuenta AS ENUM('CHECKING','SAVINGS','CREDIT')
CREATE TYPE tipo_Transaccion AS ENUM('DEPOSIT','WHITDRAW')

--  Cuenta              Tipo de datos
    saldo_actual    =   NUMERIC
    mod_cuenta  =   TIMESTAMPTZ
    pk y fk = UUID

    --Numeric a diferencia de float no redondea

    --TIEMSTAMPZ absorbe la zona horaria del usuario

    --UUID genera aleatoriamente los digitos
