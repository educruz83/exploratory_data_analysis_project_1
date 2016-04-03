## Download data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
## Read and preprocess data
doc1 <- read.table(file, header=TRUE, sep=';')

doc1$Date <- as.Date(doc1$Date, format="%d/%m/%Y")
doc1_datefilter <- doc1[(doc1$Date =="2007-02-01") | doc1$Date=="2007-02-02",]

doc1_datefilter$Global_active_power <- as.numeric(as.character(doc1_datefilter$Global_active_power))
doc1_datefilter$Global_reactive_power <- as.numeric(as.character(doc1_datefilter$Global_reactive_power))
doc1_datefilter$Voltage <- as.numeric(as.character(doc1_datefilter$Voltage))
doc1_datefilter$Sub_metering_1 <- as.numeric(as.character(doc1_datefilter$Sub_metering_1))
doc1_datefilter$Sub_metering_2 <- as.numeric(as.character(doc1_datefilter$Sub_metering_2))
doc1_datefilter$Sub_metering_3 <- as.numeric(as.character(doc1_datefilter$Sub_metering_3))

## Plot 4
par(mfrow=c(2,2))

##PLOT 1
plot(doc1_datefilter$timestamp,doc1_datefilter$Global_active_power, type="l", xlab="", ylab="Global Active Power")
##PLOT 2
plot(doc1_datefilter$timestamp,doc1_datefilter$Voltage, type="l", xlab="datetime", ylab="Voltage")

##PLOT 3
plot(doc1_datefilter$timestamp,doc1_datefilter$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(doc1_datefilter$timestamp,doc1_datefilter$Sub_metering_2,col="red")
lines(doc1_datefilter$timestamp,doc1_datefilter$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)

#PLOT 4
plot(doc1_datefilter$timestamp,doc1_datefilter$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#OUTPUT
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()