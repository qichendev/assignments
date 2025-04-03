CREATE TABLE CUSTOMER (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    address VARCHAR2(255) NOT NULL,
    city VARCHAR2(100),
    state VARCHAR2(50),
    zip_code VARCHAR2(20),
    mobile_number VARCHAR2(20) NOT NULL,
    email VARCHAR2(100),
    registration_date DATE DEFAULT SYSDATE,
    credit_limit NUMBER(10, 2) DEFAULT 1000.00,
    status VARCHAR2(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Suspended'))
);

CREATE TABLE ASSOCIATE (
    associate_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100),
    phone_number VARCHAR2(20),
    hire_date DATE DEFAULT SYSDATE,
    salary NUMBER(10, 2),
    commission_rate NUMBER(5, 2),
    manager_id NUMBER
);

CREATE TABLE WAREHOUSE (
    warehouse_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    location VARCHAR2(255) NOT NULL,
    capacity NUMBER(10),
    manager_id NUMBER,
    phone_number VARCHAR2(20),
    is_active NUMBER(1) DEFAULT 1,
    opening_date DATE
);

CREATE TABLE SUPPLIER (
    supplier_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    contact_person VARCHAR2(100),
    email VARCHAR2(100),
    phone_number VARCHAR2(20) NOT NULL,
    address VARCHAR2(255),
    country VARCHAR2(50),
    payment_terms VARCHAR2(50),
    credit_rating VARCHAR2(20),
    status VARCHAR2(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Blacklisted'))
);

CREATE TABLE CATEGORY (
    category_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(255),
    parent_category_id NUMBER
);

CREATE TABLE PRODUCT (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    cell_composition VARCHAR2(100),
    uses_for VARCHAR2(100),
    voltage VARCHAR2(50),
    price NUMBER(10, 2) NOT NULL,
    cost NUMBER(10, 2),
    stock_quantity NUMBER DEFAULT 0,
    warehouse_id NUMBER,
    min_stock_level NUMBER DEFAULT 5,
    max_stock_level NUMBER DEFAULT 100,
    manufacturer VARCHAR2(100),
    created_date DATE DEFAULT SYSDATE,
    last_updated DATE DEFAULT SYSDATE,
    category_id NUMBER,
    supplier_id NUMBER,
    warranty_period NUMBER,
    reorder_point NUMBER DEFAULT 10
);

CREATE TABLE INVOICE (
    invoice_id NUMBER PRIMARY KEY,
    invoice_number VARCHAR2(20) UNIQUE,
    date DATE DEFAULT SYSDATE,
    address VARCHAR2(255),
    customer_id NUMBER,
    mobile_number VARCHAR2(20),
    associate_id NUMBER,
    subtotal NUMBER(10, 2) DEFAULT 0,
    taxes NUMBER(10, 2) DEFAULT 0,
    shipping_fee NUMBER(10, 2) DEFAULT 0,
    discount NUMBER(10, 2) DEFAULT 0,
    total_due NUMBER(10, 2) DEFAULT 0,
    payment_method VARCHAR2(50),
    payment_status VARCHAR2(20) DEFAULT 'Pending' CHECK (
        payment_status IN ('Paid', 'Pending', 'Cancelled', 'Refunded')
    ),
    shipping_method VARCHAR2(50),
    tracking_number VARCHAR2(50),
    notes VARCHAR2(500)
);

CREATE TABLE INVOICE_ITEM (
    item_id NUMBER PRIMARY KEY,
    invoice_id NUMBER,
    product_id NUMBER,
    quantity NUMBER DEFAULT 1,
    unit_price NUMBER(10, 2),
    total_price NUMBER(10, 2)
);

CREATE TABLE SHIPMENT (
    shipment_id NUMBER PRIMARY KEY,
    invoice_id NUMBER,
    shipment_date DATE,
    delivery_date DATE,
    status VARCHAR2(20) DEFAULT 'Processing' CHECK (
        status IN ('Processing', 'Shipped', 'Delivered', 'Returned')
    ),
    carrier VARCHAR2(50),
    tracking_number VARCHAR2(50),
    shipping_cost NUMBER(10, 2)
);

CREATE TABLE PURCHASE_ORDER (
    po_id NUMBER PRIMARY KEY,
    po_number VARCHAR2(20) UNIQUE,
    supplier_id NUMBER,
    order_date DATE DEFAULT SYSDATE,
    expected_delivery_date DATE,
    status VARCHAR2(20) DEFAULT 'Pending' CHECK (
        status IN ('Pending', 'Approved', 'Received', 'Cancelled')
    ),
    total_amount NUMBER(12, 2),
    payment_terms VARCHAR2(50),
    associate_id NUMBER
);

CREATE TABLE PURCHASE_ORDER_ITEM (
    po_item_id NUMBER PRIMARY KEY,
    po_id NUMBER,
    product_id NUMBER,
    quantity NUMBER,
    unit_price NUMBER(10, 2),
    total_price NUMBER(10, 2),
    received_quantity NUMBER DEFAULT 0
);

CREATE TABLE RETURN (
    return_id NUMBER PRIMARY KEY,
    invoice_id NUMBER,
    return_date DATE DEFAULT SYSDATE,
    reason VARCHAR2(255),
    status VARCHAR2(20) DEFAULT 'Pending' CHECK (
        status IN ('Pending', 'Approved', 'Rejected', 'Refunded')
    ),
    refund_amount NUMBER(10, 2),
    processed_by NUMBER
);

CREATE TABLE RETURN_ITEM (
    return_item_id NUMBER PRIMARY KEY,
    return_id NUMBER,
    invoice_item_id NUMBER,
    quantity NUMBER,
    condition VARCHAR2(50)
);

CREATE TABLE REVIEW (
    review_id NUMBER PRIMARY KEY,
    product_id NUMBER,
    customer_id NUMBER,
    rating NUMBER(2, 1) CHECK (
        rating BETWEEN 1
        AND 5
    ),
    comments VARCHAR2(1000),
    review_date DATE DEFAULT SYSDATE,
    verified_purchase NUMBER(1) DEFAULT 0
);

ALTER TABLE
    ASSOCIATE
ADD
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES ASSOCIATE(associate_id);

ALTER TABLE
    WAREHOUSE
ADD
    CONSTRAINT fk_warehouse_manager FOREIGN KEY (manager_id) REFERENCES ASSOCIATE(associate_id);

ALTER TABLE
    CATEGORY
ADD
    CONSTRAINT fk_parent_category FOREIGN KEY (parent_category_id) REFERENCES CATEGORY(category_id);

ALTER TABLE
    PRODUCT
ADD
    CONSTRAINT fk_product_warehouse FOREIGN KEY (warehouse_id) REFERENCES WAREHOUSE(warehouse_id);

ALTER TABLE
    PRODUCT
ADD
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id);

ALTER TABLE
    PRODUCT
ADD
    CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id);

ALTER TABLE
    INVOICE
ADD
    CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id);

ALTER TABLE
    INVOICE
ADD
    CONSTRAINT fk_invoice_associate FOREIGN KEY (associate_id) REFERENCES ASSOCIATE(associate_id);

ALTER TABLE
    INVOICE_ITEM
ADD
    CONSTRAINT fk_item_invoice FOREIGN KEY (invoice_id) REFERENCES INVOICE(invoice_id);

ALTER TABLE
    INVOICE_ITEM
ADD
    CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id);

ALTER TABLE
    SHIPMENT
ADD
    CONSTRAINT fk_shipment_invoice FOREIGN KEY (invoice_id) REFERENCES INVOICE(invoice_id);

ALTER TABLE
    PURCHASE_ORDER
ADD
    CONSTRAINT fk_po_supplier FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id);

ALTER TABLE
    PURCHASE_ORDER
ADD
    CONSTRAINT fk_po_associate FOREIGN KEY (associate_id) REFERENCES ASSOCIATE(associate_id);

ALTER TABLE
    PURCHASE_ORDER_ITEM
ADD
    CONSTRAINT fk_poitem_po FOREIGN KEY (po_id) REFERENCES PURCHASE_ORDER(po_id);

ALTER TABLE
    PURCHASE_ORDER_ITEM
ADD
    CONSTRAINT fk_poitem_product FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id);

ALTER TABLE
    RETURN
ADD
    CONSTRAINT fk_return_invoice FOREIGN KEY (invoice_id) REFERENCES INVOICE(invoice_id);

ALTER TABLE
    RETURN
ADD
    CONSTRAINT fk_return_associate FOREIGN KEY (processed_by) REFERENCES ASSOCIATE(associate_id);

ALTER TABLE
    RETURN_ITEM
ADD
    CONSTRAINT fk_returnitem_return FOREIGN KEY (return_id) REFERENCES RETURN(return_id);

ALTER TABLE
    RETURN_ITEM
ADD
    CONSTRAINT fk_returnitem_invoiceitem FOREIGN KEY (invoice_item_id) REFERENCES INVOICE_ITEM(item_id);

ALTER TABLE
    REVIEW
ADD
    CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id);

ALTER TABLE
    REVIEW
ADD
    CONSTRAINT fk_review_customer FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id);

INSERT INTO
    CUSTOMER (
        customer_id,
        name,
        address,
        city,
        state,
        zip_code,
        mobile_number,
        email,
        registration_date,
        credit_limit
    )
VALUES
    (
        101,
        'Alex Johnson',
        '123 Tech Avenue',
        'Boston',
        'MA',
        '02115',
        '6175551234',
        'alex.j@example.com',
        TO_DATE('2023-08-15', 'YYYY-MM-DD'),
        5000.00
    );

INSERT INTO
    ASSOCIATE (
        associate_id,
        name,
        email,
        phone_number,
        hire_date,
        salary,
        commission_rate
    )
VALUES
    (
        101,
        'Michael Smith',
        'msmith@company.com',
        '5085552345',
        TO_DATE('2023-05-10', 'YYYY-MM-DD'),
        8000.00,
        3.50
    );

INSERT INTO
    WAREHOUSE (
        warehouse_id,
        name,
        location,
        capacity,
        phone_number,
        is_active,
        opening_date
    )
VALUES
    (
        101,
        'Main Distribution Center',
        '88 Logistics Blvd, Memphis, TN',
        100000,
        '9015557890',
        1,
        TO_DATE('2023-01-15', 'YYYY-MM-DD')
    );

INSERT INTO
    SUPPLIER (
        supplier_id,
        name,
        contact_person,
        email,
        phone_number,
        address,
        country,
        payment_terms,
        credit_rating,
        status
    )
VALUES
    (
        101,
        'GlobalBattery Inc.',
        'Sarah Williams',
        'swilliams@globalbattery.com',
        '3125556789',
        '500 Industrial Park, Chicago, IL',
        'USA',
        'Net 30',
        'A',
        'Active'
    );

INSERT INTO
    CATEGORY (category_id, name, description)
VALUES
    (
        101,
        'Lithium Polymer Batteries',
        'High-performance lithium polymer batteries for modern electronic devices'
    );

INSERT INTO
    PRODUCT (
        product_id,
        name,
        cell_composition,
        uses_for,
        voltage,
        price,
        cost,
        stock_quantity,
        warehouse_id,
        manufacturer,
        category_id,
        supplier_id,
        warranty_period
    )
VALUES
    (
        101,
        'SuperCell X9',
        'Lithium-Polymer',
        'Premium Smartphones',
        '3.85V',
        199.99,
        80.00,
        500,
        101,
        'GlobalBattery',
        101,
        101,
        18
    );

INSERT INTO
    INVOICE (
        invoice_id,
        invoice_number,
        date,
        address,
        customer_id,
        mobile_number,
        associate_id,
        subtotal,
        taxes,
        shipping_fee,
        total_due,
        payment_method,
        payment_status
    )
VALUES
    (
        101,
        'INV-2023-101',
        TO_DATE('2023-09-01', 'YYYY-MM-DD'),
        '123 Tech Avenue, Boston, MA',
        101,
        '6175551234',
        101,
        599.97,
        30.00,
        15.00,
        644.97,
        'Credit Card',
        'Paid'
    );

INSERT INTO
    INVOICE_ITEM (
        item_id,
        invoice_id,
        product_id,
        quantity,
        unit_price,
        total_price
    )
VALUES
    (101, 101, 101, 3, 199.99, 599.97);

INSERT INTO
    PURCHASE_ORDER (
        po_id,
        po_number,
        supplier_id,
        order_date,
        expected_delivery_date,
        status,
        total_amount,
        payment_terms,
        associate_id
    )
VALUES
    (
        101,
        'PO-2023-101',
        101,
        TO_DATE('2023-08-15', 'YYYY-MM-DD'),
        TO_DATE('2023-08-30', 'YYYY-MM-DD'),
        'Approved',
        40000.00,
        'Net 30',
        101
    );

INSERT INTO
    PURCHASE_ORDER_ITEM (
        po_item_id,
        po_id,
        product_id,
        quantity,
        unit_price,
        total_price,
        received_quantity
    )
VALUES
    (101, 101, 101, 500, 80.00, 40000.00, 0);

-- Test 1: Customer Status Constraint (Valid)
INSERT INTO
    CUSTOMER (
        customer_id,
        name,
        address,
        mobile_number,
        status
    )
VALUES
    (
        201,
        'John Doe',
        '456 Main St',
        '5551234567',
        'Active'
    );

-- Test 2: Customer Status Constraint (Invalid)
INSERT INTO
    CUSTOMER (
        customer_id,
        name,
        address,
        mobile_number,
        status
    )
VALUES
    (
        202,
        'Jane Smith',
        '789 Oak Ave',
        '5559876543',
        'Pending'
    );

-- Test 3: Product Rating Range Constraint (Valid)
INSERT INTO
    REVIEW (review_id, product_id, customer_id, rating)
VALUES
    (101, 101, 101, 4.5);

-- Test 4: Product Rating Range Constraint (Invalid - Below Range)
INSERT INTO
    REVIEW (review_id, product_id, customer_id, rating)
VALUES
    (102, 101, 101, 0.5);

-- Test 5: Product Rating Range Constraint (Invalid - Above Range)
INSERT INTO
    REVIEW (review_id, product_id, customer_id, rating)
VALUES
    (103, 101, 101, 5.5);

-- Test 6: Foreign Key Constraint (Valid)
INSERT INTO
    INVOICE_ITEM (
        item_id,
        invoice_id,
        product_id,
        quantity,
        unit_price,
        total_price
    )
VALUES
    (201, 101, 101, 2, 199.99, 399.98);

-- Test 7: Foreign Key Constraint (Invalid)
INSERT INTO
    INVOICE_ITEM (
        item_id,
        invoice_id,
        product_id,
        quantity,
        unit_price,
        total_price
    )
VALUES
    (202, 101, 999, 2, 199.99, 399.98);

-- Test 8: Invoice Payment Status Constraint (Valid)
INSERT INTO
    INVOICE (
        invoice_id,
        invoice_number,
        customer_id,
        mobile_number,
        payment_status
    )
VALUES
    (
        201,
        'INV-2023-201',
        101,
        '6175551234',
        'Refunded'
    );

-- Test 9: Invoice Payment Status Constraint (Invalid)
INSERT INTO
    INVOICE (
        invoice_id,
        invoice_number,
        customer_id,
        mobile_number,
        payment_status
    )
VALUES
    (
        202,
        'INV-2023-202',
        101,
        '6175551234',
        'Processing'
    );

-- Test 10: NOT NULL Constraint (Invalid)
INSERT INTO
    PRODUCT (
        product_id,
        cell_composition,
        uses_for,
        voltage,
        price,
        cost
    )
VALUES
    (
        201,
        'Lithium-Ion',
        'Tablets',
        '4.5V',
        249.99,
        100.00
    );