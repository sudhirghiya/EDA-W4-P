#
# File   : plot6.R 
##
## Q: Compare emissions from motor vehicle sources in Baltimore City with emissions from 
##    motor vehicle sources in **Los Angeles County**, California (**fips == "06037"**). 
##    Which city has seen greater changes over time in motor vehicle emissions?
## 

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")             # 6497651 obs. of 6 variables
SCC <- readRDS("./data/Source_Classification_Code.rds")  # 11717 obs. of 15 variables

#
# 1. Subset Data for Baltimore (fips=24510 or fips=06037) and SCC$EI.Sector containing "Vehicle"
#

fipsLAandBaltimore  <- subset(NEI, fips == "06037" | fips == "24510" )

graphdata   <- fipsLAandBaltimore[fipsLAandBaltimore$SCC %in% SCC[grep("Vehicle", SCC$EI.Sector),1], ]
summarydata <- aggregate(Emissions ~ fips * year, graphdata, sum)

summarydata$county <- ifelse(summarydata$fips == "06037", "Los Angeles County, CA", "Baltimore City County, MD")

png(filename = "plot6.png", width = 480, height = 480)

qplot(year, Emissions, data = summarydata, geom = "line", group = fips, color = county, 
      main="PM2.5 Emissions Baltimore City-MD, v/s Los Angeles, CA",
      xlab="Year", ylab="Motor Vehicle PM2.5 Emission (Tons)")+
      theme(legend.position = c("bottom"))

dev.off()
