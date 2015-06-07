# Read the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

# Filter out the two days we want. We could wait and do this with timestamps, but it's 
# still more performant to do it this way instead of parsing timestamps from ALL the data
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Concat the date and time columns and generate a timestamp column
data$timestamp <- (strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))

# Make a function to generate the plot
makeplot <- function(){
  #Make the plot
  plot(data$timestamp, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(data$timestamp, data$Sub_metering_2, col="red")
  lines(data$timestamp, data$Sub_metering_3, col="blue")
  legend("topright",  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
}

# Draw the plot to the screen
makeplot()

# Create the plot again for a png, using dev.copy() was causing some distortion, so did it this way instead
png("plot3.png", width=480, height=480)
makeplot()
dev.off()