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

##Select necessary data columns including filter to motor vehicle sources
new.scc <- scc %>% select(c(1,3)) %>% filter(grepl("motor vehicle", Short.Name, ignore.case = TRUE))

##Merge data frames with left outer join and remove NAs
md <- merge(x=nei, y=new.scc, by.x = "SCC", by.y = "SCC", all.y = TRUE)
md <- md %>% filter(!is.na(year)) %>% filter(!is.na(Emissions))

##Generate plot
plot.data <- md %>% group_by(year) %>% summarize(sum(Emissions))
names(plot.data) <- c("year", "total.emissions")
g <- ggplot(plot.data, aes(year, total.emissions))
g + geom_point(alpha = 1/3) + geom_line() + ggtitle("Total PM2.5 emissions from motor vehicles in Baltimore City")

##Saving to png file
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()
