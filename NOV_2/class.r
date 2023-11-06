install.packages(c("dplyr", "ggplot2", "gganimate", "lubridate", "png", "gifski","gapminder"))

library(dplyr)
library(ggplot2)
library(gganimate)
library(lubridate)
library(png)
library(gifski)
library(gapminder)

plt1 <- gapminder %>%
    ggplot(aes(gdpPercap, lifeExp)) +
    geom_point()

plot(plt1)

#animeate groupe
plt_anim_year <- plt1 + 
    transition_states(states = year, transition_length = 1, state_length= 4)+
    ggtitle("Life expectancy vs GPP per capity by ear", subtitle = "year")

plt_anim_year
