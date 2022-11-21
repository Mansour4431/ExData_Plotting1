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

plot_1 <- function() {
  hist(mf$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot_1.png", width=480, height=480)
  dev.off()
  cat("plot_1.png has been saved in", getwd())
}
plot_1()


