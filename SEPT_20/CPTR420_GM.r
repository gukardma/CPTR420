# 9/20/23
# Guichard Manigat

# If not installed, install the package
if (!requireNamespace("dplyr", quietly = TRUE)) {
    install.packages("dplyr")
}

# Loads library
library(dplyr)

# 0 Check if file exists, otherwise choose, keeps header, and converts blank variables into NA strings
if (file.exists("CPTR420_9_20/September_19_Data.csv")) {
    df <- read.csv("CPTR420_9_20/September_19_Data.csv", header = TRUE, na.strings = "")
} else {
    df <- read.csv(file.choose(), header = TRUE, na.strings = "")
}

# 1 Randomly select 3/5 of rows in df into GM_sampleDF
GM_sampleDF <- df %>%
    sample_frac(0.6)

# 2 List all the column names
colnames(GM_sampleDF)

# 3 Drop the two columns WHEELS_OFF and WHEELS_ON
GM_sampleDF <- GM_sampleDF %>%
    select(-c("WHEELS_OFF", "WHEELS_ON"))

# 4 Change the name of column CARRIER to Airline
GM_sampleDF <- GM_sampleDF %>%
    rename("Airline" = "CARRIER")

# 5 Remove leading/trailing spaces in DEST_STATE and ORIGIN_STATE (Does not work?)
GM_sampleDF <- GM_sampleDF %>%
    mutate(DEST_STATE = trimws(DEST_STATE), ORIGIN_STATE = trimws(ORIGIN_STATE))

# 6 Show all variables for Southwest (WN) flights
GM_sampleDF %>% filter(Airline == "WN")

# 7 Show flight date, carrier, origin city, destination city for all observations(i.e. rows)
GM_sampleDF %>% select(FL_DATE, Airline, ORIGIN_CITY, DEST_CITY)

# 8 Show Flight Date, Origin, Destination, Airline, Cancelled, Cancellation Code of all cancelled flights
QUES_8 <- GM_sampleDF %>%
    filter(CANCELLED == 1) %>%
    select(FL_DATE, ORIGIN_CITY, DEST_CITY, Airline, CANCELLED, CANCELLATION_CODE)

# 9 Show Flight Date, Carried, Origin, Destination, Origin State, Destination State, Scheduled Departure time, Scheduled Arrival Time for flights between New York Airports
QUES_9 <- GM_sampleDF %>%
    filter(ORIGIN_CITY == "New York" | DEST_CITY == "New York") %>%
    select(c("FL_DATE", "Airline", "ORIGIN_CITY", "DEST_CITY", "ORIGIN_STATE", "DEST_STATE", "DEP_TIME", "ARR_TIME"))

# 10 Show Flight Date, Carrier, Day Name, Origin, Destination for Delta (DL) flights going to Miami on Friday
QUES_10 <- GM_sampleDF %>%
    filter(DEST_CITY == "Miami" & DAY_NAME == "Friday") %>%
    select(c("FL_DATE", "Airline", "DAY_NAME", "ORIGIN_CITY", "DEST_CITY"))

# 11 Show Flight Date, Carrier, Origin, Destination, Destination CIty, and Scheduled Departuer Time of flights between JFK or LGA and Florida
QUES_11 <- GM_sampleDF %>%
    filter(ORIGIN == "JFK" | ORIGIN == "LGA") %>%
    filter(DAY_NAME == "Friday") %>%
    select(c("FL_DATE", "Airline", "ORIGIN", "DEST", "DEST_CITY", "DEP_TIME"))

# 12 Show flight date, carrier, origin, destination, and distance for all flights
# with a distance more than 2200. SHow th results in order from tnearest to farthest
QUES_12 <- GM_sampleDF %>%
    filter(DISTANCE > 2200) %>%
    arrange(DISTANCE) %>%
    select(c("FL_DATE", "Airline", "ORIGIN", "DEST", "DISTANCE"))

# 13 Create a df called longFlghts and...
longFlights <- GM_sampleDF %>%
    select(c("FL_DATE", "Airline", "ORIGIN", "DEST", "TAXI_OUT", "TAXI_IN", "AIR_TIME")) %>%
    mutate(Flight_Time = TAXI_OUT + TAXI_IN + AIR_TIME) %>%
    filter(Flight_Time > 360)

# 14 Show the average departure delay for each carrier for flights from jfk
QUES_14 <- GM_sampleDF %>%
    filter(ORIGIN == "JFK") %>%
    group_by(Airline) %>%
    summarise(AVG_DEP_DELAY = mean(DEP_DELAY, na.rm = TRUE))

# 15 How many flight leave New York each day of the week
QUES_15 <- GM_sampleDF %>%
    filter(ORIGIN_CITY == "New York") %>%
    group_by(DAY_NAME) %>%
    summarise(NUM_FLIGHTS = n()) %>%
    arrange(NUM_FLIGHTS)

# 16 Which are the 10 most popular airlines (based on number of flights for that airline)
QUES_16 <- GM_sampleDF %>%
    group_by(Airline) %>%
    summarise(NUM_FLIGHTS = n()) %>%
    arrange(NUM_FLIGHTS)