-- student name     : Qi Chen
-- student number   : C0944666

-- 1
SELECT TO_CHAR(rental_fee, '$999,999.99') AS "Fee"
    , slip_code AS "Slip"
    , boat_name AS "Boat Name"
FROM m_marina_slips
WHERE marina_id = 1
    AND slip_length BETWEEN 25 AND 40
    AND rental_fee > 2600
ORDER BY rental_fee DESC;

-- 2
SELECT marina_id AS "MARINA_ID"
    , rental_fee AS "RENTAL_FEE"
    , slip_code AS "SLIP_CODE"
    , boat_name AS "BOAT_NAME"
FROM m_marina_slips
WHERE marina_id = 1 AND rental_fee > 3000
    OR marina_id = 2 AND rental_fee < 4000
ORDER BY marina_id, rental_fee;

-- 3
SELECT marina_id AS "MARINA_ID"
    , slip_length AS "SLIP_LENGTH"
    , boat_name AS "BOAT_NAME"
FROM m_marina_slips
WHERE boat_type IN ('Sprite 4000', 'Sprite 3000', 'Ray 4025')
ORDER BY marina_id, slip_length, boat_name DESC;

-- 4
SELECT boat_name AS "Boat Name"
    , TO_CHAR(rental_fee, '$999,999.99') AS "Old Rental Fee"
    , TO_CHAR(rental_fee * 1.0875, '$999,999.99') AS "New Rental Fee"
FROM m_marina_slips
WHERE rental_fee * 1.0875 > 4000
ORDER BY "New Rental Fee" DESC;

-- 5
SELECT slip_code AS "Slip"
    , TO_CHAR(next_service_date, 'Day, Month DD, YYYY') AS "Next Service"
FROM m_service_requests
WHERE next_service_date > TO_DATE(:ENTER_YEAR || '-01-01', 'YYYY-MM-DD')
ORDER BY slip_code, next_service_date;

-- 6
SELECT marina_id AS "Marina"
    , CASE 
        WHEN rental_fee >= 4200 THEN 'Gold customer'
        WHEN rental_fee BETWEEN 3600 AND 4199 THEN 'Silver customer'
        WHEN rental_fee BETWEEN 2000 AND 3599 THEN 'Bronze customer'
        ELSE 'Not Categorized'
    END AS "Category"
    , TO_CHAR(rental_fee, '$999,999.99') AS "Fee"
    , slip_code AS "Slip"
FROM m_marina_slips
ORDER BY marina_id, "Category", "Fee", slip_code;

-- 7
SELECT boat_name AS "BOAT_NAME"
    , slip_code AS "SLIP_LENGTH"
    , TO_CHAR(FLOOR(rental_fee), '$999,999.99') AS "RENTAL_FEE"
FROM m_marina_slips
WHERE rental_fee >= 3800
ORDER BY boat_name;

-- 8
SELECT slip_code AS "SLIP_CODE"
    , TO_CHAR(est_hours, '999.99') AS "EST_HOURS"
    , TO_CHAR(est_hours * 119.999, '999.99') AS "ESTIMATED_COST"
FROM m_service_requests
WHERE est_hours * 119.999 >= 300
ORDER BY slip_code, "ESTIMATED_COST" DESC;

-- 9
SELECT last_name AS "OWNER_NAME"
FROM m_previous_owners
WHERE LOWER(last_name || first_name) LIKE '%and%'
ORDER BY last_name;

-- 10
SELECT marina_id AS "MARINA_ID", slip_code AS "SLIP_CODE", 
    CASE 
        WHEN boat_name IS NULL THEN 'No boat assigned'
        ELSE boat_name
    END AS "BOAT_NAME"
FROM m_marina_slips
WHERE marina_id IN (1, 3)
ORDER BY marina_id, slip_code DESC;

-- 11
SELECT TO_CHAR(next_service_date, 'Day, Month DD, YYYY') AS "Next service date", slip_code AS "Slip"
FROM m_service_requests
WHERE next_service_date BETWEEN '2025-05-01' AND '2026-04-30'
ORDER BY next_service_date, slip_code;

-- 12
SELECT slip_length AS "SLIP_LENGTH", 
    TO_CHAR(AVG(rental_fee), '999,999.99') AS "AVERAGE_RENTAL_FEE"
FROM m_marina_slips
GROUP BY slip_length
ORDER BY slip_length;

-- 13
SELECT marina_id AS "MARINA_ID", slip_length AS "SLIP_LENGTH", 
    COUNT(*) AS "COUNT", 
    TO_CHAR(SUM(rental_fee), '999,999.99') AS "YEARLY_REVENUE"
FROM m_marina_slips
WHERE marina_id IN (1, 2)
GROUP BY marina_id, slip_length
ORDER BY marina_id;

-- 14
SELECT marina_id AS "MARINA_ID", slip_length AS "SLIP_LENGTH", 
    COUNT(*) AS "COUNT", 
    TO_CHAR(SUM(rental_fee), '999,999.99') AS "YEARLY_REVENUE"
FROM m_marina_slips
WHERE marina_id IN (1, 2)
GROUP BY marina_id, slip_length
HAVING SUM(rental_fee) > 4000
ORDER BY marina_id;
