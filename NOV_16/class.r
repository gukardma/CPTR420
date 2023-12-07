#more text mining
library(tidyverse)
library(tm)
library(wordcloud2)
library(RSentiment)

#get data

data <- read.csv("NOV_16/Nov16Texts.csv")

View(data)

#build corpu

data_corpus <- Corpus(VectorSource(data$Text))

data_corpus
inspect(data_corpus)
content(data_corpus)

clean_data <- data_corpus %>%
    tm_map(removeNumbers) %>%
    tm_map(removePunctuation)%>%
    tm_map(stripWhitespace) %>%
    tm_map(stemDocument) %>%
    tm_map(removeWords,stopwords('en'))

inspect(clean_data)

sent_data <- content(clean_data)

sent_data

calculate_sentiment(sent_data)
calculate_sentiment(data$Text)

calculate_score(sent_data)
calculate_score(data$Text)

calculate_total_presence_sentiment(sent_data)
calculate_total_presence_sentiment(data$Text)
