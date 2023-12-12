# Load required packages
library(tidyverse)
library(lubridate)
library(corrplot)
library(rgdal)
library(tmap)
library(tidytext)
library(tm)

# Read data using readr
data <- read_csv("your_data.csv")

# Exploratory Data Analysis (EDA)

# Basic summary statistics
summary(data)

# Data wrangling with dplyr and tidyr
data <- data %>%
  mutate(date = ymd(date)) %>%
  gather(key = "variable", value = "value", -date)

# Charting

# Histogram
ggplot(data, aes(x = value)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Histogram", x = "Values", y = "Frequency")

# Scatterplot
ggplot(data, aes(x = variable, y = value)) +
  geom_point(color = "orange") +
  labs(title = "Scatterplot", x = "Variable", y = "Values")

# Density Plot
ggplot(data, aes(x = value, fill = variable)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot", x = "Values", y = "Density") +
  theme_minimal()

# Line Plot
ggplot(data, aes(x = date, y = value, color = variable)) +
  geom_line() +
  labs(title = "Line Plot", x = "Date", y = "Values")

# Boxplot
ggplot(data, aes(x = variable, y = value, fill = variable)) +
  geom_boxplot() +
  labs(title = "Boxplot", x = "Variable", y = "Values")

# Geospatial Charts with tmap and rgdal

# Load shapefile
world <- readOGR("world_shapefile.shp", layer = "world")

# Plot world map
tm_shape(world) +
  tm_borders() +
  tm_layout(title = "World Map")

# Correlation Plot with corrplot
cor_matrix <- cor(data %>% select_if(is.numeric), use = "complete.obs")
corrplot(cor_matrix, method = "color")

# Wordcloud with tidytext
words <- data %>%
  unnest_tokens(word, value) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE)

wordcloud(words$word, words$n, max.words = 50, colors = brewer.pal(8, "Dark2"))

# Documenting Charts

# Labels, Legends, Titles, Interactivity, Color, Facets
# Adjust these components based on specific charting needs

# For ggplot2, you can use functions like labs(), theme(), scale_color_manual(), facet_wrap(), etc.

# Save the final plot
ggsave("final_plot.png", plot = last_plot(), width = 8, height = 6)

# Feel free to customize and expand based on your specific needs.
