-- Generado por Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   en:        2022-03-07 08:15:08 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE diagnostico (
    iddiagnostico INTEGER NOT NULL,
    tipofumador   VARCHAR2(150) NOT NULL
);

ALTER TABLE diagnostico ADD CONSTRAINT diagnostico_pk PRIMARY KEY ( iddiagnostico );

CREATE TABLE "DIAGNOSTICO-EVALUACION" (
    iddiagnosticoevaluacion   INTEGER NOT NULL,
    rangodiagnostico          INTEGER NOT NULL,
    evaluacion_idevaluacion   INTEGER NOT NULL,
    diagnostico_iddiagnostico INTEGER NOT NULL
);

ALTER TABLE "DIAGNOSTICO-EVALUACION" ADD CONSTRAINT "DIAGNOSTICO-EVALUACION_PK" PRIMARY KEY ( iddiagnosticoevaluacion );

CREATE TABLE empleado (
    idempleado            INTEGER NOT NULL,
    nombre                VARCHAR2(150) NOT NULL,
    apellido              VARCHAR2(150) NOT NULL,
    direccion             VARCHAR2(150) NOT NULL,
    telefono              VARCHAR2(20) NOT NULL,
    genero                VARCHAR2(1),
    fechanacimiento       DATE NOT NULL,
    profesion_idprofesion INTEGER NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( idempleado );

CREATE TABLE evaluacion (
    idevaluacion        INTEGER NOT NULL,
    fechaevaluacion     DATE NOT NULL,
    sintoma_idsintoma   INTEGER NOT NULL,
    empleado_idempleado INTEGER NOT NULL,
    paciente_idpaciente INTEGER NOT NULL
);

ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pk PRIMARY KEY ( idevaluacion );

CREATE TABLE paciente (
    idpaciente      INTEGER NOT NULL,
    nombre          VARCHAR2(150) NOT NULL,
    apellido        VARCHAR2(150) NOT NULL,
    direccion       VARCHAR2(150) NOT NULL,
    telefono        VARCHAR2(20) NOT NULL,
    genero          VARCHAR2(1),
    fechanacimiento DATE NOT NULL,
    altura          FLOAT NOT NULL,
    peso            NUMBER NOT NULL
);

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( idpaciente );

CREATE TABLE profesion (
    idprofesion INTEGER NOT NULL,
    titulo      VARCHAR2(150) NOT NULL
);

ALTER TABLE profesion ADD CONSTRAINT profesion_pk PRIMARY KEY ( idprofesion );

CREATE TABLE sintoma (
    idsintoma INTEGER NOT NULL,
    nombre    VARCHAR2(150) NOT NULL
);

ALTER TABLE sintoma ADD CONSTRAINT sintoma_pk PRIMARY KEY ( idsintoma );

CREATE TABLE tratamiento (
    idtratamiento INTEGER NOT NULL,
    nombre        VARCHAR2(150) NOT NULL
);

ALTER TABLE tratamiento ADD CONSTRAINT tratamiento_pk PRIMARY KEY ( idtratamiento );

CREATE TABLE "TRATAMIENTO-PACIENTE" (
    idtratamientopaciente     INTEGER NOT NULL,
    fechatratamiento          DATE NOT NULL,
    tratamiento_idtratamiento INTEGER NOT NULL,
    paciente_idpaciente       INTEGER NOT NULL
);

ALTER TABLE "TRATAMIENTO-PACIENTE" ADD CONSTRAINT "TRATAMIENTO-PACIENTE_PK" PRIMARY KEY ( idtratamientopaciente );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE "DIAGNOSTICO-EVALUACION"
    ADD CONSTRAINT "DIAGNOSTICO-EVALUACION_DIAGNOSTICO_FK" FOREIGN KEY ( diagnostico_iddiagnostico )
        REFERENCES diagnostico ( iddiagnostico );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE "DIAGNOSTICO-EVALUACION"
    ADD CONSTRAINT "DIAGNOSTICO-EVALUACION_EVALUACION_FK" FOREIGN KEY ( evaluacion_idevaluacion )
        REFERENCES evaluacion ( idevaluacion );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_profesion_fk FOREIGN KEY ( profesion_idprofesion )
        REFERENCES profesion ( idprofesion );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_empleado_fk FOREIGN KEY ( empleado_idempleado )
        REFERENCES empleado ( idempleado );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_paciente_fk FOREIGN KEY ( paciente_idpaciente )
        REFERENCES paciente ( idpaciente );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_sintoma_fk FOREIGN KEY ( sintoma_idsintoma )
        REFERENCES sintoma ( idsintoma );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE "TRATAMIENTO-PACIENTE"
    ADD CONSTRAINT "TRATAMIENTO-PACIENTE_PACIENTE_FK" FOREIGN KEY ( paciente_idpaciente )
        REFERENCES paciente ( idpaciente );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE "TRATAMIENTO-PACIENTE"
    ADD CONSTRAINT "TRATAMIENTO-PACIENTE_TRATAMIENTO_FK" FOREIGN KEY ( tratamiento_idtratamiento )
        REFERENCES tratamiento ( idtratamiento );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   4
-- WARNINGS                                 0
