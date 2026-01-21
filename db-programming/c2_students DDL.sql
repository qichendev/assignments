DROP TABLE c2_students;

CREATE TABLE c2_students (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(30),
    last_name VARCHAR2(30),
    enrollment_date DATE,
    program VARCHAR2(50),
    gpa NUMBER(3,2)
);

INSERT INTO c2_students VALUES (1, 'Alice', 'Smith', DATE '2023-09-01', 'Computer Science', 3.8);
INSERT INTO c2_students VALUES (2, 'Bob', 'Johnson', DATE '2023-09-01', 'Business', 3.4);
INSERT INTO c2_students VALUES (3, 'Charlie', 'Brown', DATE '2023-09-01', 'Engineering', 3.6);
INSERT INTO c2_students VALUES (4, 'Diana', 'Prince', DATE '2023-09-01', 'Nursing', 3.9);
INSERT INTO c2_students VALUES (5, 'Ethan', 'Hunt', DATE '2023-09-01', 'Law', 3.7);
INSERT INTO c2_students VALUES (6, 'Fiona', 'Davis', DATE '2023-09-01', 'Arts', 3.5);
INSERT INTO c2_students VALUES (7, 'George', 'Miller', DATE '2023-09-01', 'Education', 3.3);
INSERT INTO c2_students VALUES (8, 'Hannah', 'Wilson', DATE '2023-09-01', 'Medicine', 4.0);
INSERT INTO c2_students VALUES (9, 'Ian', 'Taylor', DATE '2023-09-01', 'Physics', 3.2);
INSERT INTO c2_students VALUES (10, 'Julia', 'Anderson', DATE '2023-09-01', 'Chemistry', 3.6);
