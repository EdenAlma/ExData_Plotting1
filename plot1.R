#zip file in working directory
zipFileName <- paste0(getwd(), "/", "exdata_data_household_power_consumption.zip")
fileName <- paste0(getwd(), "/", "household_power_consumption.txt")

start <- as.Date("01/02/2007","%d/%m/%Y") #date range
end <- as.Date("02/02/2007","%d/%m/%Y")

unzip(zipFileName) #unzip

#read data
inputData <- read.table(fileName, sep = ";", header = TRUE, stringsAsFactors = FALSE)
library(dplyr)

par(pty = "s") #set graphing parameter
par(cex = 0.75)

#read data according to date range
inputData <- filter(inputData, (as.Date(inputData$Date, "%d/%m/%Y") >= start
                                & as.Date(inputData$Date, "%d/%m/%Y") <= end))


#plot histogram
hist(as.numeric(inputData$Global_active_power), main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)", col = "red")
