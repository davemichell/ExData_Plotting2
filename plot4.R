plot4 <- function(){
    
    library("ggplot2")
    library("plyr")
    library("dplyr")
    
    ## Load data
    ## assumes data is in data directory in working directory
    ## This first line will likely take a few seconds.
    PM_data <- readRDS("./data/summarySCC_PM25.rds")
    codeBook <- readRDS("./data/Source_Classification_Code.rds")
    
    ## select coal entries in codebook
    coal <- grep("[Cc]oal",codeBook$EI.Sector)
    CB_coal <- codeBook[coal, ]
    
    ## Select only the data for Coal
    PM_coal <- filter(PM_data, SCC %in% CB_coal$SCC)
    
    rm(PM_data) ## remove the full data set
    
    ## aggregate data by year
    PMagg <- summarise(group_by(PM_coal, Year=year), Emissions=sum(Emissions))
    
    ## plot the data!
    plot4 <- qplot(Year,Emissions, data=PMagg, main="Coal based emissions")
    
    ggsave(plot4,file="plot4.png")    
    print("Plot saved as plot4.png in working directory")
}