from twitter.twitterApiManager import *
from sql.connection import *
from dotenv import load_dotenv
from model.aircraft import *
from model.airport import *
from model.airline import *
from model.flight import *
from model.airline_review import *
from model.flight_schedule import *

def insertFlightScheduleFromCsv(conn):
    try:
        print('Inserting flight schedules')
        data = ['2022-12-30', '2022-12-30', 'JFK', 'ATL', '4h 30m', 1]
        airline = "air france"
        aircraftName = "boeing 757"
        airineIata = findAirlineByName(conn, airline)
        print('found airline', airineIata[0])
        if (isinstance(airineIata, Exception)):
            raise airineIata
        flight = findFlightIdByAirlineAndNumber(conn, airineIata[0], 898)
        if (isinstance(flight, Exception)):
            aircraft = findAircraftByName(conn, aircraftName)
            print('aircraft name', aircraft)
            if (isinstance(aircraft, Exception)):
                print('no aircraft found')
            else:
                newFlight = Flight(airineIata[0], aircraft[0], 898)
                print(newFlight.airlineIata, newFlight.aircraftIata)
                newFlight.addToDatabase(conn)
        else:
            fs1 = FlightSchedule(data[0], data[1], data[2], data[3], data[4], flight[0])
            fs1.addToDatabase(conn)
    except Exception as e:
        print(e)

def findAircraftByName(conn, aircraft):
    try:
        if (conn=={}):
            raise Exception("DB Connection not found")
        query = f"SELECT * FROM aircraft WHERE name LIKE '%{aircraft}%'"
        cur = conn.cursor()
        cur.execute(query)
        data = cur.fetchall()
        if (len(data)>0):
            return data[0]
        else:
            raise Exception("No aircraft found")
    except Exception as e:
        return e

def findFlightIdByAirlineAndNumber(conn, airline, flightNumber):
    try:
        if (conn=={}):
            raise Exception("DB Connection not found")
        query = f"SELECT * FROM flight WHERE airline_iata='{airline}' AND flight_number={flightNumber}"
        cur = conn.cursor()
        cur.execute(query)
        data = cur.fetchall()
        if (len(data)>0):
            return data[0]
        else:
            raise Exception("No flight found")
    except Exception as e:
        return e

def findAirlineByName(conn, query):
    try:
        if (conn=={}):
            raise Exception("DB Connection not found")
        query = f"SELECT * FROM airline WHERE name LIKE '%{query}%'"
        cur = conn.cursor()
        cur.execute(query)
        data = cur.fetchall()
        if (len(data)>0):
            return data[0]
        else:
            raise Exception("No airline found")
    except Exception as e:
        return e

def insertAirlineFromCsv(conn):
    print('Inserting from airline.rtf...')
    rows = getRowsFromCsv('airline.rtf')
    for aircraft in rows:
        row = aircraft.split(';')
        if (len(row)>=2):
            obj = Airline(row[0], row[1])
            obj.addToDatabase(conn)
    print('Completed inserting')

def insertAircraftFromCsv(conn):
    print('Inserting from aircraft.rtf...')
    rows = getRowsFromCsv('aircraft.rtf')
    for aircraft in rows:
        row = aircraft.split(',')
        obj = Aircraft(row[0], row[2], row[3])
        obj.addToDatabase(conn)
    print('Completed inserting')

def insertAirportFromCsv(conn):
    print('Inserting from airport.rtf...')
    rows = getRowsFromCsv('airport.rtf')
    for aircraft in rows:
        row = aircraft.split(';')
        if (isValidAirport(row)):
            obj = Airport(row[0], row[3], row[2])
            obj.addToDatabase(conn)
    print('Completed inserting')

def getRowsFromCsv(filename):
    rows = []
    with open(filename, 'r') as file:
        for line in file:
            rows.append(line)
    return rows

def isValidAirport(row):
    answer = True
    if (len(row)<4):
        return False
    elif (not row[0] or not row[2]):
        return False
    elif (len(row[3])!=3):
        return False
    return answer

def insertReviews(conn):
    rows = getRowsFromCsv('reviews.csv')
    print(len(rows))
    for r in rows:
        try:
            if (len(r)>=19):
                row = r.split(',')
                obj = AirlineReview("AF", row[2], row[4], row[10], row[11], row[12], row[13], row[14], row[15], row[16], row[1], row[17])
                obj.addToDatabase(conn)
        except Exception  as e:
            print (e)

def main():
    load_dotenv()
    conn = establishMysqlConnection()
    print(
        "1. Load Airport Data\n2. Load Aircraft Data\n3. Scrape Twitter Data\n4. Load AirlineData\n5. Exit" 
    )
    userInput = input()
    match userInput:
        case '1':
            insertAirportFromCsv(conn)
        case '2':
            insertAircraftFromCsv(conn)
        case '3':
            twitterApiManager = TwitterApiManager(conn)
            twitterApiManager.addTweetsToDatabase()
        case '4':
            insertAirlineFromCsv(conn)
        case '5':
            insertFlightScheduleFromCsv(conn)
        case '6':
            insertReviews(conn)
    closeMysqlConnection(conn)

if __name__ == "__main__":
    main()