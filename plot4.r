
#Set the working directory
getwd()
setwd('D:/Documents/DS/EDA/https---github.com-randomnumb-ExData_Plotting1')

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



#Set Option for plots on single frame

png("plot4.png")
par(mfrow=c(2,2))
#Top Left
#Create Plot 
plot(range(HHpower$DTTM),range(HHpower$Global_active_power),ylab='Global Active Power (kilowatts)',xlab='',type='n')
#Add Line
lines(HHpower$DTTM,HHpower$Global_active_power,type='l')

#################Top Right
#Create Plot
plot(range(HHpower$DTTM),range(HHpower$Voltage),ylab='Voltage',xlab='datetime',type='n')

#Add Line
lines(HHpower$DTTM,HHpower$Voltage,type='l')

#################Bottom Left
#Get Ranges
xrange <- range(HHpower$DTTM)
yrange <- range(c(HHpower$Sub_metering_1,HHpower$Sub_metering_2,HHpower$Sub_metering_3))

#Create Plot
plot(xrange,yrange,ylab='Energy sub metering',xlab='',type='n')

#Add Lines
lines(HHpower$DTTM,HHpower$Sub_metering_1,type='l')
lines(HHpower$DTTM,HHpower$Sub_metering_2,type='l',col='red')
lines(HHpower$DTTM,HHpower$Sub_metering_3,type='l',col='blue')

#Add Legend
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1),col=c('black','red','blue'), bty="n")

#################Bottom Right
#Create Plot
plot(range(HHpower$DTTM),range(HHpower$Global_reactive_power),ylab='Global_reactive_power',xlab='datetime',type='n')

#Add Line
lines(HHpower$DTTM,HHpower$Global_reactive_power,type='l')

dev.off()
