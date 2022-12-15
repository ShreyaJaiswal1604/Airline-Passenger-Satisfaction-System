#DROP STORED PROCEDURES
DROP PROCEDURE IF EXISTS SelectAirlineFlightCount;
DROP PROCEDURE IF EXISTS ViewReviewCount;

#STORED PROCEDURES 1
DELIMITER //
CREATE PROCEDURE SelectAirlineFlightCount 
(
   iata_airline VARCHAR(10)
) 
BEGIN 
SELECT t2.airline_name, count(t2.airline_name) AS flight_count
		FROM flight t1
		INNER JOIN airline t2 
		ON t1.iata_airline=t2.iata_airline
		INNER JOIN aircraft t3 
		ON t1.iata_aircraft=t3.iata_aircraft
		WHERE t3.capacity>0 AND t1.iata_airline=iata_airline
		GROUP BY t2.airline_name;
END//
DELIMITER ;


#STORED PROCEDURES 2
DELIMITER //

CREATE PROCEDURE ViewReviewCount 
(
   airlineName VARCHAR(150) ,
   score INT
) 
BEGIN 
SELECT t1.iata_airline, t1.review_title, t1.overall_score 
FROM airline_review t1
INNER JOIN (
	SELECT * 
	FROM airline 
	WHERE lower(airline_name) = lower(airlineName)
	LIMIT 1) as t2 
ON t1.iata_airline=t2.iata_airline
WHERE t1.overall_score>=score;
END//
DELIMITER ;

CALL SelectAirlineFlightCount("AF");
CALL SelectAirlineFlightCount("BA");

CALL ViewReviewCount("EMIRATES",8);
CALL ViewReviewCount("AIR FRANCE",10);
