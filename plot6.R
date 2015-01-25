#Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## How have emissions from motor vehicle sources
# changed from 1999–2008 in Baltimore City

motorVehicleScc <- SCC$SCC[SCC$SCC.Level.One=="Mobile Sources"]


library(plyr)
emissionsMotorVehicle <- ddply(NEI[NEI$SCC %in% motorVehicleScc &
                                NEI$fips %in% c("24510", "06037"),], 
                               c("year", "fips"), 
                               summarise, 
                               sumEmis=sum(Emissions))

emissionsChange <- ddply(emissionsMotorVehicle, 
                         "fips", 
                         transform,
                         changeEmis=sumEmis-sumEmis[which.min(year)])
labeller <- function(var,v){
    x=rep("Los Angeles",length(v));
    x[v=="06037"]="Baltimore";
    x
}
library(ggplot2)
png(file="plot6.png", width=960)
plot1 <- ggplot(emissionsMotorVehicle,aes(x=factor(year),y=sumEmis))+ 
    ylab("emissions, tons")+xlab("year")+
    ggtitle("Emissions from motor vehicle sources\n in Baltimore and Los Angeles")+
    geom_bar(fill="lightblue", width=0.7, stat="identity") +
    facet_grid(fips~., labeller=labeller)

plot2 <- ggplot(emissionsChange,aes(x=factor(year),y=changeEmis))+ 
    ylab("emissions, tons")+xlab("year")+
    ggtitle("Change in emissions from motor vehicle sources\n in Baltimore and Los Angeles")+
    geom_bar(fill="pink", width=0.7, stat="identity") +
    facet_grid(fips~.,labeller=labeller)

library(gridExtra)
grid.arrange(plot1,plot2,ncol=2)

dev.off()