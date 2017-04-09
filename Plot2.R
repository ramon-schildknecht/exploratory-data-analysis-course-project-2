install.packages("dplyr")
install.packages("plyr")
library(plyr)
library(dplyr)


##1. Load & Read Data
##Download and unzip the dataset (if it exists not already in the working directory)
filename <- "Data for Peer Assessment.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, filename, mode = "wb")
}  
unzip(filename)

##Read Data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

##Generate base plot
plot.data <- nei %>% filter(fips == "24510") %>% group_by(year) %>% summarize(sum(Emissions))
names(plot.data) <- c("year", "total.emissions")
opt <- options("scipen" = 20)
with(plot.data, plot(year, total.emissions))
lines(plot.data)
title(main = "total PM2.5 from Baltimore City, Maryland")

## Saving to png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
