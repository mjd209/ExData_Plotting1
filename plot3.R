#Read the first 5 lines so we can selec the column classes
tab5rows=read.table("household_power_consumption.txt",sep=";", header=TRUE, nrow=5)
classes=sapply(tab5rows,class)

#Import the whole data set
allData=read.table("household_power_consumption.txt", sep=";", header=TRUE, na.string="?", 
                   colClasses = classes)

#Get the 2 dates we want
data=allData[(allData$Date=="1/2/2007")|(allData$Date=="2/2/2007"),]
dim(data)

data$CompleteTime<-sapply(data, function(x) paste(data$Date,data$Time,sep=" "))[,1]

data$CompleteTime<-strptime(data$CompleteTime,"%d/%m/%Y %H:%M:%S")

#plot3
png("plot3.png",width = 480, height = 480, units = "px")
with(data,plot(CompleteTime,Sub_metering_1, "l",xlab="",ylab="Energy sub metering"))
lines(data$CompleteTime,data$Sub_metering_2, col="red")
lines(data$CompleteTime,data$Sub_metering_3, col="blue")
plot3Names=names(data[7:9])
legend("topright",lty=1,col=c("black","blue","red"),legend=plot3Names)
dev.off()

