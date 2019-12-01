zipFileName <- paste0(getwd(), "/", "exdata_data_household_power_consumption.zip")
fileName <- paste0(getwd(), "/", "household_power_consumption.txt")

start <- as.Date("01/02/2007","%d/%m/%Y") #date range
end <- as.Date("02/02/2007","%d/%m/%Y")

unzip(zipFileName)
inputData <- read.table(fileName, sep = ";", header = TRUE, stringsAsFactors = FALSE)

library(dplyr)

par(pty = "s")
par(cex = 0.75)

#filter on date
inputData <- filter(inputData, (as.Date(inputData$Date, "%d/%m/%Y") >= start
                                & as.Date(inputData$Date, "%d/%m/%Y") <= end))

#convert date string to date format
inputData <- transform(inputData, dateTime = as.POSIXct(paste0(Date," ",Time ),
                                               format = "%d/%m/%Y %H:%M:%OS"))


png(filename = "plot2.png", width = 480, height = 480)

#plot the graph
plot(inputData$dateTime,inputData$Global_active_power,type = "l", xlab = "",
      ylab = "Global Active Power (kilowatts)")

dev.off()
