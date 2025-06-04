SELECT 
  c.category_id || ' ' || c.category_description AS CATEGORY,
  s.service_id || ' ' || s.service_description AS SERVICE,
  s.price AS PRICE
FROM 
  p_categories c
JOIN 
  p_services s ON c.category_id = s.category_id
ORDER BY 
  c.category_id, s.service_id;

SELECT 
  car.model_year AS MODEL_YEAR,
  car.car_make AS CAR_MAKE,
  po.first_name || ' ' || po.last_name AS PREVIOUS_OWNER
FROM 
  p_cars car
JOIN 
  p_previous_owners po ON car.previous_owner_id = po.owner_id
WHERE 
  car.model_year = 2015
ORDER BY 
  car.model_year;

SELECT 
  d.dealer_name AS DEALER_NAME,
  car.car_make AS CAR_MAKE,
  po.first_name || ' ' || po.last_name AS PREVIOUS_OWNER
FROM 
  p_cars car
JOIN 
  p_dealers d ON car.dealer_id = d.dealer_id
JOIN 
  p_previous_owners po ON car.previous_owner_id = po.owner_id
WHERE 
  d.dealer_name IN ('Bayside Autos', 'Eastside Better Used Cars')
ORDER BY 
  d.dealer_name, car.car_make, PREVIOUS_OWNER;

SELECT 
  car.model_year || ' ' || car.car_make AS CAR,
  TO_CHAR(car.date_acquired, 'Month DD, YYYY') AS ACQUIRED,
  po.first_name || ' ' || po.last_name AS PREVIOUS_OWNER
FROM 
  p_cars car
JOIN 
  p_previous_owners po ON car.previous_owner_id = po.owner_id
WHERE 
  EXTRACT(YEAR FROM car.date_acquired) = 2023
ORDER BY 
  CAR;

SELECT 
  car.model_year || ' ' || car.car_make || ' ' || car.car_id AS CAR,
  CASE 
    WHEN po.owner_id IS NOT NULL THEN po.first_name || ' ' || po.last_name
    ELSE 'No previous owner on record.'
  END AS PREVIOUS_OWNER
FROM 
  p_cars car
LEFT JOIN 
  p_previous_owners po ON car.previous_owner_id = po.owner_id
WHERE 
  EXTRACT(YEAR FROM car.date_acquired) = 2024
ORDER BY 
  CAR;

SELECT 
  d.dealer_name AS DEALER_NAME,
  EXTRACT(YEAR FROM c.date_acquired) AS YEAR,
  TO_CHAR(SUM(c.acquired_price), 'FM$999,999.00') AS INVENTORY_VALUE
FROM 
  p_cars c
JOIN 
  p_dealers d ON c.dealer_id = d.dealer_id
WHERE 
  c.dealer_id IN (120, 206)
GROUP BY 
  d.dealer_name, EXTRACT(YEAR FROM c.date_acquired)
ORDER BY 
  d.dealer_name, YEAR;