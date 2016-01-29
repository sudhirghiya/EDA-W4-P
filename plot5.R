#
# File   : plot5.R 
##
## Q: How have emissions from motor vehicle sources changed from 1999–2008 in **Baltimore City**?
## 

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")             # 6497651 obs. of 6 variables
SCC <- readRDS("./data/Source_Classification_Code.rds")  # 11717 obs. of 15 variables

#
# 1. Subset Data for Baltimore (fips=24510) and SCC$EI.Sector containing "Vehicle"
# 2. get NEI for Coal based SCC
# 3. Aggregate by year
#

fips24510 <- subset(NEI, fips == "24510")
BaltimoreVehicleNEI  <- fips24510[fips24510$SCC %in% SCC[grep("Vehicle", SCC$EI.Sector),1], ]  
fips24510VehicleData <- aggregate((BaltimoreVehicleNEI$Emissions) ~ year, 
                                   BaltimoreVehicleNEI, sum)

png(filename = "plot5.png", width = 480, height = 480)

plot(fips24510VehicleData, type = "l", pch = 18, ylab = "Emissions (in Tons)", 
     xlab = "Year", main = "Baltimore Annual Vehicular PM2.5 Emissions")

dev.off()
