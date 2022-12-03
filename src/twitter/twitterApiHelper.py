import requests
import os
import sys
sys.path.insert(0, os.getenv('SOURCE_PATH'))

class twitterApiHelper:
    def createUrlForTweets(resource, objective, maxResults):
        if (maxResults > 30):
            maxResults = 30
        params = []
        language = "en"
        url = os.getenv('TWITTER_BASE_URL')
        if (resource == "tweet" and objective == "search"):
            url += "/tweets/search/recent?"
            query = "%23qatarairways (holiday OR review OR baggage OR business OR economy)" + f"lang:{language}"
            fields = ["author_id", "created_at"]
            params.append(f"query={query}")
            params.append(f"tweet.fields={','.join(str(field) for field in fields)}")
            params.append(f"max_results={maxResults}")
        url += '&'.join(str(param) for param in params)
        return url

    def createUrlForUsers(objective, userId):
        params = []
        url = os.getenv('TWITTER_BASE_URL')
        if (objective == "get"):
            url += f"/users/{userId}?"
            fields = ["profile_image_url", "created_at", "username", "description", "public_metrics"]
            params.append(f"user.fields={','.join(str(field) for field in fields)}")
        url += '&'.join(str(param) for param in params)
        return url

    def bearerOauth(r):
        r.headers["Authorization"] = f"Bearer {os.getenv('TWITTER_BEARER_TOKEN')}"
        r.headers["User-Agent"] = "v2TweetLookupPython"
        return r

    def fetchTweetsFromTwitterApi(resource, objective, maxResults=10):
        url = twitterApiHelper.createUrlForTweets(resource, objective, maxResults)
        response = requests.request("GET", url, auth=twitterApiHelper.bearerOauth)
        if response.status_code != 200:
            raise Exception(
                "Request returned an error: {} {}".format(response.status_code, response.text)
            )
        return response.json()

    def fetchUserFromTwitterApi(userId):
        url = twitterApiHelper.createUrlForUsers("get", userId)
        response = requests.request("GET", url, auth=twitterApiHelper.bearerOauth)
        if response.status_code != 200:
            raise Exception(
                "Request returned an error: {} {}".format(response.status_code, response.text)
            )
        return response.json()