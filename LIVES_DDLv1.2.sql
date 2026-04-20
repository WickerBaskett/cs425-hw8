/*
	DDL to create LIVES database

	This example creates the PKs and FKs in the CREATE TABLE
	statement.
*/

-- DROP DATABASE IF EXISTS LIVES3NF; -- use to nuke everything first
CREATE DATABASE IF NOT EXISTS LIVES3NF;

USE LIVES3NF;

/*
	Do this if you want to delete all tables before recreating them.

	Note that the tables need to be dropped in the correct order or
	you will get a SQL runtime error due to foreign key dependecy.
	Typically it is easiest to drop them in the reverse order they were
	created.
*/
DROP TABLE IF EXISTS Violation_Inspection;
DROP TABLE IF EXISTS Violation;
DROP TABLE IF EXISTS ViolationCode;
DROP TABLE IF EXISTS Inspection;
DROP TABLE IF EXISTS Business;

CREATE TABLE IF NOT EXISTS Business (
	business_id				VARCHAR(9) NOT NULL,
	business_name			VARCHAR(72),
	business_address		VARCHAR(40),
	business_city			VARCHAR(13),
	business_state			VARCHAR(2),
	business_zip			DECIMAL(38,0),
	business_phone			VARCHAR(16),
	PRIMARY KEY (business_id)
);

CREATE TABLE IF NOT EXISTS Inspection (
	inspection_id			VARCHAR(9) NOT NULL,
	business_id				VARCHAR(9),
	inspection_date			VARCHAR(16),
	incpection_score		INT,
	inspection_description	VARCHAR(44),
	inspection_type			VARCHAR(19),
	PRIMARY KEY (inspection_id),
	FOREIGN KEY fk_business_id (business_id) REFERENCES Business(business_id)
);

/*
	Changes in V1.2

	In class we learned that violation_code is not the determinant for violation_description
	because a violation_code code can have many different descriptions. This is likely either
	bad data or the description has changed over time.

	There was no easy fix, so to make the model work we removed the ViolationCode table and
	moved violation_description into the Violation table.

	This is not an optimal design because of redundancy and data anomalies, but without
	understanding whey the different descriptions exist we cannot address the root problem.
*/

-- CREATE TABLE IF NOT EXISTS ViolationCode (
-- 	violation_code			VARCHAR(4) NOT NULL,
-- 	violation_description	VARCHAR(97) NOT NULL,
-- 	PRIMARY KEY (violation_code)
-- );

-- moved violation description here
CREATE TABLE IF NOT EXISTS Violation (
	violation_id			VARCHAR(9) NOT NULL,
	violation_code			VARCHAR(4) NOT NULL,
	violation_description	VARCHAR(97) NOT NULL,
	PRIMARY KEY (violation_id)
--	FOREIGN KEY fv_violation_code (violation_code) REFERENCES ViolationCode(violation_code)
);

CREATE TABLE IF NOT EXISTS Violation_Inspection (
	inspection_id		VARCHAR(9) NOT NULL,
	violation_id		VARCHAR(9) NOT NULL,
	PRIMARY KEY (inspection_id, violation_id),
	FOREIGN KEY fk_inspection (inspection_id) REFERENCES Inspection(inspection_id),
	FOREIGN KEY fk_violation (violation_id) REFERENCES Violation(violation_id)
);

