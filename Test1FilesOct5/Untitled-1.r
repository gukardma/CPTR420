library(dplyr)
library(tidyr)

# 2.
movies <- read.csv("Test1FilesOct5/Test1Movies.csv", header = TRUE, na.strings = "")
test <- movies %>%
    select(Budget) %>%
    mutate(
        as_char = as.character(movies$Budget)
    )