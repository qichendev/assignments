SET SERVEROUTPUT ON
SET VERIFY OFF

PROMPT === P0904: Step 1 - Set Up Copy Tables ===

BEGIN
    reset_copy_tables;
END;
/

ALTER TABLE gl_sections_copy
DROP CONSTRAINT gl_sect_copy_professor_no_fk;

ALTER TABLE gl_sections_copy
ADD CONSTRAINT gl_sect_copy_professor_no_fk
    FOREIGN KEY (professor_no)
    REFERENCES gl_professors_copy (professor_no);

PROMPT === P0904: Step 2 - Create professor_section_view ===

CREATE OR REPLACE VIEW professor_section_view AS
    SELECT p.professor_no,
           COUNT(s.section_id) AS total_sections
      FROM gl_professors_copy p
      LEFT JOIN gl_sections_copy s ON p.professor_no = s.professor_no
     GROUP BY p.professor_no;

PROMPT === P0904: Step 3 - Display View ===

SELECT professor_no,
       total_sections
  FROM professor_section_view
 ORDER BY professor_no;

PROMPT === P0904: Step 4 - Delete Professor 5008 (no trigger yet - expect ORA-01732) ===

DELETE FROM professor_section_view
 WHERE professor_no = 5008;

PROMPT === P0904: Step 5 - Create professor_delete_trg ===

CREATE OR REPLACE TRIGGER professor_delete_trg
INSTEAD OF DELETE ON professor_section_view
FOR EACH ROW
BEGIN
    DELETE FROM gl_professors_copy
     WHERE professor_no = :OLD.professor_no;
END;
/

PROMPT === P0904: Step 6 - Delete Professor 5008 (trigger fires - succeeds) ===

DELETE FROM professor_section_view
 WHERE professor_no = 5008;

PROMPT === P0904: Step 7 - Verify Professor 5008 Deleted ===

SELECT professor_no,
       total_sections
  FROM professor_section_view
 ORDER BY professor_no;

PROMPT === P0904: Step 8 - Delete Professor 5001 (has sections - expect FK error) ===

DELETE FROM professor_section_view
 WHERE professor_no = 5001;

PROMPT === P0904: Step 9 - Verify Professor 5001 Was Not Deleted ===

SELECT professor_no,
       total_sections
  FROM professor_section_view
 ORDER BY professor_no;

PROMPT === P0904: Step 10 - Drop professor_delete_trg ===

DROP TRIGGER professor_delete_trg;

PROMPT === P0904: Step 11 - Create professor_section_delete_trg ===

CREATE OR REPLACE TRIGGER professor_section_delete_trg
INSTEAD OF DELETE ON professor_section_view
FOR EACH ROW
BEGIN
    DELETE FROM gl_sections_copy
     WHERE professor_no = :OLD.professor_no;

    DELETE FROM gl_professors_copy
     WHERE professor_no = :OLD.professor_no;
END;
/

PROMPT === P0904: Step 12 - Delete Professor 5007 (0 sections - succeeds) ===

DELETE FROM professor_section_view
 WHERE professor_no = 5007;

PROMPT === P0904: Step 13 - Delete Professor 5001 (has sections - succeeds) ===

DELETE FROM professor_section_view
 WHERE professor_no = 5001;

PROMPT === P0904: Step 14 - Verify Professors 5007 and 5001 Deleted ===

SELECT professor_no,
       total_sections
  FROM professor_section_view
 ORDER BY professor_no;
