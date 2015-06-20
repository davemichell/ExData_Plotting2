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
    PMagg <- summarise(group_by(BC_data, year, type), sum(Emissions))
        
    ## if line below is commented out, the plot will be sent to the screen
    png(file="plot3.png",width=480,height=480) 
    
    ## plot the data!
    
    
    plot(PMagg$Year, PMagg$Emissions, type="b", xlab="Year", ylab="Total Emissions",
         main="Baltimore City Emissions")

    ## if the plot is sent to the screen, uncomment below to copy to a file
    ## dev.copy(png, file= "plot3.png") 
    dev.off()
    
    print("Plot saved as plot3.png in working directory")
}