from twitter.twitterApiManager import *
from sql.connection import *
from dotenv import load_dotenv
from model.aircraft import *
from model.airport import *
from model.airline import *

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
    rows = getRowsFromCsv('aircraft_type.rtf')
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
    filename = 'airport.rtf'
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
    closeMysqlConnection(conn)

if __name__ == "__main__":
    main()