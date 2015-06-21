plot3 <- function(){
    
    library("ggplot2")
    library("plyr")
    library("dplyr")
    
    ## Load data
    ## assumes data is in data directory in working directory
    ## This first line will likely take a few seconds.
    PM_data <- readRDS("./data/summarySCC_PM25.rds")
    ## codeBook <- readRDS("./data/Source_Classification_Code.rds")
    
    ## Select only the data for Baltimore City
    BC_data <- filter(PM_data,fips=="24510")
    rm(PM_data) ## remove the full data set
    
    ## aggregate data by year
    PMagg <- summarise(group_by(BC_data, Year=year, Type=type), 
                       Emissions=sum(Emissions))
    
    ## plot the data!
    qplot(Year,Emissions, data=PMagg, facets= ~Type)

    dev.copy(png, file= "plot3.png") 
    dev.off()
    
    print("Plot saved as plot3.png in working directory")
}