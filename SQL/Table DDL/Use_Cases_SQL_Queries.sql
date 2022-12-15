#USE CASES

USE airline_passenger_system;

#1 Count all aircrafts owned by airlines which have a seat capacity>150
SELECT t1.airline_name, t2.aircraft_name, count(t2.aircraft_name) as airline_count, t2.capacity
FROM airline t1
JOIN flight t3 
ON t1.iata_airline = t3.iata_airline
JOIN aircraft t2 
ON t2.iata_aircraft = t3.iata_aircraft
WHERE t2.capacity>150
GROUP by t1.airline_name, t2.aircraft_name, t2.capacity;

#2 Display airline names and the number of positive recommendations receieved 
SELECT t1.airline_name, COUNT(t2.recommended) no_of_recommendation
FROM airline t1
JOIN airline_review t2
ON (t1.iata_airline = t2.iata_airline)
WHERE t2.recommended = True
GROUP BY t1.airline_name
ORDER BY no_of_recommendation DESC ;

#3 How many passenger flights do Air France Airlines own?
SELECT t2.airline_name, count(t2.airline_name) AS flight_count
FROM flight t1
INNER JOIN airline t2 
ON t1.iata_airline=t2.iata_airline
INNER JOIN aircraft t3 
ON t1.iata_aircraft=t3.iata_aircraft
WHERE t3.capacity>0 AND t1.iata_airline="AF"
GROUP BY t2.airline_name;

#4 Which airline received maximum average seating comfort rating ?
SELECT t1.airline_name, AVG(t2.seat_comfort_rating) AS avg_seat_comfort_rating
FROM airline t1
JOIN airline_review t2
ON (t1.iata_airline = t2.iata_airline)
GROUP BY t1.airline_name
limit 1
;
						
#5 Find all airlines owning  2 passenger flights
SELECT t2.airline_name, count(t2.airline_name) AS airline_count
FROM flight t1
INNER JOIN airline t2 
ON t1.iata_airline=t2.iata_airline
INNER JOIN aircraft t3 
ON t1.iata_aircraft=t3.iata_aircraft
WHERE t3.capacity>0 
GROUP BY t2.airline_name
HAVING count(t2.airline_name)=2;

#6 How many reviews does Air France have with >4.0 rating
SELECT t1.iata_airline, t1.review_title, t1.overall_score 
FROM airline_review t1
INNER JOIN (
	SELECT * 
	FROM airline 
	WHERE airline_name like '%air france%' 
	LIMIT 1) as t2 
ON t1.iata_airline=t2.iata_airline
WHERE t1.overall_score>8;

#7 Find top 5 airlines with best overall reviews
SELECT t2.airline_name, AVG(t1.overall_score) as avg_overall_score
FROM airline_review t1
INNER JOIN airline t2 
ON t1.iata_airline=t2.iata_airline
GROUP BY t2.airline_name
ORDER BY avg_overall_score DESC
LIMIT 5;

#8 Find the airline which provides the best entertainment in flights along with their reviews
SELECT t2.airline_name,t1.review_title, MAX(avg_rating) as max_average_rating 
FROM (
	SELECT review_title,iata_airline,AVG(entertainment_rating)
	AS avg_rating
	FROM airline_review
	GROUP BY iata_airline,review_title ) AS t1
JOIN airline t2
ON t1.iata_airline=t2.iata_airline
GROUP BY t2.airline_name,t1.review_title
ORDER BY MAX(avg_rating) DESC
limit 1;

#9 order airline names based on the count of their service rating for service rating > 4
SELECT t1.airline_name, COUNT(t2.service_rating) AS service_rating_count
FROM airline t1
JOIN airline_review t2
USING(iata_airline)
WHERE t2.service_rating > 4
GROUP BY t1.airline_name
ORDER BY service_rating_count DESC;

#10 Count the number of aircraft each flight has
SELECT t1.flight_number, COUNT(t2.aircraft_name) AS aircraft_count
FROM flight t1
JOIN aircraft t2
ON t1.iata_aircraft = t2.iata_aircraft
GROUP BY t1.flight_number;


#11 DISPLAY COUNT OF REVIEWS FOR EVERY AIRLINE BASED ON THE COUNTRY IT FLIES
SELECT t1.airline_name, t2.country_name, COUNT(t3.review_id) as count_of_reviews
FROM airline t1
JOIN country t2
ON t1.country_code = t2.country_code
JOIN airline_review t3
ON t1.iata_airline = t3.iata_airline
GROUP  BY t1.airline_name, t2.country_name;

#12 GET ALL QATAR REVIEWS
SELECT t1.twitter_handle, t1.tweet_text
FROM tweet t1 
JOIN airline t2
ON t1.iata_airline = t2.iata_airline
WHERE t2.iata_airline = "QR";

#13 DISPLAY THE REVIEW COUNT, FOOD RATING FOR EVERY AIRLINE WHERE THE RATING GIVEN IS =5
SELECT t1.airline_name, t2.food_rating, COUNT(*) as review_count
FROM airline t1
JOIN airline_review t2
USING(iata_airline)
WHERE t2.food_rating=5
GROUP BY t1.airline_name, t2.food_rating;

#14 SELECT THE MAXIMUM COUNTS GIVEN TO TWEET REVIEWS FOR BRITISH AIRWAYS
SELECT t1.like_count, t1.tweet_text
FROM tweet t1
WHERE t1.like_count = (
	SELECT MAX(like_count)  
	FROM tweet);

#15 DISPLAY NUMBER OF FOLLOWERS, THEIR NAME, FOLLOWING COUNT AND WHEN WAS IT CREATED FOR THOSE WHO REVIEWED FOR TURKISH AIRLINES
SELECT t1.user_display_name,t1.user_follower_count,  t2.airline_name, t3.created_at as TWEET_DATE
FROM tweet t3
JOIN airline t2 
ON t3.iata_airline = t2.iata_airline
JOIN tweet_user t1
ON t1.twitter_handle = t3.twitter_handle
WHERE lower(t2.airline_name)= "TURKISH AIRLINES";

#16  GET THE AVERAGE COUNT OF LIKES FOR REVIEWS GIVEN BY CUSTOMERS FOR QATAR AIRWAYS
SELECT t2.airline_name,AVG(t1.like_count) AS AVG_CNT 
FROM tweet t1
JOIN airline t2
USING(iata_airline)
WHERE lower(airline_name) = "qatar airways"
GROUP BY t2.airline_name
ORDER BY t2.airline_name;

#17 WHICH AIRLINE GOT THE MAXIMUM NUMBER OF RATING 5 FOR ITS WIFI SERVICE
SELECT t1.airline_name, t2.wifi_rating, COUNT(t2.wifi_rating) AS rating_count
FROM airline t1
JOIN airline_review t2
USING(iata_airline)
WHERE wifi_rating = 5
GROUP BY t1.airline_name, t2.wifi_rating
ORDER BY rating_count desc
LIMIT 1;

#18 WHICH AIRLINE GOT THE MINIMUM NUMBER OF RATING 5 FOR ITS WIFI SERVICE
SELECT t1.airline_name, t2.wifi_rating, COUNT(t2.wifi_rating) AS rating_count
FROM airline t1
JOIN airline_review t2
USING(iata_airline)
WHERE wifi_rating = 5
GROUP BY t1.airline_name, t2.wifi_rating
ORDER BY rating_count 
LIMIT 1;

#19 SELECT THE COUNT OF LIKES FOR DIFFERENT AIRLINE NAMES
SELECT  t2.airline_name,COUNT(t1.like_count) AS LIKE_COUNT 
FROM tweet t1
JOIN airline t2
ON t1.iata_airline = t2.iata_airline
WHERE airline_name <> ""
GROUP BY t2.airline_name; 

#20 WHICH AIRLINE REVIEW GOT THE MOST NUMBER OF TWEET LIKES
SELECT t2.airline_name,t1.like_count, t1.tweet_text
FROM tweet t1
JOIN airline t2
ON t1.iata_airline = t2.iata_airline
WHERE t1.like_count = (SELECT MAX(like_count)  FROM tweet ) ;

#21 VIEW THE AIRLINES AND COUNT OF HOW MANY PEOPLE RECOMMENDED IT ?
SELECT t1.airline_name, COUNT(t2.recommended) as recommendation_count
FROM airline t1
JOIN airline_review t2
ON t1.iata_airline = t2.iata_airline
WHERE t2.recommended =1
GROUP BY t1.airline_name;

#22 REVIEWS FOR WHICH AIRLINE GOT THE MOST NUMBER OF RECOMMENDATION  FOR THEIR GROUND SERVICE rating >4?
SELECT t1.airline_name, COUNT(t2.recommended) as recommendation_count
FROM airline t1
JOIN airline_review t2
ON t1.iata_airline = t2.iata_airline
WHERE t2.recommended =1 AND t2.groundservice_rating>4
GROUP BY t1.airline_name
ORDER BY recommendation_count DESC
LIMIT 1;

#23 REVIEWS FOR WHICH AIRLINE GOT THE LEAST NUMBER OF RECOMMENDATION  FOR THEIR FOOD SERVICE rating >4?
SELECT t1.airline_name, COUNT(t2.recommended) as recommendation_count
FROM airline t1
JOIN airline_review t2
ON t1.iata_airline = t2.iata_airline
WHERE t2.recommended =1 AND t2.food_rating>4
GROUP BY t1.airline_name
ORDER BY recommendation_count 
LIMIT 1;

#24 REVIEWS FOR WHICH AIRLINE GOT THE MOST NUMBER OF RECOMMENDATION  FOR THEIR SEAT SERVICE rating = 5?
SELECT t1.airline_name, COUNT(t2.recommended) as recommendation_count
FROM airline t1
JOIN airline_review t2
ON t1.iata_airline = t2.iata_airline
WHERE t2.recommended =1 AND t2.seat_comfort_rating=5
GROUP BY t1.airline_name
ORDER BY recommendation_count DESC
LIMIT 1;

#25 SELECT THE COUNT OF LIKES FOR REVIEWS GIVEN TO BRITISH AIRWAYS
SELECT  t2.airline_name, COUNT(t1.like_count) 
FROM tweet t1
JOIN airline t2
ON t1.iata_airline = t2.iata_airline
WHERE lower(t2.airline_name) = "british airways"
GROUP BY t2.airline_name; 