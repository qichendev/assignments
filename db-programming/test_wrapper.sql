-- Wrapper script to run P04B Chapter-4-Cursors-PE2&3.sql with hardcoded inputs for testing
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET FEEDBACK OFF;

-- Define bind variables
VARIABLE ENTER_SEMESTER_YEAR NUMBER;
VARIABLE ENTER_SEMESTER_TERM VARCHAR2(1);
VARIABLE ENTER_PROFESSOR_NO NUMBER;
VARIABLE ENTER_SECTION_ID NUMBER;

-- Assign values
BEGIN
    :ENTER_SEMESTER_YEAR := 2021;
    :ENTER_SEMESTER_TERM := 'W';
    :ENTER_PROFESSOR_NO := 5001;
    :ENTER_SECTION_ID := 10001;
END;
/

-- Run the student script
@/opt/oracle/scripts/P04B_Chapter-4-Cursors-PE2_3.sql

EXIT;
