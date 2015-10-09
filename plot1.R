# download and save the file to read data from

data_file <- "household_power_consumption.txt"
if (!file.exists(data_file)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

# read data into R

data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", comment.char = "", header=TRUE,
                   stringsAsFactors = FALSE, 
                   colClasses= c(rep("character", 2), rep("numeric", 7)))

# subset data to include only records valid for requested dates

data_filtered <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# add Timestamp column to the data frame

data_filtered$DateTime <- strptime(paste(data_filtered$Date, data_filtered$Time), "%d/%m/%Y %H:%M:%S")

# make a plot and save it into PNG file

png("plot1.png", width = 480, height = 480)
hist(data_filtered$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()