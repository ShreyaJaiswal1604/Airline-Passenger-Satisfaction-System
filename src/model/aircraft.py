class Aircraft():
    def __init__(self, name, iata, capacity):
        self.name = name
        self.iata = iata
        self.capacity = capacity

    def addToDatabase(self, conn):
        try:
            query = "INSERT IGNORE INTO aircraft(aircraft_iata, name, capacity)" \
                    "VALUES(%s,%s,%s)"
            args = (self.iata, self.name, self.capacity)
            conn.cursor().execute(query, args)
            conn.commit()
        except Exception as e:
            print("Error inserting tweet,", e)