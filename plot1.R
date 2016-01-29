#
# File : plot1.R 
##
## Q: Have total emissions from PM2.5 decreased in the United States from 
##    1999 to 2008? Using the base plotting system, make a plot showing the 
##    total PM2.5 emission from all sources for each of the years 
##    1999, 2002, 2005, and 2008.
##

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")            # 6497651 obs. of  6 variables
SCC <- readRDS("./data/Source_Classification_Code.rds") #   11717 obs. of 15 variables

# Compute Totals for Year
NEIbyYear <- aggregate((Emissions/1000) ~ year, NEI, sum)

png(file="plot1.png", width=480, height=480)

# Plot
plot(NEIbyYear, type = "l", pch = 18, ylab = "Emissions (in MTons)", 
     xlab = "Year", main = "USA Annual PM2.5 Emissions")

dev.off()