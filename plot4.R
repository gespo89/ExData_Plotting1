# Read the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

# Filter out the two days we want. We could wait and do this with timestamps, but it's 
# still more performant to do it this way instead of parsing timestamps from ALL the data
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Concat the date and time columns and generate a timestamp column
data$timestamp <- (strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))

# Make a function to generate the plot
makeplot <- function(){
  # Save parameters so we can put them back when we are done
  # The parameter ignores the readonly parameters. We don't need to save them since we obcviously can't change them
  opar<-par(no.readonly = TRUE)
  
  # Set up 2x2 plot grid
  par(mfrow=c(2,2))
  
  # Set the font size a bit smaller as it looked a bit off on my computer
  par(cex=0.7)
  
  # Make the top left plot
  plot(data$timestamp, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  # Make the top right plot
  plot(data$timestamp, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  # Make the bottom left plot
  plot(data$timestamp, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(data$timestamp, data$Sub_metering_2, col="red")
  lines(data$timestamp, data$Sub_metering_3, col="blue")
  legend("topright",  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
  
  # Make the bottom right plot
  plot(data$timestamp, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  # Reset parameters. This fixes an issue where, when running the scripts in succession, parameters
  # would carry over and screw up plotting for later scripts
  par(opar)
}

# Draw the plot to the screen
makeplot()

# Create the plot again for a png, using dev.copy() was causing some distortion, so did it this way instead
png("plot4.png", width=480, height=480)
makeplot()
dev.off()