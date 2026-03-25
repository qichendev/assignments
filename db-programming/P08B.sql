SET SERVEROUTPUT ON
SET VERIFY OFF

PROMPT === P0802 Donor Overload Application ===
CREATE OR REPLACE PACKAGE donor_pkg IS
    PROCEDURE get_donor
    (
        p_donor_id IN gl_donors.donor_id%TYPE,
        p_donor    OUT gl_donors%ROWTYPE
    );

    PROCEDURE get_donor
    (
        p_registration_code IN gl_donors.registration_code%TYPE,
        p_donor             OUT gl_donors%ROWTYPE
    );
END donor_pkg;
/

CREATE OR REPLACE PACKAGE BODY donor_pkg IS
    PROCEDURE get_donor
    (
        p_donor_id IN gl_donors.donor_id%TYPE,
        p_donor    OUT gl_donors%ROWTYPE
    )
    IS
    BEGIN
        SELECT *
          INTO p_donor
          FROM gl_donors
         WHERE donor_id = p_donor_id;
    END get_donor;

    PROCEDURE get_donor
    (
        p_registration_code IN gl_donors.registration_code%TYPE,
        p_donor             OUT gl_donors%ROWTYPE
    )
    IS
    BEGIN
        SELECT *
          INTO p_donor
          FROM gl_donors
         WHERE registration_code = p_registration_code;
    END get_donor;
END donor_pkg;
/

PROMPT Example donor id: 1
PROMPT Example missing donor id: 99
ACCEPT p08b_donor_id NUMBER PROMPT 'Enter donor id: '

DECLARE
    v_donor_id gl_donors.donor_id%TYPE := &p08b_donor_id;
    v_donor    gl_donors%ROWTYPE;
BEGIN
    donor_pkg.get_donor(v_donor_id, v_donor);

    DBMS_OUTPUT.PUT_LINE('Donor name: ' || v_donor.donor_name);
    DBMS_OUTPUT.PUT_LINE('Donor type: ' || v_donor.donor_type);
    DBMS_OUTPUT.PUT_LINE(
        'Pledge amount: ' ||
        TO_CHAR(v_donor.monthly_pledge_amount, 'FM$999,990.00')
    );
    DBMS_OUTPUT.PUT_LINE('Pledge months: ' || TO_CHAR(v_donor.pledge_months));
    DBMS_OUTPUT.PUT_LINE(
        'Total amounts: ' ||
        TO_CHAR(v_donor.monthly_pledge_amount * v_donor.pledge_months, 'FM$999,990.00')
    );
    DBMS_OUTPUT.PUT_LINE(NULL);
    DBMS_OUTPUT.PUT_LINE('Donor request by donor id completed');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Donor not found');
END;
/

PROMPT Example registration code: G1002
ACCEPT p08b_registration_code CHAR PROMPT 'Enter registration code: '

DECLARE
    v_registration_code gl_donors.registration_code%TYPE := UPPER(TRIM('&p08b_registration_code'));
    v_donor             gl_donors%ROWTYPE;
BEGIN
    donor_pkg.get_donor(v_registration_code, v_donor);

    DBMS_OUTPUT.PUT_LINE('Donor name: ' || v_donor.donor_name);
    DBMS_OUTPUT.PUT_LINE('Donor type: ' || v_donor.donor_type);
    DBMS_OUTPUT.PUT_LINE(
        'Pledge amount: ' ||
        TO_CHAR(v_donor.monthly_pledge_amount, 'FM$999,990.00')
    );
    DBMS_OUTPUT.PUT_LINE('Pledge months: ' || TO_CHAR(v_donor.pledge_months));
    DBMS_OUTPUT.PUT_LINE(
        'Total amounts: ' ||
        TO_CHAR(v_donor.monthly_pledge_amount * v_donor.pledge_months, 'FM$999,990.00')
    );
    DBMS_OUTPUT.PUT_LINE(NULL);
    DBMS_OUTPUT.PUT_LINE('Donor request by registration code completed');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Donor not found');
END;
/

PROMPT === P0803 Bodiless Package For Currency Exchange ===
CREATE OR REPLACE PACKAGE currency_exchange_pkg IS
    us_to_can CONSTANT NUMBER := 1.34470;
    can_to_us CONSTANT NUMBER := 0.743731;
    euro_to_us CONSTANT NUMBER := 1.06570;
    us_to_euro CONSTANT NUMBER := 0.938351;
    euro_to_can CONSTANT NUMBER := 1.43287;
    can_to_euro CONSTANT NUMBER := 0.697899;
END currency_exchange_pkg;
/

PROMPT Example conversion type: 1
PROMPT Example currency amount: 1200
ACCEPT p08b_conversion_type NUMBER PROMPT 'Enter conversion type: '
ACCEPT p08b_currency_amount NUMBER PROMPT 'Enter currency amount: '

DECLARE
    v_conversion_type NUMBER := &p08b_conversion_type;
    v_currency_amount NUMBER := &p08b_currency_amount;
    v_converted_amount NUMBER;
    v_from_currency VARCHAR2(30);
    v_to_currency   VARCHAR2(30);
BEGIN
    CASE v_conversion_type
        WHEN 1 THEN
            v_converted_amount := v_currency_amount * currency_exchange_pkg.us_to_can;
            v_from_currency := 'United States dollars';
            v_to_currency := 'Canadian dollars';
        WHEN 2 THEN
            v_converted_amount := v_currency_amount * currency_exchange_pkg.can_to_us;
            v_from_currency := 'Canadian dollars';
            v_to_currency := 'United States dollars';
        WHEN 3 THEN
            v_converted_amount := v_currency_amount * currency_exchange_pkg.euro_to_us;
            v_from_currency := 'Euro';
            v_to_currency := 'United States dollars';
        WHEN 4 THEN
            v_converted_amount := v_currency_amount * currency_exchange_pkg.us_to_euro;
            v_from_currency := 'United States dollars';
            v_to_currency := 'Euro';
        WHEN 5 THEN
            v_converted_amount := v_currency_amount * currency_exchange_pkg.euro_to_can;
            v_from_currency := 'Euro';
            v_to_currency := 'Canadian dollars';
        WHEN 6 THEN
            v_converted_amount := v_currency_amount * currency_exchange_pkg.can_to_euro;
            v_from_currency := 'Canadian dollars';
            v_to_currency := 'Euro';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Invalid conversion type');
    END CASE;

    DBMS_OUTPUT.PUT_LINE(
        TO_CHAR(v_currency_amount, 'FM$999,990.00') || ' ' || v_from_currency ||
        ' = ' || TO_CHAR(v_converted_amount, 'FM$999,990.00') || ' ' || v_to_currency
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
