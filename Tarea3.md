Tarea 3

1.-Evaluación de la Teoría: ¿Tiene razón el auditor de que una columna de saldo calculado es técnicamente un dato derivado/redundante según la teoría estricta de normalización pura?

Si, segun la teoria estricta de normalizacion de bases de datos, una columna de saldo
calculado es un dato derivado y redundante

2.-El Problema del Rendimiento (La Justificación del Mundo Real): Imagina que un cliente comercial masivo tiene un historial continuo de 250,000 transacciones acumuladas a lo largo de 5 años.

¿Qué sucedería con la CPU y los tiempos de latencia (milisegundos) del servidor de PostgreSQL si calculáramos el saldo desde cero (SUM()) en cada solicitud del frontend (infracciones a NFRs de rendimiento)?

EL uso de la cpu aumentaria drasticamente y el tiempo de latencia aumentaria de forma exponencial degradando la experiencia del usuario, ademas que saturaria el servidor

¿Por qué en la banca de grado empresarial mantenemos deliberadamente el campo saldo_actual como una desnormalización controlada, y cómo se protegerá para no caer en inconsistencias con el historial transaccional en el futuro (pista: bloqueos transaccionales y triggers ACID)?