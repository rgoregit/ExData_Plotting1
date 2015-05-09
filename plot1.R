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
  invisible(read.csv(datafile ,sep=";",header=TRUE, na.string="?", colClasses=c("character", "character", "numeric",
                                                                           "numeric", "numeric", "numeric",
                                                                           "numeric", "numeric", "numeric")))

}

# Get Data frame from data File
df <- getData()

## Format the date and subseting the data only on 2007-02-01 and 2007-02-02
df$Date = as.Date(df$Date, format="%d/%m/%Y")
## Intialize Start date and End date as 2007-02-01 and 2007-02-02
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")

## get subset data- from startDate to endDate
df = df[df$Date >= startDate & df$Date <= endDate, ]

## Create the plot
png(filename="plot1.png", width=480, height=480)
# Create histogram
hist(df$Global_active_power, 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power",
     col="red")
## close device
dev.off()


