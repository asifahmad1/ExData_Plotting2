#fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
#unzip("./tempdata.zip")
neiData <- readRDS("summarySCC_PM25.rds")
sccData <- readRDS("Source_Classification_Code.rds")

# Check if both data exist in the environment. If not, load the data.
if (!"neiData" %in% ls()) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
        unzip("./tempdata.zip")
        neiData <- readRDS("./summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
        sccData <- readRDS("./Source_Classification_Code.rds")
}

head(sccData$Short.Name)

# if (!"load_data.R" %in% list.files()) {
#     setwd("~/Desktop/Online Coursera/Coursera-Exploratory-Data-Analysis/ExData_Plotting2/")
# } 
# source("load_data.R")

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot4.png", 
    width = 480, height = 480, 
    units = "px")
coal <- grep("coal", sccData$Short.Name, ignore.case = T)
coal <- sccData[coal, ]
coal <- neiData[neiData$SCC %in% coal$SCC, ]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")
# options(scipen=0)
# options(scipen=999)
plot(coalEmissions, type = "l", xlab = "Years", 
     main = "Total Emissions From Coal Combustion-related\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()




