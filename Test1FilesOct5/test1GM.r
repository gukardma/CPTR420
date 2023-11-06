install.packages(c("dplyr", "ggplot2", "gganimate", "lubridate", "png", "gifski","gapminder"))

library(dplyr)
library(ggplot2)
library(gganimate)
library(lubridate)
library(png)
library(gifski)
library(gapminder)

plt1 <- gapminder %>%
  ggplot(aes(gdpPercap, pop, color = continent)) +
  geom_point() +
  scale_color_manual(values = c("Asia" = "red", "Europe" = "blue", "Africa" = "green", "Americas" = "purple", "Oceania" = "orange"))

plot(plt1)


plt_anim_year <- plt1 +
  transition_states(states = year, transition_length = 1, state_length = 4)

plt_anim_year
