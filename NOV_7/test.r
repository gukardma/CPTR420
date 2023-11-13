library(dplyr)
library(ggplot2)
library(corrplot)

data("storms")
# 7. Which month (name) seem to be most prone to these weather activities


storms %>%
  group_by(month) %>%
  summarise(count = n()) %>%
  ggplot(aes(x = factor(month, labels = month.name), y = count, fill = factor(month))) +
  geom_bar(stat = "identity") +
  labs(title = "Frequency of Weather Activities by Month",
       x = "Month",
       y = "Number of Activities") +
  theme_minimal()
