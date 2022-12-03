class Airport():
    def __init__(self, name, iata, country):
        self.name = name
        self.iata = iata
        self.country = country

    def addToDatabase(self, conn):
        try:
            query = "INSERT IGNORE INTO airport(airport_iata, name, country)" \
                    "VALUES(%s,%s,%s)"
            args = (self.iata, self.name, self.country)
            conn.cursor().execute(query, args)
            conn.commit()
        except Exception as e:
            print("Error inserting tweet,", e)     