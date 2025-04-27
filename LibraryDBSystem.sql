# removing librarysystem if exists already in system and creating a new one
DROP DATABASE IF EXISTS LIBRARYSYSTEM;
CREATE DATABASE LIBRARYSYSTEM;

# creating a new library schema
DROP SCHEMA IF EXISTS LIBRARY;
CREATE SCHEMA LIBRARY;


USE LIBRARY;
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

DROP TABLE IF EXISTS BOOK;
CREATE TABLE BOOK (
  ItemID DECIMAL(13) NOT NULL,       
  Title VARCHAR(45) NOT NULL,    
  Publisher VARCHAR(255),         
  Author VARCHAR(255),            
  PRIMARY KEY (ItemID, Title), 
  FOREIGN KEY (ItemID, Title) REFERENCES ITEM(ItemID, Title) 
);

DROP TABLE IF EXISTS CD;
CREATE TABLE CD (
  ItemID DECIMAL(13) NOT NULL,        
  Title VARCHAR(45) NOT NULL,    
  Director VARCHAR(255),         
  starActor VARCHAR(255),         
  PRIMARY KEY (ItemID, Title), 
  FOREIGN KEY (ItemID, Title) REFERENCES ITEM(ItemID, Title) 
);



# Creating Member Table
DROP TABLE IF EXISTS MEMBER;
CREATE TABLE MEMBER (
  MemberID INT(6) NOT NULL,       
  FirstName VARCHAR(255),         
  LastName VARCHAR(255),          
  Email VARCHAR(255),             
  PhoneNumber INT(9),             
  PRIMARY KEY (MemberID)        
);


# Creating Loan Table
DROP TABLE IF EXISTS LOAN;
CREATE TABLE LOAN (
  LoanID INT(10) NOT NULL AUTO_INCREMENT,   
  MemberID INT(6) NOT NULL,                 
  ItemID DECIMAL(13) NOT NULL,                
  LoanDate DATE,                            
  DueDate DATE,                             
  PRIMARY KEY (LoanID),                     
  FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID),  
  FOREIGN KEY (ItemID) REFERENCES ITEM(ItemID)        
);



# creating EMPLOYEE table
DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE (
EmployeeID INT(6) UNIQUE NOT NULL AUTO_INCREMENT,
DeptNo INT(2) NOT NULL,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255) NOT NULL,
Email VARCHAR(255),
PhoneNumber INT(9),
Salary INT(9),
Role SET('Volunteer', 'Librarian', 'Maintenance', 'Manager'),

FOREIGN KEY (DeptNo) REFERENCES DEPARTMENT(DeptNo),
PRIMARY KEY (EmployeeID)

);


# creating DEPARTMENT table

DROP TABLE IF EXISTS DEPARTMENT;
CREATE TABLE DEPARTMENT (
DeptNo INT(2) UNIQUE NOT NULL AUTO_INCREMENT,
Location SET('First Floor', 'Second Floor', 'Basement'),
EmployeeCount INT(3) NOT NULL,
DeptName VARCHAR(255) UNIQUE NOT NULL,

PRIMARY KEY (DeptNo)
);


# creating EVENTS table 
DROP TABLE IF EXISTS EVENTS;
CREATE TABLE EVENTS (
EventID INT(10) UNIQUE NOT NULL AUTO_INCREMENT,
SupervisorID INT(6) UNIQUE NOT NULL,
Title VARCHAR(255),
Location SET('First Floor', 'Second Floor', 'Basement'),
EDate DATE NOT NULL,

PRIMARY KEY (EventID),
CONSTRAINT FK_SupervisorID FOREIGN KEY (SupervisorID) REFERENCES EMPLOYEE(EmployeeID)
);


