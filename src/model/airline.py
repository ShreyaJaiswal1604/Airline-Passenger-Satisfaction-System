class Airline():
    def __init__(self, name, iata):
        self.name = name
        self.iata = iata

    def addToDatabase(self, conn):
        try:
            query = "INSERT IGNORE INTO airline(airline_iata, name)" \
                    "VALUES(%s,%s)"
            args = (self.iata, self.name)
            conn.cursor().execute(query, args)
            conn.commit()
        except Exception as e:
            print("Error inserting airline,", e)