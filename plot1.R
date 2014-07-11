## Reading .txt dataset

filePath <- file.choose()
df <- read.csv(filePath, header=T, sep=';', na.strings="?", 
				nrows=2075259, check.names=F, stringsAsFactors=F, 
				comment.char="", quote='\"')
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

## getting subset of original whole dataset
subdata <- subset(df, subset=(Date >= "2007-02-01" 
				& Date <= "2007-02-02"))

## converting the Date and Time variables to Date/Time classes
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)

## Plotting
hist(subdata$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## outputting to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()