# 0/20/23
# Guichard Manigat

# View(GM_sampleDF)

install.packages(c("dplyr"))

# Loads library
library(dplyr)


# 0 Choses file to read, keeps header, and converts blank variables into NA strings
# Relative path
# yourFileName <- read.csv("CPTR420_9_20/September_19_Data.csv", header = T, na.strings = "")

yourFileName <- read.csv(file.choose(), header = T, na.strings = "")

# 1 Randomly select 3/5 of rows in yourFileName into GM_sampleDF
GM_sampleDF <- yourFileName %>%
    sample_frac(3 / 5)

# 2 List all the column names
colnames(GM_sampleDF)

# 3 Drop the two columns WHEELS_OFF and WHEELS_ON
GM_sampleDF <- GM_sampleDF %>%
    select(-c("WHEELS_OFF", "WHEELS_ON"))

# Check if exists (returns error)
# GM_sampleDF['WHEELS_OFF']

# 4 Change the name of column CARRIER to Airline
GM_sampleDF <- GM_sampleDF %>%
    rename("Airline" = "CARRIER")

# colnames(GM_sampleDF)

# 5 Remove leading/trailing spaces in DEST_STATE and ORIGIN_STATE
GM_sampleDF <- GM_sampleDF %>%
    mutate(
        GM_sampleDF["DEST_STATE"] <- trimws(GM_sampleDF["DEST_STATE"]),
        GM_sampleDF["ORIGIN_STATE"] <- trimws(GM_sampleDF["ORIGIN_STATE"])
    )

# 6 Show all variables for Southwest (WN) flights
GM_sampleDF_WN <- GM_sampleDF %>%
    filter(Airline == "WN")


# 7 Show flight date, carrier, origin city, destination city for all observations(i.e. rows)
GM_sampleDF_Sel <- GM_sampleDF %>%
    select(c("FL_DATE", "Airline", "ORIGIN_CITY", "DEST_CITY"))

# 8 Show Flight Date, Origin, Destination, Airline, Cancelled, Cancellation Code of all cancelled flights
GM_sampleDF_Cancled <- GM_sampleDF %>%
    filter(CANCELLED == 1) %>%
    select(c("FL_DATE", "ORIGIN_CITY", "DEST_CITY", "Airline", "CANCELLED", "CANCELLATION_CODE", ))

# 9 Show Flight Date, Carried, Origin, Destination, Origin State, Destination State, Scheduled Departure time, Scheduled Arrival Time for flights between New York Airports
GM_sampleDF_New_York <- GM_sampleDF %>%
    filter(ORIGIN_CITY == "New York" | DEST_CITY == "New York") %>%
    select(c("FL_DATE", "Airline", "ORIGIN_CITY", "DEST_CITY", "ORIGIN_STATE", "DEST_STATE", "DEP_TIME", "ARR_TIME"))

# 10 Show Flight Date, Carrier, Day Name, Origin, Destination for Delta (DL) flights going to Miami on Friday
GM_sampleDF_FD <- GM_sampleDF %>%
    filter(DEST_CITY == "Miami" & DAY_NAME == "Friday") %>%
    select(c("FL_DATE", "Airline", "DAY_NAME", "ORIGIN_CITY", "DEST_CITY"))

# 11 Show Flight Date, Carrier, Origin, Destination, Destination CIty, and Scheduled Departuer Time of flights between JFK or LGA and Florida
GM_sampleDF_JFK <- GM_sampleDF %>%
    filter(ORIGIN == "JFK" | ORIGIN == "LGA") %>%
    filter(DAY_NAME == "Friday") %>%
    select(c("FL_DATE", "Airline", "ORIGIN", "DEST", "DEST_CITY", "DEP_TIME"))

# 12 Show flight date, carrier, origin, destination, and distance for all flights
# with a distance more than 2200. SHow th results in order from tnearest to farthest
GM_sampleDF_Dist <- GM_sampleDF %>%
    filter(DISTANCE > 2200) %>%
    arrange(DISTANCE) %>%
    select(c("FL_DATE", "Airline", "ORIGIN", "DEST", "DISTANCE"))

colnames(GM_sampleDF)

# 13 Create a df called longFlghts and...
longFlights <- GM_sampleDF %>%
    select(c("FL_DATE", "Airline", "ORIGIN", "DEST", "TAXI_OUT", "TAXI_IN", "AIR_TIME")) %>%
    mutate(Flight_Time = TAXI_OUT + TAXI_IN + AIR_TIME) %>%
    filter(Flight_Time > 6)
