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
