SET SERVEROUTPUT ON
SET VERIFY OFF

PROMPT === Step 1: Create GL_PRO_AUDIT_LOG Table ===

CREATE TABLE IF NOT EXISTS gl_pro_audit_log
(
    user_id          VARCHAR2(30) DEFAULT USER,
    last_change_date DATE         DEFAULT SYSDATE,
    trigger_name     VARCHAR2(50),
    log_action       VARCHAR2(30)
);

PROMPT === Step 2: Create GL_PROFESSOR_TRG Trigger ===

CREATE OR REPLACE TRIGGER gl_professor_trg
AFTER INSERT ON gl_professors_copy
BEGIN
    INSERT INTO gl_pro_audit_log (trigger_name, log_action)
    VALUES ('gl_professor_trg', 'INSERT');
END;
/

PROMPT === Step 3: Test GL_PROFESSOR_TRG Trigger ===
PROMPT Example input: professor_no=5015, first=ANN, last=page, office=421, ext=3421, school=cs

DECLARE
    v_professor   gl_professors_copy%ROWTYPE;
    v_school_name gl_schools.school_name%TYPE;
BEGIN
    v_professor.professor_no := :ENTER_PROFESSOR_NO;
    v_professor.first_name   := INITCAP(TRIM(:ENTER_FIRST_NAME));
    v_professor.last_name    := INITCAP(TRIM(:ENTER_LAST_NAME));
    v_professor.office_no    := :ENTER_OFFICE_NO;
    v_professor.office_ext   := :ENTER_OFFICE_EXT;
    v_professor.school_code  := UPPER(TRIM(:ENTER_SCHOOL_CODE));

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
    DBMS_OUTPUT.PUT_LINE('Office No: '  || v_professor.office_no);
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
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error code: '    || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

PROMPT === Step 4: Display GL_PRO_AUDIT_LOG Contents ===

SELECT user_id,
       TO_CHAR(last_change_date, 'YYYY-MM-DD') AS last_change_date,
       trigger_name,
       log_action
  FROM gl_pro_audit_log;
