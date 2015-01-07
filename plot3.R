# Exploratory Data Analysis Course Project 1
# Plot 3
# Written by Trish Campbell 7 January 2014

###############
#
# Housekeeping
#
###############

# set working directory
setwd("~/Coursera/Exploratory Data Analysis/Course Project 1")

###########
#
# Load data
#
###########

# full dataset
allConsumption <- read.table(
        file = "household_power_consumption.txt", 
        sep = ";", 
        header = TRUE, 
        na.strings = "?",
        colClasses = c("character","character","numeric",
                       "numeric", "numeric", "numeric",
                       "numeric","numeric", "numeric")
)

# convert Date variable to Date class
allConsumption$Date <- as.Date(allConsumption$Date, format="%d/%m/%Y")

# retain only records for 01/02/2007 and 02/02/2007
consumption <- allConsumption[
        allConsumption$Date == as.Date("01/02/2007",format="%d/%m/%Y")|
                allConsumption$Date == as.Date("02/02/2007",format="%d/%m/%Y"),
        ]

# concatenate Date and Time to form a timestamp and format to POSIXlt
consumption$timestamp <- paste(consumption$Date,consumption$Time,sep=" ")
consumption$timestamp <- strptime(consumption$timestamp,"%Y-%m-%d %H:%M:%S")

# remove full dataset 
rm(allConsumption)

####################################
#
# Prepare plot 3 using base commands
#
####################################

png(filename = "plot3.png") # launch png graphics device
plot(
     consumption$timestamp,consumption$Sub_metering_1,
     type="n", 
     yaxt = "n",
     xlab = paste(""),
     ylab = paste("Energy sub metering")
     )
lines(
      consumption$timestamp,consumption$Sub_metering_1, 
      col = "black"
      )
lines(
      consumption$timestamp,consumption$Sub_metering_2, 
      col = "red"
      )
lines(
      consumption$timestamp,consumption$Sub_metering_3, 
      col = "blue"
      )
axis(2, at = seq(0,30,10))
legend(
        "topright", 
        lty=c(1,1), 
        col = c("black","red", "blue"), 
        legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
        )
dev.off() # close graphics device