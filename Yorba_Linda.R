library(ggmap)
library(ggplot2)

setwd("C:/GIS")
sep <- read.csv("California_SEP_assets_csv.csv")


Sub1 <- sep[grep("SEP.12", names(sep))]


sep$newCol <- 100*rowSums(Sub1)/rowSums(sep[3:6])


# create a new grouping variable
Percent_SEP12_Assets <- ifelse(sep[,7] >= 50, "Over 50", "Under 50")

# get the map
map <- get_map('Yorba Linda', zoom = 11, maptype = 'hybrid')

# plot the map and use the grouping variable for the fill inside the aes
ggmap(map) +
  geom_point(data=sep, aes(x = Longitude, y = Latitude, color=Percent_SEP12_Assets), size=6, alpha=0.6) +
  scale_color_manual(breaks=c("Over 50", "Under 50"), values=c("green","red"))