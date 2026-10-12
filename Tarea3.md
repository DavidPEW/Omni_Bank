Tarea 3

1.-Evaluación de la Teoría: ¿Tiene razón el auditor de que una columna de saldo calculado es técnicamente un dato derivado/redundante según la teoría estricta de normalización pura?
El auditor junior tiene la razón desde una perspectiva puramente académica y teórica de normalización. En una base de datos en 3NF estricta y absoluta, no se deberían almacenar valores derivados que puedan calcularse a partir de otros campos transaccionales (como sería un SUM(monto) del historial), dado que se añade riesgo de inconsistencia al duplicar o derivar estados sin dependencia funcional directa indivisible.

2.-El Problema del Rendimiento (La Justificación del Mundo Real): Imagina que un cliente comercial masivo tiene un historial continuo de 250,000 transacciones acumuladas a lo largo de 5 años.

¿Qué sucedería con la CPU y los tiempos de latencia (milisegundos) del servidor de PostgreSQL si calculáramos el saldo desde cero (SUM()) en cada solicitud del frontend (infracciones a NFRs de rendimiento)?
En sistemas bancarios o comerciales de escala empresarial con volúmenes intensivos, calcular el saldo al vuelo (SUM(monto)) cada vez que un usuario consulta un ATM, hace un pago en un punto de venta (POS), o abre su aplicación bancaria generaría los siguientes problemas catastróficos:

Colapso del CPU e I/O de disco: Escanear e indexar 250,000 filas por consulta masiva (incluso en memoria con Índices) destruiría por completo el tiempo de respuesta del servidor relacional al escalar a millones de cuentas concurrentes (fallando los NFRs de latencia < 10ms).

Incapacidad de bloqueo rápido para salvedades concurrentes: Al transferir dinero es imperativo verificar inmediatamente en microsegundos que saldo_actual >= monto_a_retirar sin latencias de agregación previa que induzcan a condiciones de carrera transaccional o fraudes por desajustes de concurrencia temporal.

¿Por qué en la banca de grado empresarial mantenemos deliberadamente el campo saldo_actual como una desnormalización controlada, y cómo se protegerá para no caer en inconsistencias con el historial transaccional en el futuro (pista: bloqueos transaccionales y triggers ACID)?
Mantenemos saldo_actual como una desnormalización controlada. Para evitar que este saldo se desajuste en relación con las filas reales de Transacciones, delegamos al motor PostgreSQL la exigencia estricta de actualizar el saldo única y exclusivamente mediante Procedimientos Almacenados atómicos o Triggers transaccionales blindados bajo propiedades ACID con bloqueos de fila (FOR UPDATE), prohibiendo alteraciones manuales en la tabla o el cálculo errante en la capa del Frontend.