-- Student Name: Qi Chen
-- Student ID: C0944666

-- 1
DECLARE
    v_section_id gl_enrollments.section_id%TYPE := :ENTER_SECTION_ID;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM gl_enrollments
    WHERE section_id = v_section_id;

    DBMS_OUTPUT.PUT_LINE('Output: There are ' || v_count || ' students in section ' || v_section_id);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 2
DECLARE
    v_section_id gl_enrollments.section_id%TYPE := :ENTER_SECTION_ID;
    v_avg_grade NUMBER;
BEGIN
    SELECT AVG(numeric_grade)
    INTO v_avg_grade
    FROM gl_enrollments
    WHERE section_id = v_section_id;

    DBMS_OUTPUT.PUT_LINE('Output: The average grade in section ' || v_section_id || ' is ' || ROUND(v_avg_grade, 0));
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 3
DECLARE
    v_course_code gl_sections.course_code%TYPE := UPPER(:ENTER_COURSE_CODE);
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM gl_sections
    WHERE course_code = v_course_code;

    DBMS_OUTPUT.PUT_LINE('Output: There are ' || v_count || ' section(s) offered in course ' || v_course_code);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 4
CREATE OR REPLACE VIEW gl_stdV1 AS
SELECT 
    s.student_no,
    s.first_name || ' ' || s.last_name AS student_name,
    p.program_name AS major,
    c.course_title AS course,
    sec.section_id,
    prof.first_name || ' ' || prof.last_name AS professor,
    e.letter_grade AS grade
FROM gl_students s
JOIN gl_programs p ON s.major_code = p.program_code
JOIN gl_enrollments e ON s.student_no = e.student_no
JOIN gl_sections sec ON e.section_id = sec.section_id
JOIN gl_courses c ON sec.course_code = c.course_code
JOIN gl_professors prof ON sec.professor_no = prof.professor_no;

DECLARE
    v_student_no gl_students.student_no%TYPE := :ENTER_STUDENT_NO;
    v_section_id gl_sections.section_id%TYPE := :ENTER_SECTION_ID;
    v_row gl_stdv1%ROWTYPE;
BEGIN
    SELECT *
    INTO v_row
    FROM gl_stdv1
    WHERE student_no = v_student_no AND section_id = v_section_id;

    DBMS_OUTPUT.PUT_LINE('Output: Student Grade:  ' || TO_CHAR(SYSDATE, 'fmDay, Month dd, YYYY'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    DBMS_OUTPUT.PUT_LINE('Student:    ' || v_row.student_name);
    DBMS_OUTPUT.PUT_LINE('Major:      ' || v_row.major);
    DBMS_OUTPUT.PUT_LINE('Course:     ' || v_row.course);
    DBMS_OUTPUT.PUT_LINE('Section:    ' || v_row.section_id);
    DBMS_OUTPUT.PUT_LINE('Professor:  ' || v_row.professor);
    DBMS_OUTPUT.PUT_LINE('Grade:      ' || v_row.grade);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 5
CREATE OR REPLACE VIEW GL_PROV1 AS
SELECT 
    p.professor_no,
    p.first_name || ' ' || p.last_name AS professor_name,
    p.office_no,
    p.office_ext,
    s.school_name
FROM gl_professors p
JOIN gl_schools s ON p.school_code = s.school_code;

DECLARE
    v_prof_no gl_professors.professor_no%TYPE := :ENTER_PROFESSOR_NO;
    v_row GL_PROV1%ROWTYPE;
BEGIN
    SELECT *
    INTO v_row
    FROM GL_PROV1
    WHERE professor_no = v_prof_no;

    DBMS_OUTPUT.PUT_LINE('Output: Professor Information');
    DBMS_OUTPUT.PUT_LINE('-----------------------');
    DBMS_OUTPUT.PUT_LINE('Professor no: ' || v_row.professor_no);
    DBMS_OUTPUT.PUT_LINE('        Name: ' || v_row.professor_name);
    DBMS_OUTPUT.PUT_LINE('   Office no: ' || v_row.office_no);
    DBMS_OUTPUT.PUT_LINE('  Office ext: ' || v_row.office_ext);
    DBMS_OUTPUT.PUT_LINE(' School name: ' || v_row.school_name);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 6
DECLARE
    v_row gl_professors_copy%ROWTYPE;
BEGIN
    v_row.professor_no := :ENTER_PROFESSOR_NO;
    v_row.first_name   := INITCAP(:ENTER_FIRST_NAME);
    v_row.last_name    := INITCAP(:ENTER_LAST_NAME);
    v_row.office_no    := :ENTER_OFFICE_NO;
    v_row.office_ext   := :ENTER_OFFICE_EXT;
    v_row.school_code  := UPPER(:ENTER_SCHOOL_CODE);

    INSERT INTO gl_professors_copy VALUES v_row;

    DBMS_OUTPUT.PUT_LINE('Output: Professor Added');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE('   Professor no: ' || v_row.professor_no);
    DBMS_OUTPUT.PUT_LINE('     First name: ' || v_row.first_name);
    DBMS_OUTPUT.PUT_LINE('      Last name: ' || v_row.last_name);
    DBMS_OUTPUT.PUT_LINE('  Old Office no: ' || v_row.office_no);
    DBMS_OUTPUT.PUT_LINE(' Old Office ext: ' || v_row.office_ext);
    DBMS_OUTPUT.PUT_LINE('    School code: ' || v_row.school_code);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 7
DECLARE
    v_prof_no    gl_professors_copy.professor_no%TYPE := :ENTER_NEW_PROFESSOR_NO;
    v_new_office gl_professors_copy.office_no%TYPE := :ENTER_NEW_OFFICE_NO;
    v_new_ext    gl_professors_copy.office_ext%TYPE := :ENTER_NEW_OFFICE_EXT;
    v_old_row    gl_professors_copy%ROWTYPE;
BEGIN
    SELECT * INTO v_old_row
    FROM gl_professors_copy
    WHERE professor_no = v_prof_no;

    UPDATE gl_professors_copy
    SET office_no = v_new_office,
        office_ext = v_new_ext
    WHERE professor_no = v_prof_no;

    DBMS_OUTPUT.PUT_LINE('Output: Professor Updated');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE('   Professor no: ' || v_old_row.professor_no);
    DBMS_OUTPUT.PUT_LINE('     First name: ' || v_old_row.first_name);
    DBMS_OUTPUT.PUT_LINE('      Last name: ' || v_old_row.last_name);
    DBMS_OUTPUT.PUT_LINE('  Old Office no: ' || v_old_row.office_no || '    New office no: ' || v_new_office);
    DBMS_OUTPUT.PUT_LINE(' Old Office ext: ' || v_old_row.office_ext || '   New office ext: ' || v_new_ext);
    DBMS_OUTPUT.PUT_LINE('    School code: ' || v_old_row.school_code);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 8
DECLARE
    v_prof_no gl_professors_copy.professor_no%TYPE := :ENTER_PROFESSOR_NO;
    v_row     gl_professors_copy%ROWTYPE;
BEGIN
    SELECT * INTO v_row
    FROM gl_professors_copy
    WHERE professor_no = v_prof_no;

    DELETE FROM gl_professors_copy
    WHERE professor_no = v_prof_no;

    DBMS_OUTPUT.PUT_LINE('Output: Professor Deleted');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE('Professor no: ' || v_row.professor_no);
    DBMS_OUTPUT.PUT_LINE('  First name: ' || v_row.first_name);
    DBMS_OUTPUT.PUT_LINE('   Last name: ' || v_row.last_name);
    DBMS_OUTPUT.PUT_LINE('   Office no: ' || v_row.office_no);
    DBMS_OUTPUT.PUT_LINE('  Office ext: ' || v_row.office_ext);
    DBMS_OUTPUT.PUT_LINE(' School code: ' || v_row.school_code);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
