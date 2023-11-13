library(leaflet)
library(corrplot)
library(dplyr)
library(ggplot2)

data("storms")

# Checking data structure
str(storms)

# 1. What are the names assigned to these weather activities (just list the names, no special 
# visualization required. No repetitions please)
unique_names <- unique(storms$name)

# 2. How many tropical storms, hurricanes occurred each year? Compare tropical storms and 
# hurricanes by year. 
storms$year <- as.factor(storms$year)

# Bar chart
ggplot(storms, aes(x = year, fill = status)) +
  geom_bar(position = "dodge") +
  labs(title = "Tropical Storms and Hurricanes Each Year",
       x = "Year", y = "Count")

# 3. For 2004 to 2021 data only, how long did each hurricane last (days), what was the maximum 
# max wind speed.
data("storms")

storms_filtered <- storms %>%
  filter(year >= 2004 & year <= 2021)

# Calculate duration of hurricanes
storms_filtered <- storms_filtered %>%
  group_by(name) %>%
  summarise(duration = max(day) - min(day))

# Bar chart
ggplot(storms_filtered, aes(x = name, y = duration)) +
  geom_bar(stat = "identity") +
  labs(title = "Duration of Hurricanes (2004-2021)",
       x = "Hurricane Name",
       y = "Duration (Days)")

# Calculate the max wind speed for hurricanes
storms_filtered_speed <- storms %>%
  group_by(name) %>%
  summarise(max_wind_speed = max(wind))

# Bar chart
ggplot(storms_filtered_speed, aes(x = name, y = max_wind_speed)) +
  geom_bar(stat = "identity") +
  labs(title = "Maximum Maximum Wind Speed of Hurricanes (2004-2021)",
       x = "Hurricane Name",
       y = "Max Wind Speed")

# 4. What is the relationship between wind and pressure
ggplot(storms, aes(x = wind, y = pressure)) +
  geom_point() +
  labs(title = "Relationship between Wind and Pressure",
       x = "Wind",
       y = "Pressure")

# 5. For 2004 to 2021 hurricanes only what is the correlation between each pair: wind, pressure, 
# tropical/hurricane_force_diameter (see corplot)
storms_subset <- storms %>%
  filter(year >= 2004 & year <= 2021 & status == "hurricane")

# Cor matrix
cor_matrix <- cor(storms_subset[c("wind", "pressure", "tropicalstorm_force_diameter", "hurricane_force_diameter")])
corrplot(cor_matrix)

# 6. What are the different types of activity status measured.  Show also the wind speed range for 
# each status
status_summary <- storms %>%
  group_by(status) %>%
  summarise(min_wind = min(wind),
            max_wind = max(wind))

# Plotting
ggplot(status_summary, aes(x = status, y = max_wind, fill = status)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste(min_wind, "-", max_wind, "kts"))) +
  labs(title = "Activity Status and Wind Speed Range",
       x = "Status",
       y = "Max Wind Speed (kts)")

# 7. Which month (name) seem to be most prone to these weather activities
storms %>%
  group_by(month) %>%
  summarise(count = n()) %>%
  ggplot(aes(x = factor(month), y = count, fill = factor(month))) +
  geom_bar(stat = "identity") +
  labs(title = "Frequency of Weather Activities by Month",
       x = "Month",
       y = "Number of Activities")

# 8. Are the weather activities concentrated in certain areas/states (map it, use only  hurricanes and 
# storms combined) 
# Filter the data for hurricanes and storms
storms_filtered <- storms %>%
  filter(status %in% c("hurricane", "storm"))

# Create map
map <- leaflet(data = storms_filtered) %>%
  addTiles() %>%
  addMarkers(
    ~long, ~lat,
    popup = ~paste("Name: ", name, "Status: ", status)
  )

map

# 9. Track an event or two over time showing the path it took and how the status and wind speed 
# changed (you select the event e.g. Maria in 2017) 
# Select data for Hurricane Maria in 2017
hurricane_maria <- storms %>%
  filter(name == "Maria", year == 2017)

# Create a line plot of the hurricane path
path <- ggplot(hurricane_maria, aes(x = long, y = lat, group = interaction(name, year))) +
  geom_path(aes(color = status), size = 1) +
  geom_point(aes(color = status, size = wind)) +
  scale_size_continuous(name = "Wind Speed") +
  labs(title = "Hurricane Maria Path and Status Over Time",
       x = "Longitude",
       y = "Latitude",
       color = "Status")

# Display the plot
print(path)