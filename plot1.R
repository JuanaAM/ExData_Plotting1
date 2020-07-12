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
hist(data$Global_active_power, main = "Global Active Power",breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)")

##Open png device and plot on it
png("plot1.png")
hist(data$Global_active_power, main = "Global Active Power",breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()

