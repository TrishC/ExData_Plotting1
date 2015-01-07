# Exploratory Data Analysis Course Project 1
# Plot 2
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
# Prepare plot 2 using base commands
#
####################################

png(filename = "plot2.png") # launch png graphics device
plot(
     consumption$timestamp,consumption$Global_active_power,
     type="l",
     xlab = paste(""), 
     ylab = paste("Global Active Power (kilowatts)"),     
     yaxt = "n"
     )
axis(2, at = seq(0,6,2))
dev.off() # close graphics device