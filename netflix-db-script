
CREATE DATABASE `netflix` DEFAULT CHARACTER SET utf8;


CREATE TABLE `netflix`.`accounts` (
  `email` VARCHAR(256) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `cellphone` VARCHAR(45) NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `id_UNIQUE` (`email` ASC));


CREATE TABLE `netflix`.`profiles` (
  `name` VARCHAR(256) NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `language` VARCHAR(256) NOT NULL,
  `subtitle_preference` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`email`, `name`),
	INDEX `email_INDEX` (`email` ASC),
	INDEX `name_INDEX` (`name` ASC),
	UNIQUE INDEX `email_name_UNIQUE` (`email` ASC, `name` ASC),
  CONSTRAINT `email_profiles`
    FOREIGN KEY (`email`)
    REFERENCES `netflix`.`accounts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `netflix`.`payment_informations` (
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
    REFERENCES `netflix`.`accounts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `netflix`.`plans` (
  `name` VARCHAR(45) NOT NULL,
  `connection_numbers` INT NOT NULL,
  `device_numbers` INT NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  
  CREATE TABLE `netflix`.`genres` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));
  
  CREATE TABLE `netflix`.`favourite_genres` (
  `genre_name` VARCHAR(45) NOT NULL,
  `profile_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`genre_name`, `profile_name`),
  UNIQUE INDEX `genre_name_profile_name_UNIQUE` (`genre_name` ASC, `profile_name` ASC),
  INDEX `profile_name_favourite_genres_idx` (`profile_name` ASC),
  INDEX `genre_name_favourite_genres_idx` (`genre_name` ASC),
  CONSTRAINT `genre_name_favourite_genres`
    FOREIGN KEY (`genre_name`)
    REFERENCES `netflix`.`genres` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `profile_name_favourite_genres`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `netflix`.`tags` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));

CREATE TABLE `netflix`.`people` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));

CREATE TABLE `netflix`.`subscriptions` (
  `account_email` VARCHAR(256) NOT NULL,
  `plan_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`account_email`, `plan_name`),
  UNIQUE INDEX `account_email_plan_name_UNIQUE` (`account_email` ASC, `plan_name` ASC),
  INDEX `plan_name_subscriptions_idx` (`plan_name` ASC),
  CONSTRAINT `account_email_subscriptions`
    FOREIGN KEY (`account_email`)
    REFERENCES `netflix`.`accounts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_name_subscriptions`
    FOREIGN KEY (`plan_name`)
    REFERENCES `netflix`.`plans` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
CREATE TABLE `netflix`.`invoices` (
  `period` DATETIME NOT NULL,
  `account_email` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`period`, `account_email`),
  UNIQUE INDEX `period_account_email_UNIQUE` (`period` ASC, `account_email` ASC),
  INDEX `acount_email_invoices_idx` (`account_email` ASC),
  CONSTRAINT `acount_email_invoices`
    FOREIGN KEY (`account_email`)
    REFERENCES `netflix`.`accounts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `netflix`.`payments` (
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
    REFERENCES `netflix`.`accounts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `invoice_period_payments`
    FOREIGN KEY (`invoice_period`)
    REFERENCES `netflix`.`invoices` (`period`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `netflix`.`activities` (
  `timestamp` DATETIME NOT NULL,
  `ip` VARCHAR(45) NOT NULL,
  `device_type` VARCHAR(45) NOT NULL,
  `account_email` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`timestamp`, `ip`, `device_type`, `account_email`),
  UNIQUE INDEX `activities_UNIQUE` (`timestamp` ASC, `device_type` ASC, `ip` ASC, `account_email` ASC),
  INDEX `account_email_activities_idx` (`account_email` ASC),
  CONSTRAINT `account_email_activities`
    FOREIGN KEY (`account_email`)
    REFERENCES `netflix`.`accounts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `netflix`.`materials` (
  `title` VARCHAR(256) NOT NULL,
  `year` INT NOT NULL,
  `description` TEXT(2000) NOT NULL,
  PRIMARY KEY (`title`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC));

CREATE TABLE `netflix`.`movies` (
  `material_title` VARCHAR(256) NOT NULL,
  `duration` INT NOT NULL,
  PRIMARY KEY (`material_title`),
  UNIQUE INDEX `material_title_UNIQUE` (`material_title` ASC),
  CONSTRAINT `material_title_movies`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `netflix`.`series` (
  `material_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`),
  UNIQUE INDEX `material_title_UNIQUE` (`material_title` ASC),
  CONSTRAINT `material_title_series`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `netflix`.`miniseries` (
  `material_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`),
  UNIQUE INDEX `material_title_UNIQUE` (`material_title` ASC),
  CONSTRAINT `material_title_miniseries`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `netflix`.`seasons` (
  `title` VARCHAR(256) NOT NULL,
  `series_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`title`, `series_title`),
  UNIQUE INDEX `title_series_title_UNIQUE` (`title` ASC, `series_title` ASC),
  INDEX `series_title_seasons_idx` (`series_title` ASC),
  CONSTRAINT `series_title_seasons`
    FOREIGN KEY (`series_title`)
    REFERENCES `netflix`.`series` (`material_title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `netflix`.`chapters` (
  `title` VARCHAR(256) NOT NULL,
  `ref_title` VARCHAR(256) NOT NULL,
  `ref_type` VARCHAR(45) NOT NULL,
  `duration` INT NOT NULL,
  `description` TEXT(2000) NOT NULL,
  PRIMARY KEY (`title`, `ref_title`, `ref_type`),
  UNIQUE INDEX `chapters_UNIQUE` (`title` ASC, `ref_type` ASC, `ref_title` ASC));


CREATE TABLE `netflix`.`coincidences` (
  `material_title_1` VARCHAR(256) NOT NULL,
  `material_title_2` VARCHAR(256) NOT NULL,
  `similarity` INT NOT NULL,
  PRIMARY KEY (`material_title_1`, `material_title_2`),
  UNIQUE INDEX `material_title_1_material_title_2_UNIQUE` (`material_title_1` ASC, `material_title_2` ASC),
  INDEX `material_title_2_coincidences_idx` (`material_title_2` ASC),
  CONSTRAINT `material_title_1_coincidences`
    FOREIGN KEY (`material_title_1`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `material_title_2_coincidences`
    FOREIGN KEY (`material_title_2`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
CREATE TABLE `netflix`.`materials_tags` (
  `tag_name` VARCHAR(45) NOT NULL,
  `material_title` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`tag_name`, `material_title`),
  UNIQUE INDEX `tag_name_material_title_UNIQUE` (`tag_name` ASC, `material_title` ASC),
  INDEX `material_title_materials_tags_idx` (`material_title` ASC),
  CONSTRAINT `material_title_materials_tags`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tag_name_materials_tags`
    FOREIGN KEY (`tag_name`)
    REFERENCES `netflix`.`tags` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `netflix`.`materials_profiles` (
  `material_title` VARCHAR(256) NOT NULL,
  `profile_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`, `profile_name`),
  UNIQUE INDEX `material_title_profile_name_UNIQUE` (`material_title` ASC, `profile_name` ASC),
  INDEX `profile_name_materials_profiles_idx` (`profile_name` ASC),
  CONSTRAINT `material_title_materials_profiles`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `profile_name_materials_profiles`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
 
CREATE TABLE `netflix`.`likes` (
  `material_title` VARCHAR(256) NOT NULL,
  `profile_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`material_title`, `profile_name`),
  UNIQUE INDEX `material_title_profile_name_UNIQUE` (`material_title` ASC, `profile_name` ASC),
  INDEX `profile_name_likes_idx` (`profile_name` ASC),
  CONSTRAINT `material_title_likes`
    FOREIGN KEY (`material_title`)
    REFERENCES `netflix`.`materials` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `profile_name_likes`
    FOREIGN KEY (`profile_name`)
    REFERENCES `netflix`.`profiles` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);






    
    
    
