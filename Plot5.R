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

#subset the data
subset <- neiData[neiData$fips == "24510", ] 



par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot5.png", 
    width = 480, height = 480, 
    units = "px")
motor <- grep("motor", sccData$Short.Name, ignore.case = T)
motor <- sccData[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]
motorEmissions <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

plot(motorEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()