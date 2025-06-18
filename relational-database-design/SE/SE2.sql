
-- SELECT STATEMENTS
-- 1
SELECT m_marinas.marina_name AS MARINA_NAME
    , m_marina_slips.slip_length AS SLIP_LENGTH
    , CASE
        WHEN m_marina_slips.boat_name IS NULL THEN 'No boat assigned'
        ELSE m_marina_slips.boat_name
      END AS BOAT_NAME
    , TO_CHAR(m_marina_slips.rental_fee, '$999,999.00') AS RENTAL_FEE
FROM m_marina_slips
    JOIN m_marinas
    ON m_marina_slips.marina_id = m_marinas.marina_id
ORDER BY m_marinas.marina_name, m_marina_slips.slip_length, m_marina_slips.boat_name;

-- 2
SELECT m_marinas.marina_name AS MARINA_NAME
    , m_owners.first_name || ', ' || m_owners.last_name AS OWNER
    , m_marina_slips.boat_name AS BOAT_NAME
FROM m_marina_slips
    JOIN m_marinas
    ON m_marina_slips.marina_id = m_marinas.marina_id
    JOIN m_owners
    ON m_marina_slips.owner_code = m_owners.owner_code
WHERE m_marina_slips.slip_length >= 30
ORDER BY MARINA_NAME, OWNER;

-- 3
SELECT m_marina_slips.slip_code AS SLIP_CODE
    , m_marina_slips.boat_name AS BOAT_NAME
    , m_owners.last_name AS OWNER
    , m_service_categories.category_description AS SERVICE_CATEGORY
    , m_service_requests.est_hours AS ESTIMATED_HOURS
FROM m_service_requests
    JOIN m_marina_slips
    ON m_service_requests.slip_code = m_marina_slips.slip_code
    JOIN m_owners
    ON m_marina_slips.owner_code = m_owners.owner_code
    JOIN m_service_categories
    ON m_service_requests.category_id = m_service_categories.category_id
WHERE m_service_requests.category_id = 2
ORDER BY m_marina_slips.slip_code;

-- 4
SELECT m_marinas.marina_name AS MARINA_NAME
    , m_marina_slips.slip_code AS SLIP
    , m_owners.last_name AS OWNER
    , m_service_categories.category_description AS CATEGORY
    , m_service_requests.est_hours AS EST
    , m_service_requests.spent_hours AS SPENT
FROM m_service_requests
    JOIN m_marina_slips
    ON m_service_requests.slip_code = m_marina_slips.slip_code
    JOIN m_owners
    ON m_marina_slips.owner_code = m_owners.owner_code
    JOIN m_service_categories
    ON m_service_requests.category_id = m_service_categories.category_id
    JOIN m_marinas
    ON m_marina_slips.marina_id = m_marinas.marina_id
WHERE m_service_categories.category_description IN ('Air conditioning', 'Engine repair')
ORDER BY m_marinas.marina_name, m_marina_slips.slip_code;

-- 5
SELECT
  m_marina_slips.marina_id AS MARINA_ID,
  m_marina_slips.slip_code AS SLIP_CODE,
  CASE 
    WHEN m_marina_slips.boat_name IS NULL THEN 'Slip not rented'
    ELSE m_marina_slips.boat_name
  END AS BOAT_NAME,
  m_owners.first_name || ', ' || m_owners.last_name AS OWNER
FROM m_marina_slips
JOIN m_owners ON m_marina_slips.owner_code = m_owners.owner_code
ORDER BY m_marina_slips.slip_code;

-- 6
SELECT
  s.slip_code AS SLIP_CODE,
  s.boat_name AS BOAT_NAME,
  TO_CHAR(r.est_hours, 'FM9990.00') AS EST,
  TO_CHAR(r.spent_hours, 'FM9990.00') AS SPENT,
  r.category_id || ' - ' || c.category_description AS CATEGORY
FROM m_marina_slips s
LEFT JOIN m_service_requests r
  ON s.slip_code = r.slip_code
LEFT JOIN m_service_categories c
  ON r.category_id = c.category_id
WHERE s.marina_id = 2
ORDER BY s.slip_code, r.category_id;

-- 7
SELECT
  o.last_name || ', ' || o.first_name AS OWNER_NAME,
  o.city AS CITY,
  s.marina_id AS MARINA_ID,
  s.slip_code AS SLIP_CODE,
  TO_CHAR(s.rental_fee, '9,999.00') AS RENTAL_FEE
FROM m_marina_slips s
JOIN m_owners o ON s.owner_code = o.owner_code
WHERE s.rental_fee > (SELECT AVG(rental_fee) FROM m_marina_slips)
ORDER BY OWNER_NAME;

-- 8
SELECT
  s.marina_id AS MARINA_ID,
  s.slip_code AS SLIP_CODE,
  o.first_name || ' ' || o.last_name AS OWNER_NAME,
  o.city AS CITY,
  TO_CHAR(s.rental_fee, '9,999.00') AS RENTAL_FEE
FROM m_marina_slips s
JOIN m_owners o ON s.owner_code = o.owner_code
WHERE s.rental_fee > (
    SELECT AVG(s2.rental_fee)
    FROM m_marina_slips s2
    WHERE s2.marina_id = s.marina_id
)
ORDER BY s.marina_id, s.slip_code;

-- 9
CREATE OR REPLACE VIEW T2V AS
SELECT
  o.city AS CITY,
  o.last_name || ', ' || o.first_name AS OWNER,
  s.boat_name AS BOAT_NAME,
  s.slip_length AS LENGTH,
  s.rental_fee AS RENTAL_FEE
FROM m_marina_slips s
JOIN m_owners o ON s.owner_code = o.owner_code
WHERE s.marina_id = 2
  AND s.rental_fee > 1800.00;

SELECT * FROM T2V;

-- 10
SELECT
  OWNER,
  BOAT_NAME,
  TO_CHAR(RENTAL_FEE, '$9,999.00') AS RENTAL_FEE
FROM T2V
WHERE LENGTH > 25
ORDER BY OWNER DESC;

-- 11
SELECT
  o.last_name || ', ' || o.first_name AS OWNER,
  s.boat_name AS BOAT_NAME,
  TO_CHAR(s.rental_fee, '$9,999.00') AS RENTAL_FEE
FROM m_marina_slips s
JOIN m_owners o ON s.owner_code = o.owner_code
WHERE s.marina_id = 2
  AND s.rental_fee > 1800.00
  AND s.slip_length > 25
ORDER BY OWNER DESC;

-- 12
CREATE OR REPLACE VIEW v_slips40 AS
SELECT
  marina_id,
  slip_code,
  rental_fee,
  boat_name,
  owner_code
FROM m_marina_slips
WHERE slip_length = 40;

SELECT * FROM v_slips40;

-- 13
SELECT
  o.first_name || ' ' || o.last_name AS OWNER,
  v.boat_name AS BOAT_NAME,
  TO_CHAR(v.rental_fee, '$9,999.00') AS RENTAL_FEE
FROM v_slips40 v
JOIN m_owners o ON v.owner_code = o.owner_code;
