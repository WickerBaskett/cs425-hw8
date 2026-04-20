-- DML to load data into the normalized database

USE LIVES3NF;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Violation_Inspection;
TRUNCATE TABLE Violation;
TRUNCATE TABLE Inspection;
TRUNCATE TABLE Business;

INSERT INTO Business
SELECT DISTINCT
	business_id,
	business_name,
	business_address,
	business_city,
	business_state,
	business_zip,
	business_phone
FROM LIVES.FoodInspection;

INSERT INTO Inspection
SELECT DISTINCT
	inspection_id,
	business_id,
	inspection_date,
	inspection_score,
	inspection_description,
	inspection_type
FROM LIVES.FoodInspection;

/*
	In class we learned that violation_code is not the determinant for violation_description
	because a violation_code code can have many different descriptions. This is likely either
	bad data or the description has changed over time.

	There was no easy fix, so to make the model work we removed the ViolationCode table and
	moved violation_description into the Violation table.
*/

-- INSERT INTO ViolationCode
-- SELECT DISTINCT
-- 	violation_code,
-- 	violation_description
-- FROM LIVES.FoodInspection;

INSERT INTO Violation
SELECT DISTINCT
	violation_id,
	violation_code,
	violation_description
FROM LIVES.FoodInspection;

INSERT INTO Violation_Inspection
SELECT DISTINCT
	inspection_id,
	violation_id
FROM LIVES.FoodInspection;

