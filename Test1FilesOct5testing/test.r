library(dplyr)
library(tidyr)

# 2.
movies <- read.csv("Test1FilesOct5testing/Test1Movies.csv", header = TRUE, na.strings = "")
language_codes <- read.csv("Test1FilesOct5testing/language-codes.csv", header = TRUE, na.strings = "")

test <- movies %>%
    select(Budget) %>%
    mutate(
        as_char = as.character(movies$Budget)
    )

typeof(movies$Budget)
