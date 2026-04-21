/*
    DML to populate PARKSPECIES database
    Elliott R. Lewandowski
    2026-04-20
*/

USE erlewandowski;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE ConsStatus;
TRUNCATE TABLE Seasons;
TRUNCATE TABLE ParkSpecies;
TRUNCATE TABLE CommonNames;
TRUNCATE TABLE SciToFam;
TRUNCATE TABLE FamToOrd;
TRUNCATE TABLE OrdToCat;

INSERT INTO OrdToCat
SELECT DISTINCT
	`Order`,
	MAX(Category)
FROM erlewandowski.Species
WHERE `Order` IS NOT NULL;
