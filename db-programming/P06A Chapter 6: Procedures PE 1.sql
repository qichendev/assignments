CREATE OR REPLACE PROCEDURE ADD_PROFESSOR
(
  p_professor_no IN gl_professors_copy.professor_no%TYPE,
  p_first_name IN gl_professors_copy.first_name%TYPE,
  p_last_name IN gl_professors_copy.last_name%TYPE,
  p_office_no IN gl_professors_copy.office_no%TYPE,
  p_office_ext IN gl_professors_copy.office_ext%TYPE,
  p_school_code IN gl_professors_copy.school_code%TYPE
)
IS
BEGIN
  INSERT INTO gl_professors_copy (professor_no, first_name, last_name, office_no, office_ext, school_code)
  VALUES (p_professor_no, p_first_name, p_last_name, p_office_no, p_office_ext, p_school_code);
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Professor ' || p_first_name || ' ' || p_last_name || ' added successfully.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error adding professor: ' || SQLERRM);
END;
/