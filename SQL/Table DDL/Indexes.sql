# DROP INDICES
alter table airline drop index airline_name_idx;
alter table airline_review drop index airline_review_score_idx;

# CREATE INDICES
CREATE INDEX airline_name_idx
ON airline (airline_name);

CREATE INDEX airline_review_score_idx
ON airline_review (overall_score, recommended, value_rating, wifi_rating, groundservice_rating, entertainment_rating, food_rating, service_rating, seat_comfort_rating);

# VIEW ALL INDICES
show indexes from airline;
show indexes from airline_review;

# EXAMPLE QUERY WITH
SELECT t1.iata_airline, t1.review_title, t1.overall_score 
FROM airline_review t1
INNER JOIN (
	SELECT * 
	FROM airline 
	WHERE airline_name like '%air france%' 
	LIMIT 1) as t2 
ON t1.iata_airline=t2.iata_airline
WHERE t1.overall_score>8;

#-> Filter: (t1.overall_score > 8)  (cost=105.61 rows=329) (actual time=1.354..3.466 rows=248 loops=1)
#-> Index lookup on t1 using fk_airline_idx (iata_airline='AF')  (cost=105.61 rows=986) (actual time=1.347..3.377 rows=986 loops=1)
