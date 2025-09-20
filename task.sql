DROP DATABASE IF EXISTS ShopDB;
CREATE DATABASE ShopDB;
USE ShopDB;

CREATE TABLE Streets(
	ID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Cities(
	ID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	StreetID INT,
	FOREIGN KEY (StreetID) REFERENCES Streets(ID) ON DELETE SET NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX idx_Cities_StreetID ON Cities(StreetID);

CREATE TABLE Countries (
    ID INT AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES Cities(ID) ON DELETE SET NULL,
    PRIMARY KEY (ID)
);
CREATE INDEX idx_Countries_CityID ON Countries(CityID);

CREATE TABLE Products(
	ID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE ProductInventory(
	ID INT AUTO_INCREMENT,
	WarehouseName VARCHAR(50) NOT NULL,
	ProductID INT,
	FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE SET NULL,
	WarehouseAmount INT,
	CountryID INT,
	FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX idx_ProductInventory_ProductID ON ProductInventory(ProductID);
CREATE INDEX idx_ProductInventory_CountryID ON ProductInventory(CountryID);

INSERT INTO Streets (Name) VALUES ('Street-1');
SET @Street1ID = LAST_INSERT_ID();
INSERT INTO Streets (Name) VALUES ('Street-2');
SET @Street2ID = LAST_INSERT_ID();
INSERT INTO Cities (Name, StreetID) 
	VALUES ('City-1', @Street1ID);
SET @City1ID = LAST_INSERT_ID();
INSERT INTO Cities (Name, StreetID) 
	VALUES ('City-2', @Street2ID);
SET @City2ID = LAST_INSERT_ID();
INSERT INTO Countries (Name, CityID) 
	VALUES ('Country1', @City1ID);
SET @Country1ID = LAST_INSERT_ID();
INSERT INTO Countries (Name, CityID) 
	VALUES ('Country2', @City2ID);
SET @Country2ID = LAST_INSERT_ID();

INSERT INTO Products (Name) 
	VALUES ('AwesomeProduct');
SET @Product1ID = LAST_INSERT_ID();

INSERT INTO ProductInventory (WarehouseName, ProductID, WarehouseAmount, CountryID) 
VALUES
('Warehouse-1', @Product1ID, 2, @Country1ID),
('Warehouse-2', @Product1ID, 5, @Country2ID);
