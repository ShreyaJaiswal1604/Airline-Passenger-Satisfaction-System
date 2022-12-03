from dotenv import load_dotenv
import sys
sys.path.insert(0, '/Users/skudli/Documents/Sudarshan/Information Systems/Sem 1/DMDD/Assignments/Scrape Twitter/src')

from sql.connection import *

class twitterSqlHelper:
    def __init__(self, conn):
        self.conn = conn
        
    def insertTweets(tweetId, user_id, tweetText, createdAt):
        try:
            query = "INSERT IGNORE INTO tweets(tweet_id, user_id, tweet_text, created_at) " \
                    "VALUES(%s,%s,%s,%s)"
            args = (tweetId, user_id, tweetText, createdAt)
            twitterSqlHelper.executeSqlQuery(query, args)
        except Exception as e:
            print("Error inserting tweet,", e)

    def insertUser(user):
        try:
            query = "INSERT IGNORE INTO users(user_id, twitter_handle, name, profile_image_url, description, followers_count, following_count) " \
                    "VALUES(%s,%s,%s,%s,%s,%s,%s)"
            args = (user["id"], user["username"], user["name"], user["profile_image_url"], user["description"], user["public_metrics"]["followers_count"], user["public_metrics"]["following_count"])
            twitterSqlHelper.executeSqlQuery(query, args)

        except Exception as e:
            print("Error inserting user,", e)

    def executeSqlQuery(query, args):
        twitterSqlHelper.conn.cursor().execute(query, args)
        twitterSqlHelper.conn.commit()

