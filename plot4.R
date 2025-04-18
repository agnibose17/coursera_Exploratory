
library(date)
library(dplyr)

hpc <- read.csv("C:/Users/agnib/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";")
dim(hpc)
names(hpc)



hpc$DT<-paste (hpc$Date,hpc$Time,sep=" ")
hpc$Datetime<-strptime(hpc$DT,format="%d/%m/%Y %H:%M:%S")
hpc$D<-as.Date(hpc$Datetime)
hpc$Day<-weekdays(hpc$D)
hpcs<-hpc%>% filter(D =="2007-02-01"|D=="2007-02-02")

hpcs$gap<-as.numeric(hpcs$Global_active_power)
hpcs$T<-strptime(hpcs$Time,format="%H:%M:%S")
hpcs$Sub_metering_1<- as.numeric(hpcs$Sub_metering_1)
hpcs$Sub_metering_2<- as.numeric(hpcs$Sub_metering_2)
attach(hpcs)
par(mfrow = c(2,2))

plot(Datetime, gap,xaxt='n', xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
days <- seq(from = hpcs$Datetime[1], to = as.POSIXlt(as.POSIXct(hpcs$Datetime[2880]+60)), by = "day")
axis(1, at = days, labels = format(days,"%A"))

plot(Datetime,as.numeric(Voltage) , xaxt='n',xlab = "datetime", ylab = "Voltage", type = "l")
days <- seq(from = hpcs$Datetime[1], to = as.POSIXlt(as.POSIXct(hpcs$Datetime[2880]+60)), by = "day")
axis(1, at = days, labels = format(days,"%A"))

plot(hpcs$Datetime, hpcs$Sub_metering_1,xaxt='n', xlab = "", ylab = "Energy sub metering", type = "l")
lines(hpcs$Datetime, hpcs$Sub_metering_2, col = "red")
lines(hpcs$Datetime, hpcs$Sub_metering_3, col = "blue")
legend('topright',legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),cex=0.8,lty=c(1,1,1),bty="n")
days <- seq(from = hpcs$Datetime[1], to = as.POSIXlt(as.POSIXct(hpcs$Datetime[2880]+60)), by = "day")
axis(1, at = days, labels = format(days,"%A"))

plot(Datetime, as.numeric(Global_reactive_power), xaxt='n',xlab = "datetime", ylab = "Global_reactive_power", type = "l")
days <- seq(from = hpcs$Datetime[1], to = as.POSIXlt(as.POSIXct(hpcs$Datetime[2880]+60)), by = "day")
axis(1, at = days, labels = format(days,"%A"))
dev.copy(png,filename='plot4.png',width=480,height=480,units='px')
dev.off()
