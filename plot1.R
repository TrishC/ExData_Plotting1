# Exploratory Data Analysis Course Project 1
# Plot 1
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
# Prepare plot 1 using base commands
#
####################################

png(filename = "plot1.png") # launch png graphics device
hist(
     consumption$Global_active_power,
     breaks = 12, 
     main = paste("Global Active Power"),
     xlim = c(0,6), 
     ylim = c(0,1200), 
     col = "red", 
     xlab = paste("Global Active Power (kilowatts)"), 
     axes = F
     )
axis(1, at = seq(0,6,2))
axis(2, at = seq(0,1200,200))
dev.off() # close graphics device
