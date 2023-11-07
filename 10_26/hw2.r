#Guichard
#10_31
library(tidygeocoder)
library(ggmap)
library(mapview)
library(dplyr)
library(sf)

detroit_data <- data.frame(
  offense = "murder",
  address = "Detroit, MI",
  lon = -83.0466,
  lat = 42.3314
)

detroit_bb <- getbb("detroit,mi")

detroit_map <- get_stamenmap(
  bbox = c(detroit_bb[1, 1], detroit_bb[2, 1], detroit_bb[1, 2], detroit_bb[2, 2]),
  maptype = "toner-lite"
)

ggmap(detroit_map)

detroit_sf <- st_as_sf(detroit_data, coords = c("lon", "lat"), crs = 4326)

mapview(detroit_sf, color = "brown")