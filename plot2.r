
#Set the working directory
getwd()
setwd('D:/Documents/DS/EDA/https---github.com-randomnumb-ExData_Plotting1')

#Loading libraries for session.
library(sqldf)
library(lubridate)

#Download the source file
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              destfile='HH_power.zip')

#list files in the zip
unzip('HH_power.zip',list=TRUE)

#Unzip the file
unzip('HH_power.zip',list=FALSE)

#Rough estimate of the size of the data frame:
# Est size = # rows * # columns * 8 bytes / 2^20
# Source: http://simplystatistics.org/2011/10/07/r-workshop-reading-in-large-data-frames/

est_size = 2075259 * 9 * 8 /2^20
est_size

#Examine data to be read.
rm(HHpower)
read.table('household_power_consumption.txt',nrows=100,sep=';')

#Conditional Dataset
HHpower <- read.csv.sql('household_power_consumption.txt',
                        sql="SELECT * FROM file WHERE Date IN ('1/2/2007','2/2/2007')",sep=';',header=TRUE)

#Setting DTTM formats
HHpower$DTTM <- paste(HHpower$Date,HHpower$Time,sep=' ')
HHpower$DTTM = dmy_hms(HHpower$DTTM)


#Create plot2

#Get Ranges
xrange <- range(HHpower$DTTM)
yrange <- range(HHpower$Global_active_power)

png("plot2.png")

plot(xrange,yrange,ylab='Global Active Power (kilowatts)',xlab='',type='n')
lines(HHpower$DTTM,HHpower$Global_active_power,type='l')

dev.off()


