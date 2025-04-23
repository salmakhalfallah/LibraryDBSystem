# removing librarysystem if exists already in system and creating a new one
DROP DATABASE IF EXISTS LIBRARYSYSTEM;
CREATE DATABASE LIBRARYSYSTEM;

# creating a new library schema
DROP SCHEMA IF EXISTS LIBRARY;
CREATE SCHEMA LIBRARY;


USE LIBRARYSYSTEM;
SHOW TABLES;

# creating item table
DROP TABLE IF EXISTS ITEM;
CREATE TABLE ITEM(

itemID	DECIMAL(13) UNIQUE NOT NULL,
title	VARCHAR(45) NOT NULL,
genre	SET('Fiction', 'Non-fiction') NOT NULL,
isAvailable	BOOLEAN NOT NULL,

PRIMARY KEY Lib_Item (itemID, title)
);

# Creating book and cd tables
CREATE TABLE Book (
  ItemID DECIMAL(13) NOT NULL,       
  Title VARCHAR(45) NOT NULL,    
  Publisher VARCHAR(255),         
  Author VARCHAR(255),            
  PRIMARY KEY (ItemID, Title), 
  FOREIGN KEY (ItemID, Title) REFERENCES Item(ItemID, Title) 
);

CREATE TABLE CD (
  ItemID DECIMAL(13) NOT NULL,        
  Title VARCHAR(45) NOT NULL,    
  Director VARCHAR(255),         
  starActor VARCHAR(255),         
  PRIMARY KEY (ItemID, Title), 
  FOREIGN KEY (ItemID, Title) REFERENCES Item(ItemID, Title) 
);

# Creating Member Table
CREATE TABLE Member (
  MemberID INT(6) NOT NULL,       
  FirstName VARCHAR(255),         
  LastName VARCHAR(255),          
  Email VARCHAR(255),             
  PhoneNumber INT(9),             
  PRIMARY KEY (MemberID)        
);

# Creating Loan Table
CREATE TABLE Loan (
  LoanID INT(10) NOT NULL AUTO_INCREMENT,   
  MemberID INT(6) NOT NULL,                 
  ItemID DECIMAL(13) NOT NULL,                
  LoanDate DATE,                            
  DueDate DATE,                             
  PRIMARY KEY (LoanID),                     
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID),  
  FOREIGN KEY (ItemID) REFERENCES Item(ItemID)        
);

