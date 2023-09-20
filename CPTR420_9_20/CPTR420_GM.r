# 0/20/23
# Guichard Manigat

# Loads library
library(dplyr)


# Choses file to read, keeps header, and converts blank variables into NA strings
yourFileName <- read.csv('CPTR420_9_20/September_19_Data.csv', header=T, na.strings = '')

#yourFileName <- read.csv(file.choose(), header=T, na.strings = '')


# Randomly select 3/5 of rows in yourFileName into GM_sampleDF
GM_sampleDF <- yourFileName %>%
    sample_frac(3/5)

# List all the column names
colnames(GM_sampleDF)

# Drop the two columns WHEELS_OFF and WHEELS_ON
GM_sampleDF <- GM_sampleDF %>%
    select(-c('WHEELS_OFF','WHEELS_ON'))

# Check if exists (returns error)
#GM_sampleDF['WHEELS_OFF']

# Change the name of column CARRIER to Airline
GM_sampleDF <- GM_sampleDF %>%
    rename('Airline' = 'CARRIER')

#colnames(GM_sampleDF)

#Remove leading/trailing spaces in DEST_STATE and ORIGIN_STATE
GM_sampleDF <- GM_sampleDF %>%
    mutate(
    GM_sampleDF['DEST_STATE'] <- trimws(GM_sampleDF['DEST_STATE']),
    GM_sampleDF['ORIGIN_STATE'] <- trimws(GM_sampleDF['ORIGIN_STATE'])
    )

# Show all variables for Southwest (WN) flights
GM_sampleDF <- GM_sampleDF %>%
    filter(CARRIER == 'WN')

