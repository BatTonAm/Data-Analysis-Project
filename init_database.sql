/*
Create Databases and Schemas
Check if existed database named 'DataWarehouse', then drop the database and recreate new database, else create database named 'DataWarehouse'
Create 3 layer namely bronze, silver, gold schemas for database

*/


USE MASTER;
GO

-- Drop and recreate 'DataWarehouse' database
IF EXISTS(SELECT 1 FROM sys.databases WHERE NAME='DataWarehouse')
BEGIN
Alter DATABASE DataWarehouse Set SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE DataWarehouse
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Create 3 layer SCHEMAS;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO