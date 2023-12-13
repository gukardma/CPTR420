# DEC_11_2023
# Guichard Manigat
# Final

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(stringr)
library(lubridate)
library(corrplot)
library(tmap)
library(tidytext)
library(class)
library(caret)

# Importing dataframe
df <- read.csv("Final/HOUSING.csv", header = TRUE, na.strings = "")

print(colnames(df_clean))

# Removing unnecessary columns
df <- select(df, -UnitId, -Fireplaces, -Heating)

# Removing columns with missing sclerite
df_clean <- filter(df, complete.cases(df$SalePrice))

# Remove ft from frontage and make it numeric
df_clean$LotFrontage <- gsub(" ft\\.", "", df_clean$LotFrontage)
df_clean$LotFrontage <- as.numeric(df_clean$LotFrontage)

# Replace missing frontage with minimum legal lot: 20ft
df_clean$LotFrontage[is.na(df_clean$LotFrontage)] <- 20

# Check
class(df_clean$LotFrontage)
print(sum(is.na(df_clean$LotFrontage)))

# Remove sq ft from columns
df_clean$LotArea <- gsub(" sq\\. ft\\.", "", df_clean$LotArea)
df_clean$LotArea <- as.numeric(df_clean$LotArea)
class(df_clean$LotArea)

# Seperate Gr_Bsmt into 2 columns
df_clean <- separate(df_clean, col = Gr.Bsmt, into = c("above_ground_area", "basement_area"), sep = ":")
df_clean$above_ground_area <- as.numeric(df_clean$above_ground_area)
df_clean$basement_area <- as.numeric(df_clean$basement_area)

# Transform datesold
df_clean$DateSold <- mdy(df_clean$DateSold)

# How many of each style of house were sold?  (sort by most to least)
HousesSold <- df_clean %>%
    select(HouseStyle) %>%
    group_by(HouseStyle) %>%
    summarize(
        numSold = n(),
    ) %>%
    arrange(desc(numSold))

# What are the different types of building and average Lot Area for each type?
BuildingTypes <- df_clean %>%
    select(BldgType, LotArea) %>%
    group_by(BldgType) %>%
    summarize(
        avgArea = mean(LotArea, na.rm = TRUE),
    ) %>%
    arrange(desc(avgArea))

# How does price vary with total area i.e. above ground + basement + woodDeck + OpenPorch square footage?   Prepare a chart. The chart should also  use
# color to indicate the SalesCategory of the homes.  Add appropriate titles labels and legends.
df_clean$TotalArea <- df_clean$above_ground_area + df_clean$basement_area + df_clean$WoodDeck + df_clean$OpenPorchSF

ggplot(df_clean, aes(x = TotalArea, y = SalePrice, color = PriceCategory)) +
    geom_point() +
    labs(x = "Total Area Square Footage", y = "Price", title = "Price vs Total Area") +
    theme_minimal()

# What is the sale trend throughout the year (in terms of number of homes sold)?  Prepare a well
# labeled line or bar chart
# Create column with just the months
df_clean$Month <- month(df_clean$DateSold)

# Find how many homes were sold per month
sales_trend <- df_clean %>%
    group_by(Month) %>%
    summarize(Count = n())

# Plot
ggplot(sales_trend, aes(x = Month, y = Count)) +
    geom_line() +
    labs(x = "Month", y = "Number of Homes Sold", title = "Sale Trend Throughout the Year")


####### KNN
# Create column for total baths
df_clean$TotalBaths <- df_clean$FullBath + df_clean$HalfBath

# Choose and normalize data
df_KNN <- df_clean[c("LotFrontage", "LotArea", "above_ground_area", "basement_area", "TotalBaths", "BedroomAbvGr", "TotRmsAbvGrd", "GarageArea", "OpenPorchSF", "SalePrice")]
normalized_df <- as.data.frame(scale(df_KNN))

# Data
train_all <- df_KNN[c("LotFrontage", "LotArea", "above_ground_area", "basement_area", "TotalBaths", "BedroomAbvGr", "TotRmsAbvGrd", "GarageArea", "OpenPorchSF")]

# Get labels from the sample
labels_all <- df_KNN[c("SalePrice")]
labels_all <- labels_all[, 1]

NewData <- data.frame(LotFrontage = 98, LotArea = 11478, above_ground_area = 1704, basement_area = 1704, TotalBaths = 2, BedroomAbvGr = 3, TotRmsAbvGrd = 7, GarageArea = 772, OpenPorchSF = 50)

# Find k
k <- round(sqrt(nrow(train_all)))
if (k %% 2 == 0) k <- k + 1

# Checking the accuracy of the model
train <- normalized_df %>% sample_frac(.75)
test <- anti_join(normalized_df, train)

# Separate the labels and variables form the 2 sets
train_labels <- train[c("SalePrice")]
train_labels <- train_labels[, 1]
train <- train[c("LotFrontage", "LotArea", "above_ground_area", "basement_area", "TotalBaths", "BedroomAbvGr", "TotRmsAbvGrd", "GarageArea", "OpenPorchSF")]

test_labels <- test[c("SalePrice")]
test_labels <- test_labels[, 1]
test <- test[c("LotFrontage", "LotArea", "above_ground_area", "basement_area", "TotalBaths", "BedroomAbvGr", "TotRmsAbvGrd", "GarageArea", "OpenPorchSF")]

KNN_Results <- knn(train, test, train_labels, k = k)
KNN_Results # Show the label fo the new data

# Predicting the price of house
KNN_Results <- knn(train, NewData, train_labels, k = k)
KNN_Results
