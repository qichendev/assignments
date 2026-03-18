SET SERVEROUTPUT ON

-- P0701
CREATE OR REPLACE FUNCTION convert_numeric_grade
(
    p_numeric_grade IN gl_enrollments.numeric_grade%TYPE
)
RETURN gl_enrollments.letter_grade%TYPE
IS
BEGIN
    RETURN CASE
        WHEN p_numeric_grade BETWEEN 90 AND 100 THEN 'A'
        WHEN p_numeric_grade BETWEEN 80 AND 89 THEN 'B'
        WHEN p_numeric_grade BETWEEN 70 AND 79 THEN 'C'
        WHEN p_numeric_grade BETWEEN 60 AND 69 THEN 'D'
        WHEN p_numeric_grade BETWEEN 0 AND 59 THEN 'F'
        ELSE NULL
    END;
END;
/

DECLARE
    v_numeric_grade gl_enrollments.numeric_grade%TYPE := :ENTER_NUMERIC_GRADE;
    v_letter_grade  gl_enrollments.letter_grade%TYPE;
BEGIN
    v_letter_grade := convert_numeric_grade(v_numeric_grade);

    DBMS_OUTPUT.PUT_LINE('Numeric grade: ' || v_numeric_grade);
    DBMS_OUTPUT.PUT_LINE('Letter grade: ' || v_letter_grade);
END;
/

-- P0702
CREATE OR REPLACE FUNCTION get_numeric_grade
(
    p_section_id IN gl_enrollments.section_id%TYPE,
    p_student_no IN gl_enrollments.student_no%TYPE
)
RETURN gl_enrollments.numeric_grade%TYPE
IS
    v_numeric_grade gl_enrollments.numeric_grade%TYPE;
BEGIN
    SELECT numeric_grade
      INTO v_numeric_grade
      FROM gl_enrollments
     WHERE section_id = p_section_id
       AND student_no = p_student_no;

    RETURN v_numeric_grade;
END;
/

DECLARE
    v_section_id    gl_enrollments.section_id%TYPE := :ENTER_SECTION_ID;
    v_student_no    gl_enrollments.student_no%TYPE := :ENTER_STUDENT_NO;
    v_numeric_grade gl_enrollments.numeric_grade%TYPE;
BEGIN
    v_numeric_grade := get_numeric_grade(v_section_id, v_student_no);

    DBMS_OUTPUT.PUT_LINE('Section id: ' || v_section_id);
    DBMS_OUTPUT.PUT_LINE('Student no: ' || v_student_no);
    DBMS_OUTPUT.PUT_LINE('Numeric Grade: ' || COALESCE(TO_CHAR(v_numeric_grade), 'NG'));
END;
/
