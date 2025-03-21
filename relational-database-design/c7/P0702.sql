DROP TABLE RP_INVENTORY;

DROP TABLE RP_WAREHOUSE;

DROP TABLE RP_CUSTOMERS;

DROP TABLE RP_REPS;

DROP TABLE RP_ORDER_LINES;

DROP TABLE RP_ORDERS;

DROP TABLE RP_PRODUCTS;

CREATE TABLE RP_INVENTORY (
    WAREHOUSE_ID NUMBER,
    PRODUCT_CODE VARCHAR2(10),
    QOH NUMBER
);

CREATE TABLE RP_WAREHOUSE (
    WAREHOUSE_ID NUMBER,
    WHSE_CITY VARCHAR2(10)
);

CREATE TABLE RP_CUSTOMERS (
    CUSTOMER_ID NUMBER,
    CUSTOMER_NAME VARCHAR2(100),
    STREET VARCHAR2(100),
    CUST_CITY VARCHAR2(50),
    CUST_STATE VARCHAR2(50),
    ZIP VARCHAR2(10),
    BALANCE NUMBER,
    CREDIT_LIMIT NUMBER,
    REP_ID NUMBER
);

CREATE TABLE RP_REPS (
    REP_ID NUMBER,
    LAST_NAME VARCHAR2(100),
    FIRST_NAME VARCHAR2(100),
    STREET VARCHAR2(100),
    REP_CITY VARCHAR2(50),
    REP_STATE VARCHAR2(50),
    ZIP VARCHAR2(10),
    COMMISSION NUMBER,
    RATE NUMBER
);

CREATE TABLE RP_ORDER_LINES (
    ORDER_ID NUMBER,
    PRODUCT_CODE VARCHAR2(10),
    QTY_ORDERED NUMBER,
    PRICE_PAID NUMBER
);

CREATE TABLE RP_ORDERS (
    ORDER_ID NUMBER,
    ORDER_DATE DATE,
    CUSTOMER_ID NUMBER
);

CREATE TABLE RP_PRODUCTS (
    PRODUCT_CODE VARCHAR2(10),
    PRODUCT_DESCRIPTION VARCHAR2(100),
    PRODUCT_CATEGORY VARCHAR2(50),
    COST_PRICE NUMBER
);

INSERT
    ALL INTO rp_inventory
VALUES
    (100, 'AT94', 43) INTO rp_inventory
VALUES
    (100, 'BV06', 24) INTO rp_inventory
VALUES
    (100, 'CD52', 21) INTO rp_inventory
VALUES
    (100, 'DL71', 11) INTO rp_inventory
VALUES
    (100, 'DR93', 31) INTO rp_inventory
VALUES
    (100, 'DW11', 12) INTO rp_inventory
VALUES
    (100, 'FD21', 12) INTO rp_inventory
VALUES
    (100, 'KL62', 34) INTO rp_inventory
VALUES
    (100, 'KT03', 23) INTO rp_inventory
VALUES
    (100, 'KV29', 25) INTO rp_inventory
VALUES
    (200, 'AT94', 43) INTO rp_inventory
VALUES
    (200, 'BV06', 34) INTO rp_inventory
VALUES
    (200, 'CD52', 11) INTO rp_inventory
VALUES
    (200, 'DL71', 41) INTO rp_inventory
VALUES
    (200, 'DR93', 21) INTO rp_inventory
VALUES
    (300, 'DW11', 42) INTO rp_inventory
VALUES
    (300, 'FD21', 52) INTO rp_inventory
VALUES
    (300, 'KL62', 14) INTO rp_inventory
VALUES
    (300, 'KT03', 53) INTO rp_inventory
VALUES
    (300, 'KV29', 35)
SELECT
    1
FROM
    DUAL;

INSERT
    ALL INTO rp_customers
VALUES
    (
        148,
        'Al''s Appliance and Sport',
        '2837 Greenway',
        'Detroit',
        'MI',
        '48244',
        6550.00,
        7500.00,
        20
    ) INTO rp_customers
VALUES
    (
        282,
        'Brookings Direct',
        '3827 Devon',
        'Toronto',
        'ON',
        'M5V7F5',
        431.50,
        10000.00,
        35
    ) INTO rp_customers
VALUES
    (
        356,
        'Ferguson''s',
        '382 Wildwood',
        'Northfield',
        'MI',
        '33146',
        5785.00,
        7500.00,
        20
    ) INTO rp_customers
VALUES
    (
        408,
        'The Everything Shop',
        '1828 Raven',
        'Crystal',
        'IL',
        '60082',
        4285.25,
        5000.00,
        65
    ) INTO rp_customers
VALUES
    (
        462,
        'Bargains Galore',
        '3829 Central',
        'Toronto',
        'ON',
        'M5V9G4',
        3412.00,
        10000.00,
        35
    ) INTO rp_customers
VALUES
    (
        524,
        'Kline''s',
        '838 Ridgeland',
        'Lakeside',
        'IL',
        '60091',
        12762.00,
        15000.00,
        65
    ) INTO rp_customers
VALUES
    (
        608,
        'Johnson''s Department Store',
        '372 Oxford',
        'Toronto',
        'ON',
        'M5V9S4',
        2106.00,
        10000.00,
        35
    ) INTO rp_customers
VALUES
    (
        687,
        'Lee''s Sport and Appliance',
        '282 Evergreen',
        'Troy',
        'MI',
        '48283',
        2851.00,
        5000.00,
        20
    ) INTO rp_customers
VALUES
    (
        725,
        'Deerfield''s Four Seasons',
        '282 Columbia',
        'Toronto',
        'ON',
        'M5V9J5',
        248.00,
        7500.00,
        35
    ) INTO rp_customers
VALUES
    (
        842,
        'All Season',
        '28 Lakeview',
        'Grove City',
        'IL',
        '60081',
        6221.00,
        7500.00,
        65
    )
SELECT
    1
FROM
    DUAL;

INSERT
    ALL INTO rp_order_lines
VALUES
    (21608, 'AT94', 11, 21.95) INTO rp_order_lines
VALUES
    (21610, 'DR93', 1, 495.00) INTO rp_order_lines
VALUES
    (21610, 'DW11', 1, 399.99) INTO rp_order_lines
VALUES
    (21613, 'KL62', 4, 329.95) INTO rp_order_lines
VALUES
    (21614, 'KT03', 2, 595.00) INTO rp_order_lines
VALUES
    (21617, 'BV06', 2, 794.95) INTO rp_order_lines
VALUES
    (21617, 'CD52', 4, 150.00) INTO rp_order_lines
VALUES
    (21619, 'DR93', 1, 495.00) INTO rp_order_lines
VALUES
    (21623, 'KV29', 2, 1290.00)
SELECT
    1
FROM
    DUAL;

INSERT
    ALL INTO rp_orders
VALUES
    (21608, '2021-01-20', 148) INTO rp_orders
VALUES
    (21610, '2021-02-20', 356) INTO rp_orders
VALUES
    (21613, '2021-02-21', 408) INTO rp_orders
VALUES
    (21614, '2021-03-21', 282) INTO rp_orders
VALUES
    (21617, '2021-03-22', 608) INTO rp_orders
VALUES
    (21619, '2021-04-23', 148) INTO rp_orders
VALUES
    (21623, '2021-04-23', 608)
SELECT
    1
FROM
    DUAL;

INSERT
    ALL INTO rp_products
VALUES
    ('AT94', 'Iron', 'HW', 24.95) INTO rp_products
VALUES
    ('BV06', 'Home Gym', 'SG', 794.95) INTO rp_products
VALUES
    ('CD52', 'Microwave Oven', 'AP', 165.00) INTO rp_products
VALUES
    ('DL71', 'Cordless Drill', 'HW', 129.95) INTO rp_products
VALUES
    ('DR93', 'Gas Range', 'AP', 495.00) INTO rp_products
VALUES
    ('DW11', 'Washer', 'AP', 399.99) INTO rp_products
VALUES
    ('FD21', 'Stand Mixer', 'HW', 159.95) INTO rp_products
VALUES
    ('KL62', 'Dryer', 'AP', 349.95) INTO rp_products
VALUES
    ('KT03', 'Dishwasher', 'AP', 595.00) INTO rp_products
VALUES
    ('KV29', 'Treadmill', 'SG', 1390.00)
SELECT
    1
FROM
    DUAL;

INSERT INTO
    RP_REPS (
        REP_ID,
        LAST_NAME,
        FIRST_NAME,
        STREET,
        REP_CITY,
        REP_STATE,
        ZIP,
        COMMISSION,
        RATE
    )
VALUES
    (
        20,
        'Culp',
        'Betty',
        '1275 Main St',
        'Detroit',
        'MI',
        '48288',
        20542.50,
        0.05
    );

INSERT INTO
    RP_REPS (
        REP_ID,
        LAST_NAME,
        FIRST_NAME,
        STREET,
        REP_CITY,
        REP_STATE,
        ZIP,
        COMMISSION,
        RATE
    )
VALUES
    (
        35,
        'Manis',
        'Richard',
        '532 Jackson',
        'Toronto',
        'ON',
        'M5V2K1',
        '39216.00',
        '0.05'
    );

INSERT INTO
    RP_REPS (
        REP_ID,
        LAST_NAME,
        FIRST_NAME,
        STREET,
        REP_CITY,
        REP_STATE,
        ZIP,
        COMMISSION,
        RATE
    )
VALUES
    (
        65,
        'Large',
        'Tom',
        '1626 Taylor',
        'Chicago',
        'IL',
        '60099',
        '23487.00',
        '0.05'
    );

INSERT INTO
    RP_WAREHOUSE (WAREHOUSE_ID, WHSE_CITY)
VALUES
    (100, 'Chicago');

INSERT INTO
    RP_WAREHOUSE (WAREHOUSE_ID, WHSE_CITY)
VALUES
    (200, 'Detroit');

INSERT INTO
    RP_WAREHOUSE (WAREHOUSE_ID, WHSE_CITY)
VALUES
    (300, 'Toronto');

UPDATE
    RP_CUSTOMERS
SET
    BALANCE = 4285.25
WHERE
    CUSTOMER_ID = 408;

UPDATE
    RP_CUSTOMERS
SET
    BALANCE = 6221
WHERE
    CUSTOMER_ID = 842;

UPDATE
    RP_PRODUCTS
SET
    COST_PRICE = COST_PRICE + COST_PRICE * 0.085;

DELETE FROM
    RP_PRODUCTS
WHERE
    PRODUCT_DESCRIPTION = 'Cordless Drill';

UPDATE
    RP_CUSTOMERS
SET
    CREDIT_LIMIT = 14500
WHERE
    CUSTOMER_NAME = 'Brookings Direct';

ALTER TABLE
    RP_INVENTORY
MODIFY
    WAREHOUSE_ID NUMBER NOT NULL;

ALTER TABLE
    RP_INVENTORY
MODIFY
    PRODUCT_CODE VARCHAR2(10) NOT NULL;

ALTER TABLE
    RP_INVENTORY
MODIFY
    QOH NUMBER NOT NULL;

ALTER TABLE
    RP_WAREHOUSE
MODIFY
    WAREHOUSE_ID NUMBER NOT NULL;

ALTER TABLE
    RP_WAREHOUSE
MODIFY
    WHSE_CITY VARCHAR2(10) NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    CUSTOMER_ID NUMBER NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    CUSTOMER_NAME VARCHAR2(100) NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    STREET VARCHAR2(100) NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    CUST_CITY VARCHAR2(50) NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    CUST_STATE VARCHAR2(50) NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    ZIP VARCHAR2(10) NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    BALANCE NUMBER NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    CREDIT_LIMIT NUMBER NOT NULL;

ALTER TABLE
    RP_CUSTOMERS
MODIFY
    REP_ID NUMBER NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    REP_ID NUMBER NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    LAST_NAME VARCHAR2(100) NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    FIRST_NAME VARCHAR2(100) NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    STREET VARCHAR2(100) NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    REP_CITY VARCHAR2(50) NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    REP_STATE VARCHAR2(50) NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    ZIP VARCHAR2(10) NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    COMMISSION NUMBER NOT NULL;

ALTER TABLE
    RP_REPS
MODIFY
    RATE NUMBER NOT NULL;

ALTER TABLE
    RP_ORDER_LINES
MODIFY
    ORDER_ID NUMBER NOT NULL;

ALTER TABLE
    RP_ORDER_LINES
MODIFY
    PRODUCT_CODE VARCHAR2(10) NOT NULL;

ALTER TABLE
    RP_ORDER_LINES
MODIFY
    QTY_ORDERED NUMBER NOT NULL;

ALTER TABLE
    RP_ORDER_LINES
MODIFY
    PRICE_PAID NUMBER NOT NULL;

ALTER TABLE
    RP_ORDERS
MODIFY
    ORDER_ID NUMBER NOT NULL;

ALTER TABLE
    RP_ORDERS
MODIFY
    ORDER_DATE DATE NOT NULL;

ALTER TABLE
    RP_ORDERS
MODIFY
    CUSTOMER_ID NUMBER NOT NULL;

ALTER TABLE
    RP_PRODUCTS
MODIFY
    PRODUCT_CODE VARCHAR2(10) NOT NULL;

ALTER TABLE
    RP_PRODUCTS
MODIFY
    PRODUCT_DESCRIPTION VARCHAR2(100) NOT NULL;

ALTER TABLE
    RP_PRODUCTS
MODIFY
    PRODUCT_CATEGORY VARCHAR2(50) NOT NULL;

ALTER TABLE
    RP_PRODUCTS
MODIFY
    COST_PRICE NUMBER NOT NULL;

ALTER TABLE
    RP_INVENTORY
MODIFY
    WAREHOUSE_ID NUMBER PRIMARY KEY;

ALTER TABLE
    RP_WAREHOUSE
MODIFY
    WAREHOUSE_ID