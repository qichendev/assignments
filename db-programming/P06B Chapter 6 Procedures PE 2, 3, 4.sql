SET SERVEROUTPUT ON

-- P0602
CREATE OR REPLACE PROCEDURE convert_grade
(
    p_numeric_grade IN gl_enrollments.numeric_grade%TYPE,
    p_letter_grade OUT gl_enrollments.letter_grade%TYPE
)
IS
BEGIN
    p_letter_grade :=
        CASE
            WHEN p_numeric_grade >= 90 THEN 'A'
            WHEN p_numeric_grade >= 80 THEN 'B'
            WHEN p_numeric_grade >= 70 THEN 'C'
            WHEN p_numeric_grade >= 60 THEN 'D'
            ELSE 'F'
        END;
END;
/

DECLARE
    v_numeric_grade gl_enrollments.numeric_grade%TYPE := :ENTER_NUMERIC_GRADE;
    v_letter_grade  gl_enrollments.letter_grade%TYPE;
    e_invalid_grade EXCEPTION;
BEGIN
    IF v_numeric_grade < 0 OR v_numeric_grade > 100 THEN
        RAISE e_invalid_grade;
    END IF;

    convert_grade(v_numeric_grade, v_letter_grade);

    DBMS_OUTPUT.PUT_LINE('Numeric grade: ' || v_numeric_grade);
    DBMS_OUTPUT.PUT_LINE('Letter grade: ' || v_letter_grade);
EXCEPTION
    WHEN e_invalid_grade THEN
        DBMS_OUTPUT.PUT_LINE(
            'Grade ' || v_numeric_grade || ' invalid. Must be between 0 and 100.'
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- P0603
CREATE OR REPLACE PROCEDURE update_grade
(
    p_section_id         IN gl_enrollments_copy.section_id%TYPE,
    p_student_no         IN gl_enrollments_copy.student_no%TYPE,
    p_new_numeric_grade  IN gl_enrollments_copy.numeric_grade%TYPE,
    p_old_numeric_grade OUT gl_enrollments_copy.numeric_grade%TYPE,
    p_old_letter_grade  OUT gl_enrollments_copy.letter_grade%TYPE,
    p_new_letter_grade  OUT gl_enrollments_copy.letter_grade%TYPE
)
IS
BEGIN
    SELECT numeric_grade, letter_grade
      INTO p_old_numeric_grade, p_old_letter_grade
      FROM gl_enrollments_copy
     WHERE section_id = p_section_id
       AND student_no = p_student_no;

    convert_grade(p_new_numeric_grade, p_new_letter_grade);

    UPDATE gl_enrollments_copy
       SET numeric_grade = p_new_numeric_grade,
           letter_grade = p_new_letter_grade
     WHERE section_id = p_section_id
       AND student_no = p_student_no;

    COMMIT;
END;
/

DECLARE
    v_section_id         gl_enrollments_copy.section_id%TYPE := :ENTER_SECTION_ID;
    v_student_no         gl_enrollments_copy.student_no%TYPE := :ENTER_STUDENT_NO;
    v_new_numeric_grade  gl_enrollments_copy.numeric_grade%TYPE := :ENTER_NEW_NUMERIC_GRADE;
    v_old_numeric_grade  gl_enrollments_copy.numeric_grade%TYPE;
    v_old_letter_grade   gl_enrollments_copy.letter_grade%TYPE;
    v_new_letter_grade   gl_enrollments_copy.letter_grade%TYPE;
BEGIN
    update_grade(
        v_section_id,
        v_student_no,
        v_new_numeric_grade,
        v_old_numeric_grade,
        v_old_letter_grade,
        v_new_letter_grade
    );

    DBMS_OUTPUT.PUT_LINE('Section: ' || v_section_id);
    DBMS_OUTPUT.PUT_LINE(
        'Numeric grade: Old = ' || COALESCE(TO_CHAR(v_old_numeric_grade), 'NG') ||
        '  New = ' || TO_CHAR(v_new_numeric_grade)
    );
    DBMS_OUTPUT.PUT_LINE(
        'Letter grade: Old = ' || COALESCE(v_old_letter_grade, 'NG') ||
        '  New = ' || COALESCE(v_new_letter_grade, 'NG')
    );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Student ' || v_student_no || ' Section ' || v_section_id || ' not found'
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- P0604
CREATE OR REPLACE PROCEDURE get_grade
(
    p_section_id     IN gl_enrollments.section_id%TYPE,
    p_student_no     IN gl_enrollments.student_no%TYPE,
    p_numeric_grade OUT gl_enrollments.numeric_grade%TYPE,
    p_letter_grade  OUT gl_enrollments.letter_grade%TYPE
)
IS
BEGIN
    SELECT numeric_grade, letter_grade
      INTO p_numeric_grade, p_letter_grade
      FROM gl_enrollments
     WHERE section_id = p_section_id
       AND student_no = p_student_no;
END;
/

DECLARE
    v_section_id     gl_enrollments.section_id%TYPE := :ENTER_SECTION_ID;
    v_student_no     gl_enrollments.student_no%TYPE := :ENTER_STUDENT_NO;
    v_numeric_grade  gl_enrollments.numeric_grade%TYPE;
    v_letter_grade   gl_enrollments.letter_grade%TYPE;
BEGIN
    get_grade(v_section_id, v_student_no, v_numeric_grade, v_letter_grade);

    DBMS_OUTPUT.PUT_LINE('Student: ' || v_student_no);
    DBMS_OUTPUT.PUT_LINE('Section: ' || v_section_id);
    DBMS_OUTPUT.PUT_LINE('Numeric grade: ' || COALESCE(TO_CHAR(v_numeric_grade), 'NG'));
    DBMS_OUTPUT.PUT_LINE('Letter grade: ' || COALESCE(v_letter_grade, 'NG'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Student ' || v_student_no || ' Section ' || v_section_id || ' not found'
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
