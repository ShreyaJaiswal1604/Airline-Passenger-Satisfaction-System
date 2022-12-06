class FlightSchedule():
    def __init__(self, arrTime,depTime, arrAirport, depAirport, duration, flight_id):
        self.arrTime = arrTime
        self.depTime = depTime
        self.arrAirport = arrAirport
        self.depAirport = depAirport
        self.duration = duration
        self.flight_id = flight_id

    def addToDatabase(self, conn):
        try:
            query = "INSERT INTO flight_schedule(arrival_time, departure_time, arrival_airport, departure_airport, duration, flight_id)" \
                    "VALUES(%s,%s,%s,%s,%s,%s)"
            args = (self.arrTime, self.depTime, self.arrAirport, self.depAirport, self.duration, self.flight_id)
            conn.cursor().execute(query, args)
            conn.commit()
        except Exception as e:
            print("Error inserting flight schedule,", e)