import mysql.connector
import os

# establishing the connection and creating cursor
def establishMysqlConnection():
    try:
        conn = mysql.connector.connect(user = os.getenv('MYSQL_USER'), password = os.getenv('MYSQL_PASSWORD'), host = os.getenv('MYSQL_HOST'), database = os.getenv('MYSQL_DB'))
        print(f"Connection established to '{conn.database}'")
        return conn
    except Exception as e:
        print("Error connecting to ", os.getenv('MYSQL_DB'), "\n", e)

# closing the connection
def closeMysqlConnection(conn):
    try:
        conn.cursor().close()
        print(f"Connection to '{conn.database}' closed")
    except:
        print("No Connection found")