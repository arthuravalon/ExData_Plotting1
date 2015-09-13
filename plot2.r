## EDA Assignment 1
##
## plot2.R - generates plot2.png

## Load the data, put it in the directory.
filename = "exdata_plotting1.zip"
if (!file.exists(filename)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                         destfile = filename,
                         )
}

## Reading the data from the contents of the zipped file
df.power = read.csv(unz(filename, "household_power_consumption.txt"), header=T,
                    sep=";", stringsAsFactors=F, na.strings="?",
                    colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

## Formatting the date and time and subseting the data only on 2007-02-01 and 2007-02-02
df.power$timestamp = strptime(paste(df.power$Date, df.power$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
df.power = df.power[df.power$timestamp >= startDate & df.power$timestamp <= endDate, ]

## Creating the plot
png(filename="plot2.png", width=480, height=480)
plot(df.power$timestamp, df.power$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()