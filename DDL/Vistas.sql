CREATE OR REPLACE VIEW "PACIENTES-ATENDIDOS" AS 
SELECT empleado_idempleado idEmpleado, COUNT(DISTINCT paciente_idPaciente) pacientes_atendidos
FROM EVALUACION
GROUP BY empleado_idEmpleado
WITH READ ONLY;