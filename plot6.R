library(dplyr)
library(ggplot2)

# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# QUESTION : Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# Searching for motor vehicle sources 
vehIdx <- grep("veh", tolower(SCC$Short.Name))
highIdx <- grep("highway", tolower(SCC$Short.Name))
vehMotorIdx <- intersect(vehIdx, highIdx)
vehMotorSources <- SCC$SCC[vehMotorIdx]

# Filtering data based on those sources
pm25_balt <- subset(NEI, NEI$SCC %in% vehMotorSources & NEI$fips == "24510")
pm25_balt <- tapply(pm25_balt$Emissions, pm25_balt$year, sum)
pm25_balt <- as.data.frame(pm25_balt)
colnames(pm25_balt) <- "value"
pm25_balt <- mutate(pm25_balt, year = rownames(pm25_balt), city = rep("Baltimore City", 4))

pm25_la <- subset(NEI, NEI$SCC %in% vehMotorSources & NEI$fips == "06037")
pm25_la <- tapply(pm25_la$Emissions, pm25_la$year, sum)
pm25_la <- as.data.frame(pm25_la)
colnames(pm25_la) <- "value"
pm25_la <- mutate(pm25_la, year = rownames(pm25_la), city = rep("Los Angeles County", 4))

pm25 <- rbind(pm25_la, pm25_balt)

# Opening graphics device
png("plot6.png", width = 600, height = 480)

g <- ggplot(pm25, aes(year, value, fill = city)) + geom_bar(stat = "identity") + facet_wrap(~ city, scales = "free_y")
g <- g + theme(legend.position = "none")
g <- g + labs(title = "PM2.5 Emissions from motor vehicle sources in Baltimore City and Los Angeles County",
              y = "PM2.5 emitted (tons)")
print(g)

# Closing graphics device
dev.off()

# ANSWER : While motor vehicles emissions in Baltimore have dropped between 1992 and 2002, and continued slowly decreasing 
# through 2002-2008, they have increased overall in the Los Angeles County even with a small decrease between
# 2005 and 2008.