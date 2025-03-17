DROP TABLE products;

CREATE TABLE products (
    product_id NUMBER,
    product_name VARCHAR2(100),
    product_category VARCHAR2(50),
    price NUMBER(10, 2),
    qty_in_stock NUMBER(7, 0),
    supplier VARCHAR2(100),
    manufacturer_date DATE,
    expiry_date DATE
);

INSERT INTO
    products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        1,
        'Laptop',
        'Electronics',
        799.95,
        50,
        'TechSupplier Inc.',
        TO_DATE('1/15/2023', 'MM/DD/YYYY'),
        TO_DATE('1/15/2025', 'MM/DD/YYYY')
    );

INSERT INTO
    products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        2,
        'Office Chair',
        'Furniture',
        120.95,
        200,
        'FurniCo',
        TO_DATE('3/10/2023', 'MM/DD/YYYY'),
        TO_DATE('3/10/2026', 'MM/DD/YYYY')
    );

INSERT INTO
    products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        3,
        'Desk Lamp',
        'Lighting',
        45.95,
        150,
        'Bright Light Ltd.',
        TO_DATE('2/20/2023', 'MM/DD/YYYY'),
        TO_DATE('2/20/2026', 'MM/DD/YYYY')
    );

INSERT INTO
    products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        4,
        'Wireless Mouse',
        'Electronics',
        25.95,
        100,
        'TechSupplier Inc.',
        TO_DATE('1/5/2023', 'MM/DD/YYYY'),
        TO_DATE('1/5/2025', 'MM/DD/YYYY')
    );

INSERT INTO
    products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        5,
        'Notebook',
        'Stationery',
        3.95,
        1000,
        'PaperGoods',
        TO_DATE('4/15/2023', 'MM/DD/YYYY'),
        TO_DATE('4/15/2025', 'MM/DD/YYYY')
    );

INSERT INTO
    products
VALUES
    (
        6,
        'Printer',
        'Electronics',
        199.95,
        75,
        'OfficeSupplyPro',
        TO_DATE('22/05/2023', 'DD/MM/YYYY'),
        TO_DATE('22/05/2026', 'DD/MM/YYYY')
    );

INSERT INTO
    products
VALUES
    (
        7,
        'Coffee Table',
        'Furniture',
        85.95,
        105,
        'FurniCo',
        TO_DATE('22/05/2023', 'DD/MM/YYYY'),
        TO_DATE('21/02/2024', 'DD/MM/YYYY')
    );

INSERT INTO
    products
VALUES
    (
        8,
        'Pen Set',
        'Stationery',
        9.95,
        500,
        'ProperGoods',
        TO_DATE('10/06/2023', 'DD/MM/YYYY'),
        TO_DATE('10/06/2025', 'DD/MM/YYYY')
    );

INSERT INTO
    products
VALUES
    (
        9,
        'Headphones',
        'Electronics',
        150.95,
        150,
        'TechSupplier Inc.',
        TO_DATE('01/04/2023', 'DD/MM/YYYY'),
        TO_DATE('15/12/2026', 'DD/MM/YYYY')
    );

INSERT INTO
    products
VALUES
    (
        10,
        'Stapler',
        'Office Supplies',
        5.95,
        250,
        'OfficeSupplyPro',
        TO_DATE('01/04/2023', 'DD/MM/YYYY'),
        TO_DATE('05/07/2026', 'DD/MM/YYYY')
    );

INSERT
    ALL INTO products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        11,
        'Smartphone',
        'Electronics',
        699.95,
        80,
        'GadgetWorld',
        TO_DATE('25/04/2023', 'DD/MM/YYYY'),
        TO_DATE('25/01/2025', 'DD/MM/YYYY')
    ) INTO products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        12,
        'Bookcase',
        'Furniture',
        130.95,
        101,
        'FurniCo',
        TO_DATE('15/03/2023', 'DD/MM/YYYY'),
        TO_DATE('15/03/2024', 'DD/MM/YYYY')
    ) INTO products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        13,
        'Water Bottle',
        'Kitchen',
        12.95,
        500,
        'Home Essentials',
        TO_DATE('18/04/2023', 'DD/MM/YYYY'),
        TO_DATE('18/01/2025', 'DD/MM/YYYY')
    ) INTO products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        14,
        'Bluetooth Speaker',
        'Electronics',
        120.95,
        90,
        'SoundWorks',
        TO_DATE('10/02/2023', 'DD/MM/YYYY'),
        TO_DATE('10/02/2025', 'DD/MM/YYYY')
    ) INTO products (
        product_id,
        product_name,
        product_category,
        price,
        qty_in_stock,
        supplier,
        manufacturer_date,
        expiry_date
    )
VALUES
    (
        15,
        'Desk Organizer',
        'Office Supplies',
        25.95,
        200,
        'OfficeSupplyPro',
        TO_DATE('08/05/2023', 'DD/MM/YYYY'),
        TO_DATE('08/05/2025', 'DD/MM/YYYY')
    )
SELECT
    1
FROM
    dual;

UPDATE
    products
SET
    price = 55.55
WHERE
    product_id = 3;

UPDATE
    products
SET
    qty_in_stock = qty_in_stock + 50
WHERE
    supplier = 'TechSupplier Inc.';

UPDATE
    products
SET
    product_category = 'Home Office'
WHERE
    product_name = 'Office Chair';

UPDATE
    products
SET
    price = price * 0.9
WHERE
    product_category = 'Stationery';

DELETE FROM
    products
WHERE
    product_id = 6;

DELETE FROM
    products
WHERE
    expiry_date < TO_DATE('20/12/2024', 'DD/MM/YYYY');

DELETE FROM
    products
WHERE
    supplier = 'OfficeSupplyPro';

DELETE FROM
    products
WHERE
    qty_in_stock < 100;