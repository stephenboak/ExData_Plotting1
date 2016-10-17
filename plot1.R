## Load Lubridate package
## library(lubridate)
## Read in a subset of data based on selected row numbers corresponding to
## readings taken on dates between 1 and 2 Feb 2007.
## Reinstate the column names from the original file.  
hPower <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880,
           col.names = c("Date", "Time", "Global Active Power", "Global Reactive Power", "Voltage", "Global Intensity", "Sub metering 1", "Sub metering 2", "Sub metering 3"), stringsAsFactors = FALSE)

## Convert Date/Time character string data to date and POSIXlt format for manipulation
hPower$Date <- as.Date(hPower$Date, format = "%d/%m/%Y")
hPower$Time <- strptime(hPower$Time, format = "%T")

## Create histogram plot of Global Active Power
hist(hPower$Global.Active.Power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Copy plot to png file
dev.copy(png, file = "plot1.png")
dev.off()

