plot3 <- function()
{
	download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile='./exdata-data-household_power_consumption.zip',method="curl")
	unzip(zipfile = 'exdata-data-household_power_consumption.zip',overwrite=TRUE,list=FALSE)
	file <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

	a <- file$Date == '1/2/2007' | file$Date == '2/2/2007'
	b <- file[a,]
	b$c <- as.numeric(as.vector(b$Global_active_power))
	b$d <- strsplit(as.character(b$Date),split="/")
	for(i in 1:2880){
	b$day[i] <- b$d[[i]][1]
	b$month[i] <- b$d[[i]][2]
	b$year[i] <- b$d[[i]][3]	
	}
	b$d <- strsplit(as.character(b$Time),split=":")
	for(i in 1:2880){
	b$Hour[i] <- b$d[[i]][1]
	b$Minute[i] <- b$d[[i]][2]
	b$Second[i] <- b$d[[i]][3]
	}

	b$DateTime<-ISOdatetime(b$year,b$month,b$day,b$Hour,b$Minute,b$Second, tz = "")


library(reshape2)
b2 <- melt(b,id=c("DateTime"),measure.vars=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

	windows.options(width=480,height=480)

plot(b2$DateTime,b2$value,type="n",ylab="Energy sub metering",xlab="")
with(subset(b2,variable=="Sub_metering_1"),lines(DateTime,value,col="black"))
with(subset(b2,variable=="Sub_metering_2"),lines(DateTime,value,col="red"))
with(subset(b2,variable=="Sub_metering_3"),lines(DateTime,value,col="blue"))
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.copy(png,filename="plot3.png",width=480,height=480)
dev.off()

}

