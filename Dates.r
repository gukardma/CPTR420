library(lubridate)
#base r

Sys.Date()
Sys.time()
xmas <- as.Date('2023-12-25')
xmas
newYearDay <- as.Date(7, origin=xmas)
newYearDay
class(newYearDay)
typeof(newYearDay)

nextXmas = xmas + 365
nextXmas

unclass(xmas)
#with lubricate
today()
now()

# create dates
1_xmas <_ make_date(2023,12,25)
1_xmas

1_xmas2 <- ymd("20231225")
1_xmas2
mdy()
ymd()

#######
today <- today()
tommorow <- today + 1
tommorow
