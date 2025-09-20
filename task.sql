DROP DATABASE IF EXISTS ShopDB;
CREATE DATABASE ShopDB;
USE ShopDB;

CREATE TABLE Countries (
    ID INT AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Cities(
	ID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	CountryID INT,
	FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX idx_Cities_CountryID ON Cities(CountryID);


CREATE TABLE Streets(
	ID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	CityID INT,
	FOREIGN KEY (CityID) REFERENCES Cities(ID) ON DELETE SET NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX idx_Streets_CityID ON Streets(CityID);

CREATE TABLE Products(
	ID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Warehouses(
	ID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	CountryID INT,
	FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX idx_Warehouses_CountryID ON Warehouses(CountryID);

CREATE TABLE ProductInventory(
	ID INT AUTO_INCREMENT,
	ProductID INT,
	FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE SET NULL,
	WarehouseAmount INT,
	WarehouseID INT,
	FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID) ON DELETE SET NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX idx_ProductInventory_ProductID ON ProductInventory(ProductID);

INSERT INTO Countries (Name) VALUES ('Country1');
SET @Country1ID = LAST_INSERT_ID();
INSERT INTO Countries (Name) VALUES ('Country2');
SET @Country2ID = LAST_INSERT_ID();

INSERT INTO Cities (Name, CountryID) VALUES ('City-1', @Country1ID);
SET @City1ID = LAST_INSERT_ID();
INSERT INTO Cities (Name, CountryID) VALUES ('City-2', @Country2ID);
SET @City2ID = LAST_INSERT_ID();

INSERT INTO Streets (Name, CityID) VALUES ('Street-1', @City1ID);
SET @Street1ID = LAST_INSERT_ID();
INSERT INTO Streets (Name, CityID) VALUES ('Street-2', @City2ID);
SET @Street2ID = LAST_INSERT_ID();

INSERT INTO Products (Name) VALUES ('AwesomeProduct');
SET @Product1ID = LAST_INSERT_ID();

INSERT INTO Warehouses (Name, CountryID) VALUES ('Warehouse-1', @Country1ID);
SET @Warehouse1ID = LAST_INSERT_ID();
INSERT INTO Warehouses (Name, CountryID) VALUES ('Warehouse-2', @Country2ID);
SET @Warehouse2ID = LAST_INSERT_ID();

INSERT INTO ProductInventory (ProductID, WarehouseAmount, WarehouseID) 
VALUES
(@Product1ID, 2, @Warehouse1ID),
(@Product1ID, 5, @Warehouse2ID);
