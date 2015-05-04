plot1 <- function()
{
	download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile='./exdata-data-household_power_consumption.zip',method="curl")
	unzip(zipfile = 'exdata-data-household_power_consumption.zip',overwrite=TRUE,list=FALSE)
	file <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

	a <- file$Date == '1/2/2007' | file$Date == '2/2/2007'
	b <- file[a,]
	c <- as.numeric(as.vector(b$Global_active_power))
	d <- 1:length(c)
	e <- floor(c*10)/10

	f <- floor(c)
	g <- (e - f)
	h <- (g >= 0.5)
	i <- (g < 0.5)
	j <- i*0.49
	k <- h*0.99
	Global_Active_Power <- f + j + k
	windows.options(width=480,height=480)
	hist(Global_Active_Power,col="red",xlab="Global Active power (kilowatts)",main = "Global Active Power")
	dev.copy(png,filename="plot1.png",width=480,height=480)
	dev.off()

}

