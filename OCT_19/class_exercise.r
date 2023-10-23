#Guichard Manigat
#10_23_2023

# 1. Install and load the titanic package and store the titanic_train dataset as a dataframe in a new 
# object 
library(tidyverse)
library(titanic)
library(dplyr)

data("titanic_train")
## 2. Prepare the data for visualization:
# a. Remove all observations where the Survived variable is not known
titanic_train <- subset(titanic_train, !is.na(Survived))

# b. Assign the mean age to all ages that are unknown
ages <- mean(titanic_train$Age, na.rm = TRUE)

titanic_train <- titanic_train %>%
  mutate(Age = ifelse(is.na(Age), ages, Age))

# c. Assign the median fare to all unknown fares 
titanic_train <- titanic_train %>%
  mutate(Fare = ifelse(is.na(Fare), median(Fare, na.rm = TRUE), Fare))

# d. Assign S to all Embarked values that are unknown
titanic_train <- titanic_train %>%
  mutate(Embarked = ifelse(is.na(Embarked), "S", Embarked))

# e. Make sure that the Pclass (i.e. Passenger class), and Survived variables are factors. 
titanic_train <- titanic_train %>%
  mutate(Pclass = factor(Pclass),
         Survived = factor(Survived))

# 3. Create another dataframe called survivors_df that has data for the survivors only 
survivors_df <- subset(titanic_train, Survived == 1)

# 4. Create plots for the following 
# a. Show how the number of males and females on the ship compare by age (overlapping 
# histogram with 10 age bins) 
ggplot(survivors_df, aes(x = Age, fill = Sex)) +
  geom_histogram(bins = 10)

# b. Show number of survivors by class
ggplot(survivors_df, aes(x = Pclass)) +
  geom_bar()
# c. Prepare a plot that compares the number of passengers and survivors/non-survivors 
# from each class.  Use a bar with one column of survivors and the other of non-survivors 
# d. Show how the number of male survivors compares with that of females survivors by 
# age.  (bar plot)
# e.  Is survival rate influenced by the port of embarkation? 
# Use a bar chart with Embarked on X axis. plot the bars side by side 
# f. Is there any relationship between Fare and Age?  Use points and smooth 
# g. Is survival related to this relationship between Age and Fare?   
# h.  Is there any correlation between Age and Survived and Gender? 
# i. Create a plot that compares survival by age. 

