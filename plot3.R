##Pull relevant rows from text data file and create header
dat <- read.table(file="household_power_consumption.txt", sep = ";", nrows = 2880, 
                  header = FALSE, skip = 66637, na.strings="?",
                  col.names = colnames(read.table(file="household_power_consumption.txt", 
                                                  sep = ";", nrows = 1, header = TRUE)))
##Convert date column to date
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

##Create new POSIXlt based dateTime column using Date and Time columns
dat$DateTime <- strptime(paste(dat$Date,dat$Time), format = "%Y-%m-%d %H:%M:%S")

##Sort order of columns, moving dateTime to position 1 and removing old Date/Time columns
dat <- dat[,c("DateTime","Global_active_power","Global_reactive_power","Voltage",
              "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")]

##Open Graphic Device
png(filename = "plot3.png", width = 480, height = 480)

##Create Plot
plot(dat$DateTime, dat$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab="", cex.lab=1, cex.axis=1)
lines(dat$DateTime, dat$Sub_metering_1)
lines(dat$DateTime, dat$Sub_metering_2, col="red")
lines(dat$DateTime, dat$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=1)

##Close Graphic Device
dev.off()