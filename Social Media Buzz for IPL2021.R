#Creating authentication variables for Twitter API authentication
api_key <- 'ZlnoVvWFgBOCU1TaBqeXmGQVT'
api_secret_key <- '5tXR4AKwrZkdnnea0uboaQ2r8Cd1h9LSxOd2Zew3IqnFjnDxXi'
access_token <- '2197831272-bj4OR0SL8FJBK0VIoJCTBobCYarwMeK27uUEkBZ'
access_token_secret <- 'Ncboxv4p4YRgRdXEyDnz9IE5hgoiNF0h5LGQ5Cd6AOkth'

#Loading the twitteR library 
library(twitteR)

#Establishing Twitter connection via API
setup_twitter_oauth(api_key, api_secret_key, access_token, access_token_secret)

#Extracting tweets and storing them in a variable
tweets <- searchTwitter("#IPL2021", n=10000, lang = 'en')
summary(tweets)

#Stripping off the redundant retweets
noretweets <- strip_retweets(tweets, strip_manual = TRUE)
summary(noretweets)

#Converting the stored tweets into a dataframe
tweetsdf <- twListToDF(noretweets)

#Obtaining user profile names for the tweets
userInfo <- lookupUsers(tweetsdf$screenName) #Batch lookup of user info
userFrame <- twListToDF(userInfo) #Converting into another dataframe
summary(userFrame)
userFrame

#Merging the tweet and user information dataframes
finalTweetsdf <- merge(tweetsdf, userFrame, by = "screenName")
finalTweetsdf

#Creating and writing into a csv file
write.csv(finalTweetsdf, "R_IPL2021.csv")