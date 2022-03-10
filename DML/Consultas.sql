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

) D
    INNER JOIN DIAGNOSTICO ON DIAGNOSTICO.idDiagnostico = D.diagnostico_idDiagnostico
ORDER BY D.cantidad_asignaciones DESC;

/* SELECT DE.paciente_idPaciente, COUNT(*) cantidad_asignaciones
FROM "DIAGNOSTICO-EVALUACION" DE
--INNER JOIN DIAGNOSTICO D ON D.idDiagnostico = DE.diagnostico_idDiagnostico
GROUP BY DE.diagnostico_idDiagnostico
HAVING DE.rangoDiagnostico = 9 */