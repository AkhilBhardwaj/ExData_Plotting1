plot2 <- function()
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
	windows.options(width=480,height=480)

	plot(b$DateTime,b$c,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.copy(png,filename="plot2.png",width=480,height=480)
dev.off()

}

