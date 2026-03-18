SET SERVEROUTPUT ON

-- P0503
DECLARE
    v_program_code gl_programs.program_code%TYPE := :ENTER_PROGRAM_CODE;
    v_new_program_name gl_programs.program_name%TYPE := :ENTER_NEW_PROGRAM_NAME;
BEGIN
    SELECT program_name INTO v_new_program_name
    FROM gl_programs    WHERE program_code = v_program_code;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Program ' || v_program_code || ' does not exist.');
    WHEN OTHERS THEN
        UPDATE gl_programs
        SET program_name = v_new_program_name
        WHERE program_code = v_program_code;
        DBMS_OUTPUT.PUT_LINE('Program name updated successfully.');
END;
/

-- P0504
SET SERVEROUTPUT ON

DECLARE
  v_major    gl_students.major_code%TYPE := '&ENTER_MAJOR_CODE';
  v_student  VARCHAR2(200);
BEGIN
  SELECT first_name || ' ' || last_name
    INTO v_student
    FROM gl_students
   WHERE major_code = v_major;

  DBMS_OUTPUT.PUT_LINE('Student: ' || v_student);
EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Request returned multiple rows');
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No students found for Major ' || v_major);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unknown error occurred. Contact software support.');
END;
/