# 0/20/23
# Guichard Manigat

# Laods library
library(dplyr)


library(magrittr)
# Choses file to read, keeps header, and converts blank variables into NA strings
yourFileName <- read.csv(file.choose(), header=T, na.strings = '')


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
