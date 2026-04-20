/*
    DDL to create PARKSPECIES database
    Elliott R. Lewandowski
    2026-04-20
*/

CREATE DATABASE IF NOT EXISTS PARKSPECIES;

USE PARKSPECIES;

CREATE TABLE IF NOT EXISTS ParkSpecies (
    ParkName            VARCHAR(46) NOT NULL,
    ScientificName 	VARCHAR(69) NOT NULL,
    Occurence           VARCHAR(31),
    Nativeness          VARCHAR(13),
    Abundance           VARCHAR(10),
    PRIMARY KEY (ParkName, ScientificName)
);

CREATE TABLE IF NOT EXISTS ConsStatus (
    ParkName            VARCHAR(46) NOT NULL,
    ScientificName 	VARCHAR(69) NOT NULL,
    ConservationStatus  VARCHAR(19),
    PRIMARY KEY (ParkName, ScientificName)
);

CREATE TABLE IF NOT EXISTS Seasons (
    ParkName            VARCHAR(46) NOT NULL,
    ScientificName 	VARCHAR(69) NOT NULL,
    Seasonality         VARCHAR(10),
    PRIMARY KEY (ParkName, ScientificName)
);

CREATE TABLE IF NOT EXISTS CommonNames (
    CommonName          VARCHAR(60) NOT NULL,
    ScientificName 	VARCHAR(69) NOT NULL,
    PRIMARY KEY (CommonName)
);

CREATE TABLE IF NOT EXISTS SciToFam (
    ScientificName 	VARCHAR(69) NOT NULL,
    Family              VARCHAR(20),
    PRIMARY KEY (ScientificName)
);


CREATE TABLE IF NOT EXISTS FamToOrd (
    Family              VARCHAR(20) NOT NULL,
    Order        	VARCHAR(20) NOT NULL,
    PRIMARY KEY (Family)
);

CREATE TABLE IF NOT EXISTS OrdToCat (
    Order               VARCHAR(20) NOT NULL,
    Category        	VARCHAR(19) NOT NULL,
    PRIMARY KEY (Order)
);
