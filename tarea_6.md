Tarea 6 - Diagnóstico de Bloqueos en Producción y Despliegues Zero-Downtime

1. Diagnóstico de Causa Raíz Computacional (AccessExclusiveLock)

El incidente inaceptable en producción fue desencadenado directamente por un desconocimiento operativo y del motor en transiciones en caliente. Cuando se ejecuta un mandato directo ADD CONSTRAINT ... CHECK (...) sobre una entidad que alberga ya transacciones en disco duro en vivacidad continua de millones de filas:

El bloqueo crítico: PostgreSQL se ve obligado a paralizar y detener las operaciones en esa tabla para garantizar una fotografía y certidumbre relacional intacta de los datos en tanto procede al escaneo secuencial e indexado computacional, revisando renglón a renglón todo su gigantesco volumen.

Impacto operativo: Para hacer esto, adquiere irrebatiblemente un bloqueo de nivel absoluto del sistema: un AccessExclusiveLock. Este es el único bloqueo y de máxima gravedad en PostgreSQL que le cierra tajantemente las puertas tanto a consultas de lectura (SELECT) como a transacciones de modificación o inserción bancarias (INSERT / UPDATE), provocando caídas de servicio y agotamiento de conexiones (Error 504 Gateway Timeout).

2. Solución Empresarial en Dos Etapas para Despliegues Sin Interrupción (Zero-Downtime Migration)

Para blindar nuestras tablas en entornos intensivos productivos y dar carpetazo definitivo a esta clase de cataclismos operativos, establecemos el siguiente estándar procedimental en dos tiempos:

-- ETAPA 1: Inyección transaccional en caliente sin escaneo retrógrado de bloqueo inquebrantable
-- Le informamos explícitamente a PostgreSQL la cláusula "NOT VALID"
ALTER TABLE core.transactions 
    ADD CONSTRAINT chk_transactions_description_valid 
    CHECK (LENGTH(TRIM(description)) >= 5) NOT VALID;

-- El motor inserta pacíficamente la nueva regla en los metadatos del catálogo en un parpadeo de tiempo, 
-- aplicando instantáneamente la protección sobre cualquier transaccionalidad NUEVA que llegue en el futuro (INSERT/UPDATE)
-- sin molestarse, escanear ni estorbar a los millones de filas antiguas consolidadas y en sosiego en el disco.


-- ETAPA 2: Validación Asíncrona Pasiva sin Caídas de Servicio ni bloqueos masivos
-- En una sesión o mandato posterior (ideal para ventanas de bajamar operante, o inmediatamente después de la primera)
ALTER TABLE core.transactions 
    VALIDATE CONSTRAINT chk_transactions_description_valid;

-- Al ejecutarse en su segunda fase con VALIDATE CONSTRAINT, PostgreSQL efectúa paulatinamente en segundo plano
-- la inspección, escaneo y fiscalización gradual del histórico de los renglones anticuados.
-- En este ciclo especial, el motor se abstiene rígidamente y renuncia al terrible bloqueo AccessExclusiveLock;
-- adopta únicamente un bloqueo muchísimo más ligero y amigable (ShareUpdateExclusiveLock), que permite y consiente en continuidad
-- y en real time la ejecución pacífica de SELECTs e inserciones operativas de los clientes concurrentes sin inyectar latencias.
