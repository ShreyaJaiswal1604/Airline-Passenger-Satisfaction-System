#V1
CREATE VIEW airline_flight_aircraft_view AS
(SELECT t1.airline_name,t1.iata_airline,t1.icao_airline,t1.active,t2.aircraft_name, t2.iata_aircraft,t2.icao_aircraft,t2.capacity,
t3.flight_id,t3.flight_number
FROM airline t1
JOIN flight t3 
ON t1.iata_airline = t3.iata_airline
JOIN aircraft t2 
ON t2.iata_aircraft = t3.iata_aircraft);

#V2
CREATE VIEW airline_review_view AS
(SELECT t1.airline_name,t1.icao_airline,t1.iata_airline,t1.active, t2.review_title, t2.review_date, t2.seat_comfort_rating, 
t2.service_rating, t2.food_rating, t2.entertainment_rating, t2.groundservice_rating, t2.wifi_rating, 
t2.value_rating, t2.overall_score,
t2.recommended
FROM airline t1
JOIN airline_review t2
ON t1.iata_airline = t2.iata_airline);

#V3
drop view twitter_view;
CREATE VIEW tweet_airline_view AS
(SELECT t1.tweet_id, t1.twitter_handle, t1.tweet_text, t1.like_count, t1.created_at, t1.iata_airline,
t2.icao_airline, t2.airline_name, t2.active
FROM tweet t1 
JOIN airline t2
ON t1.iata_airline = t2.iata_airline

);


#V4
drop view tweet_airlines_view;
CREATE VIEW tweet_airlines_view AS
(SELECT t1.tweet_id, t1.twitter_handle, t1.tweet_text, t1.like_count, t1.created_at, t1.iata_airline,
t2.airline_name
FROM tweet t1 
JOIN airline t2
ON t1.iata_airline = t2.iata_airline
);

#V5
CREATE VIEW user_tweets_airlines_view AS
(
SELECT t1.twitter_handle, t1.user_display_name, t1.user_id, t1.user_profile_image_url, t1.user_description, t1.user_follower_count, t1.user_following_count,
t3.tweet_id, t3.tweet_text,t3.like_count, t3.created_at, t3.iata_airline, t2.airline_name
FROM tweet_user t1
JOIN tweet t3
ON t1.twitter_handle = t3.twitter_handle
JOIN airline t2
ON t2.iata_airline = t3.iata_airline
);

#Q1 Count all aircrafts owned by airlines which have a seat capacity>150
SELECT airline_name, aircraft_name, count(aircraft_name) as airline_count, capacity
FROM airline_flight_aircraft_view 
WHERE capacity>150
GROUP by airline_name, aircraft_name, capacity;



#Q2 Select the maximum like_count given to the tweet_texts
SELECT airline_name, COUNT(recommended) as no_of_recommendation
FROM airline_review_view
WHERE recommended = True
GROUP BY airline_name
ORDER BY no_of_recommendation DESC ;

#3 How many passenger flights do Air France Airlines own?
SELECT airline_name, count(airline_name) AS flight_count
FROM airline_flight_aircraft_view
WHERE capacity>0 AND iata_airline="AF";


#Q4 Which airline received maximum average seating comfort rating ?
SELECT airline_name, AVG(seat_comfort_rating) AS avg_seat_comfort_rating
FROM airline_review_view
GROUP BY t1.airline_name
limit 1
;

#5 Find all airlines owning  2 passenger flights
SELECT airline_name, count(airline_name) AS airline_count
FROM airline_flight_aircraft_view 
WHERE capacity>0 
GROUP BY airline_name
HAVING count(airline_name)=2;


#7 Find top 5 airlines with best overall reviews
SELECT airline_name, AVG(overall_score) as avg_overall_score
FROM airline_review_view 
GROUP BY airline_name
ORDER BY avg_overall_score DESC
LIMIT 5;

#9 order airline names based on the count of their service rating for service rating > 4
SELECT airline_name, COUNT(service_rating) AS service_rating_count
FROM airline_review_view
WHERE service_rating > 4
GROUP BY t1.airline_name
ORDER BY service_rating_count DESC;


#10 Count the number of aircraft each flight has
SELECT flight_number, COUNT(aircraft_name) AS aircraft_count
FROM airline_flight_aircraft_view 
GROUP BY flight_number;


#11 Get all Qatar reviews
SELECT twitter_handle, tweet_text
FROM tweet_airline_view 
WHERE iata_airline = "QR";


#12 Select the count of likes for british airways
SELECT COUNT(like_count),  airline_name
FROM tweet_airlines_view
Where airline_name = "british_airways"
GROUP BY airline_name; 


#13 Number of followers, their name and when they created the tweet  about the British Airways
SELECT user_follower_count, user_display_name, airline_name, created_at as TWEET_DATE
FROM user_tweets_airlines_view
Where lower(airline_name) = "british airways";

#14 DISPLAY THE USER NAME ALONG WITH AIRLINE_NAME
SELECT user_display_name, airline_name
FROM user_tweets_airlines_view
;

#15  GET THE AVERAGE COUNT OF LIKES FOR REVIEWS GIVEN BY CUSTOMERS FOR BRITISH AIRWAYS
SELECT airline_name,AVG(like_count) AS AVG_CNT 
FROM tweet_airlines_view
WHERE lower(airline_name) = "british airways"
GROUP BY airline_name
ORDER BY airline_name;



#17 Select the count of likes for the different airline names
SELECT COUNT(like_count) AS LIKE_COUNT,  airline_name
FROM tweet_airlines_view
WHERE airline_name <> ""
GROUP BY airline_name; 

#18 Tweet airline reviews that have the most likes.
SELECT like_count, tweet_text, airline_name
FROM tweet_airlines_view
WHERE like_count = (SELECT MAX(like_count)  FROM tweet ) ;


#20 DISPLAY THE REVIEW COUNT, FOOD RATING FOR EVERY AIRLINE WHERE THE RATING GIVEN IS =5
SELECT airline_name, food_rating, COUNT(*) as review_count
FROM airline_review_view
WHERE food_rating=5
GROUP BY t1.airline_name, t2.food_rating;


