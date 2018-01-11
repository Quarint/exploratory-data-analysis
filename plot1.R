# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# QUESTION : Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for 
# each of the years 1999, 2002, 2005, and 2008.

pm25_year <- tapply(NEI$Emissions, NEI$year, sum)

# Opening graphics device
png("plot1.png", width = 480, height = 480)

# Plotting result
barplot(pm25_year, ylab = "PM2.5 emitted (tons)", main = "Total PM2.5 emissions in the US")

# Closing graphics device
dev.off()

# ANSWER : Yes, total emissions from PM2.5 have decreased in the US from 1999 to 2008.