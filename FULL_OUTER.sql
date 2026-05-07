CREATE TABLE cars (
  id    INTEGER PRIMARY KEY,
  model TEXT    NOT NULL,
  price REAL    NOT NULL
);

INSERT INTO cars VALUES
  (1,'Toyota Corolla',22000),
  (2,'Honda Civic',24000),
  (3,'Ford Focus',19000),
  (4,'Tesla Model 3',42000);

CREATE TABLE drivers (
  id     INTEGER PRIMARY KEY,
  name   TEXT    NOT NULL,
  car_id INTEGER,
  FOREIGN KEY (car_id) REFERENCES cars(id)
);

INSERT INTO drivers VALUES
  (1,'Dana',1),
  (2,'Omar',2),
  (3,'Noa',NULL),
  (4,'Liam',3),
  (5,'Rina',NULL);

-- 1. Write a FULL OUTER JOIN to show all drivers and all cars in one result set

SELECT
  COALESCE(d.name,'— no driver assigned —') AS driver_name,
  coalesce(c.model, '- no car assigned -') AS car_model
FROM   drivers d
FULL OUTER JOIN cars c ON d.car_id = c.id
-- 2. From the full-outer result, find only the unmatched rows on EITHER side — drivers with no car AND cars with no driver — add a WHERE clause
WHERE c.id IS NULL OR d.id IS NULL;

-- 3. Use COALESCE to replace NULL car prices with 0 for drivers who have no car assigned

SELECT
  COALESCE(d.name,'— no driver assigned —') AS driver_name,
  coalesce(c.price, 0) AS car_price
FROM   drivers d
FULL OUTER JOIN cars c ON d.car_id = c.id

-- should i use left join here? if so then here's the code:

-- LEFT JOIN cars c ON d.car_id = c.id


-- 4. Which single join type lets you find drivers WITHOUT a car AND cars WITHOUT a driver in one query?
 -- The answer is: FULL OUTER JOIN, because its the ONLY one that lets you take unmatched rows from both tables, after you can filter it with where (q2).
