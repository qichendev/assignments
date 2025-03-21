CREATE TABLE BC_JOBS (
    job_id NUMBER(3, 0) PRIMARY KEY,
    job_title VARCHAR2(50) UNIQUE NOT NULL,
    charge_hour NUMBER(7, 2) NOT NULL
);

-- 注意：最后一行 charge_hour 后面不能有逗号！
CREATE TABLE BC_EMPLOYEES (
    employee_id NUMBER(5, 0) PRIMARY KEY,
    first_name VARCHAR2(40) NOT NULL,
    last_name VARCHAR2(40) NOT NULL,
    job_id NUMBER(3, 0) NOT NULL,
    CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES BC_JOBS(job_id)
);

CREATE TABLE BC_PROJECTS (
    project_id NUMBER(5, 0) PRIMARY KEY,
    project_name VARCHAR2(40) UNIQUE NOT NULL,
    project_leader_id NUMBER(5, 0),
    CONSTRAINT fk_project_leader_id FOREIGN KEY (project_leader_id) REFERENCES BC_EMPLOYEES(employee_id)
);

CREATE TABLE BC_BILLINGS (
    hours_billed NUMBER(3, 1),
    project_id NUMBER(5, 0) NOT NULL,
    employee_id NUMBER(5, 0) NOT NULL,
    CONSTRAINT pk_project_employee PRIMARY KEY(project_id, employee_id),
    CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES BC_PROJECTS(project_id),
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES BC_EMPLOYEES(employee_id)
);