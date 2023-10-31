# Load required libraries
library(ggplot2)
library(ggmap)
library(mapview)
library(tidygeocoder)

# Sample GDP data (replace with your dataset)
gdp_data <- read.csv("10_26/dataset.csv", header = TRUE, na.strings = "")


# Geocode country names (replace with actual geocoding process)
# You need to obtain latitude and longitude coordinates for each country
# Example:
gdp_data <- gdp_data %>%
  geocode(location = gdp_data$Country)

# Create a map using ggplot2 and ggmap
world_map <- get_map(location = "world", zoom = 2)
map <- ggmap(world_map)

# Add points for each country's GDP
map <- map + geom_point(data = gdp_data, aes(x = lon, y = lat, size = GDP), color = "blue")
map <- map + scale_size_continuous(range = c(1, 10))
map <- map + labs(title = "Worldwide GDP Visualization")

# Create an interactive map using mapview
mapview(map, zcol = "GDP", map.types = "toner-lite", popup = "GDP")
