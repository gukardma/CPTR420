# September 5
# Class Assignment
# Guichard Manigat

# 1 Create a matrix called New_York to store the dataNew_York <- matrix(c(10,8,5,12,17,3,6,5,3,2,100,189,127,130,22),5,3)
New_York <- matrix(c(10, 8, 5, 12, 17, 3, 6, 5, 3, 2, 100, 189, 127, 130, 22), 5, 3)
colnames(New_York) <- c("Age", "Employees", "2021 profit")
rownames(New_York) <- c("NY1", "NY2", "NY3", "NY4", "NY5")

# 2 Display the 2021 profit for store NY4
New_York[4, 3]

# 3 Display all the profits
New_York[, 3]

# 4 Display the shop, employees and 2021 profit only
colnames(New_York)

# 5 Find the largest profit
max(New_York[, 3])

# 6 Create a matrix called Jersey to store the NJ data
Jersey <- matrix(c(11, 9, 5, 1, 6, 2, 14, 92, 38), 3, 3)
rownames(Jersey) <- c("NJ1", "NJ2", "NJ3")
colnames(Jersey) <- c("Age", "Employees", "2021 profit")

# 7 Create a vector called New_Profit to store these values
New_Profit <- c(108, 200, 137, 128, 25, 15, 93, 40, 81, 144)

# 8 Combine all the data into a single matrix called Store_Profit
Store <- rbind(New_York, Jersey)
Store_Profit <- cbind(Store, New_Profit)


# 9 Find the min,max, median, mean of the 2021 profit, repeat for 2022
summary(Store_Profit)
summary(New_Profit)

# 10 Multiply the 2021 profit by a thousand, repeat for 2022
Changed_Profit1 <- (seq(Store_Profit[, 3]) * 1000)
print(Changed_Profit1)

Changed_Profit2 <- (New_Profit * 1000)
print(Changed_Profit2)

# 11 Can you find which store has the largest profit?
which.max(Store_Profit[,3])

# 12 Make a dataframe called Stores_df from the data
Stores_df <- data.frame(Store_Profit)

# 13 Add a column called "Store_type" with each store being either online or physical following values
Store_type <- c("Physical", "Online")
Stores_df$"Store type" <- c(sample(Store_type, 8, replace = T))






#################
# to access a column (variable) in a dataframe
Stores_df$Age
Stores_df[,"Age"]

#for multiple columns
Stores_df[,c("Age", "Profit2021")]

# for select rows
stores_df[stores_df["st_Type"]=="online"]