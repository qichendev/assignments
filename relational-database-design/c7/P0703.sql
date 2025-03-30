DROP TABLE RP_ORDER_LINES CASCADE CONSTRAINTS;

DROP TABLE RP_ORDERS CASCADE CONSTRAINTS;

DROP TABLE RP_INVENTORY CASCADE CONSTRAINTS;

DROP TABLE RP_WAREHOUSE CASCADE CONSTRAINTS;

DROP TABLE RP_CUSTOMERS CASCADE CONSTRAINTS;

DROP TABLE RP_REPS CASCADE CONSTRAINTS;

DROP TABLE RP_PRODUCTS CASCADE CONSTRAINTS;

CREATE TABLE RP_WAREHOUSE (
    WAREHOUSE_ID NUMBER PRIMARY KEY,
    WHSE_CITY VARCHAR2(10) NOT NULL
);

CREATE TABLE RP_PRODUCTS (
    PRODUCT_CODE VARCHAR2(10) PRIMARY KEY,
    PRODUCT_DESCRIPTION VARCHAR2(100) UNIQUE NOT NULL,
    PRODUCT_CATEGORY VARCHAR2(50) NOT NULL,
    COST_PRICE NUMBER NOT NULL,
    CONSTRAINT chk_product_category CHECK (PRODUCT_CATEGORY IN ('HW', 'AP', 'SG')),
    CONSTRAINT chk_cost_price CHECK (
        COST_PRICE BETWEEN 20
        AND 2000
    )
);

CREATE TABLE RP_REPS (
    REP_ID NUMBER PRIMARY KEY,
    LAST_NAME VARCHAR2(100) NOT NULL,
    FIRST_NAME VARCHAR2(100) NOT NULL,
    STREET VARCHAR2(100) NOT NULL,
    REP_CITY VARCHAR2(50) NOT NULL,
    REP_STATE VARCHAR2(50) NOT NULL,
    ZIP VARCHAR2(10) NOT NULL,
    COMMISSION NUMBER NOT NULL,
    RATE NUMBER DEFAULT 0.04 NOT NULL,
    CONSTRAINT chk_rep_state CHECK (REP_STATE IN ('MI', 'IL', 'ON')),
    CONSTRAINT chk_rate CHECK (
        RATE BETWEEN 0.03
        AND 0.07
    )
);

CREATE TABLE RP_CUSTOMERS (
    CUSTOMER_ID NUMBER PRIMARY KEY,
    CUSTOMER_NAME VARCHAR2(100) NOT NULL,
    STREET VARCHAR2(100) NOT NULL,
    CUST_CITY VARCHAR2(50) NOT NULL,
    CUST_STATE VARCHAR2(50) NOT NULL,
    ZIP VARCHAR2(10) NOT NULL,
    BALANCE NUMBER DEFAULT 0 NOT NULL,
    CREDIT_LIMIT NUMBER DEFAULT 5000.00 NOT NULL,
    REP_ID NUMBER NOT NULL,
    CONSTRAINT chk_credit_limit CHECK (CREDIT_LIMIT < 18000),
    CONSTRAINT chk_balance CHECK (BALANCE < CREDIT_LIMIT),
    CONSTRAINT fk_customers_rep FOREIGN KEY (REP_ID) REFERENCES RP_REPS(REP_ID)
);

CREATE TABLE RP_ORDERS (
    ORDER_ID NUMBER PRIMARY KEY,
    ORDER_DATE DATE NOT NULL,
    CUSTOMER_ID NUMBER NOT NULL,
    CONSTRAINT chk_order_date CHECK (ORDER_DATE > TO_DATE('2021-01-01', 'YYYY-MM-DD')),
    CONSTRAINT fk_orders_customer FOREIGN KEY (CUSTOMER_ID) REFERENCES RP_CUSTOMERS(CUSTOMER_ID)
);

CREATE TABLE RP_ORDER_LINES (
    ORDER_ID NUMBER NOT NULL,
    PRODUCT_CODE VARCHAR2(10) NOT NULL,
    QTY_ORDERED NUMBER NOT NULL,
    PRICE_PAID NUMBER NOT NULL,
    CONSTRAINT chk_qty_ordered CHECK (
        QTY_ORDERED BETWEEN 0
        AND 150
    ),
    CONSTRAINT pk_order_lines PRIMARY KEY (ORDER_ID, PRODUCT_CODE),
    CONSTRAINT fk_order_lines_order FOREIGN KEY (ORDER_ID) REFERENCES RP_ORDERS(ORDER_ID),
    CONSTRAINT fk_order_lines_product FOREIGN KEY (PRODUCT_CODE) REFERENCES RP_PRODUCTS(PRODUCT_CODE)
);

CREATE TABLE RP_INVENTORY (
    WAREHOUSE_ID NUMBER NOT NULL,
    PRODUCT_CODE VARCHAR2(10) NOT NULL,
    QOH NUMBER NOT NULL,
    CONSTRAINT chk_qoh CHECK (QOH >= 0),
    CONSTRAINT pk_inventory PRIMARY KEY (WAREHOUSE_ID, PRODUCT_CODE),
    CONSTRAINT fk_inventory_warehouse FOREIGN KEY (WAREHOUSE_ID) REFERENCES RP_WAREHOUSE(WAREHOUSE_ID),
    CONSTRAINT fk_inventory_product FOREIGN KEY (PRODUCT_CODE) REFERENCES RP_PRODUCTS(PRODUCT_CODE)
);

INSERT INTO
    RP_REPS
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
    RP_REPS
VALUES
    (
        35,
        'Manis',
        'Richard',
        '532 Jackson',
        'Toronto',
        'ON',
        'M5V2K1',
        39216.00,
        0.05
    );

INSERT INTO
    RP_REPS
VALUES
    (
        65,
        'Large',
        'Tom',
        '1626 Taylor',
        'Chicago',
        'IL',
        '60099',
        23487.00,
        0.05
    );

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
    ALL INTO rp_orders
VALUES
    (21608, DATE '2021-01-20', 148) INTO rp_orders
VALUES
    (21610, DATE '2021-02-20', 356) INTO rp_orders
VALUES
    (21613, DATE '2021-02-21', 408) INTO rp_orders
VALUES
    (21614, DATE '2021-03-21', 282) INTO rp_orders
VALUES
    (21617, DATE '2021-03-22', 608) INTO rp_orders
VALUES
    (21619, DATE '2021-04-23', 148) INTO rp_orders
VALUES
    (21623, DATE '2021-04-23', 608)
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

INSERT INTO
    RP_WAREHOUSE
VALUES
    (100, 'Chicago');

INSERT INTO
    RP_WAREHOUSE
VALUES
    (200, 'Detroit');

INSERT INTO
    RP_WAREHOUSE
VALUES
    (300, 'Toronto');

INSERT
    ALL INTO rp_inventory
VALUES
    (100, 'AT94', 43) INTO rp_inventory
VALUES
    (100, 'BV06', 24) INTO rp_inventory
VALUES
    (100, 'CD52', 21) INTO rp_inventory
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