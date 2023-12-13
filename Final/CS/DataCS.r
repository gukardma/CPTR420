# R Cheat Sheet

###### Get Data

# CSV
data <- read.csv("file.csv")

# Excel
library(readxl)
data <- read_excel("file.xlsx")

# Tidyverse (dplyr, ggplot2, tidyr, readr, stringr)
library(tidyverse)
data <- mpg

# Lubridate
library(lubridate)
date <- ymd("2023-01-31")

# Tmap
library(tmap)
tm_shape(data) + tm_bubbles("variable")


#### Working with different data types
library(lubridate)
date <- ymd("2023-01-31")


#### Handling Missing Data
# Identify missing values
missing_values <- is.na(data)

# Locate missing values in a specific column
missing_in_column <- data$column_name[is.na(data$column_name)]

# Remove rows with any missing values
data_clean <- na.omit(data)

# Remove rows with missing values in a specific column
data_clean <- data[complete.cases(data$column_name), ]

# Replace missing values with a fixed value
data$column_name[is.na(data$column_name)] <- 0

# Replace missing values with the mean of the column
data$column_name[is.na(data$column_name)] <- mean(data$column_name, na.rm = TRUE)

# Replace missing values based on another variable
data$column_name[is.na(data$column_name)] <- data$related_column[is.na(data$column_name)]

# Identify duplicate rows
duplicated_rows <- df[duplicated(df), ]
# Remove duplicate rows
df <- unique(df)

# Rename columns
colnames(df) <- c("new_name1", "new_name2", ...)
