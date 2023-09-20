library(dplyr)

yourFileName <- read.csv(file.choose(), header=T, na.strings = '')

GM_sampleDF <- yourFileName %>%
    slice_sample(prop=.10)

# List all the column names
colnames(GM_sampleDF)

GM_sampleDF <- GM_sampleDF['CARRIER']=='Airliner'
