#Guichard Manigat
#9-28-23

install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)

# 1. load datasets
airlines <- read.csv("SEPT_26_HW/theAirlines.csv", header = TRUE, na.strings = "")
airplanes <- read.csv("SEPT_26_HW/theAirplanes.csv", header = TRUE, na.strings = "")
airport <- read.csv("SEPT_26_HW/theAirport.csv", header = TRUE, na.strings = "")
flights <- read.csv("SEPT_26_HW/theFlights.csv", header = TRUE, na.strings = "")
weather <- read.csv("SEPT_26_HW/theWeather.csv", header = TRUE, na.strings = "")

# 2. view the flights data
summary(flights)

# 3. spit the time_hour column into date and time. Do not remove the original
# column
flights <- separate(flights, col = time_hour, into = c("time", "hour"), sep = "T")

# 4. for each df, decide what you think is the key variable(s) and check to see
# whether there are any duplicates

colnames(airlines) # carrier/names
colnames(airplanes) # tailnum
colnames(airport) # name/faa
colnames(flights) # tailnum
colnames(weather) # time_hour

# 5. Combine the flight day, month, year into a single field called flightDate
# Similarly combine the year, month, day for the weather df into a single column
# called obsDate

flights <- unite(flights, col="flightDate", c("year","month","day"),sep="-", remove=TRUE)

#6. Create a new df called dailyWeather that will have the average temp, average

# Data cleaning
weather <- weather %>%
  mutate(
    temp = as.numeric(temp),
    wind_speed = as.numeric(wind_speed),
    humid = as.numeric(humid)
  )

dailyWeather <- weather %>%
  group_by(origin, day) %>%
  summarize(
    avg_temp = mean(temp, na.rm = TRUE),
    avg_wind_speed = mean(wind_speed, na.rm = TRUE),
    avg_humidity = mean(humid, na.rm = TRUE)
  )

#7. Create a new df called full_flights. This should have (flight, origin,
#desHnaHon, … all the data from flights as well as the appropriate carrier
#name, average temperature, average wind speed and average humidity

full_flights <- flights %>% left_join(dailyWeather, by = "origin", relationship = "many-to-many")
head(full_flights)


#8. Is there a relationship between the age of a plane and its delays?
flight_info <- flights %>% inner_join(airplanes, by = "tailnum")
relation_plane <- flight_info %>%
    group_by(dep_delay, year)
