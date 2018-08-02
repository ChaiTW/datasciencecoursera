## Load and clean the table:

epc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
epc$Date <- as.Date(epc$Date, "%d/%m/%Y")
  
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
epc <- subset(epc,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
epc <- epc[complete.cases(epc),]

## Combine Date and Time column
dateTime <- paste(epc$Date, epc$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Remove Date and Time column
epc <- epc[ ,!(names(epc) %in% c("Date","Time"))]
  
## Add DateTime column
epc <- cbind(dateTime, epc)
  
## Format dateTime Column
epc$dateTime <- as.POSIXct(dateTime)

## PLOT 1
  
  ## Create the histogram
  hist(epc$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
  
  ##Save file and close device
  
  #dev.copy(png,"plot1.png", width=480, height=480)
  #dev.off()
