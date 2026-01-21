-- Student Name: Qi Chen
-- Student ID: C0944666
-- 1
DECLARE
    v_student_id c2_students.student_id%TYPE := 11;
    v_first_name c2_students.first_name%TYPE := 'Kim';
    v_last_name c2_students.last_name%TYPE := 'Green';
    v_enrollment_date c2_students.enrollment_date%TYPE := DATE '2023-10-20';
    v_program c2_students.program%TYPE := 'Computer Science';
    v_gpa c2_students.gpa%TYPE := 3.5;
BEGIN
    INSERT INTO c2_students
    VALUES (
            v_student_id,
            v_first_name,
            v_last_name,
            v_enrollment_date,
            v_program,
            v_gpa
        );
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 2
DECLARE
    v_gpa c2_students.gpa%TYPE := 3.9;
BEGIN
    UPDATE c2_students
    SET gpa = v_gpa
    WHERE student_id = 3;
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 3
DECLARE
    v_student_id c2_students.student_id%TYPE := 9;
BEGIN
    DELETE FROM c2_students
    WHERE student_id = v_student_id;
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 4
DECLARE
    v_student_id c2_students.student_id%TYPE := 4;
    v_first_name c2_students.first_name%TYPE;
    v_last_name c2_students.last_name%TYPE;
BEGIN
    SELECT first_name, last_name
    INTO v_first_name, v_last_name
    FROM c2_students
    WHERE student_id = v_student_id;
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_last_name);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 5
DECLARE
    v_gpa c2_students.gpa%TYPE;
BEGIN
    SELECT AVG(gpa)
    INTO v_gpa
    FROM c2_students;
    DBMS_OUTPUT.PUT_LINE('Average GPA: ' || v_gpa);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 6
DECLARE
    v_student_id c2_students.student_id%TYPE := 2;
    v_student c2_students%ROWTYPE;
BEGIN
    SELECT *
    INTO v_student
    FROM c2_students
    WHERE student_id = v_student_id;
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_student.first_name || ' ' || v_student.last_name || ' ' || v_student.enrollment_date || ' Program: ' || v_student.program || ' GPA: ' || v_student.gpa);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 7
DECLARE
    v_program c2_students.program%TYPE := 'Engineering';
BEGIN
    UPDATE c2_students
    SET gpa = gpa + 0.1
    WHERE program = v_program;
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 8
DECLARE
    v_program c2_students.program%TYPE := 'Computer Science';
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM c2_students
    WHERE program = v_program;
    DBMS_OUTPUT.PUT_LINE('Number of students in ' || v_program || ': ' || v_count);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 9
DECLARE
    v_gpa c2_students.gpa%TYPE := 3;
BEGIN
    DELETE FROM c2_students
    WHERE gpa < v_gpa;
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 10
DECLARE
    v_max_gpa c2_students.gpa%TYPE;
BEGIN
    SELECT MAX(gpa)
    INTO v_max_gpa
    FROM c2_students;
    DBMS_OUTPUT.PUT_LINE('Highest GPA: ' || v_max_gpa);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 11
DECLARE
    v_enrollment_date c2_students.enrollment_date%TYPE;
BEGIN
    SELECT MIN(enrollment_date)
    INTO v_enrollment_date
    FROM c2_students;
    DBMS_OUTPUT.PUT_LINE('Earliest enrollment date: ' || v_enrollment_date);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 12
DECLARE
    c_gpa c2_students.gpa%TYPE := 4;
    c_program c2_students.program%TYPE := 'Medicine';
BEGIN
    UPDATE c2_students
    SET gpa = c_gpa
    WHERE program = c_program;
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 13
DECLARE
    c_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO c_count
    FROM c2_students;
    DBMS_OUTPUT.PUT_LINE('Number of students: ' || c_count);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 14
DECLARE
    TYPE student_record IS RECORD (
        first_name c2_students.first_name%TYPE,
        last_name c2_students.last_name%TYPE,
        gpa c2_students.gpa%TYPE
    );
    v_student_id c2_students.student_id%TYPE := 5;
    v_student student_record;
BEGIN
    SELECT first_name, last_name, gpa
    INTO v_student
    FROM c2_students
    WHERE student_id = v_student_id;
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_student.first_name || ' ' || v_student.last_name || ' GPA: ' || v_student.gpa);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- 15