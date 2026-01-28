CREATE OR REPLACE PROCEDURE reset_COPY_tables 
AS
  v_count INTEGER;
BEGIN
DBMS_OUTPUT.PUT_LINE('starting the script');
  SELECT COUNT(*) INTO v_count
  FROM USER_TABLES
  WHERE TABLE_NAME = 'GL_PROFESSORS_COPY';
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE 'DROP TABLE gl_professors_copy CASCADE CONSTRAINTS';
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM USER_TABLES
  WHERE TABLE_NAME = 'GL_PROFESSORS';
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE ' 
    CREATE TABLE gl_professors_copy AS
      SELECT * FROM gl_professors ';
	  
	EXECUTE IMMEDIATE '
    ALTER TABLE gl_professors_copy 
    ADD CONSTRAINT gl_professors_copy_pk
    PRIMARY KEY ( professor_no ) ';
  ELSE
    DBMS_OUTPUT.PUT_LINE('GL_PROFESSORS table is missing - unable to create GL_PROFESSORS_COPY table');
  END IF;
-------------------------------------------------------------

  SELECT COUNT(*) INTO v_count
  FROM USER_TABLES
  WHERE TABLE_NAME = 'GL_ENROLLMENTS_COPY';
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE 'DROP TABLE gl_enrollments_copy CASCADE CONSTRAINTS';
  END IF;
  
  SELECT COUNT(*) INTO v_count
  FROM USER_TABLES
  WHERE TABLE_NAME = 'GL_ENROLLMENTS';
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE ' 
    CREATE TABLE gl_enrollments_copy AS
    SELECT * FROM gl_enrollments ';

    EXECUTE IMMEDIATE '
    ALTER TABLE gl_enrollments_copy 
    ADD CONSTRAINT gl_enrollments_copy_pk
    PRIMARY KEY ( section_id, student_no ) ';
  ELSE
    DBMS_OUTPUT.PUT_LINE('GL_ENROLLMENTS table is missing - unable to create GL_ENROLLMENTS_COPY table');
  END IF;
  ------------------------------------------------------------
  
  SELECT COUNT(*) INTO v_count
  FROM USER_TABLES
  WHERE TABLE_NAME = 'GL_SECTIONS_COPY';
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE 'DROP TABLE gl_sections_copy CASCADE CONSTRAINTS';
  END IF;
  
  SELECT COUNT(*) INTO v_count
  FROM USER_TABLES
  WHERE TABLE_NAME = 'GL_SECTIONS';
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE ' 
    CREATE TABLE gl_sections_copy AS
    SELECT * FROM gl_sections ';

    EXECUTE IMMEDIATE '
    ALTER TABLE gl_sections_copy 
    ADD CONSTRAINT gl_sections_copy_pk
    PRIMARY KEY ( section_id ) ';
   
    EXECUTE IMMEDIATE '
    ALTER TABLE gl_sections_copy
    ADD CONSTRAINT gl_sect_copy_professor_no_fk
    FOREIGN KEY (professor_no)
    REFERENCES gl_professors (professor_no) ';
  ELSE
     DBMS_OUTPUT.PUT_LINE('GL_SECTIONS table is missing - unable to create GL_SECTIONS_COPY table');
  END IF;

END reset_COPY_tables;