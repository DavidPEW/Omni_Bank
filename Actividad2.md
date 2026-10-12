Actividad 2



Cliente

\-Cliente\_id(pk)

\-Nombre

\-Tax\_id

\-Correo

\-teléfono

\-fecha de nacimiento



Cuenta

\-Cuenta\_id(pk)

\-Cliente\_id(fk)

\-Saldo

\-Tipo\_de\_cuenta

\-Limite\_de\_Credito



Transacciones

\-Transacciones\_id(pk)

\-Cuenta\_id(fk)

\-monto

\-fecha\_del\_movimiento

\-Tipo

\-Origen 

\-Destino



Cliente 1----N Cuentas 1-----N Transacciones

