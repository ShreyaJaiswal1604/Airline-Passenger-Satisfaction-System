# DROP INDICES
#ALTER TABLE airline DROP INDEX airline_name_idx;
#ALTER TABLE airline_review DROP INDEX airline_review_score_idx;

# CREATE INDICES
CREATE INDEX airline_name_idx
ON airline (airline_name);

CREATE INDEX airline_review_score_idx
ON airline_review (overall_score, recommended, value_rating, wifi_rating, groundservice_rating, entertainment_rating, food_rating, service_rating, seat_comfort_rating);

# VIEW ALL INDICES
SHOW INDEXES FROM airline;
SHOW INDEXES FROM airline_review;

# EXAMPLE QUERY WITH
EXPLAIN ANALYZE
SELECT t1.iata_airline, t1.review_title, t1.overall_score 
FROM airline_review t1
INNER JOIN (
	SELECT * 
	FROM airline 
	WHERE airline_name LIKE '%air france%' 
	LIMIT 1) AS t2 
ON t1.iata_airline=t2.iata_airline
WHERE t1.overall_score>8;
