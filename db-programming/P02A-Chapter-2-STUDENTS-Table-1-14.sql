-- 1
INSERT INTO c2_students
VALUES (
        11,
        'Kim',
        'Green',
        DATE '2023-10-20',
        'Computer Science',
        3.5
    );
-- 2
UPDATE c2_students
SET gpa = 3.9
WHERE student_id = 3;
-- 3
DELETE FROM c2_students
WHERE student_id = 9;