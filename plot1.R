zipFileName <- paste0(getwd(), "/", "exdata_data_household_power_consumption.zip")
fileName <- paste0(getwd(), "/", "household_power_consumption.txt")

start <- as.Date("01/02/2007","%d/%m/%Y")
end <- as.Date("02/02/2007","%d/%m/%Y")

unzip(zipFileName)
inputData <- read.table(fileName, sep = ";", header = TRUE)
library(dplyr)


inputData <- filter(inputData, (as.Date(inputData$Date, "%d/%m/%Y") >= start & as.Date(inputData$Date, "%d/%m/%Y") <= end))