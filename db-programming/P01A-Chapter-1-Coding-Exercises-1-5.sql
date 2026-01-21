-- 1.
SELECT TO_CHAR(LAST_DAY(SYSDATE), 'YYYY-MM-DD') FROM DUAL;
/

-- 2.
DECLARE
   v_salary DECIMAL(10, 2) := 7500.00;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Salary: ' || TO_CHAR(v_salary, 'FM$999,999,999.99'));
END;
/

-- 3.
DECLARE
   v_book_type VARCHAR(100) := 'fiction';
BEGIN
   DBMS_OUTPUT.PUT_LINE('The book type is ' || v_book_type);
END;
/

-- 4.
DECLARE
   v_text VARCHAR(15);
BEGIN
    v_text := 'PL/SQL is easy';
   DBMS_OUTPUT.PUT_LINE(v_text);
END;
/

-- 5.
DECLARE
    TAX_RATE CONSTANT NUMBER(5, 2) := 0.18;
    v_gross_pay NUMBER(10, 2) := 6000.00;
    H1 VARCHAR(100) := TO_CHAR('Gross Pay: ' || TO_CHAR(v_gross_pay, 'FM$999,999,990.00'));
    H2 VARCHAR(100) := TO_CHAR('Tax (18%): ' || TO_CHAR(v_gross_pay * TAX_RATE, 'FM$999,999,990.00'));
    H3 VARCHAR(100) := TO_CHAR(LPAD('Net Pay: ', LENGTH('Gross Pay: '), ' ') || TO_CHAR(v_gross_pay - (v_gross_pay * TAX_RATE), 'FM$999,999,990.00'));
BEGIN
   DBMS_OUTPUT.PUT_LINE(H1);
   DBMS_OUTPUT.PUT_LINE(H2);
   DBMS_OUTPUT.PUT_LINE(H3);
END;
/