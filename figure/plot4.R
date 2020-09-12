#Read the text file
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
#Set the format of date as Date
t$Date<-as.Date(t$Date,"%d/%m/%Y")
#Keeping the data from specified range of dates
t<-subset(t,Date>=as.Date("2007-2-1")&Date<=as.Date("2007-2-2"))
#Keep only the complete data
t<-t[complete.cases(t),]
#Combining date and time
datetime<- paste(t$Date,t$Time)
datetime<-setNames(datetime,"DateTime")
#Removing date and time from the data set
t<-t[,!(names(t) %in% c("Date","Time"))]
#Adding the datetime column to the dataset
t<-cbind(datetime,t)
#Formatting the datetime column
t$datetime <- as.POSIXct(datetime)

#Plot4
par(mfrow=c(2,2))
with(t, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})