DECLARE
    CURSOR course_cursor IS
        SELECT course_code
             , course_title
        FROM gl_courses
        ORDER BY course_code;
    v_course course_cursor%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('Course Code', 15) || 'Course Title');
    DBMS_OUTPUT.PUT_LINE(RPAD('-----------', 15) || '------------');

    OPEN course_cursor;
    LOOP
        FETCH course_cursor INTO v_course;
        EXIT WHEN course_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_course.course_code, 15) || v_course.course_title);
    END LOOP;
    CLOSE course_cursor;
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/