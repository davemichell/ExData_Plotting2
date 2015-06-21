plot5 <- function(){
    
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
    
    ## Subset from subsetted codebook 
    PM_road <- filter(PM_data, SCC %in% CB_road$SCC)
    
    ## Select only the data for Baltimore City
    BC_road_data <- filter(PM_road,fips=="24510")
    rm(PM_data) ## remove the full data set
    
    ## aggregate data by year
    PMagg <- summarise(group_by(BC_road_data, Year=year, Type=type), 
                       Emissions=sum(Emissions))
    
    ## plot the data!
    plot5 <- qplot(Year,Emissions, data=PMagg, geom="line",
                   main="Road based emissions - Baltimore City")
    
    ggsave(plot5,file="plot5.png")    
    print("Plot saved as plot5.png in working directory")
}