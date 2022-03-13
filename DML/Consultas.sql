----- 1 -----
SELECT EMPLEADO.nombre,
    EMPLEADO.apellido,
    EMPLEADO.telefono,
    PA.pacientes_atendidos
FROM EMPLEADO
    INNER JOIN "PACIENTES-ATENDIDOS" PA ON PA.idEmpleado = EMPLEADO.idEmpleado
ORDER BY PA.pacientes_atendidos DESC;

----- 2 -----
SELECT EMPLEADO.nombre,
    EMPLEADO.apellido,
    EMPLEADO.direccion,
    PROFESION.titulo
FROM EMPLEADO
    INNER JOIN PROFESION ON PROFESION.idProfesion = EMPLEADO.profesion_idProfesion
    INNER JOIN "PACIENTES-ATENDIDOS" PA ON PA.idEmpleado = EMPLEADO.idEmpleado AND PA.pacientes_atendidos > 3
    INNER JOIN (SELECT DISTINCT empleado_idEmpleado FROM EVALUACION
        WHERE EXTRACT(YEAR FROM EVALUACION.fechaEvaluacion) = 2016) T ON T.empleado_idEmpleado = EMPLEADO.idEmpleado
WHERE EMPLEADO.genero = 'M';

----- 3 -----
SELECT DISTINCT PACIENTE.nombre,
    PACIENTE.apellido
FROM PACIENTE
    INNER JOIN "TRATAMIENTO-PACIENTE" TC ON TC.paciente_idPaciente = PACIENTE.idPaciente
    INNER JOIN TRATAMIENTO T ON T.idTratamiento = TC.tratamiento_idTratamiento AND T.nombre = 'Tabaco en polvo'
    INNER JOIN EVALUACION E ON E.paciente_idPaciente = PACIENTE.idPaciente
    INNER JOIN SINTOMA S ON S.idSintoma = E.sintoma_idSintoma AND S.nombre = 'Dolor de cabeza';

----- 4 -----
SELECT PACIENTE.nombre,
    PACIENTE.apellido,
    P.cantidad_antidepresivos
FROM(
        SELECT TC.paciente_idPaciente, COUNT(*) cantidad_antidepresivos
        FROM "TRATAMIENTO-PACIENTE" TC
        INNER JOIN TRATAMIENTO T ON T.idTratamiento = TC.tratamiento_idTratamiento AND T.nombre = 'Antidepresivos'
        GROUP BY TC.paciente_idPaciente
    ) P
    INNER JOIN PACIENTE ON PACIENTE.idPaciente = P.paciente_idPaciente
ORDER BY P.cantidad_antidepresivos DESC
FETCH FIRST 5 ROWS ONLY;

----- 5 -----
SELECT PACIENTE.nombre,
    PACIENTE.apellido,
    PACIENTE.direccion,
    PT.cantidad_tratamientos
FROM PACIENTE
    INNER JOIN (
        SELECT TC.paciente_idPaciente, COUNT(*) cantidad_tratamientos
        FROM "TRATAMIENTO-PACIENTE" TC
        INNER JOIN TRATAMIENTO T ON T.idTratamiento = TC.tratamiento_idTratamiento
        GROUP BY TC.paciente_idPaciente
        HAVING COUNT(*) > 3
    ) PT ON PT.paciente_idPaciente = PACIENTE.idPaciente
    LEFT OUTER JOIN EVALUACION ON PACIENTE.idPaciente = EVALUACION.paciente_idPaciente
        WHERE EVALUACION.paciente_idPaciente IS NULL
ORDER BY PT.cantidad_tratamientos DESC;

----- 6 -----
SELECT DIAGNOSTICO.tipoFumador,
    D.cantidad_asignaciones
FROM(
        SELECT DE.diagnostico_idDiagnostico, DE.rangoDiagnostico, COUNT(*) cantidad_asignaciones
        FROM "DIAGNOSTICO-EVALUACION" DE
        GROUP BY DE.diagnostico_idDiagnostico, DE.rangoDiagnostico
        HAVING DE.rangoDiagnostico = 9
    ) D
    INNER JOIN DIAGNOSTICO ON DIAGNOSTICO.idDiagnostico = D.diagnostico_idDiagnostico
ORDER BY D.cantidad_asignaciones DESC;

----- 7 -----
SELECT DISTINCT P.nombre,
    P.apellido,
    P.direccion
FROM PACIENTE P
INNER JOIN EVALUACION E ON E.paciente_idPaciente = P.idPaciente
INNER JOIN "DIAGNOSTICO-EVALUACION" DE ON DE.evaluacion_idEvaluacion = E.idEvaluacion AND DE.rangoDiagnostico > 5
ORDER BY P.nombre, P.apellido DESC;

----- 8 -----
SELECT E.nombre,
    E.apellido,
    E.fechaNacimiento,
    PA.pacientes_atendidos
FROM EMPLEADO E
INNER JOIN "PACIENTES-ATENDIDOS" PA ON PA.idEmpleado = E.idEmpleado
WHERE E.genero = 'F'
AND E.direccion = '1475 Dryden Crossing'
ORDER BY PA.pacientes_atendidos DESC;

----- 9 -----
SELECT E.idEmpleado,
    E.nombre,
    E.apellido,
    ROUND((PA.pacientes_atendidos/total_pacientes)*100,4) porcentaje
FROM (
    SELECT empleado_idempleado idEmpleado, COUNT(DISTINCT paciente_idPaciente) pacientes_atendidos
    FROM EVALUACION
    WHERE EXTRACT(YEAR FROM fechaEvaluacion) >= 2017
    GROUP BY empleado_idEmpleado
) PA,
(SELECT COUNT(*) total_pacientes FROM PACIENTE),
(SELECT idEmpleado, nombre, apellido FROM EMPLEADO) E
WHERE E.idEmpleado = PA.idEmpleado
ORDER BY porcentaje DESC;

----- 10 -----
SELECT T.titulo,
    ROUND((T.conteo/total_empleados)*100,4) porcentaje
FROM (
    SELECT PROFESION.titulo, COUNT(*) conteo
    FROM EMPLEADO
    INNER JOIN PROFESION ON PROFESION.idProfesion = EMPLEADO.profesion_idProfesion
    GROUP BY PROFESION.titulo
) T,
(SELECT COUNT(*) total_empleados FROM EMPLEADO)
ORDER BY porcentaje DESC;

----- 11 -----
SELECT Q.año, Q.mes, P.nombre, P.apellido
FROM (
    SELECT EXTRACT(YEAR FROM MIN(PEP.primeraEvaluacion)) año, EXTRACT(MONTH FROM MIN(PEP.primeraEvaluacion)) mes, PEP.idPaciente
    FROM "PRIMERA-EVALUACION-PACIENTE" PEP,
    (
        SELECT TP.paciente_idPaciente, COUNT(*) tratamientos_aplicados
        FROM "TRATAMIENTO-PACIENTE" TP
        GROUP BY TP.paciente_idPaciente
        ORDER BY tratamientos_aplicados DESC
        FETCH FIRST 5 ROWS ONLY
    ) PMAS,
    (
        SELECT TP.paciente_idPaciente, COUNT(*) tratamientos_aplicados
        FROM "TRATAMIENTO-PACIENTE" TP
        GROUP BY TP.paciente_idPaciente
        ORDER BY tratamientos_aplicados ASC
        FETCH FIRST 5 ROWS ONLY
    ) PMENOS
    WHERE (PMAS.paciente_idPaciente = PEP.idPaciente OR PMENOS.paciente_idPaciente = PEP.idPaciente)
    GROUP BY PEP.idPaciente
) Q
INNER JOIN PACIENTE P ON P.idPaciente = Q.idPaciente;