# Gucihard Manigat
# 11_21_2023
# Test2
# install.packages("")

library(tidyverse)
library(lubridate)
library(corrplot)
library(wordcloud2)
library(tmap)
library(maps)
library(tm)
library(tidytext)
library(dplyr)
library(tidyr)

# 2. Get datasets:
gm_hotel_df <- read.csv("GMTest2/Datafiniti_Hotel_Reviews_Jun19.csv")
gm_crimes_df <- read.csv("GMTest2/state_crime_2019.csv")
gm_state_name <- state.name
gm_state_abb <- state.abb

# 3. Create df called states_df that has column for the name and another
# for abbreviations
states_df <- data.frame(gm_state_name, gm_state_abb)
colnames(states_df) <- c('state_name','state_abbr')

# 4. work on hotel file
# Number of rows and columns
dim(gm_hotel_df)
# First 5 rows
head(gm_hotel_df, n = 5)
#stats
summary(gm_hotel_df)
#remove time from dateadded and dateupdated
gm_hotel_df <- separate(gm_hotel_df, col = dateAdded, into = "dateAdded", sep = "T", remove = TRUE)
gm_hotel_df <- separate(gm_hotel_df, col = dateUpdated, into = "dateUpdated", sep = "T", remove = TRUE)
# drop columns
gm_hotel_df <- gm_hotel_df %>%
    select(-c('keys', 'categories','reviews.date','sourceURLs','reviews.username','reviews.dateAdded','websites'))

colnames(gm_hotel_df)[colnames(gm_hotel_df) == 'province'] <- 'state_abbr'

#Analysis
# 5. How many hotel reviews are there for each state, and what is the
# average for each state
review_df <- gm_hotel_df %>%
    select(state_abbr, reviews.rating) %>%
    group_by(state_abbr) %>%
    summarize(
        numReviews = n(),
        avgRating = mean(reviews.rating, na.rm = TRUE)
        )
# 6
review_df <- review_df %>% left_join(states_df, by = "state_abbr")
# 7
colnames(review_df)[colnames(review_df) == 'state_name'] <- 'State'
review_df <- review_df %>% left_join(gm_crimes_df, by = "State")

# 8
temp <- review_df %>%
    select(c('State', 'Data.Population', 'Data.Rates.Property.All', 'Data.Rates.Violent.All'))

review_df <- review_df %>%
    select(-c(grep('Data', colnames(review_df), value = TRUE)))

review_df <- review_df %>% left_join(temp, by = "State")
# 9.
