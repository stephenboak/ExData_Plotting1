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

## Set up multiple base plots
par(mfcol = c(2,2), mar = c(4, 4, 2, 1), oma = c(1, 1, 0, 0))
with(hPower, {

    ## PlotA: Plot line graph with amended y axis label and suppressed x axis label/ticks
    plot(Global.Active.Power, type = "l", ylab = "Global Active Power (kilowatts)",
         xlab = "", xaxt = "n", cex = 1.0, cex.lab = 0.75, cex.axis = 0.75)

    ## Add x axis tick labels and set positions  
    axisLabels <- unique(weekdays(hPower$Date, abbreviate = TRUE))
    axisLabelsAt <- c(0, 1440, 2881)
    axis(1, at = axisLabelsAt, labels = axisLabels, cex.axis = 0.75)

    ## PlotB: Plot line graph with amended y axis label and suppressed x axis label/ticks
    plot(Sub.metering.1, type = "l", ylab = "Energy sub metering", xlab = "",
         xaxt = "n", cex = 1.0, cex.lab = 0.75, cex.axis = 0.75)

    ## Add additional lines to plot for submetering 2 & 3 and distinguish with colour 
    lines(Sub.metering.2, type = "l", col = "red")
    lines(Sub.metering.3, type = "l", col = "blue")

    ## Add x axis tick labels and set positions  
    axisLabels <- unique(weekdays(hPower$Date, abbreviate = TRUE))
    axisLabelsAt <- c(0, 1440, 2881)
    axis(1, at = axisLabelsAt, labels = axisLabels, cex.axis = 0.75)

    ## Create legend box
    legend(1300, 40, lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", text.width = 1000, cex = 0.7, pt.cex = 1.0, y.intersp = 1.2)


    ## PlotC: Plot line graph of voltage over time
    plot(Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n",
         cex = 1.0, cex.lab = 0.75, cex.axis = 0.75)
    
    ## Add x axis tick labels and set positions  
    axisLabels <- unique(weekdays(hPower$Date, abbreviate = TRUE))
    axisLabelsAt <- c(0, 1440, 2881)
    axis(1, at = axisLabelsAt, labels = axisLabels, cex.axis = 0.75)


    
    ## PlotD:
    plot(Global.Reactive.Power, type = "l", ylab = "Global Reactive Power",
         xlab = "datetime", xaxt = "n", cex = 1.0, cex.lab = 0.75, cex.axis = 0.75)
    
    ## Add x axis tick labels and set positions  
    axisLabels <- unique(weekdays(hPower$Date, abbreviate = TRUE))
    axisLabelsAt <- c(0, 1440, 2881)
    axis(1, at = axisLabelsAt, labels = axisLabels, cex.axis = 0.75)

})


## Copy plot to png file
dev.copy(png, file = "plot4.png")
dev.off()