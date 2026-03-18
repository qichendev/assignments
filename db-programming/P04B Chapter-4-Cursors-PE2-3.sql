SET SERVEROUTPUT ON;

-- P0402
DECLARE
    v_input_year    gl_semesters.semester_year%TYPE := :ENTER_SEMESTER_YEAR;
    v_input_term    gl_semesters.semester_term%TYPE := UPPER(:ENTER_SEMESTER_TERM);
    v_input_prof_no gl_professors.professor_no%TYPE := :ENTER_PROFESSOR_NO;

    v_prof_rec     gl_professors%ROWTYPE;
    
    CURSOR c_teaching_load (
        p_year    gl_semesters.semester_year%TYPE,
        p_term    gl_semesters.semester_term%TYPE,
        p_prof_no gl_professors.professor_no%TYPE
    ) IS
        SELECT c.course_title, s.section_id
        FROM gl_sections s, gl_courses c, gl_semesters sem
        WHERE s.course_code = c.course_code
          AND s.semester_id = sem.semester_id
          AND sem.semester_year = p_year
          AND sem.semester_term = p_term
          AND s.professor_no = p_prof_no;

BEGIN
    SELECT * INTO v_prof_rec
    FROM gl_professors
    WHERE professor_no = v_input_prof_no;

    DBMS_OUTPUT.PUT_LINE('Teaching Load for ' || v_prof_rec.first_name || ' ' || v_prof_rec.last_name);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Semester: ' || v_input_year || v_input_term);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE(RPAD('Course(s)', 30) || RPAD('Section(s)', 10));
    DBMS_OUTPUT.PUT_LINE(RPAD('---------', 30) || RPAD('----------', 10));

    FOR v_load IN c_teaching_load(v_input_year, v_input_term, v_input_prof_no) LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(v_load.course_title, 30) || LPAD(v_load.section_id, 8));
    END LOOP;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Professor not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- P0403
DECLARE
    v_input_section_id gl_sections.section_id%TYPE := :ENTER_SECTION_ID;

    v_course_title gl_courses.course_title%TYPE;
    v_course_code  gl_courses.course_code%TYPE;
    v_semester     VARCHAR2(20);
    v_prof_name    VARCHAR2(130);
    
    CURSOR c_class_list (p_section_id gl_sections.section_id%TYPE) IS
        SELECT s.student_no, s.first_name || ' ' || s.last_name as student_name
        FROM gl_enrollments e, gl_students s
        WHERE e.student_no = s.student_no
          AND e.section_id = p_section_id
        ORDER BY s.student_no;

BEGIN
    SELECT c.course_code, c.course_title, 
           sem.semester_year || sem.semester_term,
           p.first_name || ' ' || p.last_name
    INTO v_course_code, v_course_title, v_semester, v_prof_name
    FROM gl_sections s, gl_courses c, gl_semesters sem, gl_professors p
    WHERE s.course_code = c.course_code
      AND s.semester_id = sem.semester_id
      AND s.professor_no = p.professor_no
      AND s.section_id = v_input_section_id;

    DBMS_OUTPUT.PUT_LINE('Class List for ' || v_course_code || ' ' || v_course_title);
    DBMS_OUTPUT.PUT_LINE('Semester: ' || v_semester);
    DBMS_OUTPUT.PUT_LINE('Instructor: ' || v_prof_name);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE(RPAD('Student No', 15) || RPAD('Student Name', 30));
    DBMS_OUTPUT.PUT_LINE(RPAD('----------', 15) || RPAD('------------', 30));

    FOR v_student IN c_class_list(v_input_section_id) LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(v_student.student_no, 15) || v_student.student_name);
    END LOOP;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Section ID not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
