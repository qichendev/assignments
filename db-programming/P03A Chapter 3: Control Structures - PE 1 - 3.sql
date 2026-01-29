-- Student Name: Qi Chen
-- Student ID: C0944666

-- 1
DECLARE
    v_purchase_amount NUMBER := 1500;
    v_customer_rate VARCHAR2(10);
BEGIN
    IF v_purchase_amount > 3500
        THEN v_customer_rate := 'Gold';
    ELSIF v_purchase_amount BETWEEN 2001 AND 3500
        THEN v_customer_rate := 'Silver';
    ELSIF v_purchase_amount BETWEEN 0 AND 2000
        THEN v_customer_rate := 'Bronze';
    END IF;
    DBMS_OUTPUT.PUT_LINE('The customer is a ' || v_customer_rate || ' member.');
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 2
DECLARE
    v_purchase_amount NUMBER := 3501;
    v_customer_rate VARCHAR2(10);
BEGIN
    CASE
        WHEN v_purchase_amount > 3500
            THEN v_customer_rate := 'Gold';
        WHEN v_purchase_amount BETWEEN 2001 AND 3500
            THEN v_customer_rate := 'Silver';
        WHEN v_purchase_amount BETWEEN 0 AND 2000
            THEN v_customer_rate := 'Bronze';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('The customer is a ' || v_customer_rate || ' member.');
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- 3
DECLARE
    v_START_NN NUMBER := 60;
    v_END_NN NUMBER := 65;
    v_START_MM NUMBER := 100;
    v_END_MMM NUMBER := 110;
BEGIN
    FOR v_outer_count IN v_START_NN..v_END_NN LOOP
        FOR v_inner_count IN v_START_MM..v_END_MMM LOOP
            DBMS_OUTPUT.PUT_LINE(v_outer_count || '-' || v_inner_count);
        END LOOP;
    END LOOP;
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
   DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/