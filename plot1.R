# Read the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

# Filter out the two days we want. We could parse the dates, but a string comparison is faster and good enough
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Make a function to generate the plot
makeplot <- function(){ 
  # Make the plot
  hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
}

# Draw the plot to the screen
makeplot()

# Create the plot again for a png, using dev.copy() was causing some distortion, so did it this way instead
png("plot1.png", width=480, height=480)
makeplot()
dev.off()