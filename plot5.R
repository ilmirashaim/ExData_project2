#Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## How have emissions from motor vehicle sources
# changed from 1999–2008 in Baltimore City

motorVehicleScc <- SCC$SCC[SCC$SCC.Level.One=="Mobile Sources"]
isBaltimore <- NEI$fips=="24510"


library(plyr)
emissionsMotorVehicle <- ddply(NEI[NEI$SCC %in% motorVehicleScc &
                                       isBaltimore,], 
                                 c("year"), 
                                 summarise, 
                                 sumEmis=sum(Emissions))

library(ggplot2)
png(file="plot5.png")
ggplot(emissionsMotorVehicle,aes(x=factor(year),y=sumEmis))+ 
    ylab("emissions, tons")+xlab("year")+
    ggtitle("Emissions from motor vehicle sources in Baltimore")+
    geom_bar(fill="lightblue", width=0.7, stat="identity")

dev.off()