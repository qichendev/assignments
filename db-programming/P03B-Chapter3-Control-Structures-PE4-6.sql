-- Student Name: Qi Chen
-- Student ID: C0944666

-- PE4: P0304 CASE Statement
-- The shipping department determines shipping costs based on the number of items ordered and club membership status.
SET SERVEROUTPUT ON;

DECLARE
    v_membership_status CHAR(1) := UPPER(:ENTER_MEMBERSHIP_STATUS);
    v_quantity_ordered NUMBER := :ENTER_QUANTITY_ORDERED;
    v_shipping_cost NUMBER(10, 2);
BEGIN
    CASE
        WHEN v_quantity_ordered BETWEEN 0 AND 3 THEN
            v_shipping_cost := CASE v_membership_status WHEN 'Y' THEN 3.00 ELSE 5.00 END;
        WHEN v_quantity_ordered BETWEEN 4 AND 6 THEN
            v_shipping_cost := CASE v_membership_status WHEN 'Y' THEN 5.00 ELSE 7.50 END;
        WHEN v_quantity_ordered BETWEEN 7 AND 10 THEN
            v_shipping_cost := CASE v_membership_status WHEN 'Y' THEN 7.00 ELSE 10.00 END;
        WHEN v_quantity_ordered > 10 THEN
            v_shipping_cost := CASE v_membership_status WHEN 'Y' THEN 9.00 ELSE 12.00 END;
        ELSE
            v_shipping_cost := 0;
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Membership status: ' || v_membership_status);
    DBMS_OUTPUT.PUT_LINE('Quantity ordered: ' || v_quantity_ordered);
    DBMS_OUTPUT.PUT_LINE('Shipping cost =   $' || TO_CHAR(v_shipping_cost, 'FM90.00'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- PE5: P0305 FOR LOOP
-- Our company provides interest-free loans up to 10,000.00 to our employees.
-- They want to generate a payment schedule.
DECLARE
    v_loan_amount NUMBER := :ENTER_LOAN_AMOUNT;
    v_loan_payment NUMBER := :ENTER_LOAN_PAYMENT;
    v_num_payments NUMBER;
    v_current_balance NUMBER;
BEGIN
    v_num_payments := FLOOR(v_loan_amount / v_loan_payment);
    v_current_balance := v_loan_amount;

    DBMS_OUTPUT.PUT_LINE('Loan Amount:   $' || TO_CHAR(v_loan_amount, 'FM9,990.00'));
    DBMS_OUTPUT.PUT_LINE('  Loan Payment:   $' || TO_CHAR(v_loan_payment, 'FM9,990.00'));
    DBMS_OUTPUT.PUT_LINE('Equal Payments: ' || v_num_payments);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Payment#       Balance');
    DBMS_OUTPUT.PUT_LINE('--------       -------');

    for i in 1..v_num_payments loop
        v_current_balance := v_current_balance - v_loan_payment;
        DBMS_OUTPUT.PUT_LINE(LPAD(i, 8) || '       ' || LPAD(TO_CHAR(v_current_balance, 'FM9,990.00'), 7));
    end loop;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Outstanding balance: $' || TO_CHAR(v_current_balance, 'FM9,990.00'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/

-- PE6: P0306 Nested CASE and %ROWTYPE
-- Accessing the DONORS table to calculate matching pledge amounts.
DECLARE
    -- Constants for donor types
    C_TYPE_IND CONSTANT CHAR(1) := 'I';
    C_TYPE_BUS CONSTANT CHAR(1) := 'B';
    C_TYPE_GRA CONSTANT CHAR(1) := 'G';
    
    -- Constants for Individual rates
    C_I_RATE_HIGH CONSTANT NUMBER := 0.50; -- 100-249
    C_I_RATE_MID  CONSTANT NUMBER := 0.30; -- 250-499
    C_I_RATE_LOW  CONSTANT NUMBER := 0.20; -- >= 500
    
    -- Constants for Business rates
    C_B_RATE_HIGH CONSTANT NUMBER := 0.20; -- 100-499
    C_B_RATE_MID  CONSTANT NUMBER := 0.10; -- 500-999
    C_B_RATE_LOW  CONSTANT NUMBER := 0.05; -- >= 1000
    
    -- Constants for Grant rates
    C_G_RATE_LOW  CONSTANT NUMBER := 0.05; -- >= 100
    
    -- Variables
    v_donor_id gl_donors.donor_id%TYPE := :ENTER_DONOR_ID;
    v_donor_rec gl_donors%ROWTYPE;
    v_total_pledge NUMBER;
    v_match_pct NUMBER := 0;
    v_match_amount NUMBER;
    v_donor_type_desc VARCHAR2(30);
BEGIN
    -- Fetch donor record
    SELECT * INTO v_donor_rec FROM gl_donors WHERE donor_id = v_donor_id;
    
    -- Calculate total pledge
    v_total_pledge := v_donor_rec.monthly_pledge_amount * v_donor_rec.pledge_months;
    
    -- Nested CASE to determine matching percentage
    v_match_pct := CASE v_donor_rec.donor_type
        WHEN C_TYPE_IND THEN
            CASE
                WHEN v_total_pledge >= 500 THEN C_I_RATE_LOW
                WHEN v_total_pledge >= 250 THEN C_I_RATE_MID
                WHEN v_total_pledge >= 100 THEN C_I_RATE_HIGH
                ELSE 0
            END
        WHEN C_TYPE_BUS THEN
            CASE
                WHEN v_total_pledge >= 1000 THEN C_B_RATE_LOW
                WHEN v_total_pledge >= 500 THEN C_B_RATE_MID
                WHEN v_total_pledge >= 100 THEN C_B_RATE_HIGH
                ELSE 0
            END
        WHEN C_TYPE_GRA THEN
            CASE
                WHEN v_total_pledge >= 100 THEN C_G_RATE_LOW
                ELSE 0
            END
        ELSE 0
    END;
    
    -- Descriptive donor type
    v_donor_type_desc := CASE v_donor_rec.donor_type
        WHEN C_TYPE_IND THEN 'Individual'
        WHEN C_TYPE_BUS THEN 'Business organization'
        WHEN C_TYPE_GRA THEN 'Grant funds'
        ELSE 'Unknown'
    END;
    
    -- Calculate match amount (rounded up)
    v_match_amount := CEIL(v_total_pledge * v_match_pct);
    
    -- Output results
    DBMS_OUTPUT.PUT_LINE('Donor pledge for ' || v_donor_rec.donor_name);
    DBMS_OUTPUT.PUT_LINE('    Donor type: ' || v_donor_type_desc);
    DBMS_OUTPUT.PUT_LINE('Amount pledged: $' || TO_CHAR(v_total_pledge, 'FM99,990.00'));
    DBMS_OUTPUT.PUT_LINE('  Match amount: $' || TO_CHAR(v_match_amount, 'FM99,990.00'));
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No donor found with ID ' || v_donor_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
