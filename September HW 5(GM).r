# September 5
# Class Assignment

#1.  Create a matrix called New_York to store the dataNew_York <- matrix(c(10,8,5,12,17,3,6,5,3,2,100,189,127,130,22),5,3)
New_York <- matrix(c(10,8,5,12,17,3,6,5,3,2,100,189,127,130,22),5,3)
colnames(New_York) <- c("Age", "Employees", "2021 profit")
rownames(New_York) <- c("NY1","NY2","NY3","NY4","NY5")

#2 Display the 2021 profit for store NY4
New_York[4,3]

#3 Display all the profits
New_York[,3]

#4 Display the shop, employees and 2021 profit only
colnames(New_York)

#5 Find the largest profit
max(New_York[,3])

#6 Create a matrix called Jersey to store the NJ data
Jersey <- matrix(c(11,9,5,1,6,2,14,92,38),3,3)