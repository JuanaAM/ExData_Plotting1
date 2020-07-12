##Check if the zip file is already downloaded and unzip it
if (!file.exists("household_power_consumption.txt")){
  unzip(zipfile = "household_power_consumption.zip")
}

## Read first row of data to check column names
dataheader <- read.table("household_power_consumption.txt",sep = ";", header = T, nrows = 1)

##Read data, skip and nrow are used to subset data in the specified dates, colnames
##in the set created in the previous step are used here to assign column names.
data <- read.table("household_power_consumption.txt", sep = ";", 
                   skip = grep("1/2/2007", readLines("household_power_consumption.txt"))[1]-1, 
                   nrows = grep("3/2/2007", readLines("household_power_consumption.txt"))[1] - grep("1/2/2007;00:00:00", readLines("household_power_consumption.txt"))[1], 
                   col.names = names(dataheader), na.strings = "?") 

##Change format of variable Time and Date
data$Time <-  strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

##Check for current device and set windows as current device
dev.cur()
X11()

##PLot on Windows
par(mfrow = c(2,2))
with(data,{
  plot(Time, Global_active_power, type = "l", ann = F)
  title(ylab = "Global Active Power")
  plot(Time, Voltage, type = "l", ylab = "Voltaje", xlab = "datetime")
  plot(Time, Sub_metering_1, type = "l", ann = F)
  lines(Time, Sub_metering_2, col="red")
  lines(Time, Sub_metering_3, col="blue")
  title(ylab = "Energy sub metering")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
  plot(Time, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
} )

##Open png device and plot on it
png("plot4.png")
par(mfrow = c(2,2))
with(data,{
  plot(Time, Global_active_power, type = "l", ann = F)
  title(ylab = "Global Active Power")
  plot(Time, Voltage, type = "l", ylab = "Voltaje", xlab = "datetime")
  plot(Time, Sub_metering_1, type = "l", ann = F)
  lines(Time, Sub_metering_2, col="red")
  lines(Time, Sub_metering_3, col="blue")
  title(ylab = "Energy sub metering")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
  plot(Time, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
} )
dev.off()
