plot2 <- function(){
    
    ## Load data
    ## assumes data is in data directory in working directory
    PM_data <- readRDS("./data/summarySCC_PM25.rds")
    ## codeBook <- readRDS("./data/Source_Classification_Code.rds")
    
    ## aggregate data by year
    PMagg <- aggregate(PM_data$Emissions, list(PM_data$year), sum)
    names(PMagg)[names(PMagg)=="Group.1"] <- "Year"
    names(PMagg)[names(PMagg)=="x"] <- "Emissions"
    
    ## if line below is commented out, the plot will be sent to the screen
    png(file="plot2.png",width=480,height=480) 
    
    ## plot the data!
    plot(PMagg$Year, PMagg$Emissions, type="b", xlab="Year", ylab="Total Emissions",
         main="Total US Emissions")

    ## if the plot is sent to the screen, uncomment below to copy to a file
    ## dev.copy(png, file= "plot2.png") 
    dev.off()
    
    print("Plot saved as plot2.png in working directory")
}