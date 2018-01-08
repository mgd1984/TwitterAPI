
# 1. Load libraries ####
library(twitteR)
library(ggplot2)


# 2. Authenticate with Twitter's API ####
consumer_key <- "mMnuLEJCBKhzf3UVmcfPUCAdG"
consumer_secret <- "CK2dsT6gtos0CmjclN0v9sQqJ85TtNGj3AFozpxysqr1p807zh"
access_token <- "165621372-kcNw3OUxMIBfMgkXJxUo3KYw1XKcXz5gc3wD2Pdt"
access_secret <- "MIVq4u9jHiRRXHzYdIzvzT2w7i4wfKPWaNJvjnG1ZwRQa"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# 3. Search Twitter by '#hashtag'
(tweets = searchTwitter('#techfest')
head(tweets)

# 4. Get a User's Tweets, Description & Other Metrics about a User
mgd_1984 = getUser('techvibes')
mgd_1984$getDescription()
mgd_1984$favoritesCount
mgd_1984$created
mgd_1984$location
mgd_1984$friendsCount
mgd_1984$followRequestSent
mgd_1984$followersCount
mgd_1984$statusesCount
mgd_1984$getFavorites(n=10)

# 5. Convert list of tweets into a data.frame using 'twListToDF' ####
df = twListToDF(tweets)
View(df)

# Pull a Twitter user's Home Timeline and create df with relevant columns.
mgd_1984_timeline = homeTimeline(n=100)
df2 = twListToDF(mgd_1984_timeline)
View(df2)
df3 = df2[,c(1,11,3,10,12)]
View(df3)

# 6. Seach with 'availableTrendLocations' then set location with 'getTrends' ####
avail_trends = availableTrendLocations()
head(avail_trends)
TO_trends_4_25_17 = getTrends(c(4118))
head(TO_trends_4_25_17)

# 7. Take a look at your Twitter API rate limits ####
API_limits <- twitteR::getCurRateLimitInfo()
View(API_limits)

# 8. Practice plotting data received through Twitter API ####
library(ggplot2)
TO_Housing_Tweets <- searchTwitter("#torontohousing",n=70)
sources <- sapply(TO_Housing_Tweets, function(x) x$getStatusSource())
sources <- gsub("</a>","",sources)
sources <- strsplit(sources, ">")
sources <- sapply(sources,function(x) ifelse(length(x) > 1, x[2], x[1]))
source_table = table(sources)
filtered_sources = names(source_table[source_table < quantile(source_table)])
sources[sources %in% filtered_sources] = "other"
source_df = as.data.frame(sources)
ggplot(source_df,aes(sources)+geom_bar() + coord_flip())

# 9. Practice scripting with other TwitteR functions ####
twitteR::as.data.frame()
JamesGRickards = twitteR::lookupUsers('JamesGRickards')
JamesGRickards$JamesGRickards$description

JGR = getUser('JoeRogan')
JGR$description
JGR$created
JGR$lastStatus
JGR$getDescription()
JGR$getFavorites()
JGR$followersCount
JGR$listedCount
JGR$verified
JGR$getFollowersCount()
JGR$getStatusesCount()
JGR$getFriends()
