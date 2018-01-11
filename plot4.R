# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# QUESTION : Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Searching for Coal combustion related sources 
coalIdx <- grep("coal", tolower(SCC$Short.Name))
combIdx <- grep("comb", tolower(SCC$Short.Name))
coalCombIdx <- intersect(coalIdx, combIdx)
coalCombSources <- SCC$SCC[coalCombIdx]

# Filtering data based on those sources
pm25coalComb <- subset(NEI, NEI$SCC %in% coalCombSources)
pm25_year <- tapply(pm25coalComb$Emissions, pm25coalComb$year, sum)

# Opening graphics device
png("plot4.png", width = 600, height = 480)

barplot(pm25_year, ylab = "PM2.5 emitted (tons)", main = "PM2.5 emissions from coal combustion-related sources in the US")

# Closing graphics device
dev.off()

# ANSWER : Emissions from coal combustion-related sources have decreased very slowly from 1999 to 2005, 
# then saw a larger drop of ~30% between 2005 and 2008.