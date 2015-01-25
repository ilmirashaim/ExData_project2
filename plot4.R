#Reading data
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

## Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?

# Choosing coal combustion-related sources.
# As there is now description of dataset variables and the set 
# of the variables is not the point for this project
# i've just picked some that i believe are connected to the coal combustion
levelOneVars <- c("External Combustion Boilers", "Internal Combustion Engines", 
  "Stationary Source Fuel Combustion")

levelThreeVars <- c("Anthracite Coal", "Bituminous/Subbituminous Coal", "Waste Coal", "Gasified Coal",
  "Lignite Coal", "Coal", "Bituminous Coal")

sccVals <- SCC$SCC[SCC$SCC.Level.Three %in% levelThreeVars & SCC$SCC.Level.One %in% levelOneVars]

library(plyr)
emissionsCoalCombustion <- ddply(NEI[NEI$SCC %in% sccVals,], 
                                 c("year"), 
                                 summarise, 
                                 sumEmis=sum(Emissions))

library(ggplot2)
png(file="plot4.png")
ggplot(emissionsCoalCombustion,aes(x=factor(year),y=sumEmis))+ 
    ylab("emissions, tons")+xlab("year")+
    ggtitle("Emissions of coal combustion-related sources")+
    geom_bar(fill="lightblue", width=0.7, stat="identity")

dev.off()