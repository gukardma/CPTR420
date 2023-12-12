# DEC 5 KNN
# Data is shirts.csv

library(dplyr) # for managing data
library(class) # for classification including knn
library(caret) # for confusion matrix

# get data
shirts_df <- read.csv('DEC_5/shirts.csv', na.strings = '')

# clean
shirts_clean <- shirts_df[c('Height', 'Weight', 'ShirtSize')]


#normalize height and weight
shirts_norm_df <- shirts_clean %>%
    mutate(Height = (Height - min(Height))/(max(Height)-min(Height))) %>%
    mutate(Weight = (Weight - min(Weight))/(max(Weight)-min(Weight)))


shirts_norm_df$ShirtSize <- as.factor(shirts_norm_df$ShirtSize)

train_all <- shirts_norm_df[c("Height","Weight")]

# Get labels from the sample
labels_all <- shirts_norm_df[c('ShirtSize')]
labels_all <- labels_all[,1]

# Uisng the normalized 169 cm and 64 kgs for the new data
NewData <- data.frame(Height = 0.917, Weight = 0.6)

k <- round(sqrt(nrow(train_all)))
if (k %% 2 == 0) k = k + 1

# use KNN method to clarify
KNN_Result <- knn(train_all, NewData, cl=labels_all, k=k)

KNN_Result # Show the label fo the new data


# Checking the accuracy of the model
# Randomly split the data into a training and a testing set (80/20)
train <- shirts_norm_df %>% sample_frac(.8)
test <- anti_join(shirts_norm_df, train)

# seperate the labels and variables form the 2 sets
train_labels <- train[c('ShirtSize')]
train_labels <- train_labels[,1] #force into vector
train <- train[c('Weight','Height')]

test_labels <- test[c('ShirtSize')]
test_labels <- test_labels[,1] #force into vector
test <- test[c('Weight','Height')]

KNN_Result <- knn(train, test, train_labels, k=k)
KNN_Result # Show the label fo the new data

