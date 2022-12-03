import sys
sys.path.insert(0, '/Users/skudli/Documents/Sudarshan/Information Systems/Sem 1/DMDD/Assignments/Scrape Twitter/src')
from twitter.twitterApiHelper import *
from twitter.twitterSqlHelper import *

class TwitterApiManager:
    #fetch tweets
    #check if author present in users table
    #add author to user table if not exists
    #cleaning
    #insert to mysqsl
    def __init__(self, conn):
        self.twitterSqlHelper = twitterSqlHelper(conn)

    def addTweetsToDatabase(self):
        try:
            tweets = twitterApiHelper.fetchTweetsFromTwitterApi("tweet", "search", 10)
            if (len(tweets["data"]) == 0):
                raise Exception("No tweets found")
            for tweet in tweets["data"]:
                userId = tweet["author_id"]
                user = twitterApiHelper.fetchUserFromTwitterApi(userId)
                self.twitterSqlHelper.insertUser(user["data"])
                self.twitterSqlHelper.insertTweets(tweet["id"], tweet["author_id"], tweet["text"], tweet["created_at"])
        except Exception as e:
            print("Error adding tweet,", e)

