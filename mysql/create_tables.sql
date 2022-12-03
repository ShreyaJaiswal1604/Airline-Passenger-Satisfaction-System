#SQL Statements for the conceptual model

#Create a Database
DROP DATABASE airline_passenger_satisfaction;
CREATE DATABASE IF NOT EXISTS airline_passenger_satisfaction;
USE airline_passenger_satisfaction;

#User Table:
CREATE TABLE IF NOT EXISTS twitter_user(
user_id VARCHAR(20),
twitter_handle VARCHAR(100),
name VARCHAR(100),
profile_image_url VARCHAR(200),
description VARCHAR(300),
followers_count BIGINT,
following_count BIGINT,
PRIMARY KEY (user_id)
);

#Tweets Table:
CREATE TABLE IF NOT EXISTS tweet(
tweet_id CHAR(25),
user_id VARCHAR(20),
tweet_text TEXT,
like_count INT,
created_at CHAR(24),
PRIMARY KEY (tweet_id),
FOREIGN KEY (user_id) REFERENCES twitter_user(user_id)
);

#Tweet Tags:
CREATE TABLE IF NOT EXISTS tweet_tags(
tweet_id CHAR(25),
hashtags VARCHAR(200),
PRIMARY KEY (tweet_id),
FOREIGN KEY (tweet_id) REFERENCES tweet(tweet_id)
);

#Tweet Mentions:
CREATE TABLE IF NOT EXISTS tweet_mentions(
tweet_id CHAR(25),
source_user text,
target_user text,
PRIMARY KEY (tweet_id),
FOREIGN KEY (tweet_id) REFERENCES tweet(tweet_id)
);

#Type of Aircraft
CREATE TABLE IF NOT EXISTS aircraft(
aircraft_iata CHAR(3),
name VARCHAR(50),
capacity int,
PRIMARY KEY (aircraft_iata)
);

#Airports
CREATE TABLE IF NOT EXISTS airport(
airport_iata CHAR(3),
name VARCHAR(50),
country VARCHAR(25),
PRIMARY KEY (airport_iata)
);

#Airlines
CREATE TABLE IF NOT EXISTS airline(
airline_iata CHAR(3),
name VARCHAR(50),
PRIMARY KEY (airline_iata)
);

#Airline Sentiment Analysis
CREATE TABLE IF NOT EXISTS airline_sentiment(
tweet_id CHAR(25),
airline_sentiment VARCHAR(50),
airline_sentiment_scale double,
negative_reason VARCHAR(50),
negative_reason_scale DOUBLE,
PRIMARY KEY (tweet_id)
);

#Flights
CREATE TABLE IF NOT EXISTS flight(
flight_id INT AUTO_INCREMENT,
flight_number INT,
airline_iata CHAR(2),
aircraft_iata CHAR(3),
PRIMARY KEY (flight_id),
FOREIGN KEY (aircraft_iata) REFERENCES aircraft(aircraft_iata),
FOREIGN KEY (airline_iata) REFERENCES airline(airline_iata)
);

#Flight Schedules
CREATE TABLE IF NOT EXISTS flight_schedule(
schedule_id INT AUTO_INCREMENT,
arival_time DATETIME,
departure_time DATETIME,
arrival_airport CHAR(3),
departure_airport CHAR(3),
flight_id INT,
PRIMARY KEY (schedule_id),
FOREIGN KEY (arrival_airport) REFERENCES airport(airport_iata),
FOREIGN KEY (departure_airport) REFERENCES airport(airport_iata),
FOREIGN KEY (flight_id) REFERENCES flight(flight_id)
);

#Airline subjected by Tweet
CREATE TABLE tweet_airline(
tweet_id CHAR(25),
airline_iata CHAR(2),
PRIMARY KEY (tweet_id),
FOREIGN KEY (tweet_id) REFERENCES tweet(tweet_id),
FOREIGN KEY (airline_iata) REFERENCES airline(airline_iata)
);
