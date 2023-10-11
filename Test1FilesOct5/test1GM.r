# Guichard Manigat
# 10_5_23
# test1GM

# I Guichard Manigat declare that no unauthorized documents or person was
# used for help to complete this exercise.

# 1.
library(dplyr)
library(tidyr)

# 2.
movies <- read.csv("Test1FilesOct5/Test1Movies.csv", header = TRUE, na.strings = "")
language_codes <- read.csv("Test1FilesOct5/language-codes.csv", header = TRUE, na.strings = "")

# 3. What are the data types of the variables?
summary(movies)

# 4. Examine the data, show a sample, the first or last 5 observations.
head(movies)

# 5. Convert the following to numbers if necessary:
typeof(movies$Budget)
typeof(movies$Box_Office)
# They are both numerical

# 6. Run basic stats to get an idea of the distribution of the data i.e. min,
# max, mean, median, quartiles, etc. and number of NAs for the variables
summary(movies)

# 7. The variable Release_Date is shown as mm/dd/yy, split this into three
# separate columns: Month, Day, Year. Discard the original Release_date column.
movies <- movies %>%
    separate(col = "Release_Date", c("Month", "Day", "Year"), sep = "/", remove = TRUE, convert = TRUE)
# I also use convert because otherwise the resulting columns are of type char

# 8: The Languages and Countries columns are not necessary for our analysis. Remove it.
movies <- movies %>%
    select(-c("Languages", "Countries"))

# 9 Remove all the rows where the language-codes.csv is not known.
sum(is.na(language_codes$code))
# did not find any NA, but drop anyways just in case
language_codes <- drop_na(language_codes)

# 10. The Running_Time is currently type chr because it has the units attached
# e.g. 80 minutes. Write the code to create a column called Movie_Length that
# will have just the number of minutes and will be an integer. The new
# Movie_Length column should replace Running_Time and must be integer type.
movies <- movies %>%
    separate(col = "Running_Time", c("Movie_Length", NA), sep = " ", remove = TRUE, convert = TRUE)
# Specify ("Movie_Length", NA) to drop the second row created after separation,
# leaving only movie length
typeof(movies$Movie_Length)
# check dtype

# 11. The Produced_by column has the names of the movie producers. Several movies
# have more than one producer. Split his into three new columns: Producer_1,
# Producer_2, Producer_3 that will have the name of the first three producers.
# Note that some movies may have fewer than 3. For those that have more than 3,
# just ignore the others. Remove extra spaces from the data in these columns.
movies <- movies %>%
    separate(
        col = "Produced_By",
        c("Producer_1", "Producer_2", "Producer_3"),
        sep = ", ",
        remove = TRUE,
        extra = "drop"
    )

# 12. Add a column called Language to the data. This column will have the name of
# the language represented by the Language_Abbr column. The codes csv file has
# corresponding language names for the codes.
movies <- movies %>% inner_join(language_codes, c("Language_Abbr" = "Code"))

# 13. Which movie had the largest income (i.e. box_office)
num_13 <- movies %>%
    select(Box_Office) %>%
    sort(decreasing = FALSE)

# 14. Which did Jordan Kerner produce? Show the Title, release date, and
# the producer.
num_14 <- movies %>%
    select(Title, Month, Day, Year, Producer_1, Producer_2, Producer_3) %>%
    filter(Producer_1 == "Jordan Kerner" | Producer_2 == "Jordan Kerner" | Producer_3 == "Jordan Kerner")

#15 Which were the 5 most successful movies based on profit? Show the Title,
# Budget and Box Office values. Note that the budget information is missing
# for some movies.
num_15 <- movies %>%
    select(Title, Budget, Box_Office) %>%
    group_by(Box_Office) %>%
    sort(decreasing = FALSE)

#16 What is the number of movies, average budget and average box office by language.
# Note that the data might be missing for some movies.
num_16 <- movies %>%
    group_by(Language) %>%
    summarize(
        numMovies = n(),
        avg_budget = mean(Budget, na.rm = TRUE),
        avg_box_office = mean(Box_Office, na.rm = TRUE),
    )

#17. What is the most popular day for movie release? Show the day number, number of
# movies released, total budget, total box office
num_17 <- movies %>%
    select(Day) %>%
    group_by(Day) %>%
    summarize(numMovies = n())



test <- movies %>%
    select(Budget)
