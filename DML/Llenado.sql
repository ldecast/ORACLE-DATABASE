-- TABLE DIAGNOSTICO
INSERT INTO DIAGNOSTICO (tipoFumador)
SELECT DISTINCT DIAGNOSTICO_DEL_SINTOMA
FROM TEMPORAL
WHERE DIAGNOSTICO_DEL_SINTOMA IS NOT NULL;

-- TABLE PROFESION
INSERT INTO PROFESION (titulo)
SELECT DISTINCT TITULO_DEL_EMPLEADO
FROM TEMPORAL
WHERE TITULO_DEL_EMPLEADO IS NOT NULL;

-- TABLE SINTOMA
INSERT INTO SINTOMA (nombre)
SELECT DISTINCT SINTOMA_DEL_PACIENTE
FROM TEMPORAL
WHERE SINTOMA_DEL_PACIENTE IS NOT NULL;

-- TABLE TRATAMIENTO
INSERT INTO TRATAMIENTO (nombre)
SELECT DISTINCT TRATAMIENTO_APLICADO
FROM TEMPORAL
WHERE TRATAMIENTO_APLICADO IS NOT NULL;