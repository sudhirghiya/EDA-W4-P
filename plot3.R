#
# File   : plot3.R 
##
## Q: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
##    variable, which of these four sources have seen decreases in emissions from 1999–2008 
##    for Baltimore City? Which have seen increases in emissions from 1999–2008? 
##    Use the ggplot2 plotting system to make a plot answer this question.
## 

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")             # 6497651 obs. of 6 variables
SCC <- readRDS("./data/Source_Classification_Code.rds")  # 11717 obs. of 15 variables

#
# Subset for County 24510 
#

library(plyr)
fips24510 <- subset(NEI, fips == "24510")
Emissionbytypeandyearfor24510 <- ddply(fips24510, .(type, year), 
                                       summarize, 
                                       SumEmibyYear = sum(Emissions))

library(ggplot2)  
png("plot3.png", width = 480, height = 480)

qplot(year, SumEmibyYear, data = Emissionbytypeandyearfor24510, group = type, 
      color = type, geom = c("point", "line"), ylab = "Total Emissions (Tons)", 
      xlab = "Year", main = "Baltimore PM2.5 Emissions by Pollutant Type")+
      theme(legend.position = c(.9, 0.8))

dev.off()