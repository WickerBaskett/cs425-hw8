/*
    DDL to create PARKSPECIES database
    Elliott R. Lewandowski
    2026-04-20
*/

-- I use erlewandowski here since I dont have permissions to create a new database 
CREATE DATABASE IF NOT EXISTS erlewandowski;

USE erlewandowski;

DROP TABLE IF EXISTS Seasons;
DROP TABLE IF EXISTS ConsStatus;
DROP TABLE IF EXISTS ParkSpecies;
DROP TABLE IF EXISTS CommonNames;
DROP TABLE IF EXISTS SciToFam;
DROP TABLE IF EXISTS FamToOrd;
DROP TABLE IF EXISTS OrdToCat;

CREATE TABLE IF NOT EXISTS OrdToCat (
    `Order`             VARCHAR(32) NOT NULL,
    Category        	VARCHAR(32) NOT NULL,
    PRIMARY KEY (`Order`)
);

CREATE TABLE IF NOT EXISTS FamToOrd (
    Family              VARCHAR(32) NOT NULL,
    `Order`       	VARCHAR(32) ,
    PRIMARY KEY (Family),
    FOREIGN KEY FKOrder (`Order`) REFERENCES OrdToCat(`Order`)
);

CREATE TABLE IF NOT EXISTS SciToFam (
    ScientificName 	VARCHAR(128) NOT NULL,
    Family              VARCHAR(32) NOT NULL,
    PRIMARY KEY (ScientificName),
    FOREIGN KEY FkFamily (Family) REFERENCES FamToOrd(Family)
);

CREATE TABLE IF NOT EXISTS CommonNames (
    CommonName          VARCHAR(128) NOT NULL,
    ScientificName 	VARCHAR(128) NOT NULL,
    PRIMARY KEY (CommonName, ScientificName),
    FOREIGN KEY FKScientificName (ScientificName) REFERENCES SciToFam(ScientificName)
);

CREATE TABLE IF NOT EXISTS ParkSpecies (
    ParkName            VARCHAR(128) NOT NULL,
    ScientificName 	VARCHAR(128) NOT NULL,
    Occurence           VARCHAR(32),
    Nativeness          VARCHAR(16),
    Abundance           VARCHAR(16),
    PRIMARY KEY (ParkName, ScientificName),
    FOREIGN KEY FKScientificName (ScientificName) REFERENCES SciToFam(ScientificName)
);

CREATE TABLE IF NOT EXISTS ConsStatus (
    ParkName            VARCHAR(128) NOT NULL,
    ScientificName 	VARCHAR(128) NOT NULL,
    ConservationStatus  VARCHAR(32),
    PRIMARY KEY (ParkName, ScientificName),
    FOREIGN KEY FKParkName (ParkName, ScientificName) REFERENCES ParkSpecies(ParkName, ScientificName)
);

CREATE TABLE IF NOT EXISTS Seasons (
    ParkName            VARCHAR(128) NOT NULL,
    ScientificName 	VARCHAR(128) NOT NULL,
    Seasonality         VARCHAR(16),
    PRIMARY KEY (ParkName, ScientificName),
    FOREIGN KEY FKParkName (ParkName, ScientificName) REFERENCES ParkSpecies(ParkName, ScientificName)
);
