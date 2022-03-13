CREATE OR REPLACE VIEW "PACIENTES-ATENDIDOS" AS 
    SELECT empleado_idempleado idEmpleado, COUNT(DISTINCT paciente_idPaciente) pacientes_atendidos
    FROM EVALUACION
    GROUP BY empleado_idEmpleado
WITH READ ONLY;

CREATE OR REPLACE VIEW "TOTAL-PACIENTES-ATENDIDOS" AS 
    SELECT SUM(pacientes_atendidos) total_pacientes_atendidos
    FROM "PACIENTES-ATENDIDOS"
WITH READ ONLY;

CREATE OR REPLACE VIEW "PRIMERA-EVALUACION-PACIENTE" AS 
    SELECT paciente_idPaciente idPaciente, MIN(fechaEvaluacion) primeraEvaluacion
    FROM EVALUACION
    GROUP BY paciente_idPaciente
    ORDER BY MIN(fechaEvaluacion)
WITH READ ONLY;
