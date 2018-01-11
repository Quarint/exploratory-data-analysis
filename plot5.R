# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# QUESTION : How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Searching for motor vehicle sources 
vehIdx <- grep("veh", tolower(SCC$Short.Name))
highIdx <- grep("highway", tolower(SCC$Short.Name))
vehMotorIdx <- intersect(vehIdx, highIdx)
vehMotorSources <- SCC$SCC[vehMotorIdx]

# Filtering data based on those sources
pm25vehMotor <- subset(NEI, NEI$SCC %in% vehMotorSources & NEI$fips == "24510")
pm25_year <- tapply(pm25vehMotor$Emissions, pm25vehMotor$year, sum)

# Opening graphics device
png("plot5.png", width = 480, height = 480)

barplot(pm25_year, ylab = "PM2.5 emitted (tons)", main = "PM2.5 emissions from motor vehicle sources in Baltimore City")

# Closing graphics device
dev.off()

# ANSWER : Emissions from motor vehicle sources have dropped between 1999 and 2002,
# and decreased slowly between 2002 and 2008.