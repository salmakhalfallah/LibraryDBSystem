-- Dropping and creating the database
DROP DATABASE IF EXISTS LIBRARYSYSTEM;
CREATE DATABASE LIBRARYSYSTEM;

-- Dropping and creating the schema
DROP SCHEMA IF EXISTS LIBRARY;
CREATE SCHEMA LIBRARY;

USE LIBRARY;

-- Drop all tables if they exist
DROP TABLE IF EXISTS EVENTS;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS LOAN;
DROP TABLE IF EXISTS MEMBER;
DROP TABLE IF EXISTS BOOK;
DROP TABLE IF EXISTS CD;
DROP TABLE IF EXISTS ITEM;

-- Create ITEM table
CREATE TABLE ITEM (
  ItemID INT(13) NOT NULL,
  Title VARCHAR(45) NOT NULL,
  Genre SET('Fiction', 'Non-fiction') NOT NULL,
  isAvailable BOOLEAN NOT NULL,
  PRIMARY KEY (ItemID, Title)
);

-- Create BOOK table
CREATE TABLE BOOK (
  ItemID INT(13) NOT NULL,
  Title VARCHAR(45) NOT NULL,
  Publisher VARCHAR(255),
  Author VARCHAR(255),
  PRIMARY KEY (ItemID, Title),
  FOREIGN KEY (ItemID, Title) REFERENCES ITEM(ItemID, Title)
);

-- Create CD table
CREATE TABLE CD (
  ItemID INT(13) NOT NULL,
  Title VARCHAR(45) NOT NULL,
  Director VARCHAR(255),
  starActor VARCHAR(255),
  PRIMARY KEY (ItemID, Title),
  FOREIGN KEY (ItemID, Title) REFERENCES ITEM(ItemID, Title)
);

-- Create MEMBER table
CREATE TABLE MEMBER (
  MemberID INT(6) NOT NULL,
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  Email VARCHAR(255),
  PhoneNumber INT(9),
  PRIMARY KEY (MemberID)
);

-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
  DeptNo INT(2) NOT NULL AUTO_INCREMENT,
  Location SET('First Floor', 'Second Floor', 'Basement'),
  EmployeeCount INT(3) NOT NULL,
  DeptName VARCHAR(255) UNIQUE NOT NULL,
  PRIMARY KEY (DeptNo)
);

-- Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
  EmployeeID INT(6) NOT NULL AUTO_INCREMENT,
  DeptNo INT(2) NOT NULL,
  FirstName VARCHAR(255) NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  Email VARCHAR(255),
  PhoneNumber INT(9),
  Salary INT(9),
  Role SET('Volunteer', 'Librarian', 'Maintenance', 'Manager'),
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (DeptNo) REFERENCES DEPARTMENT(DeptNo)
);

-- Create LOAN table
CREATE TABLE LOAN (
  LoanID INT(10) NOT NULL AUTO_INCREMENT,
  MemberID INT(6) NOT NULL,
  ItemID INT(13) NOT NULL,
  LoanDate DATE,
  DueDate DATE,
  ReturnDate DATE,
  Status BOOLEAN,
  Fine INT(4),
  PRIMARY KEY (LoanID),
  FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID),
  FOREIGN KEY (ItemID) REFERENCES ITEM(ItemID)
);

-- Create EVENTS table
CREATE TABLE EVENTS (
  EventID INT(10) NOT NULL AUTO_INCREMENT,
  SupervisorID INT(6) NOT NULL,
  Title VARCHAR(255),
  Description VARCHAR(255),
  Location SET('First Floor', 'Second Floor', 'Basement'),
  EDate DATE NOT NULL,
  PRIMARY KEY (EventID),
  FOREIGN KEY (SupervisorID) REFERENCES EMPLOYEE(EmployeeID)
);

# Sample Queries 
-- Show count of the largest population (how many books are in the library?)
SELECT COUNT(*) AS TotalBooks FROM BOOK;

-- Show a listing of a key entity in the database (who are the librarians in the library?)
SELECT * FROM EMPLOYEE WHERE Role = 'Librarian';

-- Show a list of entities that must function together (how many librarians work in a specific department?)
SELECT d.DeptName, COUNT(e.EmployeeID) AS NumberOfLibrarians
FROM DEPARTMENT d
JOIN EMPLOYEE e ON d.DeptNo = e.DeptNo
WHERE e.Role = 'Librarian'
GROUP BY d.DeptName;

-- Show a schedule for multiple occurrences, sorted by date and time (when will certain events occur in the library?)
SELECT Title, Location, EDate FROM EVENTS ORDER BY EDate;
