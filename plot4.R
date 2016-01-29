#
# File   : plot4.R 
##
## Q: Across the United States, how have emissions from coal combustion-related 
##    sources changed from 1999–2008?
## 

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")             # 6497651 obs. of 6 variables
SCC <- readRDS("./data/Source_Classification_Code.rds")  # 11717 obs. of 15 variables

#
# 1. get sources in SCC for Coal based ...
# 2. get NEI for Coal based SCC
# 3. Aggregate by year
#

CoalbasedNEI  <- NEI[NEI$SCC %in% SCC[grep("Coal", SCC$Short.Name),1] , ]  
CoalNEIbyYear <- aggregate((Emissions) ~ year, CoalbasedNEI, sum)

png(file="plot4.png", width=480, height=480)

# Plot
plot(CoalNEIbyYear, type = "l", pch = 18, ylab = "Coal based Emissions", 
     xlab = "Year", main = "Annual Coal based PM2.5 Emissions")

dev.off()