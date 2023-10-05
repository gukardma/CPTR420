installed.packages() #which packages are installed
data()               #datasets available

Install a package
install.packages("dplyr") 

#load a packages
library(dplyr)

df1 <- starwars

#get a look at what you data is like
View(df1)
summary(df1)
colnames(df1)
head(df1)
tail(df1,2)
dim(df1)
str(df1)
nrow(df1)
ncol(df1)

select(df1, name, mass)
select(df1, !c(name,height))
select(df1, is.numeric)
select(df1, contains(color))

# pipelining %>%

df1 %>%
    select(name,mass)

#working with rows(dplyr) filter

df1 %>%
    filter(height > 180)


df2 <- df1 %>%
    filter(height > 180 & height <200)


df3 <- df1 %>%
    filter(2023 - birth_year > 1000) %>%
    select(name,hair_color,skin_color,eye_color)

#without squiggle
# df3 <- select(filter(df1, 2023 - birth_year > 1000), name, hair_color, skin_color, eye_color)
df4 <- select(filter(df1, 2023 - birth_year > 1000), name, contains("color"))

# sorting - (dplyr) arrange. NAs are put last whether ascending
df5 <- df1 %>%
    arrange(species, desc(homeworld))

# changing column names - (dplyr) rename
df5 <- df5 %>% rename(theCharacter - name)

# Create, modify, delete columns - (dplyr) mutate
df5 <- df5 %>%
    mutate(age = 2023-birth_year, .before=birth_year, vehicles=NULL)

# grouping and summarizing (dplyr) group_by summarize
dfg <- df5 %>%
    group_by(species) %>%
    summarize(groupsize = n(), avgHeight = mean(height, na.rm = T))

# (dplyr) slice
dfs <- df5 %>%
    slice(12:20)

# a random slice
dfsr <- df5 %>%
    slice_sample(prop=.10)

# heaviest
dfsh <- df5 %>%
    slice_max(mass, n=10)
