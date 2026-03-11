SET SERVEROUTPUT ON;

-- P0505
DECLARE
    v_school_code VARCHAR2(20) := UPPER(:ENTER_SCHOOL_CODE);
    e_not_found   EXCEPTION;
    e_too_long    EXCEPTION;
    e_integrity   EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_integrity, -2292);
BEGIN
    -- Check length
    IF LENGTH(v_school_code) > 2 THEN
        RAISE e_too_long;
    END IF;

    DELETE FROM gl_schools WHERE school_code = v_school_code;

    IF SQL%NOTFOUND THEN
        RAISE e_not_found;
    END IF;

    DBMS_OUTPUT.PUT_LINE('School code ' || v_school_code || ' deleted successfully.');

EXCEPTION
    WHEN e_too_long THEN
        DBMS_OUTPUT.PUT_LINE('School code is too long. Can only be two characters long.');
    WHEN e_not_found THEN
        DBMS_OUTPUT.PUT_LINE('School code ' || v_school_code || ' does not exist.');
    WHEN e_integrity THEN
        DBMS_OUTPUT.PUT_LINE('Cannot delete row because of integrity constraint error. There are child foreign key relationships with the GL_SCHOOLS table.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- P0506
DECLARE
    v_search_gpa NUMBER := :ENTER_GPA;
    v_student_id c2_students.student_id%TYPE;
    v_gpa        c2_students.gpa%TYPE;
BEGIN
    SELECT student_id, gpa 
    INTO v_student_id, v_gpa
    FROM c2_students
    WHERE gpa > v_search_gpa;

    DBMS_OUTPUT.PUT_LINE('Student ' || v_student_id || ' has a GPA of ' || TO_CHAR(v_gpa, '9.99'));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND FOR GPA > ' || TO_CHAR(v_search_gpa, '9.9'));
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS RETURNED FOR GPA > ' || TO_CHAR(v_search_gpa, '9.9'));
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- P0507
DECLARE
    v_search_gpa NUMBER := :ENTER_GPA;
    CURSOR c_students IS
        SELECT student_id, gpa
        FROM c2_students
        WHERE gpa > v_search_gpa;
    v_found BOOLEAN := FALSE;
BEGIN
    FOR r_student IN c_students LOOP
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Student ' || r_student.student_id || ' has a GPA of ' || TO_CHAR(r_student.gpa, '9.99'));
    END LOOP;

    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('NO STUDENTS FOUND FOR GPA > ' || TO_CHAR(v_search_gpa, '9.9'));
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
