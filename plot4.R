zipFileName <- paste0(getwd(), "/", "exdata_data_household_power_consumption.zip")
fileName <- paste0(getwd(), "/", "household_power_consumption.txt")

start <- as.Date("01/02/2007","%d/%m/%Y") #date range
end <- as.Date("02/02/2007","%d/%m/%Y")

unzip(zipFileName)
inputData <- read.table(fileName, sep = ";", header = TRUE, stringsAsFactors = FALSE)

library(dplyr)

#filter dates
inputData <- filter(inputData, (as.Date(inputData$Date, "%d/%m/%Y") >= start
                                & as.Date(inputData$Date, "%d/%m/%Y") <= end))

#convert date string into date format
inputData <- transform(inputData, dateTime = as.POSIXct(paste0(Date," ",Time ),
              format = "%d/%m/%Y %H:%M:%OS"))

par(mfrow = c(2,2)) #set parameter to plot multiple graphs
par(pty = "s")
par(cex = 0.5)

plot(inputData$dateTime,inputData$Global_active_power,type = "l",
      xlab = "", ylab = "Global Active Power")

plot(inputData$dateTime,inputData$Voltage,type = "l",
      xlab = "datetime", ylab = "Voltage")

plot(inputData$dateTime,inputData$Sub_metering_1,type = "l",
      xlab = "", ylab = "Energy sub metering")

lines(inputData$dateTime,inputData$Sub_metering_2, col = "red")
lines(inputData$dateTime,inputData$Sub_metering_3, col = "blue")
lineNames <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
lineColors <- c("red","blue","black")

legend(x = "topright", legend = lineNames, col = lineColors, lty = c(1,1,1),
      cex = 0.75, border = "white", fill = "white", bty = "n")

plot(inputData$dateTime,inputData$Global_reactive_power,type = "l", 
      xlab = "datetime", ylab = "Global_reactive_power")
