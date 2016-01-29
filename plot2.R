#
# File   : plot2.R 
##
## Q: Have total emissions from PM2.5 decreased in the **Baltimore City**, 
##    Maryland (**fips == "24510"**) from 1999 to 2008? 
##
##    Use the base plotting system to make a plot answering this question.
##

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")             # 6497651 obs. of 6 variables
SCC <- readRDS("./data/Source_Classification_Code.rds")  # 11717 obs. of 15 variables

#
# 1. Subset for County 24510 
# 2. Compute yearly Totals
#

fips24510 <- subset(NEI, fips == "24510")
yearlyfips24510 <- aggregate((fips24510$Emissions/1000) ~ year, fips24510, sum)

png(filename = "plot2.png", width = 480, height = 480)

plot(yearlyfips24510, type = "l", pch = 18, ylab = "Emissions (in MTons)", 
     xlab = "Year", main = "Baltimore Annual PM2.5 Emissions")

dev.off()
