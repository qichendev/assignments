SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE add_professor
(
    p_professor_no IN gl_professors_copy.professor_no%TYPE,
    p_first_name   IN gl_professors_copy.first_name%TYPE,
    p_last_name    IN gl_professors_copy.last_name%TYPE,
    p_office_no    IN gl_professors_copy.office_no%TYPE,
    p_office_ext   IN gl_professors_copy.office_ext%TYPE,
    p_school_code  IN gl_professors_copy.school_code%TYPE
)
IS
BEGIN
    INSERT INTO gl_professors_copy
    (
        professor_no,
        first_name,
        last_name,
        office_no,
        office_ext,
        school_code
    )
    VALUES
    (
        p_professor_no,
        p_first_name,
        p_last_name,
        p_office_no,
        p_office_ext,
        p_school_code
    );
END;
/

DECLARE
    v_professor    gl_professors_copy%ROWTYPE;
    v_school_name  gl_schools.school_name%TYPE;
    e_bad_len      EXCEPTION;
BEGIN
    v_professor.professor_no := :ENTER_PROFESSOR_NO;
    v_professor.first_name   := INITCAP(TRIM(:ENTER_FIRST_NAME));
    v_professor.last_name    := INITCAP(TRIM(:ENTER_LAST_NAME));
    v_professor.office_no    := :ENTER_OFFICE_NO;
    v_professor.office_ext   := :ENTER_OFFICE_EXT;

    IF LENGTH(TRIM(:ENTER_SCHOOL_CODE)) > 2 THEN
        RAISE e_bad_len;
    END IF;

    v_professor.school_code := UPPER(TRIM(:ENTER_SCHOOL_CODE));

    add_professor(
        v_professor.professor_no,
        v_professor.first_name,
        v_professor.last_name,
        v_professor.office_no,
        v_professor.office_ext,
        v_professor.school_code
    );

    SELECT school_name
      INTO v_school_name
      FROM gl_schools
     WHERE school_code = v_professor.school_code;

    DBMS_OUTPUT.PUT_LINE('Inserted ' || SQL%ROWCOUNT || ' row');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE(
        'Professor: ' || v_professor.professor_no || ' - ' ||
        v_professor.first_name || ' ' || v_professor.last_name
    );
    DBMS_OUTPUT.PUT_LINE('Office No: ' || v_professor.office_no);
    DBMS_OUTPUT.PUT_LINE('Office Ext: ' || v_professor.office_ext);
    DBMS_OUTPUT.PUT_LINE(
        'School Code: ' || v_professor.school_code || ' - ' || v_school_name
    );

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(
            'Professor ' || v_professor.professor_no || ' already in table'
        );
    WHEN e_bad_len THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Enter valid data. Input data is too long.');
    WHEN VALUE_ERROR THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Enter valid data. Input data is too long.');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(
            'Invalid school code: ' || COALESCE(v_professor.school_code, 'NULL')
        );
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
