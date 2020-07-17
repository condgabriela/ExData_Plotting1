##########Course Project 1: Exploratory Data Analysis#############

rm(list = ls())

# Libraries =======================

library(dplyr)

# Set download date ===============
DataSetEj1<-Sys.Date()

# Set working directory ======================
setwd("C:/Users/condgabriela/Curso R/GettingandCleaningData")


# Create working directories========
if (!file.exists(("data"))){ dir.create("data")}
if (!file.exists(("code"))){dir.create("code")}
if (!file.exists(("plots"))){dir.create("plots")}

# Unzip file ======================
unzip("./data/household_power_consumption.zip", exdir = "./data")

# Upload table ======================
HouseHPC<-read.table("./data/household_power_consumption.txt", stringsAsFactors = FALSE, 
                     na.strings = "?", header = TRUE, sep = ";")

# Format Date and Time columns ======================
HouseHPC$Date<-as.Date(HouseHPC$Date, tryFormats = c("%d-%m-%Y", "%d/%m/%Y"))
HouseHPC$Time<-strptime(HouseHPC$Time, format = "%H:%M:%S") 
HouseHPC$Time<-as.POSIXct(HouseHPC$Time)


# Filter data frame ================================
HouseHPC_Filtered<-filter(HouseHPC, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

### Transform Time variable==========================

HouseHPC_Filtered[1:1440,"Time"] <- format(HouseHPC_Filtered[1:1440,"Time"],"2007-02-01 %H:%M:%S")
HouseHPC_Filtered[1441:2880,"Time"] <- format(HouseHPC_Filtered[1441:2880,"Time"],"2007-02-02 %H:%M:%S")




# Plot 1 ================================

png("./plots/plot1.png", height = 480, width = 480)

hist(HouseHPC_Filtered$Global_active_power,col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.off()
