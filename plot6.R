plot6 <- function(){
    
    library("ggplot2")
    library("plyr")
    library("dplyr")
    
    ## Load data
    ## assumes data is in data directory in working directory
    ## This first line will likely take a few seconds.
    PM_data <- readRDS("./data/summarySCC_PM25.rds")
    codeBook <- readRDS("./data/Source_Classification_Code.rds")
    
    ## select only Onroad data from CodeBook - all motorvehicle sources
    road <- grep("Onroad",codeBook$Data.Category)
    CB_road <- codeBook[road, ]
    
    ## Subset PM data from subsetted codebook 
    PM_road <- filter(PM_data, SCC %in% CB_road$SCC)
    
    ## Select only the data for Baltimore City & LA County
    BC_road_data <- filter(PM_road,fips=="24510")
    LA_road_data <- filter(PM_road,fips=="06037")
    rm(PM_data) ## remove the full data set
    rm(codeBook) ## remove full codebook
    
    ## aggregate data by year for each location
    PMagg_BC <- summarise(group_by(BC_road_data, Year=year), 
                       Emissions=sum(Emissions))
    PMagg_BC$Location = "Baltimore City" ## add location variable
    PMagg_BC$Comp  <- PMagg_BC$Emissions/ 
        (PMagg_BC[which(PMagg_BC$Year==1999),]$Emissions) ## add normalised comparison
    
    PMagg_LA <- summarise(group_by(LA_road_data, Year=year), 
                          Emissions=sum(Emissions))
    PMagg_LA$Location = "Los Angeles County" ## add location variable
    PMagg_LA$Comp  <- PMagg_LA$Emissions/ 
        (PMagg_LA[which(PMagg_LA$Year==1999),]$Emissions) ## add normalised comparison
    
    ## combine data sets
    PMagg <- rbind(PMagg_LA, PMagg_BC)
    
    ## plot the data!
    plot6 <- qplot(Year,Comp, data=PMagg, color=Location, geom="line", 
                   ylab="Normalised Comparision from 1999", 
                   main= "Comparision based on normalised data (1999=1)")
    
    
    ggsave(plot6,file="plot6.png", width=8, height=4, units="in", dpi=100)    
    print("Plot saved as plot6.png in working directory")
}