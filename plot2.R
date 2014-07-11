## Reading .txt dataset

filePath <- file.choose()
df <- read.csv(filePath, header=T, sep=';', na.strings="?", 
				nrows=2075259, check.names=F, stringsAsFactors=F, 
				comment.char="", quote='\"')
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

## getting subset of original whole dataset

ss <- subset(df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(df)

## converting the Date and Time variables to Date/Time classes

datetime <- paste(as.Date(ss$Date), ss$Time)
ss$Datetime <- as.POSIXct(datetime)

## Plotting

plot(ss$Global_active_power~ss$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()