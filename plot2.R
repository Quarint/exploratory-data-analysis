# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# QUESTION : Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

NEI_bcity <- subset(NEI, NEI$fips == "24510")
pm25_bcity <- tapply(NEI_bcity$Emissions, NEI_bcity$year, sum)

# Opening graphics device
png("plot2.png", width = 480, height = 480)

# Plotting result
barplot(pm25_bcity, ylab = "PM2.5 emitted (tons)", main = "Total PM2.5 emissions in Baltimore City, Maryland")

# Closing graphics device
dev.off()

# ANSWER : Total emissions from PM2.5 in Baltimore City, Maryland have decreased
# overall from 1999 to 2008, but there was a local significant increase between 2002 and 2005.