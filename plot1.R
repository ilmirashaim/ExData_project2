#Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? 
# Using the base plotting system,
# make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.

emissionsByYear <- tapply(NEI$Emissions, NEI$year, sum)

png(file="plot1.png")

scipen <- options()$scipen
options(scipen=10) # for fixed(not exponential) format in y-ticks
barplot(names.arg=names(emissionsByYear),
        emissionsByYear,
        xlab="year",
        ylab="total emissions, tons",
        main="Total emissions from PM2.5 in the United States")


dev.off()
options(scipen=scipen)
