-- DROP TABLES (in proper dependency order)
DROP TABLE bd_store_departments CASCADE CONSTRAINTS;
DROP TABLE bd_employees CASCADE CONSTRAINTS;
DROP TABLE bd_stores CASCADE CONSTRAINTS;
DROP TABLE bd_departments CASCADE CONSTRAINTS;
-- CREATE bd_departments
CREATE TABLE bd_departments (
    department_id NUMBER(6) NOT NULL,
    department_name VARCHAR2(50) NOT NULL,
    CONSTRAINT departments_pk PRIMARY KEY (department_id)
);
-- CREATE bd_stores
CREATE TABLE bd_stores (
    store_id NUMBER(6) NOT NULL,
    city VARCHAR2(40),
    store_mgr_id NUMBER(6),
    CONSTRAINT stores_pk PRIMARY KEY (store_id)
);
-- CREATE bd_store_departments
CREATE TABLE bd_store_departments (
    store_id NUMBER(6) NOT NULL,
    department_id NUMBER(6) NOT NULL,
    dept_mgr_id NUMBER(6),
    CONSTRAINT store_departments_pk PRIMARY KEY (store_id, department_id),
    CONSTRAINT store_departments_fk1 FOREIGN KEY (store_id) REFERENCES bd_stores(store_id),
    CONSTRAINT store_departments_fk2 FOREIGN KEY (department_id) REFERENCES bd_departments(department_id)
);
-- CREATE bd_employees
CREATE TABLE bd_employees (
    employee_id NUMBER(6) NOT NULL,
    first_name VARCHAR2(30) NOT NULL,
    last_name VARCHAR2(30) NOT NULL,
    birth_date DATE NOT NULL,
    soc_ins_no NUMBER(9, 0) NOT NULL,
    sex VARCHAR2(1) NOT NULL,
    pension_contr NUMBER(1) DEFAULT 0 NOT NULL,
    hire_date DATE DEFAULT SYSDATE NOT NULL,
    job_class VARCHAR2(1) NOT NULL,
    job_level NUMBER(1) DEFAULT 1 NOT NULL,
    salary NUMBER(9, 2) NOT NULL,
    bonus NUMBER(9, 2),
    commission NUMBER(9, 2),
    coach_id NUMBER(6),
    store_id NUMBER(6) NOT NULL,
    department_id NUMBER(6) DEFAULT 300 NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY (employee_id),
    CONSTRAINT employees_fk1 FOREIGN KEY (coach_id) REFERENCES bd_employees(employee_id),
    CONSTRAINT employees_fk2 FOREIGN KEY (store_id) REFERENCES bd_stores(store_id),
    CONSTRAINT employees_fk3 FOREIGN KEY (department_id) REFERENCES bd_departments(department_id)
);
-- ALTER city to NOT NULL
ALTER TABLE bd_stores
MODIFY city VARCHAR2(40) NOT NULL;
-- ADD foreign key after employees are created
ALTER TABLE bd_stores
ADD CONSTRAINT stores_manager_fk FOREIGN KEY (store_mgr_id) REFERENCES bd_employees(employee_id);
-- ASSIGN store managers
UPDATE bd_stores
SET store_mgr_id = 201
WHERE store_id = 11;
UPDATE bd_stores
SET store_mgr_id = 204
WHERE store_id = 22;
UPDATE bd_stores
SET store_mgr_id = 207
WHERE store_id = 33;
ALTER TABLE bd_stores
ADD CONSTRAINT store_id_range CHECK (
        store_id BETWEEN 11 AND 99
    );
ALTER TABLE bd_departments
ADD CONSTRAINT department_id_range CHECK (
        department_id BETWEEN 300 AND 399
    );
ALTER TABLE bd_employees
ADD CONSTRAINT birth_date_check CHECK (
        birth_date >= TO_DATE('1980-01-01', 'YYYY-MM-DD')
    );
ALTER TABLE bd_employees
ADD CONSTRAINT soc_ins_no_check CHECK (
        soc_ins_no BETWEEN 1 AND 999999999
    );
ALTER TABLE bd_employees
ADD CONSTRAINT sex_check CHECK (sex IN ('F', 'M'));
ALTER TABLE bd_employees
ADD CONSTRAINT pension_contr_check CHECK (pension_contr IN (0, 1));
ALTER TABLE bd_employees
ADD CONSTRAINT hire_date_check CHECK (hire_date > birth_date);
ALTER TABLE bd_departments
MODIFY department_id DEFAULT 300;
ALTER TABLE bd_employees
MODIFY job_class DEFAULT 'T';
ALTER TABLE bd_employees
ADD CONSTRAINT job_class_check CHECK (job_class IN ('T', 'I', 'C', 'M'));
ALTER TABLE bd_employees
ADD CONSTRAINT job_level_check CHECK (
        job_level BETWEEN 1 AND 9
    );
ALTER TABLE bd_employees
ADD CONSTRAINT salary_check CHECK (salary <= 125000.00);
ALTER TABLE bd_employees
ADD CONSTRAINT salary_vs_commission_check CHECK (
        salary > commission
        OR commission IS NULL
    );
ALTER TABLE bd_employees
ADD CONSTRAINT bonus_commission_check CHECK (
        (
            bonus IS NULL
            AND commission IS NOT NULL
        )
        OR (
            bonus IS NOT NULL
            AND commission IS NULL
        )
        OR (
            bonus IS NULL
            AND commission IS NULL
        )
    );
ALTER TABLE bd_employees
ADD CONSTRAINT commission_percent_check CHECK (
        commission < (salary * 0.085)
        OR commission IS NULL
    );
-- POPULATE bd_departments
INSERT ALL INTO bd_departments
VALUES (300, 'New Hire') INTO bd_departments
VALUES (301, 'IT') INTO bd_departments
VALUES (302, 'Administration') INTO bd_departments
VALUES (303, 'Men''s Clothing') INTO bd_departments
VALUES (304, 'Women''s Clothing') INTO bd_departments
VALUES (305, 'Kids') INTO bd_departments
VALUES (306, 'Toys')
SELECT 1
FROM DUAL;
-- POPULATE bd_stores
INSERT INTO bd_stores (store_id, city)
VALUES (11, 'Sarnia');
INSERT INTO bd_stores (store_id, city)
VALUES (22, 'London');
INSERT INTO bd_stores (store_id, city)
VALUES (33, 'Toronto');
-- POPULATE bd_employees
INSERT ALL INTO bd_employees
VALUES (
        201,
        'Lauren',
        'Alexander',
        DATE '1980-02-10',
        749583756,
        'F',
        1,
        DATE '2012-09-22',
        'M',
        8,
        94500,
        12000,
        NULL,
        NULL,
        11,
        304
    ) INTO bd_employees
VALUES (
        202,
        'Lisa',
        'James',
        DATE '1988-06-16',
        396812058,
        'F',
        0,
        DATE '2013-12-15',
        'M',
        6,
        52000,
        7500,
        NULL,
        NULL,
        22,
        303
    ) INTO bd_employees
VALUES (
        203,
        'Dave',
        'Bernard',
        DATE '1990-04-28',
        184759364,
        'M',
        1,
        DATE '2014-05-10',
        'C',
        3,
        24000,
        NULL,
        500,
        202,
        22,
        303
    ) INTO bd_employees
VALUES (
        204,
        'Betty',
        'Smith',
        DATE '1980-05-15',
        744963756,
        'F',
        1,
        DATE '2015-10-18',
        'M',
        8,
        84500,
        9200,
        NULL,
        NULL,
        22,
        304
    ) INTO bd_employees
VALUES (
        205,
        'Amy',
        'Albert',
        DATE '1988-09-26',
        396396858,
        'F',
        0,
        DATE '2016-02-22',
        'C',
        6,
        42000,
        7500,
        NULL,
        NULL,
        22,
        305
    ) INTO bd_employees
VALUES (
        206,
        'Peter',
        'Alan',
        DATE '1990-08-15',
        181957464,
        'M',
        1,
        DATE '2017-11-11',
        'C',
        5,
        24000,
        NULL,
        500,
        NULL,
        22,
        306
    ) INTO bd_employees
VALUES (
        207,
        'Alice',
        'Manis',
        DATE '1980-03-08',
        840681248,
        'F',
        1,
        DATE '2015-08-21',
        'M',
        8,
        84500,
        12000,
        NULL,
        NULL,
        33,
        300
    ) INTO bd_employees
VALUES (
        208,
        'Brook',
        'Payne',
        DATE '1988-10-01',
        185038596,
        'F',
        0,
        DATE '2016-10-14',
        'M',
        6,
        62000,
        7500,
        NULL,
        NULL,
        33,
        304
    ) INTO bd_employees
VALUES (
        209,
        'Terry',
        'Russell',
        DATE '1990-06-20',
        205837501,
        'M',
        1,
        DATE '2017-04-09',
        'T',
        3,
        24000,
        NULL,
        500,
        207,
        33,
        300
    ) INTO bd_employees
VALUES (
        210,
        'Carol',
        'Brown',
        DATE '1980-02-25',
        740149284,
        'F',
        1,
        DATE '2015-08-08',
        'T',
        3,
        24500,
        NULL,
        2080,
        207,
        33,
        300
    ) INTO bd_employees
VALUES (
        211,
        'Casey',
        'Emery',
        DATE '1988-03-16',
        749127485,
        'F',
        0,
        DATE '2016-04-12',
        'T',
        3,
        25000,
        NULL,
        800,
        206,
        22,
        300
    ) INTO bd_employees
VALUES (
        212,
        'Bill',
        'Jewel',
        DATE '1990-05-05',
        385012745,
        'M',
        1,
        DATE '2017-10-12',
        'T',
        3,
        24500,
        NULL,
        500,
        205,
        11,
        300
    )
SELECT 1
FROM DUAL;
-- POPULATE bd_store_departments (now dept_mgr_id values exist)
INSERT ALL INTO bd_store_departments
VALUES (11, 304, 201) INTO bd_store_departments
VALUES (11, 300, 212) INTO bd_store_departments
VALUES (22, 303, 202) INTO bd_store_departments
VALUES (22, 304, 204) INTO bd_store_departments
VALUES (22, 305, 205) INTO bd_store_departments
VALUES (22, 306, 206) INTO bd_store_departments
VALUES (33, 300, 210) INTO bd_store_departments
VALUES (33, 304, 208)
SELECT 1
FROM DUAL;