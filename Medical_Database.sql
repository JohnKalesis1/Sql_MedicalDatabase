-- MySQL Script generated by MySQL Workbench
-- Πεμ 01 Απρ 2021 08:14:37 μμ EEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hospital` (
  `Address` VARCHAR(45) NOT NULL,
  `Phone Number` VARCHAR(45) NOT NULL,
  `Town` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Vaccination Center` TINYINT NOT NULL,
  PRIMARY KEY (`Address`, `Phone Number`, `Town`, `Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical Ward`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical Ward` (
  `Specialization` VARCHAR(45) NOT NULL,
  `Hospital_Address` VARCHAR(45) NOT NULL,
  `Hospital_Phone Number` VARCHAR(45) NOT NULL,
  `Hospital_Town` VARCHAR(45) NOT NULL,
  `Hospital_Name` VARCHAR(45) NOT NULL,
  `Number of Total Beds` INT NOT NULL,
  `Number of Patients Hospitalized` INT NOT NULL,
  `Number of Rooms` INT NOT NULL,
  `Covid_specialized` TINYINT NOT NULL,
  PRIMARY KEY (`Specialization`, `Hospital_Address`, `Hospital_Phone Number`, `Hospital_Town`, `Hospital_Name`),
  INDEX `fk_Medical Ward_Hospital_idx` (`Hospital_Address` ASC, `Hospital_Phone Number` ASC, `Hospital_Town` ASC, `Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Medical Ward_Hospital`
    FOREIGN KEY (`Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    REFERENCES `mydb`.`Hospital` (`Address` , `Phone Number` , `Town` , `Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `AMKA` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Age` INT NOT NULL,
  `Date of Birth` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AMKA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IMCU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IMCU` (
  `UniqueId` INT NOT NULL,
  `Hospital_Address` VARCHAR(45) NOT NULL,
  `Hospital_Phone Number` VARCHAR(45) NOT NULL,
  `Hospital_Town` VARCHAR(45) NOT NULL,
  `Hospital_Name` VARCHAR(45) NOT NULL,
  `Number of Rooms` INT NOT NULL,
  PRIMARY KEY (`UniqueId`, `Hospital_Address`, `Hospital_Phone Number`, `Hospital_Town`, `Hospital_Name`),
  INDEX `fk_ICMR_Hospital1_idx` (`Hospital_Address` ASC, `Hospital_Phone Number` ASC, `Hospital_Town` ASC, `Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_ICMR_Hospital1`
    FOREIGN KEY (`Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    REFERENCES `mydb`.`Hospital` (`Address` , `Phone Number` , `Town` , `Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hospitalized`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hospitalized` (
  `Room Number` INT NOT NULL,
  `Number of beds` VARCHAR(45) NOT NULL,
  `Medical Ward_Specialization` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Address` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Phone Number` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Town` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Name` VARCHAR(45) NULL,
  `Person_AMKA` INT NOT NULL,
  `Symptoms of Patient` VARCHAR(45) NULL,
  `People Patient Came Into Contact With` VARCHAR(45) NULL,
  `Medication` VARCHAR(45) NOT NULL,
  `IMCU_UniqueId` INT NULL,
  `IMCU_Hospital_Address` VARCHAR(45) NULL,
  `IMCU_Hospital_Phone Number` VARCHAR(45) NULL,
  `IMCU_Hospital_Town` VARCHAR(45) NULL,
  `IMCU_Hospital_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Room Number`, `Medical Ward_Specialization`, `Medical Ward_Hospital_Address`, `Medical Ward_Hospital_Phone Number`, `Medical Ward_Hospital_Town`, `Medical Ward_Hospital_Name`, `Person_AMKA`, `IMCU_UniqueId`, `IMCU_Hospital_Address`, `IMCU_Hospital_Phone Number`, `IMCU_Hospital_Town`, `IMCU_Hospital_Name`),
  INDEX `fk_Room_Medical Ward1_idx` (`Medical Ward_Specialization` ASC, `Medical Ward_Hospital_Address` ASC, `Medical Ward_Hospital_Phone Number` ASC, `Medical Ward_Hospital_Town` ASC, `Medical Ward_Hospital_Name` ASC) VISIBLE,
  INDEX `fk_Room_Person1_idx` (`Person_AMKA` ASC) VISIBLE,
  INDEX `fk_Hospitalized_IMCU1_idx` (`IMCU_UniqueId` ASC, `IMCU_Hospital_Address` ASC, `IMCU_Hospital_Phone Number` ASC, `IMCU_Hospital_Town` ASC, `IMCU_Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Medical Ward1`
    FOREIGN KEY (`Medical Ward_Specialization` , `Medical Ward_Hospital_Address` , `Medical Ward_Hospital_Phone Number` , `Medical Ward_Hospital_Town` , `Medical Ward_Hospital_Name`)
    REFERENCES `mydb`.`Medical Ward` (`Specialization` , `Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_Person1`
    FOREIGN KEY (`Person_AMKA`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospitalized_IMCU1`
    FOREIGN KEY (`IMCU_UniqueId` , `IMCU_Hospital_Address` , `IMCU_Hospital_Phone Number` , `IMCU_Hospital_Town` , `IMCU_Hospital_Name`)
    REFERENCES `mydb`.`IMCU` (`UniqueId` , `Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`is_a_Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`is_a_Doctor` (
  `Specialization` VARCHAR(45) NOT NULL,
  `Person_AMKA` INT NOT NULL,
  `Hospital_Address` VARCHAR(45) NOT NULL,
  `Hospital_Phone Number` VARCHAR(45) NOT NULL,
  `Hospital_Town` VARCHAR(45) NOT NULL,
  `Hospital_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Specialization`, `Person_AMKA`, `Hospital_Address`, `Hospital_Phone Number`, `Hospital_Town`, `Hospital_Name`),
  INDEX `fk_is_a_Doctor_Person1_idx` (`Person_AMKA` ASC) VISIBLE,
  INDEX `fk_is_a_Doctor_Hospital1_idx` (`Hospital_Address` ASC, `Hospital_Phone Number` ASC, `Hospital_Town` ASC, `Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_is_a_Doctor_Person1`
    FOREIGN KEY (`Person_AMKA`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_is_a_Doctor_Hospital1`
    FOREIGN KEY (`Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    REFERENCES `mydb`.`Hospital` (`Address` , `Phone Number` , `Town` , `Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor_Works`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor_Works` (
  `Medical Ward_Specialization` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Address` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Phone Number` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Town` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Name` VARCHAR(45) NULL,
  `is_a_Doctor_Specialization` VARCHAR(45) NOT NULL,
  `is_a_Doctor_Person_AMKA` INT NOT NULL,
  `IMCU_UniqueId` INT NULL,
  `IMCU_Hospital_Address` VARCHAR(45) NULL,
  `IMCU_Hospital_Phone Number` VARCHAR(45) NULL,
  `IMCU_Hospital_Town` VARCHAR(45) NULL,
  `IMCU_Hospital_Name` VARCHAR(45) NULL,
  `Day of week` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Medical Ward_Specialization`, `Medical Ward_Hospital_Address`, `Medical Ward_Hospital_Phone Number`, `Medical Ward_Hospital_Town`, `Medical Ward_Hospital_Name`, `is_a_Doctor_Specialization`, `is_a_Doctor_Person_AMKA`, `IMCU_UniqueId`, `IMCU_Hospital_Address`, `IMCU_Hospital_Phone Number`, `IMCU_Hospital_Town`, `IMCU_Hospital_Name`),
  INDEX `fk_Medical Ward_has_is_a_Doctor_is_a_Doctor1_idx` (`is_a_Doctor_Specialization` ASC, `is_a_Doctor_Person_AMKA` ASC) VISIBLE,
  INDEX `fk_Medical Ward_has_is_a_Doctor_Medical Ward1_idx` (`Medical Ward_Specialization` ASC, `Medical Ward_Hospital_Address` ASC, `Medical Ward_Hospital_Phone Number` ASC, `Medical Ward_Hospital_Town` ASC, `Medical Ward_Hospital_Name` ASC) VISIBLE,
  INDEX `fk_Doctor_Works_IMCU1_idx` (`IMCU_UniqueId` ASC, `IMCU_Hospital_Address` ASC, `IMCU_Hospital_Phone Number` ASC, `IMCU_Hospital_Town` ASC, `IMCU_Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Medical Ward_has_is_a_Doctor_Medical Ward1`
    FOREIGN KEY (`Medical Ward_Specialization` , `Medical Ward_Hospital_Address` , `Medical Ward_Hospital_Phone Number` , `Medical Ward_Hospital_Town` , `Medical Ward_Hospital_Name`)
    REFERENCES `mydb`.`Medical Ward` (`Specialization` , `Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medical Ward_has_is_a_Doctor_is_a_Doctor1`
    FOREIGN KEY (`is_a_Doctor_Specialization` , `is_a_Doctor_Person_AMKA`)
    REFERENCES `mydb`.`is_a_Doctor` (`Specialization` , `Person_AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Works_IMCU1`
    FOREIGN KEY (`IMCU_UniqueId` , `IMCU_Hospital_Address` , `IMCU_Hospital_Phone Number` , `IMCU_Hospital_Town` , `IMCU_Hospital_Name`)
    REFERENCES `mydb`.`IMCU` (`UniqueId` , `Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person_Visits_Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person_Visits_Hospital` (
  `Hospital_Address` VARCHAR(45) NOT NULL,
  `Hospital_Phone Number` VARCHAR(45) NOT NULL,
  `Hospital_Town` VARCHAR(45) NOT NULL,
  `Hospital_Name` VARCHAR(45) NOT NULL,
  `Person_AMKA` INT NOT NULL,
  `Day of Visit` VARCHAR(45) NOT NULL,
  `is_a_Doctor_Specialization` VARCHAR(45) NOT NULL,
  `is_a_Doctor_Person_AMKA` INT NOT NULL,
  PRIMARY KEY (`Hospital_Address`, `Hospital_Phone Number`, `Hospital_Town`, `Hospital_Name`, `Person_AMKA`, `is_a_Doctor_Specialization`, `is_a_Doctor_Person_AMKA`),
  INDEX `fk_Hospital_has_Person_Person1_idx` (`Person_AMKA` ASC) VISIBLE,
  INDEX `fk_Hospital_has_Person_Hospital1_idx` (`Hospital_Address` ASC, `Hospital_Phone Number` ASC, `Hospital_Town` ASC, `Hospital_Name` ASC) VISIBLE,
  INDEX `fk_Person_Visits_Hospital_is_a_Doctor1_idx` (`is_a_Doctor_Specialization` ASC, `is_a_Doctor_Person_AMKA` ASC) VISIBLE,
  CONSTRAINT `fk_Hospital_has_Person_Hospital1`
    FOREIGN KEY (`Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    REFERENCES `mydb`.`Hospital` (`Address` , `Phone Number` , `Town` , `Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospital_has_Person_Person1`
    FOREIGN KEY (`Person_AMKA`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_Visits_Hospital_is_a_Doctor1`
    FOREIGN KEY (`is_a_Doctor_Specialization` , `is_a_Doctor_Person_AMKA`)
    REFERENCES `mydb`.`is_a_Doctor` (`Specialization` , `Person_AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Production Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Production Company` (
  `Manufacturer_ID` INT NOT NULL,
  PRIMARY KEY (`Manufacturer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Storage Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Storage Company` (
  `Company ID` INT NOT NULL,
  PRIMARY KEY (`Company ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vaccine Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vaccine Type` (
  `EMA ID` INT NOT NULL,
  `Vaccine Name` VARCHAR(45) NOT NULL,
  `Number of Doses` INT NOT NULL,
  `Date of Approval` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EMA ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vaccine Batch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vaccine Batch` (
  `Production Company_Manufacturer_ID` INT NOT NULL,
  `Date of Manifacturing` VARCHAR(45) NOT NULL,
  `Amount of Vaccines` INT NOT NULL,
  `Country of Export` VARCHAR(45) NOT NULL,
  `Vaccine Type_EMA ID` INT NOT NULL,
  PRIMARY KEY (`Production Company_Manufacturer_ID`, `Vaccine Type_EMA ID`),
  INDEX `fk_Storage Company_has_Production Company_Production Compan_idx` (`Production Company_Manufacturer_ID` ASC) VISIBLE,
  INDEX `fk_Vaccine Batch_Vaccine Type1_idx` (`Vaccine Type_EMA ID` ASC) VISIBLE,
  CONSTRAINT `fk_Storage Company_has_Production Company_Production Company1`
    FOREIGN KEY (`Production Company_Manufacturer_ID`)
    REFERENCES `mydb`.`Production Company` (`Manufacturer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vaccine Batch_Vaccine Type1`
    FOREIGN KEY (`Vaccine Type_EMA ID`)
    REFERENCES `mydb`.`Vaccine Type` (`EMA ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Examination Center`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Examination Center` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone Number` VARCHAR(45) NOT NULL,
  `Vaccination Center` TINYINT NOT NULL,
  PRIMARY KEY (`Name`, `Address`, `Email`, `Phone Number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Has_an_Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Has_an_Exam` (
  `Person_AMKA` INT NOT NULL,
  `IMCU_UniqueId` INT NULL,
  `IMCU_Hospital_Address` VARCHAR(45) NULL,
  `IMCU_Hospital_Phone Number` VARCHAR(45) NULL,
  `IMCU_Hospital_Town` VARCHAR(45) NULL,
  `IMCU_Hospital_Name` VARCHAR(45) NULL,
  `Medical Ward_Specialization` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Address` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Phone Number` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Town` VARCHAR(45) NULL,
  `Medical Ward_Hospital_Name` VARCHAR(45) NULL,
  `Exam Type` VARCHAR(45) NOT NULL,
  `Exam Result` VARCHAR(45) NOT NULL,
  `Date of Exam` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Person_AMKA`, `IMCU_UniqueId`, `IMCU_Hospital_Address`, `IMCU_Hospital_Phone Number`, `IMCU_Hospital_Town`, `IMCU_Hospital_Name`, `Medical Ward_Specialization`, `Medical Ward_Hospital_Address`, `Medical Ward_Hospital_Phone Number`, `Medical Ward_Hospital_Town`, `Medical Ward_Hospital_Name`),
  INDEX `fk_Person_has_IMCU_IMCU1_idx` (`IMCU_UniqueId` ASC, `IMCU_Hospital_Address` ASC, `IMCU_Hospital_Phone Number` ASC, `IMCU_Hospital_Town` ASC, `IMCU_Hospital_Name` ASC) VISIBLE,
  INDEX `fk_Person_has_IMCU_Person1_idx` (`Person_AMKA` ASC) VISIBLE,
  INDEX `fk_Person_has_IMCU_Medical Ward1_idx` (`Medical Ward_Specialization` ASC, `Medical Ward_Hospital_Address` ASC, `Medical Ward_Hospital_Phone Number` ASC, `Medical Ward_Hospital_Town` ASC, `Medical Ward_Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Person_has_IMCU_Person1`
    FOREIGN KEY (`Person_AMKA`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_IMCU_IMCU1`
    FOREIGN KEY (`IMCU_UniqueId` , `IMCU_Hospital_Address` , `IMCU_Hospital_Phone Number` , `IMCU_Hospital_Town` , `IMCU_Hospital_Name`)
    REFERENCES `mydb`.`IMCU` (`UniqueId` , `Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_IMCU_Medical Ward1`
    FOREIGN KEY (`Medical Ward_Specialization` , `Medical Ward_Hospital_Address` , `Medical Ward_Hospital_Phone Number` , `Medical Ward_Hospital_Town` , `Medical Ward_Hospital_Name`)
    REFERENCES `mydb`.`Medical Ward` (`Specialization` , `Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COVID_Test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COVID_Test` (
  `Person_AMKA` INT NOT NULL,
  `Examination Center_Name` VARCHAR(45) NULL,
  `Examination Center_Address` VARCHAR(45) NULL,
  `Examination Center_Email` VARCHAR(45) NULL,
  `Examination Center_Phone Number` VARCHAR(45) NULL,
  `Hospital_Address` VARCHAR(45) NULL,
  `Hospital_Phone Number` VARCHAR(45) NULL,
  `Hospital_Town` VARCHAR(45) NULL,
  `Hospital_Name` VARCHAR(45) NULL,
  `Date of Test` VARCHAR(45) NOT NULL,
  `Test Result` TINYINT NOT NULL,
  `Type of Test` VARCHAR(45) NOT NULL,
  `Test ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Person_AMKA`, `Examination Center_Name`, `Examination Center_Address`, `Examination Center_Email`, `Examination Center_Phone Number`, `Hospital_Address`, `Hospital_Phone Number`, `Hospital_Town`, `Hospital_Name`),
  INDEX `fk_Person_has_Examination Center_Examination Center1_idx` (`Examination Center_Name` ASC, `Examination Center_Address` ASC, `Examination Center_Email` ASC, `Examination Center_Phone Number` ASC) VISIBLE,
  INDEX `fk_Person_has_Examination Center_Person1_idx` (`Person_AMKA` ASC) VISIBLE,
  INDEX `fk_Person_has_Examination Center_Hospital1_idx` (`Hospital_Address` ASC, `Hospital_Phone Number` ASC, `Hospital_Town` ASC, `Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Person_has_Examination Center_Person1`
    FOREIGN KEY (`Person_AMKA`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Examination Center_Examination Center1`
    FOREIGN KEY (`Examination Center_Name` , `Examination Center_Address` , `Examination Center_Email` , `Examination Center_Phone Number`)
    REFERENCES `mydb`.`Examination Center` (`Name` , `Address` , `Email` , `Phone Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Examination Center_Hospital1`
    FOREIGN KEY (`Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    REFERENCES `mydb`.`Hospital` (`Address` , `Phone Number` , `Town` , `Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COVID_Vaccination`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COVID_Vaccination` (
  `Person_AMKA` INT NOT NULL,
  `Examination Center_Name` VARCHAR(45) NULL,
  `Examination Center_Address` VARCHAR(45) NULL,
  `Examination Center_Email` VARCHAR(45) NULL,
  `Examination Center_Phone Number` VARCHAR(45) NULL,
  `Hospital_Address` VARCHAR(45) NULL,
  `Hospital_Phone Number` VARCHAR(45) NULL,
  `Hospital_Town` VARCHAR(45) NULL,
  `Hospital_Name` VARCHAR(45) NULL,
  `Vaccine Type_EMA ID` INT NOT NULL,
  `Dates of Doses` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Person_AMKA`, `Examination Center_Name`, `Examination Center_Address`, `Examination Center_Email`, `Examination Center_Phone Number`, `Hospital_Address`, `Hospital_Phone Number`, `Hospital_Town`, `Hospital_Name`, `Vaccine Type_EMA ID`),
  INDEX `fk_Person_has_Examination Center_Examination Center2_idx` (`Examination Center_Name` ASC, `Examination Center_Address` ASC, `Examination Center_Email` ASC, `Examination Center_Phone Number` ASC) VISIBLE,
  INDEX `fk_Person_has_Examination Center_Person2_idx` (`Person_AMKA` ASC) VISIBLE,
  INDEX `fk_Person_has_Examination Center_Hospital2_idx` (`Hospital_Address` ASC, `Hospital_Phone Number` ASC, `Hospital_Town` ASC, `Hospital_Name` ASC) VISIBLE,
  INDEX `fk_Person_has_Examination Center_Vaccine Type1_idx` (`Vaccine Type_EMA ID` ASC) VISIBLE,
  CONSTRAINT `fk_Person_has_Examination Center_Person2`
    FOREIGN KEY (`Person_AMKA`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Examination Center_Examination Center2`
    FOREIGN KEY (`Examination Center_Name` , `Examination Center_Address` , `Examination Center_Email` , `Examination Center_Phone Number`)
    REFERENCES `mydb`.`Examination Center` (`Name` , `Address` , `Email` , `Phone Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Examination Center_Hospital2`
    FOREIGN KEY (`Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    REFERENCES `mydb`.`Hospital` (`Address` , `Phone Number` , `Town` , `Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Examination Center_Vaccine Type1`
    FOREIGN KEY (`Vaccine Type_EMA ID`)
    REFERENCES `mydb`.`Vaccine Type` (`EMA ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stores_Vaccines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stores_Vaccines` (
  `Vaccine Batch_Production Company_Manufacturer_ID` INT NOT NULL,
  `Vaccine Batch_Vaccine Type_EMA ID` INT NOT NULL,
  `Storage Company_Company ID` INT NOT NULL,
  `Storage Instructions` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Vaccine Batch_Production Company_Manufacturer_ID`, `Vaccine Batch_Vaccine Type_EMA ID`, `Storage Company_Company ID`),
  INDEX `fk_Vaccine Batch_has_Storage Company_Storage Company1_idx` (`Storage Company_Company ID` ASC) VISIBLE,
  INDEX `fk_Vaccine Batch_has_Storage Company_Vaccine Batch1_idx` (`Vaccine Batch_Production Company_Manufacturer_ID` ASC, `Vaccine Batch_Vaccine Type_EMA ID` ASC) VISIBLE,
  CONSTRAINT `fk_Vaccine Batch_has_Storage Company_Vaccine Batch1`
    FOREIGN KEY (`Vaccine Batch_Production Company_Manufacturer_ID` , `Vaccine Batch_Vaccine Type_EMA ID`)
    REFERENCES `mydb`.`Vaccine Batch` (`Production Company_Manufacturer_ID` , `Vaccine Type_EMA ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vaccine Batch_has_Storage Company_Storage Company1`
    FOREIGN KEY (`Storage Company_Company ID`)
    REFERENCES `mydb`.`Storage Company` (`Company ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplies_Vaccines_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplies_Vaccines_to` (
  `Examination Center_Name` VARCHAR(45) NULL,
  `Examination Center_Address` VARCHAR(45) NULL,
  `Examination Center_Email` VARCHAR(45) NULL,
  `Examination Center_Phone Number` VARCHAR(45) NULL,
  `Storage Company_Company ID` INT NOT NULL,
  `Hospital_Address` VARCHAR(45) NULL,
  `Hospital_Phone Number` VARCHAR(45) NULL,
  `Hospital_Town` VARCHAR(45) NULL,
  `Hospital_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Examination Center_Name`, `Examination Center_Address`, `Examination Center_Email`, `Examination Center_Phone Number`, `Storage Company_Company ID`, `Hospital_Address`, `Hospital_Phone Number`, `Hospital_Town`, `Hospital_Name`),
  INDEX `fk_Examination Center_has_Storage Company_Storage Company1_idx` (`Storage Company_Company ID` ASC) VISIBLE,
  INDEX `fk_Examination Center_has_Storage Company_Examination Cente_idx` (`Examination Center_Name` ASC, `Examination Center_Address` ASC, `Examination Center_Email` ASC, `Examination Center_Phone Number` ASC) VISIBLE,
  INDEX `fk_Supplies_Vaccines_to_Hospital1_idx` (`Hospital_Address` ASC, `Hospital_Phone Number` ASC, `Hospital_Town` ASC, `Hospital_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Examination Center_has_Storage Company_Examination Center1`
    FOREIGN KEY (`Examination Center_Name` , `Examination Center_Address` , `Examination Center_Email` , `Examination Center_Phone Number`)
    REFERENCES `mydb`.`Examination Center` (`Name` , `Address` , `Email` , `Phone Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examination Center_has_Storage Company_Storage Company1`
    FOREIGN KEY (`Storage Company_Company ID`)
    REFERENCES `mydb`.`Storage Company` (`Company ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supplies_Vaccines_to_Hospital1`
    FOREIGN KEY (`Hospital_Address` , `Hospital_Phone Number` , `Hospital_Town` , `Hospital_Name`)
    REFERENCES `mydb`.`Hospital` (`Address` , `Phone Number` , `Town` , `Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Came_In_Contact_With`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Came_In_Contact_With` (
  `Patient` INT NOT NULL,
  `Possible_Infected` INT NOT NULL,
  PRIMARY KEY (`Patient`, `Possible_Infected`),
  INDEX `fk_Person_has_Person_Person2_idx` (`Possible_Infected` ASC) VISIBLE,
  INDEX `fk_Person_has_Person_Person1_idx` (`Patient` ASC) VISIBLE,
  CONSTRAINT `fk_Person_has_Person_Person1`
    FOREIGN KEY (`Patient`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Person_Person2`
    FOREIGN KEY (`Possible_Infected`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical Event` (
  `Date of Event` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Person_AMKA` INT NOT NULL,
  PRIMARY KEY (`Date of Event`, `Description`, `Person_AMKA`),
  INDEX `fk_Medical Event_Person1_idx` (`Person_AMKA` ASC) VISIBLE,
  CONSTRAINT `fk_Medical Event_Person1`
    FOREIGN KEY (`Person_AMKA`)
    REFERENCES `mydb`.`Person` (`AMKA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;