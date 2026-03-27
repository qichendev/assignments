SET SERVEROUTPUT ON
SET VERIFY OFF

PROMPT === Step 1: Reset GL_PROFESSORS_COPY ===
BEGIN
    reset_copy_tables;
END;
/

PROMPT === Step 2: Create package specification ===
CREATE OR REPLACE PACKAGE college_pkg IS
    PROCEDURE get_professor
    (
        p_professor_no IN gl_professors_copy.professor_no%TYPE,
        p_professor    OUT gl_professors_copy%ROWTYPE
    );

    PROCEDURE add_professor
    (
        p_professor_no IN gl_professors_copy.professor_no%TYPE,
        p_first_name   IN gl_professors_copy.first_name%TYPE,
        p_last_name    IN gl_professors_copy.last_name%TYPE,
        p_office_ext   IN gl_professors_copy.office_ext%TYPE,
        p_office_no    IN gl_professors_copy.office_no%TYPE
    );

    PROCEDURE delete_professor
    (
        p_professor_no IN gl_professors_copy.professor_no%TYPE
    );
END college_pkg;
/

PROMPT === Step 3, 5, 7: Create package body ===
CREATE OR REPLACE PACKAGE BODY college_pkg IS
    PROCEDURE get_professor
    (
        p_professor_no IN gl_professors_copy.professor_no%TYPE,
        p_professor    OUT gl_professors_copy%ROWTYPE
    )
    IS
    BEGIN
        SELECT *
          INTO p_professor
          FROM gl_professors_copy
         WHERE professor_no = p_professor_no;
    END get_professor;

    PROCEDURE add_professor
    (
        p_professor_no IN gl_professors_copy.professor_no%TYPE,
        p_first_name   IN gl_professors_copy.first_name%TYPE,
        p_last_name    IN gl_professors_copy.last_name%TYPE,
        p_office_ext   IN gl_professors_copy.office_ext%TYPE,
        p_office_no    IN gl_professors_copy.office_no%TYPE
    )
    IS
    BEGIN
        INSERT INTO gl_professors_copy
        (
            professor_no,
            first_name,
            last_name,
            office_no,
            office_ext
        )
        VALUES
        (
            p_professor_no,
            p_first_name,
            p_last_name,
            p_office_no,
            p_office_ext
        );
    END add_professor;

    PROCEDURE delete_professor
    (
        p_professor_no IN gl_professors_copy.professor_no%TYPE
    )
    IS
    BEGIN
        DELETE FROM gl_professors_copy
         WHERE professor_no = p_professor_no;
    END delete_professor;
END college_pkg;
/

PROMPT === Step 4: Test get_professor ===
PROMPT Example valid professor: 5001
PROMPT Example missing professor: 9999
ACCEPT p0801_get_prof_no NUMBER PROMPT 'Enter professor number for get_professor: '

VARIABLE ENTER_PROFESSOR_NO NUMBER
BEGIN
    :ENTER_PROFESSOR_NO := &p0801_get_prof_no;
END;
/

DECLARE
    v_professor_no gl_professors_copy.professor_no%TYPE := :ENTER_PROFESSOR_NO;
    v_professor    gl_professors_copy%ROWTYPE;
BEGIN
    college_pkg.get_professor(v_professor_no, v_professor);

    DBMS_OUTPUT.PUT_LINE('No: ' || v_professor.professor_no);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_professor.first_name || ' ' || v_professor.last_name);
    DBMS_OUTPUT.PUT_LINE('Office ext: ' || TO_CHAR(v_professor.office_ext));
    DBMS_OUTPUT.PUT_LINE('Office no: ' || TO_CHAR(v_professor.office_no));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Professor ' || v_professor_no || ' does not exist in the professor''s table'
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

PROMPT === Step 6: Test add_professor ===
PROMPT Example new professor: 2001 / Pete / Smith / 2201 / 201
PROMPT Run again with the same professor number to test duplicate handling.
ACCEPT p0801_add_prof_no NUMBER PROMPT 'Enter professor number for add_professor: '
ACCEPT p0801_add_first_name CHAR PROMPT 'Enter first name: '
ACCEPT p0801_add_last_name CHAR PROMPT 'Enter last name: '
ACCEPT p0801_add_office_ext NUMBER PROMPT 'Enter office ext: '
ACCEPT p0801_add_office_no NUMBER PROMPT 'Enter office no: '

VARIABLE ENTER_FIRST_NAME VARCHAR2(64)
VARIABLE ENTER_LAST_NAME VARCHAR2(64)
VARIABLE ENTER_OFFICE_EXT NUMBER
VARIABLE ENTER_OFFICE_NO NUMBER
BEGIN
    :ENTER_PROFESSOR_NO := &p0801_add_prof_no;
    :ENTER_FIRST_NAME := '&p0801_add_first_name';
    :ENTER_LAST_NAME := '&p0801_add_last_name';
    :ENTER_OFFICE_EXT := &p0801_add_office_ext;
    :ENTER_OFFICE_NO := &p0801_add_office_no;
END;
/

DECLARE
    v_professor_no gl_professors_copy.professor_no%TYPE := :ENTER_PROFESSOR_NO;
    v_first_name   gl_professors_copy.first_name%TYPE := :ENTER_FIRST_NAME;
    v_last_name    gl_professors_copy.last_name%TYPE := :ENTER_LAST_NAME;
    v_office_ext   gl_professors_copy.office_ext%TYPE := :ENTER_OFFICE_EXT;
    v_office_no    gl_professors_copy.office_no%TYPE := :ENTER_OFFICE_NO;
BEGIN
    college_pkg.add_professor(
        v_professor_no,
        v_first_name,
        v_last_name,
        v_office_ext,
        v_office_no
    );

    DBMS_OUTPUT.PUT_LINE('Inserted ' || SQL%ROWCOUNT || ' row');
    DBMS_OUTPUT.PUT_LINE(NULL);
    DBMS_OUTPUT.PUT_LINE(
        'Professor: ' || v_professor_no || ' - ' || v_first_name || ' ' || v_last_name
    );
    DBMS_OUTPUT.PUT_LINE('Office ext.: ' || TO_CHAR(v_office_ext));
    DBMS_OUTPUT.PUT_LINE('Office no: ' || TO_CHAR(v_office_no));

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE(
            'Professor ' || v_professor_no || ' already exists in the professors table'
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

PROMPT === Step 8: Test delete_professor ===
PROMPT Example existing professor after insert test: 2001
PROMPT Run again with the same professor number to test not found handling.
ACCEPT p0801_delete_prof_no NUMBER PROMPT 'Enter professor number for delete_professor: '

BEGIN
    :ENTER_PROFESSOR_NO := &p0801_delete_prof_no;
END;
/

DECLARE
    v_professor_no gl_professors_copy.professor_no%TYPE := :ENTER_PROFESSOR_NO;
BEGIN
    college_pkg.delete_professor(v_professor_no);

    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Delete professor request completed');

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Professor ' || v_professor_no || ' does not exist in the professors table'
        );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
