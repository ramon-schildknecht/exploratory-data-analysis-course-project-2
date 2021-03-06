install.packages("dplyr")
install.packages("plyr")
install.packages("ggplot2")
library(plyr)
library(dplyr)
library(ggplot2)


##Load & Read Data
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

##Generate ggplot2 plot
plot.data <- nei %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize(sum(Emissions))
names(plot.data) <- c("year", "type", "total.emissions")
g <- ggplot(plot.data, aes(year, total.emissions, color = type))
g + geom_point(alpha = 1/3) + geom_line() + ggtitle("Total PM2.5 development by source types")

##Saving to png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
