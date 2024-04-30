SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Create Schema, mydb
CREATE SCHEMA IF NOT EXISTS `customersdb` DEFAULT CHARACTER SET utf8;
USE `customersdb`;
-- Create Table for Customer
DROP TABLE IF EXISTS `customersdb`.`Customer` ;
CREATE TABLE IF NOT EXISTS `customersdb`.`Customer` (
  `customer_ID` INT NOT NULL,
  `customer_name` VARCHAR(50) NOT NULL,
  `customer_address` VARCHAR(100) NOT NULL,
  `customer_phone` VARCHAR(50) NOT NULL,
  `customer_email` VARCHAR(50) NOT NULL,
  `customer_DOB` DATE NOT NULL,
  PRIMARY KEY (`customer_ID`))
ENGINE = InnoDB;

-- Create Table for Plan
DROP TABLE IF EXISTS `customersdb`.`Plan` ;
CREATE TABLE IF NOT EXISTS `customersdb`.`Plan` (
  `plan_ID` INT NOT NULL,
  `plan_type` VARCHAR(50) NOT NULL,
  `plan_name` VARCHAR(50) NOT NULL,
  `plan_duration` INT NOT NULL,
  `plan_cost` DECIMAL(10,2) NOT NULL,
  `plan_features` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`plan_ID`))
ENGINE = InnoDB;

-- Create Table for Transaction
DROP TABLE IF EXISTS `customersdb`.`Transaction` ;
CREATE TABLE IF NOT EXISTS `customersdb`.`Transaction` (
  `transaction_ID` INT NOT NULL,
  `customer_ID` INT NOT NULL,
  `plan_ID` INT NOT NULL,
  `transaction_type` VARCHAR(50) NOT NULL,
  `transaction_date` DATE NOT NULL,
  `transaction_amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`transaction_ID`),
  INDEX `customer_ID_idx` (`customer_ID` ASC) VISIBLE,
  INDEX `plan_ID_idx` (`plan_ID` ASC) VISIBLE,
  CONSTRAINT `customer_planfk_ID`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `customersdb`.`Customer` (`customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_planfk_ID`
    FOREIGN KEY (`plan_ID`)
    REFERENCES `customersdb`.`Plan` (`plan_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Create Table for Call_Traffic
DROP TABLE IF EXISTS `customersdb`.`Call_Traffic` ;
CREATE TABLE IF NOT EXISTS `customersdb`.`Call_Traffic` (
  `call_ID` INT NOT NULL,
  `call_date` DATE NOT NULL,
  `call_duration` INT NOT NULL,
  `call_cost` DECIMAL(10,2) NOT NULL,
  `call_type` VARCHAR(45) NOT NULL,
  `customer_ID` INT NOT NULL,
  PRIMARY KEY (`call_ID`),
  INDEX `customer_ID_idx` (`customer_ID` ASC) VISIBLE,
  CONSTRAINT `customer_traffic_ID`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `customersdb`.`Customer` (`customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Create Table for Customer_Plan
DROP TABLE IF EXISTS `customersdb`.`Customer_Plan` ;
CREATE TABLE IF NOT EXISTS `customersdb`.`Customer_Plan` (
  `customer_ID` INT NOT NULL,
  `plan_ID` INT NOT NULL,
  PRIMARY KEY (`customer_ID`, `plan_ID`),
  INDEX `plan_ID_idx` (`plan_ID` ASC) VISIBLE,
  CONSTRAINT `customer_ID`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `customersdb`.`Customer` (`customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_ID`
    FOREIGN KEY (`plan_ID`)
    REFERENCES `customersdb`.`Plan` (`plan_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Create Table for Cancellation
DROP TABLE IF EXISTS `customersdb`.`Cancellation` ;
CREATE TABLE IF NOT EXISTS `customersdb`.`Cancellation` (
  `cancellation_ID` INT NOT NULL,
  `customer_ID` INT NOT NULL,
  `cancellation_date` DATE NOT NULL,
  `cancellation_reason` VARCHAR(500) NULL,
  PRIMARY KEY (`cancellation_ID`),
  INDEX `customer_ID_idx` (`customer_ID` ASC) VISIBLE,
  CONSTRAINT `customer_cancellationfk_ID`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `customersdb`.`Customer` (`customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;