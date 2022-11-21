library(dplyr)
library(lubridate)
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

mf <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

mf$Global_active_power <- as.numeric(as.character(mf$Global_active_power))
mf$Global_reactive_power <- as.numeric(as.character(mf$Global_reactive_power))
mf$Voltage <- as.numeric(as.character(mf$Voltage))

mf <- transform(mf, TimeSt=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

mf$Sub_metering_1 <- as.numeric(as.character(mf$Sub_metering_1))
mf$Sub_metering_2 <- as.numeric(as.character(mf$Sub_metering_2))
mf$Sub_metering_3 <- as.numeric(as.character(mf$Sub_metering_3))

plot_4 <- function() {
  par(mfrow=c(2,2))
  plot(mf$TimeSt,mf$Global_active_power,ylab="Global Active Power",
       xlab="",type="l")
  plot(mf$TimeSt,mf$Voltage,ylab="Voltage",type="l")
  plot(mf$TimeSt,mf$Sub_metering_1,type="n",xlab = "",ylab="Energy sub metering")
  lines(mf$TimeSt,mf$Sub_metering_1,col="black")
  lines(mf$TimeSt,mf$Sub_metering_2,col="red")
  lines(mf$TimeSt,mf$Sub_metering_3,col="blue")
  plot(mf$TimeSt,mf$Global_reactive_power,type="l")
  dev.copy(png, file="plot_4.png", width=480, height=480)
  dev.off()
  cat("plot_4.png has been saved in", getwd())
}

plot_4()
