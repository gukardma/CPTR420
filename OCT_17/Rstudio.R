#Guichard Manigat

library("lubridate")
library("dplyr")
library("tidyr")

# 0. Setup
lakers <- lubridate :: lakers
lakers$time <- hm(lakers$time)
lakers$date <- ymd(lakers$date)

# 1. Who are the players on the team?
Ques_1 <- unique(lakers$player[!is.na(lakers$player)])

# 2. How many games are played (Home and Away)?
length(unique(lakers$date[!is.na(lakers$date)]))

# 3. For each game, who was the opposing team for each game? (Show date and team)
Ques_3 <- lakers %>%
  select(date, opponent) %>%
  distinct(date, .keep_all = TRUE) %>%
  filter(!is.na(date))

# 4. How long did the season last (number of weeks)?
difftime(max(lakers$date), min(lakers$date), units = "weeks")

# 5. How long ago did the season end (number of months)?
Ques_5 <- as.period(interval(max(lakers$date), Sys.Date()))$year * 12 +
  as.period(interval(max(lakers$date), Sys.Date()))$month

# 6. The MVP for each game is the player who made the most shots. Who is the MVP for each 
# game?
Ques_6 <- lakers %>%
  group_by(date) %>%
  summarise(MVP = player[which.max(points)])

# 7. Who was the MVP for the season?
Ques_7 <- lakers %>%
  group_by(player) %>%
  summarise(totalPoints = sum(points)) %>%
  arrange(desc(totalPoints)) %>%
  head(1)

# 8. What was the average time between shots attempted for each game?
Ques_8 <- lakers %>%
  group_by(date) %>%
  arrange(date, time) %>%
  mutate(  ) 

# 9. What is the longest time between shots made for each game?
Ques_9 <- lakers %>%
  group_by(date, opponent) %>%
  summarize(diff = max((x - lag(y)), na.rm = TRUE))

# 10. Approximately how long did each game last?


# 11. What was the most popular game day. Show the number of games played on each day of the 
# week?


# 12. During which years and months were games played?


# 13. Were any games played on Christmas day or New Year’s Day, Thanksgiving Day?