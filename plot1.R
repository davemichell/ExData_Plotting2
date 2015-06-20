plot1 <- function(){
    
    ## Load data
    ## assumes data is in data directory in working directory
    PM_data <- readRDS("./data/summarySCC_PM25.rds")
    ## codeBook <- readRDS("./data/Source_Classification_Code.rds")
    
    ## aggregate data by year
    PMagg <- aggregate(PM_data$Emissions, list(PM_data$year), sum)
    names(PMagg)[names(PMagg)=="Group.1"] <- "Year"
    names(PMagg)[names(PMagg)=="x"] <- "Emissions"
    
    plot(PMagg$Year, PMagg$Emissions, type="b", xlab="Year", ylab="Total Emissions")
    
}