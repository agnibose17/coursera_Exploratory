
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
png(file="plot1.png",width = 480, height = 480, units = "px")
hist(hpcs$gap,na.rm=TRUE,col="red",main="Global Active Power",xlab="Global Active Power (Kilowatts)")
dev.off()

