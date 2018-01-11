# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Loading ggplot2 package
library(ggplot2)
library(plyr)

# QUESTION : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions
# from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question.

NEI_bcity <- subset(NEI, NEI$fips == "24510")

# Split by type and year, sum emissions for each combination and combine into new data frame
pm25_bytype <- ddply(NEI_bcity, .(type, year), summarize, Emissions = sum(Emissions))
pm25_bytype$year <- as.factor(pm25_bytype$year)

# Opening graphics device
png("plot3.png", width = 480, height = 480)

# plotting
g <- ggplot(pm25_bytype, aes(year, Emissions, fill = type)) + geom_bar(stat = "identity") + facet_grid(.~ type)
g <- g + theme(legend.position = "none")
g <- g + labs(title = "PM2.5 Emissions in Baltimore City by type of source", y = "PM2.5 emitted (tons)")
print(g)

dev.off()

# ANSWER : Non-road, nonpoint and on-road  sources have seen decreases in emissions without
# interruption from 1999 to 2008.
# Point sources, however, have seen a great increase in emissions from 1999 to 2005, before a decrease between
# 2005 and 2008, resulting in a small increase overall.