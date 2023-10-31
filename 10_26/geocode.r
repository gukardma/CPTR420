install.packages("tidygeocoder")
install.packages("ggmap")
install.packages("mapview")
install.packages("sf")


library(tidygeocoder)
library(ggmap)
library(mapview)
library(dplyr)
library(sf)

# To find cords for adresses, use geocode

# Creat a df of local eateries

location <- c("Baguette", "Panera", "Subway")
addr <- c(
    "9187 M139, Berrien Springs, MI",
    "3260 Niles Rd, St Joseph, MI",
    "1244 S11th St, Niles, MI"
)

df <- data.frame(location, addr)
df <- tidygeocoder::geocode(df, address = addr, method="osm")


#get all murder data from the crimes dataset
homicide <- filter(crime, offense == "murder") %>%
    select(date, offense, address, lon, lat)

#view data
head(homicide, 3)


houston_bb <- getbb("houston,tx")

houstone <- get_stamenmap(bbox = c(houston_bb[1,1] , houston_bb[2,1] , houston_bb[1,2] , houston_bb[2,2]), maptype="toner-lite")



# Interactive maps with mapview that uses sf
# conver the homicide df into a simple features (sf) object
mymap <- st_as_sf(homicide, coords = c("lon","lat"), crs = 4326)
mapview(mymap, color="brown")





