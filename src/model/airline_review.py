class AirlineReview():
    def __init__(self, iata_airline, review_title ,review_date ,seat_comfort_rating , service_rating ,food_rating ,entertainment_rating ,groundservice_rating ,wifi_rating ,value_rating ,overall_score ,recommended):
        self.iata = iata_airline
        self.review = review_title
        self.review_date = review_date
        self.seat_comfort_rating = seat_comfort_rating
        self.service_rating = service_rating
        self.food_rating = food_rating
        self.entertainment_rating = entertainment_rating
        self.groundservice_rating = groundservice_rating
        self.wifi_rating = wifi_rating
        self.value_rating = value_rating
        self.overall_score = overall_score
        self.recommended = recommended

    def addToDatabase(self, conn):
        try:
            query = "INSERT INTO airline_review(iata_airline, review_title ,review_date ,seat_comfort_rating , service_rating ,food_rating ,entertainment_rating ,groundservice_rating ,wifi_rating ,value_rating ,overall_score ,recommended)" \
                    "VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            args = (self.iata, self.review, self.review_date, self.seat_comfort_rating, self.service_rating, self.food_rating, self.entertainment_rating, self.groundservice_rating, self.wifi_rating, self.value_rating, self.overall_score, self.recommended)
            conn.cursor().execute(query, args)
            conn.commit()
        except Exception as e:
            print("Error inserting airline,", e)