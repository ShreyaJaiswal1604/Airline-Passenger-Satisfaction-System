class Flight():
    def __init__(self, airlineIata, aircraftIata, flightNumber):
        self.airlineIata = airlineIata
        self.aircraftIata = aircraftIata
        self.flightNumber = flightNumber

    def addToDatabase(self, conn):
        try:
            query = "INSERT INTO flight(airline_iata, aircraft_iata, flight_number)" \
                    "VALUES(%s,%s,%s)"
            args = (self.airlineIata, self.aircraftIata, self.flightNumber)
            conn.cursor().execute(query, args)
            conn.commit()
        except Exception as e:
            print("Error inserting flight,", e)