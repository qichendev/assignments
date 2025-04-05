
INSERT ALL
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (11, 304, 201)
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (11, 300, 212)
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (22, 303, 202)
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (22, 304, NULL)
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (22, 305, 205)
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (22, 306, 206)
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (33, 300, 210)
INTO bd_store_departments (store_id, department_id, dept_mgr_id) VALUES (33, 304, 208)
SELECT 1 FROM DUAL;

-- Populate departments table
INSERT ALL
INTO bd_departments (department_id, department_name) VALUES (300, 'New Hire')
INTO bd_departments (department_id, department_name) VALUES (301, 'IT')
INTO bd_departments (department_id, department_name) VALUES (302, 'Administration')
INTO bd_departments (department_id, department_name) VALUES (303, 'Men''s Clothing')
INTO bd_departments (department_id, department_name) VALUES (304, 'Women''s Clothing')
INTO bd_departments (department_id, department_name) VALUES (305, 'Kids')
INTO bd_departments (department_id, department_name) VALUES (306, 'Toys')
SELECT 1 FROM DUAL;

-- Populate employees table
-- (employee_id, first_name, last_name, birth_date, soc_ins_no, sex, pension_contr, hire_date, coach_id, store_id,
--  department_id, job_class, job_level, salary, bonus, commission )
INSERT ALL
INTO bd_employees VALUES (201, 'Lauren', 'Alexander', '1980-02-10', 749583756, 'F', 1, '2012-09-22', NULL, 11, 304, 'M', 8, 94500, 12000,    0)
INTO bd_employees VALUES (202, 'Lisa',   'James',     '1988-06-16', 396812058, 'F', 0, '2013-12-15', NULL, 22, 303, 'M', 6, 52000,  7500,    0)
INTO bd_employees VALUES (203, 'Dave',   'Bernard',   '1990-04-28', 184759364, 'M', 1, '2014-05-10', 202,  22, 303, 'C', 3, 24000,     0,  500)
INTO bd_employees VALUES (204, 'Betty',  'Smith',     '1980-05-15', 744963756, 'F', 1, '2015-10-18', NULL, 22, 304, 'M', 8, 84500,  9200,    0)
INTO bd_employees VALUES (205, 'Amy',    'Albert',    '1988-09-26', 396396858, 'F', 0, '2016-02-22', NULL, 22, 305, 'J', 6, 42000,  7500,    0)
INTO bd_employees VALUES (206, 'Peter',  'Alan',      '1990-08-15', 181957464, 'M', 1, '2017-11-11', NULL, 22, 306, 'C', 5, 24000,     0,  500)
INTO bd_employees VALUES (207, 'Alice',  'Manis',     '1980-03-08', 840681248, 'F', 1, '2015-08-21', NULL, 33, 300, 'M', 8, 84500, 12000,    0)
INTO bd_employees VALUES (208, 'Brook',  'Payne',     '1988-10-01', 185038596, 'F', 0, '2016-10-14', NULL, 33, 304, 'M', 6, 62000,  7500,    0)
INTO bd_employees VALUES (209, 'Terry',  'Russell',   '1990-06-20', 205837501, 'M', 1, '2017-04-09', 207,  33, 300, 'T', 3, 24000,     0,  500)
INTO bd_employees VALUES (210, 'Carol',  'Brown',     '1980-02-25', 740149284, 'F', 1, '2015-08-08', 207,  33, 300, 'T', 3, 24500,     0, 2080)
INTO bd_employees VALUES (211, 'Casey',  'Emery',     '1988-03-16', 749127485, 'F', 0, '2016-04-12', 206,  22, 300, 'T', 3, 25000,     0,  800)
INTO bd_employees VALUES (212, 'Bill',   'Jewel',     '1990-05-05', 385012745, 'M', 1, '2017-10-12', 205,  11, 300, 'T', 3, 24500,     0,  500)
SELECT 1 FROM DUAL;

-- Populate stores table
INSERT INTO bd_stores (store_id, city) VALUES (11,'Sarnia');
INSERT INTO bd_stores (store_id, city) VALUES (22,'London');
INSERT INTO bd_stores (store_id, city) VALUES (33,'Toronto');  

UPDATE bd_stores
SET store_mgr_id = 201
WHERE store_id = 11;

UPDATE bd_stores
SET store_mgr_id = 204
WHERE store_id = 22;

UPDATE bd_stores
SET store_mgr_id = 207
WHERE store_id = 33;


-- Constraint Testing

-- CHECK CONSTRAINT bd_store_departments store_id BETWEEN 11 AND 99;
-- CHECK CONSTRAINT bd_store_departments department_id BETWEEN 300 AND 399;
-- CHECK CONSTRAINT bd_employees birth_date < TO_DATE('1980-01-01','YYYY-MM-DD');
