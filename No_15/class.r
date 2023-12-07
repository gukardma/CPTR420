install.packages("tidyverse")
install.packages("tm")
install.packages("wordcloud2")
install.packages("SnowballC")
library(tidyverse)
library(tm) #text mining
library(worldcloud2) # for building cloud
library(dplyr)
library(snowballc)

sampleData <- c("Marry had 1 little lamb, it's fleece was white as snow",
"Mary, MAry quite contrary, how does your garden grow",
"Little Jack Horner sat in a corner, eating 3 christmas pies")

#create corpus from v source
my_Data <- Corpus(VectorSource(sampleData))

#check
inspect(my_Data)
content(my_Data[1])

#clean
my_data_Clean <- my_Data %>%
    tm_map(removeNumbers) %>%
    tm_map(removePunctuation) %>%
    tm_map(content_transformer(tolower)) %>%
    tm_map(stemDocument())

#check data
inspect(my_Data_Clean)
inspect(my_Data_Clean[1])


# term docoument matrix
my_TDM <- TermDocumentMatrix(my_data_Clean) %>%
    as.matrix()

#check
my_TDM

my_data_freq <- sort(rowSums(my_TDM), decreasing = TRUE)
my_data_freq

my_data_df <- data.frame(word=names(my_data_freq), occurs=my_data_freq)

my_data_df

ggplot(my_data_df, aes(x=word, y=occurs)) +
    geom_col()

wordcloud2(my_data_df)
letterCloud(my_data_df, 'A')