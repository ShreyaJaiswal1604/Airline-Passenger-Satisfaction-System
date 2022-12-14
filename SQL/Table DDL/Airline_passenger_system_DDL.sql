CREATE DATABASE IF NOT EXISTS airline_passenger_system;

#TABLE 1 
#COUNTRY
DROP TABLE IF EXISTS `airline_passenger_system`.`country`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`country` (
  `country_code` VARCHAR(10) NOT NULL,
  `country_name` VARCHAR(100) NULL,
  PRIMARY KEY (country_code))
ENGINE = InnoDB;

#TABLE 2 
#COUNTRY_AREA
DROP TABLE IF EXISTS `airline_passenger_system`.`country_area`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`country_area` (
  `area_code_id` VARCHAR(10) NOT NULL,
  `country_code` VARCHAR(10),
  `world_area_code` INT NULL,
  PRIMARY KEY (`area_code_id`),
  INDEX `fk_countryarea_idx` (`country_code` ASC) VISIBLE,
  CONSTRAINT `fk_countryarea`
    FOREIGN KEY (`country_code`)
    REFERENCES `airline_passenger_system`.`country` (`country_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

#TABLE 3
#CITY

DROP TABLE IF EXISTS `airline_passenger_system`.`city`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`city` (
  `city_code` VARCHAR(10) NOT NULL,
  `city_name` VARCHAR(100) NULL,
  `country_code` VARCHAR(10) NULL,
  PRIMARY KEY (`city_code`),
  INDEX `fk_city_idx` (`country_code` ASC) VISIBLE,
  CONSTRAINT `fk_city_country`
    FOREIGN KEY (`country_code`)
    REFERENCES `airline_passenger_system`.`country` (`country_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

#TABLE 4
#AIRPORT

DROP TABLE IF EXISTS `airline_passenger_system`.`airport`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`airport` (
  `iata_airport` VARCHAR(10) NOT NULL,
  `icao_airport` VARCHAR(10) NULL,
  `airport_name` VARCHAR(150) NULL,
  `state` VARCHAR(100) NULL,
  `latitude` DECIMAL(20,10) NULL,
  `longitude` DECIMAL(20,10) NULL,
  `area_code_id` VARCHAR(10) NULL,
  PRIMARY KEY (`iata_airport`),
  INDEX `fk_area_code_idx` (`area_code_id` ASC) VISIBLE,
  CONSTRAINT `fk_city`
    FOREIGN KEY (`iata_airport`)
    REFERENCES `airline_passenger_system`.`city` (`city_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_area_code`
    FOREIGN KEY (`area_code_id`)
    REFERENCES `airline_passenger_system`.`country_area` (`area_code_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#TABLE 5
#AIRLINE
DROP TABLE IF EXISTS `airline_passenger_system`.`airline`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`airline` (
  `iata_airline` VARCHAR(10) NOT NULL,
  `icao_airline` VARCHAR(10) NULL,
  `airline_name` VARCHAR(150) NULL,
  `active` VARCHAR(2) NULL,
  `country_code` VARCHAR(10) NULL,
  PRIMARY KEY (`iata_airline`),
  INDEX `fk_airline_countrycode_idx` (`country_code` ASC) VISIBLE,
  CONSTRAINT `fk_airline_countrycode`
    FOREIGN KEY (`country_code`)
    REFERENCES `airline_passenger_system`.`country` (`country_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

#TABLE 6
#AIRLINE REVIEW
DROP TABLE IF EXISTS `airline_passenger_system`.`airline_review`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`airline_review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `iata_airline` VARCHAR(10) NULL,
  `review_title` VARCHAR(200) NULL,
  `review_date` DATE NULL,
  `seat_comfort_rating` INT NULL,
  `service_rating` INT NULL,
  `food_rating` INT NULL,
  `entertainment_rating` INT NULL,
  `groundservice_rating` INT NULL,
  `wifi_rating` INT NULL,
  `value_rating` INT NULL,
  `overall_score` INT NULL,
  `recommended` INT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_airline_idx` (`iata_airline` ASC) VISIBLE,
  CONSTRAINT `fk_airline`
    FOREIGN KEY (`iata_airline`)
    REFERENCES `airline_passenger_system`.`airline` (`iata_airline`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

#TABLE 7
#AIRCRAFT

DROP TABLE IF EXISTS `airline_passenger_system`.`aircraft`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`aircraft` (
  `iata_aircraft` VARCHAR(10) NOT NULL,
  `icao_aircraft` VARCHAR(10) NULL,
  `aircraft_name` VARCHAR(100) NULL,
  `capacity` INT NULL,
  PRIMARY KEY (`iata_aircraft`))
ENGINE = InnoDB;

#TABLE 8
#FLIGHT

DROP TABLE IF EXISTS `airline_passenger_system`.`flight`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`flight` (
  `flight_id` INT NOT NULL AUTO_INCREMENT,
  `flight_number` INT NULL,
  `iata_airline` VARCHAR(10) NULL,
  `iata_aircraft` VARCHAR(10) NULL,
  PRIMARY KEY (`flight_id`),
  INDEX `fk_airline_idx` (`iata_airline` ASC) VISIBLE,
  INDEX `fk_aircraft_idx` (`iata_aircraft` ASC) VISIBLE,
  CONSTRAINT `fk_airline_flight`
    FOREIGN KEY (`iata_airline`)
    REFERENCES `airline_passenger_system`.`airline` (`iata_airline`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aircraft`
    FOREIGN KEY (`iata_aircraft`)
    REFERENCES `airline_passenger_system`.`aircraft` (`iata_aircraft`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#TABLE 9
#TWEET_USER

DROP TABLE IF EXISTS `airline_passenger_system`.`tweet_user`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`tweet_user` (
  `twitter_handle` VARCHAR(100) NOT NULL,
  `user_display_name` VARCHAR(150) NULL,
  `user_id` VARCHAR(200) NULL,
  `user_profile_image_url` VARCHAR(200) NULL,
  `user_description` VARCHAR(255) NULL,
  `user_follower_count` INT NULL,
  `user_following_count` INT NULL,
  `verified_account` VARCHAR(45) NULL,
  PRIMARY KEY (`twitter_handle`))
ENGINE = InnoDB;

#TABLE 10
#TWEET

DROP TABLE IF EXISTS `airline_passenger_system`.`tweet`;
CREATE TABLE IF NOT EXISTS `airline_passenger_system`.`tweet` (
  `tweet_id` BIGINT NOT NULL,
  `twitter_handle` VARCHAR(45) NULL,
  `iata_airline` VARCHAR(10) NULL,
  `tweet_text` TEXT NULL,
  `like_count` INT NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`tweet_id`),
  INDEX `fk_tweet_user_idx` (`twitter_handle` ASC) VISIBLE,
  INDEX `fk_airlines_idx` (`iata_airline` ASC) VISIBLE,
  CONSTRAINT `fk_tweet_user`
    FOREIGN KEY (`twitter_handle`)
    REFERENCES `airline_passenger_system`.`tweet_user` (`twitter_handle`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_airlines`
    FOREIGN KEY (`iata_airline`)
    REFERENCES `airline_passenger_system`.`airline` (`iata_airline`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;