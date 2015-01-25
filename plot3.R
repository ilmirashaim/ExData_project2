#Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot 
# answer this question.
library(plyr)
isBaltimore <- NEI$fips=="24510"
emissionsForBaltimore <- NEI[isBaltimore, ]
emissionsByType <- ddply(emissionsForBaltimore, c("type", "year"), summarise,
                         res=sum(Emissions))

library(ggplot2)
png(file="plot3.png")
qplot(year, res, log="y", data=emissionsByType, col=type, geom="line",
      ylab="emissions, tons",
      main="Emissions of the four types of sources in Baltimore")

dev.off()

