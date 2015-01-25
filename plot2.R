#Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering
# this question.

isBaltimore <- NEI$fips=="24510"
emissionsBaltimore <- tapply(NEI$Emissions[isBaltimore], NEI$year[isBaltimore], sum)

png(file="plot2.png")

barplot(names.arg=names(emissionsBaltimore),
        emissionsBaltimore,
        xlab="year",
        ylab="emissions, tons",
        main="Emissions in the Baltimore City, Maryland")

dev.off()