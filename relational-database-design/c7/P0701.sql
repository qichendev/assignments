-- Drop Tables in proper order with CASCADE to remove constraints
DROP TABLE BC_BILLINGS CASCADE CONSTRAINTS;
DROP TABLE BC_PROJECTS CASCADE CONSTRAINTS;
DROP TABLE BC_EMPLOYEES CASCADE CONSTRAINTS;
DROP TABLE BC_JOBS CASCADE CONSTRAINTS;
-- Create tables
CREATE TABLE BC_JOBS (
    job_id NUMBER(3, 0),
    job_title VARCHAR2(50),
    charge_hour NUMBER(7, 2)
);
CREATE TABLE BC_EMPLOYEES (
    employee_id NUMBER(5, 0),
    first_name VARCHAR2(40),
    last_name VARCHAR2(40),
    job_id NUMBER(3, 0)
);
CREATE TABLE BC_PROJECTS (
    project_id NUMBER(5, 0),
    project_name VARCHAR2(40),
    project_leader_id NUMBER(5, 0)
);
CREATE TABLE BC_BILLINGS (
    project_id NUMBER(5, 0),
    employee_id NUMBER(5, 0),
    hours_billed NUMBER(5, 1)
    -- Increased from 3,1 to 5,1
);
-- Insert data into BC_PROJECTS
INSERT INTO BC_PROJECTS(project_id, project_name)
VALUES (15, 'Lakeview');
INSERT INTO BC_PROJECTS(project_id, project_name)
VALUES (18, 'Web App');
INSERT INTO BC_PROJECTS(project_id, project_name)
VALUES (22, 'Blue Light');
INSERT INTO BC_PROJECTS(project_id, project_name)
VALUES (25, 'Power Lite');
-- Insert data into BC_JOBS
INSERT INTO BC_JOBS(job_id, job_title, charge_hour)
VALUES (501, 'Lead Programmer', 85.50);
INSERT INTO BC_JOBS(job_id, job_title, charge_hour)
VALUES (502, 'Database Designer', 105.00);
INSERT INTO BC_JOBS(job_id, job_title, charge_hour)
VALUES (503, 'Programmer', 37.75);
INSERT INTO BC_JOBS(job_id, job_title, charge_hour)
VALUES (504, 'Systems Analyst', 96.75);
INSERT INTO BC_JOBS(job_id, job_title, charge_hour)
VALUES (505, 'General Support', 18.36);
INSERT INTO BC_JOBS(job_id, job_title, charge_hour)
VALUES (506, 'DDS Analyst', 45.95);
INSERT INTO BC_JOBS(job_id, job_title, charge_hour)
VALUES (507, 'Clerical Support', 26.87);
-- Insert data into BC_EMPLOYEES
INSERT ALL INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (103, 'June', 'Arbough', 501) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (101, 'John', 'News', 502) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (105, 'Alice', 'Johnson', 502) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (106, 'William', 'Smith', 503) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (102, 'David', 'Senior', 504) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (114, 'Annelise', 'Jones', 503) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (118, 'James', 'Frommer', 505) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (104, 'Anne', 'Ramoras', 504) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (112, 'Darlene', 'Smithson', 506) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (113, 'Jen', 'Clarke', 503) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (111, 'Geoff', 'Wabash', 507) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (107, 'Maria', 'Alonzo', 503) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (115, 'Travis', 'Bawangi', 504) INTO bc_employees (employee_id, first_name, last_name, job_id)
VALUES (108, 'Ralph', 'Washington', 504)
SELECT 1
FROM DUAL;
-- Insert data into BC_BILLINGS
INSERT ALL INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (15, 103, 23.8) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (15, 101, 19.4) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (15, 105, 35.7) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (15, 106, 12.6) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (15, 102, 23.8) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (18, 114, 25.6) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (18, 118, 45.3) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (18, 104, 32.4) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (18, 112, 45.0) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (22, 105, 65.7) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (22, 104, 48.4) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (22, 113, 23.6) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (22, 111, 22.0) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 106, 12.8) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 107, 25.6) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 115, 45.8) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 101, 56.3) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 114, 33.1) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 108, 23.6) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 118, 30.5) INTO bc_billings (project_id, employee_id, hours_billed)
VALUES (25, 112, 41.4)
SELECT 1
FROM DUAL;
-- Assign project leaders
UPDATE BC_PROJECTS
SET project_leader_id = 105
WHERE project_id = 15;
UPDATE BC_PROJECTS
SET project_leader_id = 104
WHERE project_id = 18;
UPDATE BC_PROJECTS
SET project_leader_id = 101
WHERE project_id = 25;
DELETE BC_BILLINGS
WHERE employee_id = (
        SELECT employee_id
        FROM BC_EMPLOYEES
        WHERE first_name = 'Darlene'
            and last_name = 'Smithson'
    );
DELETE BC_EMPLOYEES
WHERE first_name = 'Darlene'
    and last_name = 'Smithson';
UPDATE BC_BILLINGS
SET hours_billed = 49.5
WHERE employee_id = 105;
ALTER TABLE BC_JOBS
MODIFY job_id NUMBER(3, 0) NOT NULL;
ALTER TABLE BC_JOBS
MODIFY charge_hour NUMBER(7, 2) NOT NULL;
ALTER TABLE BC_EMPLOYEES
MODIFY first_name VARCHAR2(40) NOT NULL;
ALTER TABLE BC_EMPLOYEES
MODIFY last_name VARCHAR2(40) NOT NULL;
ALTER TABLE BC_EMPLOYEES
MODIFY job_id NUMBER(3, 0) NOT NULL;
ALTER TABLE BC_PROJECTS
MODIFY project_name VARCHAR2(40) UNIQUE NOT NULL;
ALTER TABLE BC_BILLINGS
MODIFY project_id NUMBER(5, 0) NOT NULL;
ALTER TABLE BC_BILLINGS
MODIFY employee_id NUMBER(5, 0) NOT NULL;
ALTER TABLE BC_JOBS
MODIFY charge_hour NUMBER(7, 2) DEFAULT 44.00;
ALTER TABLE BC_JOBS
MODIFY job_id NUMBER(3, 0) PRIMARY KEY;
ALTER TABLE BC_JOBS
MODIFY job_title VARCHAR2(50) UNIQUE NOT NULL;
ALTER TABLE BC_EMPLOYEES
MODIFY employee_id NUMBER(5, 0) PRIMARY KEY;
ALTER TABLE BC_EMPLOYEES
ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES BC_JOBS(job_id);
ALTER TABLE BC_PROJECTS
MODIFY project_id NUMBER(5, 0) PRIMARY KEY;
ALTER TABLE BC_PROJECTS
ADD CONSTRAINT fk_project_leader_id FOREIGN KEY (project_leader_id) REFERENCES BC_EMPLOYEES(employee_id);
ALTER TABLE BC_BILLINGS
ADD CONSTRAINT pk_project_employee PRIMARY KEY(project_id, employee_id);
ALTER TABLE BC_BILLINGS
ADD CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES BC_PROJECTS(project_id);
ALTER TABLE BC_BILLINGS
ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES BC_EMPLOYEES(employee_id);