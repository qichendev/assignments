SET SERVEROUTPUT ON

-- Dependency for P0705 when this file is run standalone.
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

-- P0703
CREATE OR REPLACE FUNCTION get_letter_grade
(
    p_section_id IN gl_enrollments.section_id%TYPE,
    p_student_no IN gl_enrollments.student_no%TYPE
)
RETURN gl_enrollments.letter_grade%TYPE
IS
    v_letter_grade gl_enrollments.letter_grade%TYPE;
BEGIN
    SELECT letter_grade
      INTO v_letter_grade
      FROM gl_enrollments
     WHERE section_id = p_section_id
       AND student_no = p_student_no;

    RETURN v_letter_grade;
END;
/

DECLARE
    v_section_id    gl_enrollments.section_id%TYPE := :ENTER_SECTION_ID;
    v_student_no    gl_enrollments.student_no%TYPE := :ENTER_STUDENT_NO;
    v_letter_grade  gl_enrollments.letter_grade%TYPE;
BEGIN
    v_letter_grade := get_letter_grade(v_section_id, v_student_no);

    DBMS_OUTPUT.PUT_LINE('Section id: ' || v_section_id);
    DBMS_OUTPUT.PUT_LINE('Student no: ' || v_student_no);
    DBMS_OUTPUT.PUT_LINE('Letter Grade: ' || COALESCE(v_letter_grade, 'NG'));
END;
/

-- P0704
CREATE OR REPLACE FUNCTION get_full_name
(
    p_student_no IN gl_students.student_no%TYPE
)
RETURN VARCHAR2
IS
    v_full_name VARCHAR2(129);
BEGIN
    SELECT first_name || ' ' || last_name
      INTO v_full_name
      FROM gl_students
     WHERE student_no = p_student_no;

    RETURN v_full_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

DECLARE
    v_student_no gl_students.student_no%TYPE := :ENTER_STUDENT_NO;
    v_full_name  VARCHAR2(129);
BEGIN
    v_full_name := get_full_name(v_student_no);

    IF v_full_name IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Student ' || v_student_no || ' not found');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Student: ' || v_student_no);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_full_name);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- P0705
DECLARE
    v_section_id    gl_enrollments.section_id%TYPE := :ENTER_SECTION_ID;
    v_student_no    gl_students.student_no%TYPE := :ENTER_STUDENT_NO;
    v_full_name     VARCHAR2(129);
    v_numeric_grade gl_enrollments.numeric_grade%TYPE;
    v_letter_grade  gl_enrollments.letter_grade%TYPE;
BEGIN
    v_full_name := get_full_name(v_student_no);

    IF v_full_name IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Student ' || v_student_no || ' not found');
    ELSE
        v_numeric_grade := get_numeric_grade(v_section_id, v_student_no);
        v_letter_grade := get_letter_grade(v_section_id, v_student_no);

        DBMS_OUTPUT.PUT_LINE('Student: ' || v_student_no || '  ' || v_full_name);
        DBMS_OUTPUT.PUT_LINE('Numeric grade: ' || COALESCE(TO_CHAR(v_numeric_grade), 'NG'));
        DBMS_OUTPUT.PUT_LINE('Letter grade: ' || COALESCE(v_letter_grade, 'NG'));
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
