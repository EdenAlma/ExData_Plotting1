zipFileName <- paste0(getwd(), "/", "exdata_data_household_power_consumption.zip")
fileName <- paste0(getwd(), "/", "household_power_consumption.txt")

start <- as.Date("01/02/2007","%d/%m/%Y") #date range
end <- as.Date("02/02/2007","%d/%m/%Y")

unzip(zipFileName)
inputData <- read.table(fileName, sep = ";", header = TRUE, stringsAsFactors = FALSE)

library(dplyr)

#filter date
inputData <- filter(inputData, (as.Date(inputData$Date, "%d/%m/%Y") >= start
                                & as.Date(inputData$Date, "%d/%m/%Y") <= end))

inputData <- transform(inputData, dateTime = as.POSIXct(paste0(Date," ",Time ),
            format = "%d/%m/%Y %H:%M:%OS"))

par(pty = "s")
par(cex = 0.75)

plot(inputData$dateTime,inputData$Sub_metering_1,type = "l", xlab = "",
      ylab = "Energy sub metering (kilowatts)")
lines(inputData$dateTime,inputData$Sub_metering_2, col = "red")  #add other lines
lines(inputData$dateTime,inputData$Sub_metering_3, col = "blue")

lineNames <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
lineColors <- c("red","blue","black") #variables for lengend

#add legend
legend(x = "topright",legend = lineNames,
       col = lineColors, lty = c(1,1,1), cex = 0.75)
