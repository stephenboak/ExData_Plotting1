## Read in a subset of data based on selected row numbers corresponding to
## readings taken on dates between 1 and 2 Feb 2007.
## Reinstate the column names from the original file.  
hPower <- read.table(file = "household_power_consumption.txt", header = TRUE,
                     sep = ";", skip = 66636, nrows = 2881, col.names =
                         c("Date", "Time", "Global Active Power","Global Reactive Power",
                           "Voltage", "Global Intensity", "Sub metering 1", "Sub metering 2",
                           "Sub metering 3"), stringsAsFactors = FALSE)

## Convert Date/Time character string data to date and POSIXlt format for manipulation
hPower$Date <- as.Date(hPower$Date, format = "%d/%m/%Y")
hPower$Time <- strptime(hPower$Time, format = "%T")

## Plot line graph with amended y axis label and suppressed x axis label/ticks
plot(hPower$Global.Active.Power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")

## Add x axis tick labels and set positions  
axisLabels <- unique(weekdays(hPower$Date, abbreviate = TRUE))
axisLabelsAt <- c(0, 1440, 2881)
axis(1, at = axisLabelsAt, labels = axisLabels)

## Copy plot to png file
dev.copy(png, file = "plot2.png")
dev.off()
