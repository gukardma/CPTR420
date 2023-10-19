library("lubridate")
library("dplyr")
library("tidyr")

lakers <- lubridate :: lakers

# 1. Who are the players on the team?
players <- unique(lakers$player[!is.na(lakers$player)])

# 2. How many games are played (Home and Away)?
length(unique(lakers$date[!is.na(lakers$date)]))

# 3. For each game, who was the opposing team for each game? (Show date and team)
game <- lakers %>%
  select(date, opponent) %>%
  distinct(date, .keep_all = TRUE) %>%
  filter(!is.na(date))

# 4. How long did the season last (number of weeks)?
lakers$date_as_date <- as.Date(as.character(lakers$date_integer), format = "%Y%m%d")


# 5. How long ago did the season end (number of months)?


# 6. The MVP for each game is the player who made the most shots. Who is the MVP for each 
# game?


# 7. Who was the MVP for the season?


# 8. What was the average time between shots attempted for each game?


# 9. What is the longest time between shots made for each game?


# 10. Approximately how long did each game last?


# 11. What was the most popular game day. Show the number of games played on each day of the 
# week?


# 12. During which years and months were games played?


# 13. Were any games played on Christmas day or New Year’s Day, Thanksgiving Day?

