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
with(ss, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", lty=1, lwd=2,col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## outputting to file

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()