CREATE TABLE DIAGNOSTICO (
    idDiagnostico INTEGER NOT NULL,
    tipoFumador   VARCHAR2(150) NOT NULL
);

ALTER TABLE DIAGNOSTICO ADD CONSTRAINT diagnostico_pk PRIMARY KEY ( idDiagnostico );

CREATE TABLE "DIAGNOSTICO-EVALUACION" (
    idDiagnosticoEvaluacion   INTEGER NOT NULL,
    rangoDiagnostico          INTEGER NOT NULL,
    evaluacion_idEvaluacion   INTEGER NOT NULL,
    diagnostico_idDiagnostico INTEGER NOT NULL
);

ALTER TABLE "DIAGNOSTICO-EVALUACION" ADD CONSTRAINT "DIAGNOSTICO-EVALUACION_PK" PRIMARY KEY ( idDiagnosticoEvaluacion );

CREATE TABLE EMPLEADO (
    idEmpleado            INTEGER NOT NULL,
    nombre                VARCHAR2(150) NOT NULL,
    apellido              VARCHAR2(150) NOT NULL,
    direccion             VARCHAR2(150) NOT NULL,
    telefono              VARCHAR2(20) NOT NULL,
    genero                VARCHAR2(1),
    fechaNacimiento       DATE NOT NULL,
    profesion_idProfesion INTEGER NOT NULL
);

ALTER TABLE EMPLEADO ADD CONSTRAINT empleado_pk PRIMARY KEY ( idEmpleado );

CREATE TABLE EVALUACION (
    idEvaluacion        INTEGER NOT NULL,
    fechaEvaluacion     DATE NOT NULL,
    sintoma_idSintoma   INTEGER NOT NULL,
    empleado_idEmpleado INTEGER NOT NULL,
    paciente_idPaciente INTEGER NOT NULL
);

ALTER TABLE EVALUACION ADD CONSTRAINT evaluacion_pk PRIMARY KEY ( idEvaluacion );

CREATE TABLE PACIENTE (
    idPaciente      INTEGER NOT NULL,
    nombre          VARCHAR2(150) NOT NULL,
    apellido        VARCHAR2(150) NOT NULL,
    direccion       VARCHAR2(150) NOT NULL,
    telefono        VARCHAR2(20) NOT NULL,
    genero          VARCHAR2(1),
    fechaNacimiento DATE NOT NULL,
    altura          FLOAT NOT NULL,
    peso            NUMBER NOT NULL
);

ALTER TABLE PACIENTE ADD CONSTRAINT paciente_pk PRIMARY KEY ( idPaciente );

CREATE TABLE PROFESION (
    idProfesion INTEGER NOT NULL,
    titulo      VARCHAR2(150) NOT NULL
);

ALTER TABLE PROFESION ADD CONSTRAINT profesion_pk PRIMARY KEY ( idProfesion );

CREATE TABLE SINTOMA (
    idSintoma INTEGER NOT NULL,
    nombre    VARCHAR2(150) NOT NULL
);

ALTER TABLE SINTOMA ADD CONSTRAINT sintoma_pk PRIMARY KEY ( idSintoma );

CREATE TABLE TRATAMIENTO (
    idTratamiento INTEGER NOT NULL,
    nombre        VARCHAR2(150) NOT NULL
);

ALTER TABLE TRATAMIENTO ADD CONSTRAINT tratamiento_pk PRIMARY KEY ( idTratamiento );

CREATE TABLE "TRATAMIENTO-PACIENTE" (
    idTratamientoPaciente     INTEGER NOT NULL,
    fechaTratamiento          DATE NOT NULL,
    tratamiento_idTratamiento INTEGER NOT NULL,
    paciente_idPaciente       INTEGER NOT NULL
);

ALTER TABLE "TRATAMIENTO-PACIENTE" ADD CONSTRAINT "TRATAMIENTO-PACIENTE_PK" PRIMARY KEY ( idTratamientoPaciente );

ALTER TABLE "DIAGNOSTICO-EVALUACION"
    ADD CONSTRAINT "DIAGNOSTICO-EVALUACION_FK1" FOREIGN KEY ( diagnostico_idDiagnostico )
        REFERENCES DIAGNOSTICO ( idDiagnostico );

ALTER TABLE "DIAGNOSTICO-EVALUACION"
    ADD CONSTRAINT "DIAGNOSTICO-EVALUACION_FK2" FOREIGN KEY ( evaluacion_idEvaluacion )
        REFERENCES EVALUACION ( idEvaluacion );

ALTER TABLE EMPLEADO
    ADD CONSTRAINT empleado_profesion_fk FOREIGN KEY ( profesion_idProfesion )
        REFERENCES PROFESION ( idProfesion );

ALTER TABLE EVALUACION
    ADD CONSTRAINT evaluacion_empleado_fk FOREIGN KEY ( empleado_idEmpleado )
        REFERENCES EMPLEADO ( idEmpleado );

ALTER TABLE EVALUACION
    ADD CONSTRAINT evaluacion_paciente_fk FOREIGN KEY ( paciente_idPaciente )
        REFERENCES PACIENTE ( idPaciente );

ALTER TABLE EVALUACION
    ADD CONSTRAINT evaluacion_sintoma_fk FOREIGN KEY ( sintoma_idSintoma )
        REFERENCES SINTOMA ( idSintoma );

ALTER TABLE "TRATAMIENTO-PACIENTE"
    ADD CONSTRAINT "TRATAMIENTO-PACIENTE_FK1" FOREIGN KEY ( paciente_idPaciente )
        REFERENCES PACIENTE ( idPaciente );

ALTER TABLE "TRATAMIENTO-PACIENTE"
    ADD CONSTRAINT "TRATAMIENTO-PACIENTE_FK2" FOREIGN KEY ( tratamiento_idTratamiento )
        REFERENCES TRATAMIENTO ( idTratamiento );
