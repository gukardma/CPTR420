# 0/20/23
# Guichard Manigat

# Laods library
library(dplyr)

# Choses file to read, keeps header, and converts blank variables into NA strings
yourFileName <- read.csv(file.choose(), header=T, na.strings = '')


# Randomly select 3/5 of the data into a new dataframe
GM_sampleDF <- yourFileName %>%
    slice_sample(prop=.10)


class(GM_sampleDF)

print(GM_sampleDF)
# List all column names
colnames(GM_sampleDF)


GM_sampleDF <- GM_sampleDF['CARRIER']=='Airliner'
