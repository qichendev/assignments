SET SERVEROUTPUT ON
SET VERIFY OFF

PROMPT === P0902: Step 1 - Drop Tables ===

BEGIN EXECUTE IMMEDIATE 'DROP TABLE accounts CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE accounts_audit CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE account_error_log CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

PROMPT === P0902: Step 2 - Create Tables ===

CREATE TABLE accounts (
    account_id   INTEGER        NOT NULL,
    first_name   VARCHAR2(30)   NOT NULL,
    last_name    VARCHAR2(30)   NOT NULL,
    balance      NUMBER(12,2)   NOT NULL,
    CONSTRAINT accounts_pk
        PRIMARY KEY (account_id)
);

CREATE TABLE accounts_audit (
    audit_id     INTEGER
        GENERATED ALWAYS AS IDENTITY
        NOCACHE,
    trigger_name VARCHAR(30),
    action_type  VARCHAR2(10)   NOT NULL,
    action_date  DATE           NOT NULL,
    user_id      VARCHAR2(30)   NOT NULL,
    CONSTRAINT accounts_audit_pk
        PRIMARY KEY (audit_id)
);

CREATE TABLE account_error_log (
    error_id      INTEGER
        GENERATED ALWAYS AS IDENTITY
        NOCACHE,
    error_date    DATE           NOT NULL,
    user_id       VARCHAR2(20)   NOT NULL,
    error_code    VARCHAR2(20)   NOT NULL,
    error_message VARCHAR2(4000) NOT NULL,
    CONSTRAINT account_error_log_pk
        PRIMARY KEY (error_id)
);

PROMPT === P0902: Step 3 - Create TRG_ACCOUNTS_AUDIT ===

CREATE OR REPLACE TRIGGER trg_accounts_audit
AFTER INSERT OR UPDATE OR DELETE ON accounts
DECLARE
    v_action VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_action := 'INSERT';
    ELSIF UPDATING THEN
        v_action := 'UPDATE';
    ELSIF DELETING THEN
        v_action := 'DELETE';
    END IF;

    INSERT INTO accounts_audit (trigger_name, action_type, action_date, user_id)
    VALUES ('TRG_ACCOUNTS_AUDIT', v_action, SYSDATE, USER);

    DBMS_OUTPUT.PUT_LINE('Trigger fired: ' || v_action || ' recorded in accounts_audit.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Trigger error - Code: ' || SQLCODE || ' Message: ' || SQLERRM
        );
END;
/

PROMPT === P0902: Step 4 - Process Transactions ===

INSERT INTO accounts (account_id, first_name, last_name, balance)
VALUES (101, 'Alice', 'Smith', 1000);

INSERT INTO accounts (account_id, first_name, last_name, balance)
VALUES (102, 'Bob', 'Johnson', 2500);

INSERT INTO accounts (account_id, first_name, last_name, balance)
VALUES (103, 'Jill', 'Black', 500);

UPDATE accounts SET balance = balance + 100;

DELETE FROM accounts WHERE balance < 800;

INSERT INTO accounts (account_id, first_name, last_name, balance)
VALUES (104, 'Diana', 'Prince', 3000);

UPDATE accounts SET balance = balance + 50 WHERE account_id = 101;

DELETE FROM accounts WHERE account_id = 104;

UPDATE accounts SET balance = balance + 25;

COMMIT;

PROMPT === P0902: Step 5 - Verify Tables ===

SELECT account_id, first_name, last_name, balance
  FROM accounts
 ORDER BY account_id;

SELECT audit_id,
       trigger_name,
       action_type,
       TO_CHAR(action_date, 'MM/DD/YYYY') AS action_date,
       user_id
  FROM accounts_audit
 ORDER BY audit_id;

SELECT * FROM account_error_log;

PROMPT === P0902: Step 6 - Error Test (account 9999 does not exist) ===

DECLARE
    v_balance     accounts.balance%TYPE;
    v_error_code  VARCHAR2(20);
    v_error_msg   VARCHAR2(4000);
BEGIN
    UPDATE accounts
       SET balance = balance + 1000
     WHERE account_id = 9999;

    SELECT balance
      INTO v_balance
      FROM accounts
     WHERE account_id = 9999;

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' row updated');
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        v_error_code := TO_CHAR(SQLCODE);
        v_error_msg  := SQLERRM;
        INSERT INTO account_error_log (error_date, user_id, error_code, error_message)
        VALUES (SYSDATE, USER, v_error_code, v_error_msg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' row updated');
END;
/

PROMPT === P0902: Step 7 - Verify After Error Test ===

SELECT account_id, first_name, last_name, balance
  FROM accounts
 ORDER BY account_id;

SELECT audit_id,
       trigger_name,
       action_type,
       TO_CHAR(action_date, 'MM/DD/YYYY') AS action_date,
       user_id
  FROM accounts_audit
 ORDER BY audit_id;

SELECT error_id,
       TO_CHAR(error_date, 'MM/DD/YYYY') AS error_date,
       user_id,
       error_code,
       error_message
  FROM account_error_log;


PROMPT === P0903: Step 1 - Create convert_numeric_grade Function ===

CREATE OR REPLACE FUNCTION convert_numeric_grade
(
    p_numeric_grade IN gl_enrollments.numeric_grade%TYPE
)
RETURN gl_enrollments.letter_grade%TYPE
IS
BEGIN
    RETURN CASE
        WHEN p_numeric_grade BETWEEN 90 AND 100 THEN 'A'
        WHEN p_numeric_grade BETWEEN 80 AND 89  THEN 'B'
        WHEN p_numeric_grade BETWEEN 70 AND 79  THEN 'C'
        WHEN p_numeric_grade BETWEEN 60 AND 69  THEN 'D'
        WHEN p_numeric_grade BETWEEN 0  AND 59  THEN 'F'
        ELSE NULL
    END;
END;
/

PROMPT === P0903: Step 2 - Create GL_ENROLL_UPDATE_LOG Table ===

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE gl_enroll_update_log';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE gl_enroll_update_log (
    user_id          VARCHAR2(30) DEFAULT USER,
    last_change_date DATE         DEFAULT SYSDATE,
    section_id       NUMBER(5, 0),
    student_no       NUMBER(7, 0),
    old_grade        VARCHAR2(2),
    new_grade        VARCHAR2(2),
    log_action       VARCHAR2(30)
);

PROMPT === P0903: Step 3 - Create GL_ENROLL_UPDATE_TRG ===

CREATE OR REPLACE TRIGGER gl_enroll_update_trg
AFTER UPDATE OF letter_grade ON gl_enrollments_copy
FOR EACH ROW
DECLARE
    v_action   VARCHAR2(30);
    v_old_rank NUMBER;
    v_new_rank NUMBER;
BEGIN
    v_old_rank := CASE :OLD.letter_grade
                      WHEN 'A' THEN 5 WHEN 'B' THEN 4 WHEN 'C' THEN 3
                      WHEN 'D' THEN 2 WHEN 'F' THEN 1 ELSE 0 END;
    v_new_rank := CASE :NEW.letter_grade
                      WHEN 'A' THEN 5 WHEN 'B' THEN 4 WHEN 'C' THEN 3
                      WHEN 'D' THEN 2 WHEN 'F' THEN 1 ELSE 0 END;

    v_action := CASE
        WHEN v_old_rank = v_new_rank THEN 'grade is the same'
        WHEN v_new_rank > v_old_rank THEN 'grade went up'
        ELSE 'grade went down'
    END;

    INSERT INTO gl_enroll_update_log
        (section_id, student_no, old_grade, new_grade, log_action)
    VALUES
        (:NEW.section_id, :NEW.student_no, :OLD.letter_grade, :NEW.letter_grade, v_action);
END;
/

PROMPT === P0903: Step 4 - Test GL_ENROLL_UPDATE_TRG ===
PROMPT Example - Input 1: section_id=10001, student_no=1001, numeric_grade=66
PROMPT Example - Input 2: section_id=10001, student_no=1002, numeric_grade=91
PROMPT Example - Input 3: section_id=10001, student_no=1003, numeric_grade=82

DECLARE
    v_section_id    gl_enrollments_copy.section_id%TYPE    := :ENTER_SECTION_ID;
    v_student_no    gl_enrollments_copy.student_no%TYPE    := :ENTER_STUDENT_NO;
    v_numeric_grade gl_enrollments_copy.numeric_grade%TYPE := :ENTER_NEW_NUMERIC_GRADE;
    v_letter_grade  gl_enrollments_copy.letter_grade%TYPE;
BEGIN
    v_letter_grade := convert_numeric_grade(v_numeric_grade);

    UPDATE gl_enrollments_copy
       SET numeric_grade = v_numeric_grade,
           letter_grade  = v_letter_grade
     WHERE section_id = v_section_id
       AND student_no = v_student_no;

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' row(s) updated.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error code: '    || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

SELECT user_id,
       last_change_date,
       section_id,
       student_no,
       old_grade,
       new_grade,
       log_action
  FROM gl_enroll_update_log
 ORDER BY section_id, student_no;

SELECT section_id, student_no, numeric_grade, letter_grade
  FROM gl_enrollments_copy
 WHERE section_id = 10001
   AND student_no < 1004
 ORDER BY section_id, student_no;
