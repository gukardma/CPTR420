library(dplyr)
library(ggplot2)

data("storms")

# 1. What are the names assigned to these weather activities (just list the names, no special 
# visualization required. No repetitions please) 
unique_names <- unique(storms$name)

# 2. How many tropical storms, hurricanes occurred each year? Compare tropical storms and 
# hurricanes by year. 
storms$year <- as.factor(storms$year)

# Create a bar chart
ggplot(storms, aes(x = year, fill = status)) +
  geom_bar(position = "dodge") +
  labs(title = "Tropical Storms and Hurricanes Each Year",
       x = "Year", y = "Count") +
  scale_fill_manual(values = c("Tropical Storm" = "blue", "Hurricane" = "red"))

# 3. For 2004 to 2021 data only, how long did each hurricane last (days), what was the maximum 
# max wind speed. 
storms_filtered <- storms %>%
  filter(year >= 2004)

# Calculate the duration of each hurricane
storms_filtered <- storms_filtered %>%
  group_by(name) %>%
  summarise(duration = max(day) - min(day))

# Plotting the bar chart
ggplot(storms_filtered, aes(x = name, y = duration)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Duration of Hurricanes (2004-2021)",
       x = "Hurricane Name",
       y = "Duration (Days)")

# Calculate the maximum maximum wind speed for each hurricane
storms_filtered_speed <- storms %>%
  group_by(name) %>%
  summarise(max_wind_speed = max(wind))

# Plotting the bar chart
ggplot(storms_filtered_speed, aes(x = name, y = max_wind_speed)) +
  geom_bar(stat = "identity", fill = "coral") +
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
# tropical/hurricane_force_diameter (see corplot) ################
storms_subset <- storms %>%
  filter(year >= 2004 & year <= 2021 & status == "hurricane")

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
  geom_text(aes(label = paste(min_wind, "-", max_wind, "kts")), vjust = -0.5) +
  labs(title = "Activity Status and Wind Speed Range",
       x = "Status",
       y = "Max Wind Speed (kts)") +
  theme_minimal()

# 7. Which month (name) seem to be most prone to these weather activities

# 8. Are the weather activities concentrated in certain areas/states (map it, use only  hurricanes and 
# storms combined) 

# 9. Track an event or two over time showing the path it took and how the status and wind speed 
# changed (you select the event e.g. Maria in 2017) 
