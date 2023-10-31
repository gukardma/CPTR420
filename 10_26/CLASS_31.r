install.packages("tmap")
library(tmap)

data("World")
theWorld <- World
tm_shape(theWorld) +
    tm_polygons("economy") + 
    tm_text("name", size="AREA")
    # tm_dots("pop_est")

# TO DO
# select a region (continent, sub-continent) of chocie create an interactive map
# with appropriate documentation for at least 2 variables be creative but tidy
africa <- theWorld[theWorld$continent == "Africa", ]

tm_shape(africa) +
    tm_polygons("pop_est")