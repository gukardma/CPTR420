library(dplyr)
library(ggplot2)

data("storms")

# 1. What are the names assigned to these weather activities (just list the names, no special 
# visualization required. No repetitions please) 
unique_names <- unique(storms$name)
print(unique_names)

# 2. How many tropical storms, hurricanes occurred each year? Compare tropical storms and 
# hurricanes by year. 

# Load necessary libraries
storm_counts <- storms %>%
  group_by(year, category) %>%
  summarise(count = n()) %>%
  ungroup()

# Create a column/bar chart to compare tropical storms and hurricanes by year
ggplot(storm_counts, aes(x = year, y = count, fill = category)) +
  geom_col(position = "dodge") +
  labs(title = "Tropical Storms and Hurricanes by Year",
       x = "Year", y = "Count") +
  scale_fill_manual(values = c("Tropical Storm" = "blue", "Hurricane" = "red")) +
  theme_minimal() +
  theme(legend.title = element_blank()) +
  facet_wrap(~category, scales = "free_y") +
  guides(fill = guide_legend(override.aes = list(fill = c("blue", "red")))


# 3. For 2004 to 2021 data only, how long did each hurricane last (days), what was the maximum 
# max wind speed.   

# 4. What is the relationship between wind and pressure 

# 5. For 2004 to 2021 hurricanes only what is the correlation between each pair: wind, pressure, 
# tropicalhurricane_force_diameter  (see corplot)  

# 6. What are the different types of activity status measured.  Show also the wind speed range for 
# each status  

# 7. Which month (name) seem to be most prone to these weather activities  

# 8. Are the weather activities concentrated in certain areas/states (map it, use only  hurricanes and 
# storms combined) 

# 9. Track an event or two over time showing the path it took and how the status and wind speed 
# changed (you select the event e.g. Maria in 2017) 
