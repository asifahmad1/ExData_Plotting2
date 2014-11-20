# Exploratory Data Analysis
# Project 2

# Clean upworkspace
rm(list=ls())

#fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
#unzip("./tempdata.zip")

library("plyr")
library("ggplot2")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data<-transform(NEI,year=factor(year))
data2<-data[data$fips=="24510",]

#Plot Data
plotdata3<-ddply(data2,.(year,type),summarize,sum=sum(Emissions))
png("plot3.png")
gplot<-ggplot(plotdata3,aes(year,sum))
gplot+geom_point()+facet_grid(.~type)+labs(title="PM2.5 Emission in Baltimore city",
                                           y="total PM2.5 emission each year")
dev.off()
