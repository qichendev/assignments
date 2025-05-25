DROP SEQUENCE b_order_id_seq;

DROP TABLE    b_employees   CASCADE CONSTRAINTS;
DROP TABLE    b_orders      CASCADE CONSTRAINTS;
DROP TABLE    b_products    CASCADE CONSTRAINTS;
DROP TABLE    b_order_lines CASCADE CONSTRAINTS;
DROP TABLE    b_warehouses  CASCADE CONSTRAINTS;
DROP TABLE    b_inventory   CASCADE CONSTRAINTS;
DROP TABLE    b_prices      CASCADE CONSTRAINTS;
DROP TABLE    b_categories;
DROP TABLE    b_departments;
DROP TABLE    b_jobs;
DROP TABLE    b_customers;

------------------------------------
CREATE TABLE b_warehouses(
  warehouse_id    INTEGER       NOT NULL,
  whse_city       VARCHAR(15) );

------------------------------------
CREATE TABLE b_categories(
  category_code   VARCHAR(2)    NOT NULL,
  category_name   VARCHAR(25)   NOT NULL );

CREATE TABLE b_departments (
  department_code VARCHAR(2)    NOT NULL,
  department_name VARCHAR(25)   NOT NULL,
  manager_id      INTEGER );


CREATE TABLE b_jobs (
  job_code        VARCHAR(7)    NOT NULL,
  job_title       VARCHAR(30)   NOT NULL,
  min_salary      DECIMAL(9,2)  NOT NULL,
  max_salary      DECIMAL(9,2)  NOT NULL );

------------------------------------
CREATE TABLE b_employees(
  employee_id     INTEGER       NOT NULL,
  first_name      VARCHAR(15)   NOT NULL,
  m_initial       VARCHAR(1),
  last_name       VARCHAR(15)   NOT NULL,
  street          VARCHAR(50)   NOT NULL,
  emp_city        VARCHAR(30)   NOT NULL,
  emp_state       VARCHAR(2)    NOT NULL,
  emp_zip         VARCHAR(7)    NOT NULL,
  soc_sec_no      DECIMAL(9)    NOT NULL,
  hire_date       DATE          DEFAULT current_date NOT NULL,
  monthly_salary  DECIMAL(7),
  commission      DECIMAL(7),
  comm_rate       DECIMAL(3,2),
  department_code VARCHAR(2),
  job_code        VARCHAR(7),
  manager_id      INTEGER ); 

--------------------------------------------
CREATE TABLE b_customers(
  customer_id     INTEGER
  GENERATED ALWAYS AS IDENTITY
  START WITH 100 INCREMENT BY 10
  NOCACHE
  NOT NULL,
  customer_name   VARCHAR(35)  NOT NULL,
  street          VARCHAR(50)  NOT NULL,
  cust_city       VARCHAR(30)  NOT NULL,
  cust_state      VARCHAR(2)   NOT NULL,
  cust_zip        VARCHAR(7)   NOT NULL,
  country         VARCHAR(2)   NOT NULL,
  credit_limit    DECIMAL(7)   DEFAULT 50000 NOT NULL,
  balance         DECIMAL(9,2) NOT NULL,
  discount        DECIMAL(3,3),
  membership_date DATE         DEFAULT CURRENT_DATE );

-----------------------------------------------
CREATE TABLE b_products(
  product_code     VARCHAR(4)   NOT NULL,
  prod_description VARCHAR(50)  NOT NULL,
  category_code    VARCHAR(2)   NOT NULL,
  price            DECIMAL(7,2) NOT NULL ); 

-------------------------------------------------
CREATE TABLE b_orders(
  order_id        INTEGER      NOT NULL,
  order_date      DATE         NOT NULL,
  customer_id     INTEGER      NOT NULL,
  ship_date       DATE,
  seller_id       INTEGER ); 
-----------------------------------------------
CREATE TABLE b_order_lines
( order_id        INTEGER      NOT NULL,
  product_code    VARCHAR(4)   NOT NULL,
  quantity        DECIMAL(3,0) NOT NULL,
  price_paid      DECIMAL(7,2) NOT NULL ); 

-----------------------------------------------
CREATE TABLE b_inventory(
  warehouse_id    INTEGER      NOT NULL,
  product_code    VARCHAR(4)   NOT NULL,
  qoh             DECIMAL(5,0) NOT NULL );
  -- discontinued  VARCHAR(1) DEFAULT'N'  NOT NULL
-----------------------------------------------
CREATE TABLE b_prices(
  product_code    VARCHAR(4)   NOT NULL,
  start_date      DATE         NOT NULL,
  end_date        DATE,
  price           DECIMAL(7,2) NOT NULL);

-------------------------------------
-- SEQUENCE -------------------------
-------------------------------------
CREATE SEQUENCE b_order_id_seq
START WITH 1000
INCREMENT BY 1
NOCACHE;

-------------------------------------
-- PRIMARY Keys ---------------------
-------------------------------------
ALTER TABLE b_departments
ADD CONSTRAINT b_departments_pk
PRIMARY KEY (department_code);

ALTER TABLE b_employees
ADD CONSTRAINT b_employees_pk
PRIMARY KEY(employee_id);
    
ALTER TABLE b_warehouses
ADD CONSTRAINT b_warehouse_pk
PRIMARY KEY ( warehouse_id );

ALTER TABLE b_jobs
ADD CONSTRAINT b_jobs_pk
PRIMARY KEY (job_code);

ALTER TABLE b_categories
ADD CONSTRAINT b_categories_pk
PRIMARY KEY ( category_code );

ALTER TABLE b_products
ADD CONSTRAINT b_products_pk
PRIMARY KEY ( product_code );

ALTER TABLE b_inventory
ADD CONSTRAINT b_inventory_pk
PRIMARY KEY ( warehouse_id, product_code );

ALTER TABLE b_customers
ADD CONSTRAINT b_customers_pk
PRIMARY KEY ( customer_id );

ALTER TABLE b_orders
ADD CONSTRAINT b_orders_pk
PRIMARY KEY ( order_id );

ALTER TABLE b_order_lines
ADD CONSTRAINT b_order_lines_pk
PRIMARY KEY(order_id, product_code);

ALTER TABLE b_prices
ADD CONSTRAINT b_prices_pk
PRIMARY KEY (product_code, start_date);

-------------------------------------
-- UNIQUE Keys ---------------------
-------------------------------------
ALTER TABLE b_categories
ADD CONSTRAINT b_categories_category_name_uk
UNIQUE(category_name);

ALTER TABLE b_departments
ADD CONSTRAINT b_departments_department_name_uk
UNIQUE(department_name);

ALTER TABLE b_jobs
ADD CONSTRAINT b_jobs_job_title_uk
UNIQUE(job_title);

-------------------------------------
-- Foreign Keys ---------------------
-------------------------------------
ALTER TABLE b_products
ADD CONSTRAINT prod_category_code_fk
FOREIGN KEY ( category_code )
REFERENCES b_categories ( category_code ); 

ALTER TABLE b_inventory
ADD CONSTRAINT inv_warehouse_id_fk
FOREIGN KEY ( warehouse_id )
REFERENCES b_warehouses ( warehouse_id );
 
ALTER TABLE b_inventory
ADD CONSTRAINT inv_product_code_fk
FOREIGN KEY ( product_code )
REFERENCES b_products ( product_code );

ALTER TABLE b_employees
ADD CONSTRAINT b_employees_department_id_fk
FOREIGN KEY (department_code)
REFERENCES b_departments (department_code);

ALTER TABLE b_employees
ADD CONSTRAINT b_employees_manager_id_fk
FOREIGN KEY (manager_id)
REFERENCES b_employees (employee_id);

ALTER TABLE b_employees
ADD CONSTRAINT b_employees_job_code_fk
FOREIGN KEY (job_code)
REFERENCES b_jobs (job_code);

ALTER TABLE b_orders
ADD CONSTRAINT b_orders_customer_id_fk
FOREIGN KEY(customer_id)
REFERENCES b_customers(customer_id);

ALTER TABLE b_orders
ADD CONSTRAINT orders_seller_id_fk
FOREIGN KEY (seller_id)
REFERENCES b_employees (employee_id);

ALTER TABLE b_order_lines
ADD CONSTRAINT ol_order_id_fk
FOREIGN KEY ( order_id )
REFERENCES b_orders ( order_id );
      
ALTER TABLE b_order_lines 
ADD CONSTRAINT ol_product_code_fk
FOREIGN KEY( product_code )
REFERENCES b_products( product_code );

ALTER TABLE b_prices
ADD CONSTRAINT b_prices_product_code_fk
FOREIGN KEY(product_code)
REFERENCES b_products(product_code);

-------------------------------------
-- Constraints ----------------------
-------------------------------------
ALTER TABLE b_customers
ADD CONSTRAINT b_cust_state_ck
CHECK(cust_state IN ('CA', 'CO', 'MI', 'MN', 'NY', 'NV', 'ON', 'SC', 'TX', 'WI', 'FL') );
  
ALTER TABLE b_customers
ADD CONSTRAINT b_customers_credit_limit_ck
CHECK(Credit_Limit < 1500000);
  
ALTER TABLE b_customers
ADD CONSTRAINT b_customers_balance_lt_credit_limit_ck
CHECK(Balance < Credit_Limit);
  
ALTER TABLE b_customers
ADD CONSTRAINT b_customers_discount_ck
CHECK(discount BETWEEN 0 AND .225);

ALTER TABLE b_orders
ADD CONSTRAINT b_orders_ship_date_gt_order_date_ck
CHECK(ship_date > order_date);
  
ALTER TABLE b_orders
ADD CONSTRAINT b_orders_order_date_ck
CHECK(order_date BETWEEN DATE '2019-01-01' AND DATE '2025-12-31');
  
ALTER TABLE b_orders
ADD CONSTRAINT b_orders_ship_date_ck
CHECK(ship_date BETWEEN DATE '2019-01-01' AND DATE '2025-12-31');

ALTER TABLE b_prices
ADD CONSTRAINT b_prices_price_ck
CHECK(price BETWEEN 20.00 AND 8000.00 ); 
 
ALTER TABLE b_inventory
ADD CONSTRAINT b_inventory_on_hand_ck
CHECK(qoh BETWEEN 0 AND 150 );  
 
ALTER TABLE b_employees
ADD CONSTRAINT b_employees_state_prov_ck
CHECK(emp_state IN (' ', 'CA', 'CO', 'MI', 'MN', 'NY', 'NV', 'ON', 'SC', 'TX', 'WI', 'FL') );
  
ALTER TABLE b_employees
ADD CONSTRAINT b_employees_sellers_rate_ck
CHECK(comm_rate BETWEEN 0.03 AND 0.07 );

-----------------------------------------
INSERT INTO b_departments VALUES ('AD', 'Administration', 104);
INSERT INTO b_departments VALUES ('AC', 'Accounting', 105);
INSERT INTO b_departments VALUES ('MK', 'Marketing', NULL);
INSERT INTO b_departments VALUES ('TR', 'Training', 110);
INSERT INTO b_departments VALUES ('IT', 'Information Technology', NULL);
INSERT INTO b_departments VALUES ('CA', 'Cameras', NULL);
INSERT INTO b_departments VALUES ('MA', 'Major Appliances', 111);
INSERT INTO b_departments VALUES ('SA', 'Small Appliances', NULL);
INSERT INTO b_departments VALUES ('OP', 'Office Products', NULL);
INSERT INTO b_departments VALUES ('VG', 'Video Games', 113);
INSERT INTO b_departments VALUES ('HT', 'Home Theatre', 112);

INSERT INTO b_categories VALUES ('SG','Sporting Goods');
INSERT INTO b_categories VALUES ('HW','Hardware');
INSERT INTO b_categories VALUES ('LA', 'Large Appliances');
INSERT INTO b_categories VALUES ('SA', 'Small Appliances');
 
INSERT INTO b_warehouses VALUES (1,'Miami');
INSERT INTO b_warehouses VALUES (2,'Miami');
INSERT INTO b_warehouses VALUES (3,'Detroit');
INSERT INTO b_warehouses VALUES (4,'Toronto');
INSERT INTO b_warehouses VALUES (5,'Chicago');
INSERT INTO b_warehouses VALUES (6,'Dallas');
INSERT INTO b_warehouses VALUES (7,'San Diego');

INSERT INTO b_jobs VALUES ('AD_PRES', 'President', 150000, 200000);
INSERT INTO b_jobs VALUES ('AD_VP',   'Vice President', 100000, 145000);
INSERT INTO b_jobs VALUES ('MK_MGR', 'Marketing Manager', 70000, 115000);
INSERT INTO b_jobs VALUES ('MK_REP', 'Marketing Representative', 45000, 65000);
INSERT INTO b_jobs VALUES ('DT_MGR', 'Department Manager', 90000, 133000);
INSERT INTO b_jobs VALUES ('SL_ACE', 'Sales Associate', 32000, 40000);
INSERT INTO b_jobs VALUES ('AC_MGR', 'Accounting Manager', 70000, 110000);
INSERT INTO b_jobs VALUES ('IT_MGR', 'IT Manager', 85000, 140000);
INSERT INTO b_jobs VALUES ('IT_DEV', 'Software Developer', 60000, 90000);
INSERT INTO b_jobs VALUES ('AD_TRN', 'Trainer', 40000, 52000);

INSERT INTO b_employees VALUES (104,'Terry',  ' ', 'Manis',     '375 Sandhill Lane', 'Troy',     'MI','53321',  750348365, '2000-05-20', 11000, 542, 0.05, 'AD', 'DT_MGR', NULL);
INSERT INTO b_employees VALUES (105,'Sandy',  ' ', 'Black',     '9467 Range Road',   'San Diego','CA','33553',  285013858, '2000-07-18', 7700,  216, 0.07, 'AC', 'DT_MGR', 104);
INSERT INTO b_employees VALUES (106,'Janis',  ' ', 'Hill',      '4923 Big Hill Road','Denver',   'CO','33336',  194012638, '2001-09-24', 6585,  487, 0.05, 'VG', 'SL_ACE', 104);
INSERT INTO b_employees VALUES (107,'Jim',    ' ', 'Smith',     '148 Main Street',   'Kenoshia', 'WI','64765',  910481945, '2002-11-30', 6000,  345, 0.03, 'HT', 'SL_ACE', 105);
INSERT INTO b_employees VALUES (108,'Jane',   ' ', 'White',     '8123 Taylor Drive', 'Rochester','NY','45322',  285305673, '2001-10-22', 4500,  329, 0.03, 'MA', 'SL_ACE', 106);
INSERT INTO b_employees VALUES (109,'Troy',   ' ', 'Mansion',   '3585 Sunny Drive',  'Toronto',  'ON','J5F 9J4',164950123, '2003-04-12', 3200,  561, 0.05, 'SA', 'SL_ACE', 107);
INSERT INTO b_employees VALUES (110,'Lauren', 'M', 'Alexander', ' ',                 ' ',        ' ', ' ',      749583756, '2007-05-20', 4500,  585, 0.05, 'TR', 'DT_MGR', NULL);
INSERT INTO b_employees VALUES (111,'Lisa',   'L', 'James',  ' ', ' ', ' ',' ',                                 396812058, '2008-02-15', 6500,  560, 0.07, 'MA', 'DT_MGR', 110);
INSERT INTO b_employees VALUES (112,'Dave',   ' ', 'Bernard',  ' ', ' ', ' ',' ',                               184759364, '2010-07-24', 6000,  910, 0.03, 'HT', 'DT_MGR', 111);
INSERT INTO b_employees VALUES (113,'Steve',  'L', 'Carr',  ' ', ' ', ' ',       ' ',                           018593745, '2007-07-29', 5500,  548, 0.05, 'VG', 'DT_MGR', 112);
INSERT INTO b_employees VALUES (114,'Marg',   'A', 'Horner',  ' ', ' ', ' ',         ' ',                       947581253, '2007-06-13', 4500,  500, 0.07, 'MA', 'SL_ACE', 111);
INSERT INTO b_employees VALUES (124,'Scott',  ' ', 'Long',  ' ', ' ', ' ', ' ',                                 912058121, '2009-08-17', 3500,  954, 0.03, 'TR', 'AD_TRN', 113);
INSERT INTO b_employees VALUES (115,'Jim',    ' ', 'Best',  ' ', ' ', ' ',     ' ',                             184629673, '2010-10-22', 2400,  145, 0.05, 'SA', 'SL_ACE', NULL);
INSERT INTO b_employees VALUES (126,'Sue',    'A', 'McDonald',  ' ', ' ', ' ',     ' ',                         285912756, '2008-02-15', 3600,  945, NULL, NULL, NULL,     110);
INSERT INTO b_employees VALUES (117,'Trish',  'S', 'Albert',  ' ', ' ', ' ',    ' ',                            649105738, '2009-07-22', 1800,  934, 0.07, 'VG', 'SL_ACE', 113);
INSERT INTO b_employees VALUES (125,'Terry',  'J', 'Maxwell',  ' ', ' ', ' ',    ' ',                           385937712, '2006-10-25', 2200,  472, 0.05, 'HT', 'SL_ACE', 112);
INSERT INTO b_employees VALUES (119,'Dave',   ' ', 'Nisbet',  ' ', ' ', ' ',         ' ',                       759127547, '2005-04-18', 3900,  211, NULL, NULL, NULL,     110);
INSERT INTO b_employees VALUES (120,'Anne',   'M', 'Richie',  ' ', ' ', ' ',     ' ',                           834577193, '2010-11-28', 4000,  026, 0.03, 'MA', 'SL_ACE', 111);
INSERT INTO b_employees VALUES (122,'Jake',   'L', 'Lee',  ' ', ' ', ' ',      ' ',                             812954926, '2012-06-15', 4500,  111, 0.05, 'VG', 'SL_ACE', 113);
INSERT INTO b_employees VALUES (118,'Janice', 'B', 'Harper',  ' ', ' ', ' ',   ' ',                             912758396, '2007-09-11', 2900,  574, 0.07, 'HT', 'SL_ACE', 112);
INSERT INTO b_employees VALUES (123,'Linda',  'M', 'Johnson',  ' ', ' ', ' ',  ' ',                             295734812, '2010-08-10', 2400,  543, 0.03, 'MA', 'SL_ACE', 114);
INSERT INTO b_employees VALUES (121,'William','J', 'Johnson',  ' ', ' ', ' ',  ' ',                             374912745, '2007-01-24', 3100,  157, NULL, NULL, NULL,     110);
INSERT INTO b_employees VALUES (127,'Sharron',' ', 'Evans',  ' ', ' ', ' ',      ' ',                           492337745, '2006-10-16', 2900,  463, 0.05, 'MA', 'SL_ACE', 114);
INSERT INTO b_employees VALUES (116,'Robert', ' ', 'Henry',  ' ', ' ', ' ',      ' ',                           512850475, '2009-05-25', 3700,  593, 0.07, 'MA', 'SL_ACE', 111);
INSERT INTO b_employees VALUES (131,'Barb',   'L', 'Gibbens',  ' ', ' ', ' ',    ' ',                           852951124, '2011-03-15', 2900,  182, NULL, NULL, NULL,     115);
INSERT INTO b_employees VALUES (135,'Greg',   'J', 'Zimmerman',  ' ', ' ', ' ',  ' ',                           539554832, '2007-04-19', 3150,  835, 0.05, 'IT', 'IT_DEV', 115);
INSERT INTO b_employees VALUES (132,'Bob',    'R', 'Allan',  ' ', ' ', ' ',      ' ',                           284447883, '2008-02-13', 2400,  623, 0.07, 'IT', 'IT_DEV', 114);
INSERT INTO b_employees VALUES (136,'Paula',  'A', 'Morris',  ' ', ' ', ' ',     ' ',                           812740127, '2006-11-24', 2250,  734, 0.05, 'IT', 'IT_DEV', NULL);
INSERT INTO b_employees VALUES (139,'Rick',   'D', 'Peters',  ' ', ' ', ' ',     ' ',                           294477289, '2013-03-15', 2875,  342, 0.03, 'IT', 'IT_DEV', 110);

INSERT INTO b_customers VALUES (DEFAULT, 'Everything Electronics',      '8639 24TH Avenue',    'Fort Gratiot',     'MI', '48059',   'US', 38000, 24500.75, .020, '2010-05-20');
INSERT INTO b_customers VALUES (DEFAULT, 'Worldwide Digital Inc',       '9119 North West Ave', 'Rochester',        'MN', '55901',   'US', 60000, 27560.85, .105, '2011-07-15');
INSERT INTO b_customers VALUES (DEFAULT, 'Best Digital Products',       '9339 Exmouth Street', 'Sarnia',           'ON', 'N7S 3X9', 'CA', 42500, 12860.55, .020, '2010-05-20');
INSERT INTO b_customers VALUES (DEFAULT, 'Worldwide Digital Inc',       '26388 Yonge Street',  'Newmarket',        'ON', 'L3Y 8S1', 'CA', 35000, 18575.75, .010, '2013-10-25');
INSERT INTO b_customers VALUES (DEFAULT, 'Big Box Digital',             '9463 South Coulter',  'Amarillo',         'TX', '79121',   'US', 54500, 34240.25, .125, '2014-06-18');
INSERT INTO b_customers VALUES (DEFAULT, 'Big Box Digital',             '2757 College Avenue', 'San Diego',        'CA', '72115',   'US', 55000, 41712.17, NULL, '2014-06-18');
INSERT INTO b_customers VALUES (DEFAULT, 'billy''s toys',               '5151 Mission Road',   'San Diego',        'CA', '92108',   'US', 75000, 57583.65, NULL, '2010-05-20');
INSERT INTO b_customers VALUES (DEFAULT, 'Star-Mart Store #2177',       '3382 Murphy Road',    'sAn diEgo',        'CA', '82123',   'US', 99000, 75732.19, NULL, '2010-07-15');
INSERT INTO b_customers VALUES (DEFAULT, 'Technology R Us',             '2342 W.250Th St',     'New Hartford',     'NY', '13413',   'US', 55000, 40012.55, NULL, '2013-10-25');
INSERT INTO b_customers VALUES (DEFAULT, 'Digital Junkies',             '9522 2Nd Ct',         'Syracuse',         'NY', '13290',   'US', 60000, 25600.85, .105, '2010-05-20');
INSERT INTO b_customers VALUES (DEFAULT, 'Best Electronics',            '7673 N Academy Blvd', 'Colorado Springs', 'CO', '70920',   'US', 30000, 16000.55, .060, '2010-07-15');
INSERT INTO b_customers VALUES (DEFAULT, 'Armstrong Digital',           '5390 Wadsworth Blvd', 'Lakewood',         'CO', '80124',   'US', 25000, 24900.66, .040, '2013-10-25');
INSERT INTO b_customers VALUES (DEFAULT, 'Best Bargain',                '3150 Center Point Rd','Colorado Springs', 'CO', '80922',   'US', 26000, 25900.47, .020, '2010-05-20');
INSERT INTO b_customers VALUES (DEFAULT, 'Best Digital Products',       '9588 52ND Street',    'Kenoshia',         'WI', '53144',   'US', 37500, 12375.85, .020, '2010-07-15');
INSERT INTO b_customers VALUES (DEFAULT, 'Everything Electronics',      '8383 8TH Street',     'Wisconsin Rapids', 'WI', '54494',   'US', 28550, 23401.25, .050, '2013-10-25');
INSERT INTO b_customers VALUES (DEFAULT, 'Big Box Digital',             '2757 Airport Bld',    'Columbia',         'SC', '92115',   'US', 55000, 30012.55, NULL, '2010-05-20');
INSERT INTO b_customers VALUES (DEFAULT, 'Worldwide Digital Inc',       '9119 Dumbar St',      'Spartanburg',      'SC', '55901',   'US', 60000, 25600.85, .105, '2010-07-15');
INSERT INTO b_customers VALUES (DEFAULT, 'Best Digital Products',       '9339 E Palmetto St',  'Florence',         'SC', 'N7S 3X9', 'US', 42500, 18600.55, .020, '2013-10-25');
INSERT INTO b_customers VALUES (DEFAULT, 'Frys Electronics',            '6845 Las Vegas Blvd', 'Las Vegas',        'NV', '89119',   'US', 68200, 41200.75, .050, '2010-05-20');
INSERT INTO b_customers VALUES (DEFAULT, 'Jerry''s Sports',             '10950 West Blvd',     'Las Vegas',        'NV', '89135',   'US', 57000, 13375.85, .100, '2010-07-15');
INSERT INTO b_customers VALUES (DEFAULT, 'Office Depot',                '2202 Harvard Way',    'Reno',             'NV', '89502',   'US', 31550, 24201.33, .045, '2013-10-25'); 

INSERT INTO b_products VALUES ('AT94', 'Iron',                                      'SA', 69.99);
INSERT INTO b_products VALUES ('BV06', 'Home Gym',                                  'SG', 2350.69);
INSERT INTO b_products VALUES ('CD52', 'Microwave Oven',                            'SA', 224.99);
INSERT INTO b_products VALUES ('DL71', 'Cordless Drill',                            'HW', 122.59);
INSERT INTO b_products VALUES ('DR93', 'Black Gas-Range',                           'LA', 1300.29);
INSERT INTO b_products VALUES ('DW11', 'Washer',                                    'LA', 1250.19);
INSERT INTO b_products VALUES ('FD21', 'Stand Mixer',                               'SA', 99.99);
INSERT INTO b_products VALUES ('KL62', 'Dryer',                                     'LA', 1195.79);
INSERT INTO b_products VALUES ('KT03', 'Dishwasher',                                'LA', 895.59);
INSERT INTO b_products VALUES ('KV29', 'Treadmill',                                 'SG', 1475.29);
INSERT INTO b_products VALUES ('RF23', 'Refrigerator',                              'LA', 1500.39);
INSERT INTO b_products VALUES ('CM12', 'Coffee Maker',                              'SA', 59.99);
INSERT INTO b_products VALUES ('W902', 'High Efficiency Top Load Washer',           'LA', 1575.89);
INSERT INTO b_products VALUES ('W283', 'Stackable Washer and Dryer Combo',          'LA', 2575.39);
INSERT INTO b_products VALUES ('W740', 'High Efficiency Front Load Washer',         'LA', 1375.29);
INSERT INTO b_products VALUES ('C136', 'Portable Air Conditioner',                  'LA', 450.79);
INSERT INTO b_products VALUES ('C832', 'Portable Canister Cleaner',                 'SA', 400.99);
INSERT INTO b_products VALUES ('V438', 'Wet/Dry Hand Vacuum',                       'SA', 89.99);
INSERT INTO b_products VALUES ('I192', 'Full Digital Iron',                         'SA', 102.99);
INSERT INTO b_products VALUES ('D951', 'Built-In Dishwasher',                       'LA', 1200.79);
INSERT INTO b_products VALUES ('R812', 'Top Freezer Refrigerator',                  'LA', 1500.99);
INSERT INTO b_products VALUES ('R501', 'Range with Dual Fuel',                      'LA', 1695.29);
INSERT INTO b_products VALUES ('R759', 'Freestanding Gas Range',                    'LA', 1425.89);
INSERT INTO b_products VALUES ('B159', 'Brushed Stainless Steel Blender',           'SA', 95.99);
INSERT INTO b_products VALUES ('C812', 'BrewStation 6 Cup Coffeemaker',             'SA', 145.69);
INSERT INTO b_products VALUES ('F246', 'Extra-large Deep Fryer',                    'SA', 189.59);
INSERT INTO b_products VALUES ('P729', '3-piece Stainless Appliance Package',       'LA', 5500.99);
INSERT INTO b_products VALUES ('R930', 'Self-Clean Smooth-Top Stainless Range',     'LA', 1565.69);
INSERT INTO b_products VALUES ('W940', 'Water Cooler',                              'SA', 250.29);
INSERT INTO b_products VALUES ('C730', 'Programmable Coffee Maker',                 'SA', 125.99);
INSERT INTO b_products VALUES ('O639', 'Countertop Oven',                           'SA', 169.99);
INSERT INTO b_products VALUES ('F930', 'Chest Freezer',                             'LA', 1995.49);
INSERT INTO b_products VALUES ('R940', 'Side-By-Side Stainless Steel Refrigerator', 'LA', 2400.99);
INSERT INTO b_products VALUES ('B935', 'Blender',                                   'SA', 49.99);

INSERT INTO b_inventory VALUES (1, 'AT94', 43);
INSERT INTO b_inventory VALUES (1, 'BV06', 24);
INSERT INTO b_inventory VALUES (1, 'CD52', 21);
INSERT INTO b_inventory VALUES (1, 'DL71', 11);
INSERT INTO b_inventory VALUES (1, 'DR93', 31);
INSERT INTO b_inventory VALUES (1, 'DW11', 12);
INSERT INTO b_inventory VALUES (2, 'FD21', 12);
INSERT INTO b_inventory VALUES (2, 'KL62', 34);
INSERT INTO b_inventory VALUES (2, 'KT03', 23);
INSERT INTO b_inventory VALUES (2, 'KV29', 25);
INSERT INTO b_inventory VALUES (2, 'AT94', 43);
INSERT INTO b_inventory VALUES (3, 'BV06', 34);
INSERT INTO b_inventory VALUES (3, 'CD52', 11);
INSERT INTO b_inventory VALUES (3, 'DL71', 41);
INSERT INTO b_inventory VALUES (3, 'DR93', 21);
INSERT INTO b_inventory VALUES (3, 'DW11', 42);
INSERT INTO b_inventory VALUES (4, 'FD21', 52);
INSERT INTO b_inventory VALUES (4, 'KL62', 14);
INSERT INTO b_inventory VALUES (4, 'KT03', 53);
INSERT INTO b_inventory VALUES (4, 'KV29', 35);

INSERT INTO b_prices VALUES ('AT94','2019-09-01', '2020-01-15', 69.95);
INSERT INTO b_prices VALUES ('AT94','2020-01-15', '2020-06-10', 74.95);
INSERT INTO b_prices VALUES ('AT94','2020-06-10', NULL, 79.95);
INSERT INTO b_prices VALUES ('BV06','2019-06-20', '2019-10-15', 794.95);
INSERT INTO b_prices VALUES ('BV06','2019-10-15', NULL, 849.49);
INSERT INTO b_prices VALUES ('CD52','2019-09-22', '2020-01-05', 165.00);
INSERT INTO b_prices VALUES ('CD52','2020-01-05', NULL, 184.65);


-----------------------------------------
-- Order 1 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL,'2020-09-13', 100, '2020-09-22', 105)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'CD52', 2, 224.99)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'DR93', 1, 1300.29)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'DW11', 3, 1250.19)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KL62', 2, 1195.79)
SELECT 1 FROM DUAL;

-----------------------------------------
-- Order 2 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-09-14' ,120, '2020-09-24', 135)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'AT94', 2, 69.99)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KL62', 1, 1195.79)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'CD52', 2, 224.99)
SELECT 1 FROM DUAL;
  
-----------------------------------------
-- Order 3 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-09-15', 110, '2020-09-30', 115)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KV29', 2, 1475.29)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KT03', 1, 895.59)
SELECT 1 FROM DUAL;

-----------------------------------------
-- Order 4 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-10-17', 130, '2020-10-20', 125)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'AT94', 11, 69.99)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KT03', 1, 895.59)
SELECT 1 FROM DUAL;

-----------------------------------------
-- Order 5 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-10-18', 100, '2020-10-24', 105)
 
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'DR93', 1, 1300.29)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'DW11', 1, 1250.19)
SELECT 1 FROM DUAL;

-----------------------------------------
-- Order 6 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-10-20', 120, '2020-10-28', 125)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KL62', 4, 1195.79)
SELECT 1 FROM DUAL;

-----------------------------------------
-- Order 7 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-11-14', 130, NULL, 115)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KT03', 2, 895.59)
SELECT 1 FROM DUAL;
  
-----------------------------------------
-- Order 8 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-11-15', 100, '2020-11-20', 105)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'BV06', 2, 2350.69)
INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'CD52', 4, 224.99)
SELECT 1 FROM DUAL;

-----------------------------------------
-- Order 9 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-11-16', 110, '2020-11-19', 120)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'DR93', 1, 1300.29)
SELECT 1 FROM DUAL;

-----------------------------------------
-- Order 10 --
INSERT ALL
INTO b_orders VALUES (b_order_id_seq.NEXTVAL, '2020-11-16', 120, NULL, 125)

INTO b_order_lines VALUES (b_order_id_seq.CURRVAL, 'KV29', 2, 1475.29)
SELECT 1 FROM DUAL;


-- SELECT STATEMENTS

-- 1
SELECT ROUND(845.553, 1) AS "ROUND",
    TO_CHAR(845.553, '999999.9') AS "TO_CHAR"
FROM DUAL;

SELECT ROUND(30695.348, 2) AS "ROUND",
    TO_CHAR(30695.348, '999999.99') AS "TO_CHAR"
FROM DUAL;

SELECT ROUND(30695.348, -2) AS "ROUND"
FROM DUAL;

SELECT TRUNC(2.3587, 1) AS "TRUNCATE"
FROM DUAL;

-- 2
SELECT MOD(34, 8) AS "RESULT"
FROM DUAL;

-- 3
SELECT first_name || ' ' || last_name AS "EMPLOYEE",
    TO_CHAR(monthly_salary * 12, '$999,999.99') AS "YEARLY_SALARY"
FROM b_employees
WHERE monthly_salary > 75000
ORDER BY "YEARLY_SALARY" DESC;

-- 4
SELECT first_name || ' ' || last_name AS "EMPLOYEE",
    monthly_salary * 12 AS "CURRENT_SALARY",
    TO_CHAR(ROUND(monthly_salary * 12 * 1.0345, 2), 'FM999999.99') AS "NEW_SALARY"
FROM b_employees
WHERE monthly_salary > 80000
ORDER BY "NEW_SALARY" DESC;

-- 5
SELECT first_name || ' ' || last_name AS "NAME",
    monthly_salary * 12 AS "CURRENT_SALARY",
    TO_CHAR(ROUND(monthly_salary * 12 * 1.0345, 2), '$999999.99') AS "NEW_SALARY"
FROM b_employees
WHERE monthly_salary > 80000
ORDER BY "NEW_SALARY" DESC;

-- 6
SELECT cust_city AS "CITY",
    customer_name AS "CUSTOMER_NAME",
    TO_CHAR(credit_limit, '$999,999.99') AS "CURRENT_LIMIT",
    TO_CHAR(credit_limit * 1.0525, '$999,999.99') AS "NEW_LIMIT"
FROM b_customers
WHERE credit_limit * 1.0525 BETWEEN 60000 AND 75000
ORDER BY "NEW_LIMIT" DESC;

-- 7
SELECT product_code AS "PRODUCT_CODE",
    price AS "ORIGINAL_PRICE",
    TO_CHAR(FLOOR(price), '$999,999.99') AS "MONDAY_PRICE",
    TO_CHAR(CEIL(price), '$999,999.99') AS "TUESDAY_PRICE"
FROM b_products;

-- 8
SELECT 
    CASE 
        WHEN MOD(:ENTER_NUM, 2) = 0 THEN 'Even number'
        ELSE 'Odd number'
    END AS RESULT
FROM dual;