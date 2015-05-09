##
## Exploratory Data Analysis  Assignment 1
## Plotting Graphs 
##
## Program file plot1.R - generates plot1.png graph
##
##
# Data location https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Overall goal of this program is to examine how household energy usage
# varies over a 2-day period in February, 2007. 
# The task is to reconstruct the plots using the base plotting system.
# The plot is save as a PNG file with a width of 480
# pixels and a height of 480 pixels.
# 
# * Name of the plot files is "plot1.png"


## Downloaded data zip file and unzip file into working directory
## Read file and create to data frame

getData <- function (){
  # download zip file 
  # Data file Name
  datafile ="household_power_consumption.txt"
  zfname = "exdata_Assign1.zip"
  furl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  if (!file.exists(zfname)) {
    retval = download.file(furl, destfile = zfname,method = "auto")
  }
  # Unzip file and get Data file in working dir
  unzip(zfname,files=datafile)
  # Read data file and return  Data Frame
  invisible(read.csv(datafile ,sep=";",header=TRUE, na.string="?",
                     colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric")))

}

# Get Data frame from data File
df <- getData()

## Formatting the date and time and subseting the data only on 2007-02-01 and 2007-02-02
df$timestamp = strptime(paste(df$Date, df$Time),format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
df = df[df$timestamp >= startDate & df$timestamp <= endDate, ]


## Creating the plot
png(filename="plot3.png", width=480, height=480)
plot(df$timestamp, df$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(df$timestamp, df$Sub_metering_2, col="red")
lines(df$timestamp, df$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"))
dev.off()
