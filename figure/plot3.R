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

#Plot3
dev.new(width = 480, height = 480, unit = "px")
par(bg = "white")
with(t, { plot(Sub_metering_1~datetime, type="l",
         ylab="Energy sub metering", xlab="")
         lines(Sub_metering_2~datetime,col='Red')
         lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", cex = 0.8, legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = c(2,2,2), col = c("black", "red", "blue"))
#Saving png
dev.copy(png, file = "plot3.png")
dev.off()
