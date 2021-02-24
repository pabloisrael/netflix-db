-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `netflix` ;
USE `netflix` ;

-- -----------------------------------------------------
-- Table `netflix`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`accounts` (
  `email` VARCHAR(256) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `cellphone` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `id_UNIQUE` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`activities` (
  `timestamp` DATETIME NOT NULL,
  `ip` VARCHAR(45) NOT NULL,
  `device_type` VARCHAR(45) NOT NULL,
  `account_email` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`timestamp`, `ip`, `device_type`, `account_email`),
  UNIQUE INDEX `activities_UNIQUE` (`timestamp` ASC, `device_type` ASC, `ip` ASC, `account_email` ASC),
  INDEX `account_email_activities_idx` (`account_email` ASC),
  CONSTRAINT `account_email_activities`
    FOREIGN KEY (`account_email`)
    REFERENCES `netflix`.`accounts` (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`chapters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`chapters` (
  `title` VARCHAR(256) NOT NULL,
  `ref_title` VARCHAR(256) NOT NULL,
  `ref_material_title` VARCHAR(256) NOT NULL,
  `ref_type` VARCHAR(45) NOT NULL,
  `duration` INT NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`title`, `ref_title`, `ref_type`, `ref_material_title`),
  UNIQUE INDEX `chapters_UNIQUE` (`title` ASC, `ref_type` ASC, `ref_title` ASC, `ref_material_title` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`materials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`materials` (
  `title` VARCHAR(256) NOT NULL,
  `year` INT NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`title`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`coincidences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`coincidences` (
  `material_title_1` VARCHAR(256) NOT NULL,
  `material_title_2` VARCHAR(256) NOT NULL,
  `similarity` INT NOT NULL,
  PRIMARY KEY (`material_title_1`, `material_title_2`),
  UNIQUE INDEX `material_title_1_material_title_2_UNIQUE` (`material_title_1` ASC, `material_title_2` ASC),
  INDEX `material_title_2_coincidences_idx` (`material_title_2` ASC),
  CONSTRAINT `material_title_1_coincidences`
    FOREIGN KEY (`material_title_1`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `material_title_2_coincidences`
    FOREIGN KEY (`material_title_2`)
    REFERENCES `netflix`.`materials` (`title`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`people` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`creators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`creators` (
  `material_title` VARCHAR(256) NOT NULL,
  `people_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`material_title`, `people_name`),
  UNIQUE INDEX `material_title_people_name_UNIQUE` (`material_title` ASC, `people_name` ASC),
  INDEX `people_name_creators_idx` (`people_name` ASC),
  CONSTRAINT `material_title_creators`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `people_name_creators`
    FOREIGN KEY (`people_name`)
    REFERENCES `netflix`.`people` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`directors` (
  `material_title` VARCHAR(256) NOT NULL,
  `people_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`material_title`, `people_name`),
  UNIQUE INDEX `material_title_people_name_UNIQUE` (`material_title` ASC, `people_name` ASC),
  INDEX `people_name_directors_idx` (`people_name` ASC),
  CONSTRAINT `material_title_directors`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `people_name_directors`
    FOREIGN KEY (`people_name`)
    REFERENCES `netflix`.`people` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`genres` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`profiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`profiles` (
  `name` VARCHAR(256) NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `language` VARCHAR(256) NOT NULL,
  `subtitle_preference` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`email`, `name`),
  UNIQUE INDEX `email_name_UNIQUE` (`email` ASC, `name` ASC),
  INDEX `email_INDEX` (`email` ASC),
  INDEX `name_INDEX` (`name` ASC),
  CONSTRAINT `email_profiles`
    FOREIGN KEY (`email`)
    REFERENCES `netflix`.`accounts` (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`favourite_genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`favourite_genres` (
  `genre_name` VARCHAR(45) NOT NULL,
  `profile_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`genre_name`, `profile_name`),
  UNIQUE INDEX `genre_name_profile_name_UNIQUE` (`genre_name` ASC, `profile_name` ASC),
  INDEX `profile_name_favourite_genres_idx` (`profile_name` ASC),
  INDEX `genre_name_favourite_genres_idx` (`genre_name` ASC),
  CONSTRAINT `genre_name_favourite_genres`
    FOREIGN KEY (`genre_name`)
    REFERENCES `netflix`.`genres` (`name`),
  CONSTRAINT `profile_name_favourite_genres`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `netflix`.`genres_materials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`genres_materials` (
  `genre_name` VARCHAR(45) NOT NULL,
  `material_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`genre_name`, `material_title`),
  UNIQUE INDEX `genre_name_material_title_UNIQUE` (`genre_name` ASC, `material_title` ASC),
  INDEX `material_title_genres_materials_idx` (`material_title` ASC),
  INDEX `genre_name_genres_materials_idx` (`genre_name` ASC),
  CONSTRAINT `genre_name_genres_materials`
    FOREIGN KEY (`genre_name`)
    REFERENCES `netflix`.`genres` (`name`),
  CONSTRAINT `material_title_genres_materials`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
                                     
                                     
-- -----------------------------------------------------
-- Table `netflix`.`film_ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`film_ratings` (
  `ref_title` VARCHAR(256) NOT NULL,
  `ref_type` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ref_title`, `ref_type`),
  UNIQUE INDEX `film_ratings_UNIQUE` (`ref_type` ASC, `ref_title` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`filmmakers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`filmmakers` (
  `material_title` VARCHAR(256) NOT NULL,
  `people_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`material_title`, `people_name`),
  UNIQUE INDEX `material_title_people_name_UNIQUE` (`material_title` ASC, `people_name` ASC),
  INDEX `people_name_filmmakers_idx` (`people_name` ASC),
  CONSTRAINT `material_title_filmmakers`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `people_name_filmmakers`
    FOREIGN KEY (`people_name`)
    REFERENCES `netflix`.`people` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`interpreters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`interpreters` (
  `material_title` VARCHAR(256) NOT NULL,
  `people_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`material_title`, `people_name`),
  UNIQUE INDEX `material_title_people_name_UNIQUE` (`material_title` ASC, `people_name` ASC),
  INDEX `people_name_interpreters_idx` (`people_name` ASC),
  CONSTRAINT `material_title_interpreters`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `people_name_interpreters`
    FOREIGN KEY (`people_name`)
    REFERENCES `netflix`.`people` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`invoices` (
  `period` DATETIME NOT NULL,
  `account_email` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`period`, `account_email`),
  UNIQUE INDEX `period_account_email_UNIQUE` (`period` ASC, `account_email` ASC),
  INDEX `acount_email_invoices_idx` (`account_email` ASC),
  CONSTRAINT `acount_email_invoices`
    FOREIGN KEY (`account_email`)
    REFERENCES `netflix`.`accounts` (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`likes` (
  `material_title` VARCHAR(256) NOT NULL,
  `profile_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`, `profile_name`),
  UNIQUE INDEX `material_title_profile_name_UNIQUE` (`material_title` ASC, `profile_name` ASC),
  INDEX `profile_name_likes_idx` (`profile_name` ASC),
  CONSTRAINT `material_title_likes`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `profile_name_likes`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`materials_profiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`materials_profiles` (
  `material_title` VARCHAR(256) NOT NULL,
  `profile_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`, `profile_name`),
  UNIQUE INDEX `material_title_profile_name_UNIQUE` (`material_title` ASC, `profile_name` ASC),
  INDEX `profile_name_materials_profiles_idx` (`profile_name` ASC),
  CONSTRAINT `material_title_materials_profiles`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `profile_name_materials_profiles`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`tags` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`materials_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`materials_tags` (
  `tag_name` VARCHAR(45) NOT NULL,
  `material_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`tag_name`, `material_title`),
  UNIQUE INDEX `tag_name_material_title_UNIQUE` (`tag_name` ASC, `material_title` ASC),
  INDEX `material_title_materials_tags_idx` (`material_title` ASC),
  CONSTRAINT `material_title_materials_tags`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `tag_name_materials_tags`
    FOREIGN KEY (`tag_name`)
    REFERENCES `netflix`.`tags` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`miniseries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`miniseries` (
  `material_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`),
  UNIQUE INDEX `material_title_UNIQUE` (`material_title` ASC),
  CONSTRAINT `material_title_miniseries`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`movies` (
  `material_title` VARCHAR(256) NOT NULL,
  `duration` INT NOT NULL,
  PRIMARY KEY (`material_title`),
  UNIQUE INDEX `material_title_UNIQUE` (`material_title` ASC),
  CONSTRAINT `material_title_movies`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`payment_informations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`payment_informations` (
  `email` VARCHAR(256) NOT NULL,
  `card_number` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `expiration_date` DATETIME NOT NULL,
  `cvv` INT NOT NULL,
  PRIMARY KEY (`email`, `card_number`),
  UNIQUE INDEX `email_card_number_UNIQUE` (`email` ASC, `card_number` ASC),
  CONSTRAINT `email_payment_informations`
    FOREIGN KEY (`email`)
    REFERENCES `netflix`.`accounts` (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`payments` (
  `invoice_period` DATETIME NOT NULL,
  `card_first_name` VARCHAR(45) NOT NULL,
  `card_last_name` VARCHAR(45) NOT NULL,
  `last_four_digits` INT NOT NULL,
  `account_email` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`invoice_period`, `card_first_name`, `card_last_name`, `last_four_digits`, `account_email`),
  UNIQUE INDEX `payments_UNIQUE` (`invoice_period` ASC, `card_first_name` ASC, `card_last_name` ASC, `last_four_digits` ASC, `account_email` ASC),
  INDEX `account_email_payments_idx` (`account_email` ASC),
  CONSTRAINT `account_email_payments`
    FOREIGN KEY (`account_email`)
    REFERENCES `netflix`.`accounts` (`email`),
  CONSTRAINT `invoice_period_payments`
    FOREIGN KEY (`invoice_period`)
    REFERENCES `netflix`.`invoices` (`period`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`plans` (
  `name` VARCHAR(45) NOT NULL,
  `connection_numbers` INT NOT NULL,
  `device_numbers` INT NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`playbacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`playbacks` (
  `profile_name` VARCHAR(256) NOT NULL,
  `ref_title` VARCHAR(256) NOT NULL,
  `ref_type` VARCHAR(45) NOT NULL,
  `ref_material_title` VARCHAR(256) NOT NULL,
  `minutes` INT NOT NULL,
  PRIMARY KEY (`profile_name`, `ref_title`, `ref_type`),
  UNIQUE INDEX `playbacks_UNIQUE` (`profile_name` ASC, `ref_type` ASC, `ref_title` ASC, `ref_material_title` ASC),
  INDEX `profile_name_playbacks_idx` (`profile_name` ASC),
  CONSTRAINT `profile_name_playbacks`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`recommendations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`recommendations` (
  `material_title` VARCHAR(256) NOT NULL,
  `profile_name` VARCHAR(256) NOT NULL,
  `similarity` INT NOT NULL,
  PRIMARY KEY (`material_title`, `profile_name`),
  UNIQUE INDEX `material_title_profile_name_UNIQUE` (`material_title` ASC, `profile_name` ASC),
  INDEX `profile_name_recommendations_idx` (`profile_name` ASC),
  CONSTRAINT `material_title_recommendations`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `profile_name_recommendations`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`screenwriters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`screenwriters` (
  `material_title` VARCHAR(256) NOT NULL,
  `people_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`material_title`, `people_name`),
  UNIQUE INDEX `material_title_people_name_UNIQUE` (`material_title` ASC, `people_name` ASC),
  INDEX `people_name_screenwriters_idx` (`people_name` ASC),
  CONSTRAINT `material_title_screenwriters`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`),
  CONSTRAINT `people_name_screenwriters`
    FOREIGN KEY (`people_name`)
    REFERENCES `netflix`.`people` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`series` (
  `material_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`),
  UNIQUE INDEX `material_title_UNIQUE` (`material_title` ASC),
  CONSTRAINT `material_title_series`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`seasons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`seasons` (
  `title` VARCHAR(256) NOT NULL,
  `series_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`title`, `series_title`),
  UNIQUE INDEX `title_series_title_UNIQUE` (`title` ASC, `series_title` ASC),
  INDEX `series_title_seasons_idx` (`series_title` ASC),
  CONSTRAINT `series_title_seasons`
    FOREIGN KEY (`series_title`)
    REFERENCES `netflix`.`series` (`material_title`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `netflix`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`subscriptions` (
  `account_email` VARCHAR(256) NOT NULL,
  `plan_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`account_email`, `plan_name`),
  UNIQUE INDEX `account_email_plan_name_UNIQUE` (`account_email` ASC, `plan_name` ASC),
  INDEX `plan_name_subscriptions_idx` (`plan_name` ASC),
  CONSTRAINT `account_email_subscriptions`
    FOREIGN KEY (`account_email`)
    REFERENCES `netflix`.`accounts` (`email`),
  CONSTRAINT `plan_name_subscriptions`
    FOREIGN KEY (`plan_name`)
    REFERENCES `netflix`.`plans` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
