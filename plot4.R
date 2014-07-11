## Reading .txt dataset

filePath <- file.choose()
df <- read.csv(filePath, header=T, sep=';', na.strings="?", 
				nrows=2075259, check.names=F, stringsAsFactors=F, 
				comment.char="", quote='\"')
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

## getting subset of original whole dataset
ss <- subset(df, subset=(Date >= "2007-02-01" 
				& Date <= "2007-02-02"))

## converting the Date and Time variables to Date/Time classes
datetime <- paste(as.Date(ss$Date), ss$Time)
ss$Datetime <- as.POSIXct(datetime)


## Plotting
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(ss, {
    plot(Global_active_power~Datetime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l",
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright",  lty=1, lwd=2, bty="n", col=c("black", "red", "blue"),
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l",
         ylab="Global Rective Power (kilowatts)",xlab="")
})

## outputting to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()