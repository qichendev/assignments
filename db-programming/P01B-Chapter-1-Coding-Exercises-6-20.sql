-- 6.
-- Student Name: Qi Chen
-- Student ID: C0944666
--begin section
BEGIN
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'));
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD'));
-- end section
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 7.
DECLARE
    v_counter DECIMAL(10, 0);
BEGIN
    v_counter := v_counter + 1;
    DBMS_OUTPUT.PUT_LINE('Counter is ' || v_counter);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- Result: 'Counter is ' printed

-- 8.
DECLARE
    v_counter DECIMAL(10, 0) := 300;
BEGIN
    v_counter := v_counter + 1;
    DBMS_OUTPUT.PUT_LINE('Counter is ' || v_counter);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- Result: 'Counter is 301' printed

-- 9.
DECLARE
    v_counter DECIMAL(10, 0) NOT NULL;
BEGIN
    v_counter := v_counter + 1;
    DBMS_OUTPUT.PUT_LINE('Counter is ' || v_counter);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- Result: ERROR at line 2:
-- ORA-06550: line 2, column 15:
-- PLS-00218: a variable declared NOT NULL must have an initialization assignment

-- https://docs.oracle.com/error-help/db/ora-06550/


-- More Details :
-- https://docs.oracle.com/error-help/db/ora-06550/
-- https://docs.oracle.com/error-help/db/pls-00218/

-- 10.
DECLARE
    v_counter DECIMAL(10, 0) NOT NULL := 500;
BEGIN
    v_counter := v_counter + 1;
    DBMS_OUTPUT.PUT_LINE('Counter is ' || v_counter);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- Result: Counter is 501

-- 11.
DECLARE
   v_default_date DATE DEFAULT SYSDATE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('The default date is ' || TO_CHAR(v_default_date, 'YYYY-MM-DD'));
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- Result: The default date is 2026-01-19

-- 12.
DECLARE
   TAX_RATE CONSTANT NUMBER := 0.13;
BEGIN
   DBMS_OUTPUT.PUT_LINE('The tax rate is ' || (TAX_RATE * 100) || ' percent');
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- Result: The tax rate is 13 percent

-- 13.
DECLARE
   CONSTANT1 CONSTANT VARCHAR2(20) := 'Hello'; 
BEGIN
   DBMS_OUTPUT.PUT_LINE('The value is ' || CONSTANT1);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
-- correct program by initializing the constant

-- 14.
DECLARE
   v_myname VARCHAR2(50) := 'John'; 
BEGIN
   v_myname := 'Smith';             
   DBMS_OUTPUT.PUT_LINE('My name is ' || v_myname);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 15.
DECLARE
   c_tax_rate CONSTANT NUMBER := 0.075;
   v_amount   NUMBER := 850.55;
   v_tax      NUMBER;
BEGIN
   v_tax := v_amount * c_tax_rate;
   DBMS_OUTPUT.PUT_LINE('Amount: ' || v_amount);
   DBMS_OUTPUT.PUT_LINE('Tax (7.5%): ' || ROUND(v_tax, 2)); 
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 16.
DECLARE
   v_salary NUMBER;
BEGIN
   v_salary := 'abc'; 
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred.');
      DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 17.
DECLARE
   v_monthly_sal NUMBER := 4250.44;
   v_annual_sal  NUMBER;
BEGIN
   v_annual_sal := v_monthly_sal * 12;
   DBMS_OUTPUT.PUT_LINE('Annual Salary: ' || TO_CHAR(v_annual_sal, '$99,999.99'));
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 18.
VARIABLE age NUMBER;
EXEC :age := 99;

BEGIN
   DBMS_OUTPUT.PUT_LINE('My age is ' || :age || ' years.');
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 19.
VARIABLE ENTER_PRICE NUMBER;
EXEC :ENTER_PRICE := 88;
VARIABLE ENTER_ITEM_CODE NUMBER;
EXEC :ENTER_ITEM_CODE := 200;
VARIABLE ENTER_ITEM_NAME VARCHAR2(100);
EXEC :ENTER_ITEM_NAME := 'Sample Item';

DECLARE
   c_tax_rate  CONSTANT NUMBER := 0.075;
   v_tax_amt   NUMBER;
   v_total     NUMBER;
   v_item_code VARCHAR2(50);
   v_item_name VARCHAR2(100);
BEGIN
   v_item_code := UPPER(:ENTER_ITEM_CODE);
   v_item_name := INITCAP(:ENTER_ITEM_NAME);
   
   v_tax_amt := :ENTER_PRICE * c_tax_rate;
   v_total   := :ENTER_PRICE + v_tax_amt;

   DBMS_OUTPUT.PUT_LINE('Item code: ' || v_item_code);
   DBMS_OUTPUT.PUT_LINE('Item name: ' || v_item_name);
   DBMS_OUTPUT.PUT_LINE('Price: ' || TO_CHAR(:ENTER_PRICE, '$99.99'));
   DBMS_OUTPUT.PUT_LINE('Tax (7.5%): ' || TO_CHAR(v_tax_amt, '$99.90'));
   DBMS_OUTPUT.PUT_LINE('Total amount: ' || TO_CHAR(v_total, '$99.99'));
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

-- 20.
VARIABLE ENTER_INVENTORY NUMBER;
EXEC :ENTER_INVENTORY := 7;
VARIABLE ENTER_UNIT_PRICE NUMBER;
EXEC :ENTER_UNIT_PRICE := 88;
VARIABLE ENTER_PRODUCT_CODE NUMBER;
EXEC :ENTER_PRODUCT_CODE := 200;
VARIABLE ENTER_PRODUCT_NAME VARCHAR2(100);
EXEC :ENTER_PRODUCT_NAME := 'Sample Item';

DECLARE
   v_total_inv      NUMBER;
   v_prod_code      VARCHAR2(50);
   v_prod_name      VARCHAR2(100);
BEGIN
   v_prod_code := UPPER(:ENTER_PRODUCT_CODE);
   v_prod_name := UPPER(:ENTER_PRODUCT_NAME);
   
   v_total_inv := :ENTER_UNIT_PRICE * :ENTER_INVENTORY;

   DBMS_OUTPUT.PUT_LINE('Product code: ' || v_prod_code);
   DBMS_OUTPUT.PUT_LINE('Product name: ' || v_prod_name);
   DBMS_OUTPUT.PUT_LINE('Unit price: ' || TO_CHAR(:ENTER_UNIT_PRICE, '$999.99'));
   DBMS_OUTPUT.PUT_LINE('Inventory: ' || :ENTER_INVENTORY);
   DBMS_OUTPUT.PUT_LINE('Total dollar inventory: ' || TO_CHAR(v_total_inv, '$999.99'));
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
