# September 5
# Vector Review

# Vector Declarations
V1 <- 15:25
V2 <- c(27, 30, 35)
V3 <- sample(2:6, 7, replace = T)

# Starts at 50 skips by 5 till 70
V4 <- seq(50, 70, by = 5)
V5 <- c(V1, V2, V3, V4)
V6 <- c(V4, NA, V2, NA, NA, 79)

# NA still counts as a value
length(V6)
summary(V6)

# Handling missing values
mean(V6)
sum(V6)

# Ignoring the NA
sum(V6, na.rm = T)

# Indexing
V6[4]
V6[1:3] # show items 1-3
V6[-c(1:3)] # all but the items 1-3
# Use brackets to index else it results in true/false statement
V6[V6 > 40]

# Matrices (2D array) are homogenous
mat1 <- matrix(1:15, 3, 5) # create matrix in column-major order
mat2 <- matrix(1:15, 3, 5, T)

# Adding Rows / Columns to matrices
mat2 <- rbind(mat2, c(8, 9, 10, 11, 12)) # Added row to end of mat2

# Indexing Matrices
mat2[3, 4]
mat2[, 4]
mat2[, -4]

# Giving names to columns
colnames(mat2) <- c("c1", "c2", "c3", "c4", "c5")
mat2[4, "c3"]

# Creating databases
df1 <- data.frame(mat2)

df1$c3 # Display column

df1$"NewColumn" <- c(":first", "second", 3, 4) # Adds or edits column. If name matches a column it replaces

str(df1) #Shows structure of dataframe
