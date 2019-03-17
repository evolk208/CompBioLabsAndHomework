#################
# Lab 09 - 
# Computational Biology, Spring 2019 
# Emily Volk 
#################
# Start time: 5pm Saturday 
# ===== Data: 
# Import camera trap data 
getwd()
camData <- read.csv( "/Users/emilymvolk/Documents/SP19/CompBio/CompBioLabsAndHomework/Labs/Lab09/data/Cusack_et_al/Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)

# Inspect data: 
names(camData)
str(camData)
# Note: DateTime is in Day/Month/Yr 12hrtime 
summary(camData)

# OVERALL GOAL of this Lab: Convert DateTime into accurate, human-readable info based on some date conversion resources 
# ==== Problem 1: Details below 
# ====
# The import as written on above creates the DateTime column as characters. Using the information at https://www.stat.berkeley.edu/~s133/dates.html, how could you convert those dates and times into actual objects that represent time (as we humans think about it) rather than just being character strings? I suggest you try to use strptime(), in which case the challenge will be to figure out how to use the format argument.

# Hints:
# - Use the info at the link given above and also try ?strptime in your console. Remember that the import of the data creates the DateTime vector as a vector of character strings. That is the starting point.
# - Don't try to work on the whole DateTime vector initially. Try your methods on a small, bite sized piece of it. For example, you could make a new variable such as:
# smallVec <- camData$DateTime[1:5]
# or
# oneDate <- camData$DateTime[1]
# and then just try lots of differerent ideas you have in your console with the smallVec and/or oneDate objects.
# - Once you think you have a working method (i.e., it seems to work on your small test object(s)), then try to implement it on the whole DateTime vector and keep the working code in your script.
# ====
# Subset out one/small DateTime unit for testing method of conversion: 
oneDate <- camData$DateTime[1]
smallVec <- head(camData$DateTime)
# Also, look at full DateTime colvec 
camData$DateTime
# Generallly, all look in same format 
# Init format: "D/M/Y_24:hrtime" 

# First goal: Convert into R spec date options. 
# 1. First option: using strptime() to store date and time in same object 
?strptime()

# Try on single DateTime first (oneDate) 
oneDate
# **Q: Uses = vs. <- in example: Want to clarify in class 
# Note: Years are coded as either 2 or 4 digit years. A couple of ways I can work around this...
oneDate

date1 <- strptime(oneDate, format="%d/%m/%Y %H:%M")
date1

# Try on smallVec and modify accordingly 
smallVecDates <- strptime(smallVec, format="%d/%m/%Y %H:%M")
smallVecDates

# Try on all...
camData$DateTime
dateTimeTest <- strptime(camData$DateTime, format="%d/%m/%Y %H:%M")
dateTimeTest
# Note: for dates that were coded as only 2 char date, did input, but missing "2" to make a proper "2013" 
# Storing one example of this to fix: 
oneTest <- dateTimeTest[905]
oneTest
str(oneTest)
oneTest <- as.character(oneTest)
# See if this works on a full vector: 
dateTimeTest <- as.character(dateTimeTest)
str(dateTimeTest)
# Conversion works 
# Need to access elements of the string to change (one way)
# Gets first two digits: In wrongly coded years, this will be "00" 
substr(oneTest, 1, 2)

# Test replacement: 
substr(oneTest, 1, 2) <- "20"
oneTest
# Checked: Works 

# See if conversion back works: 
str(oneTest)
oneTest <- as.POSIXlt(oneTest)
str(oneTest)
# Good, works I think 

# Make a function for this yr repl to 20__ 
# - Calling the two digits to add to a two-digit year "prefix" 
# - "Vector" is a vector of POSIXlt data type dates 
fourDigitYear <- function(prefix, vector) {
    vector <- as.character(vector)
    for(i in 1:length(vector)) {
        if(substr(vector[i], 1, 2)=="00") {
            substr(vector[i], 1, 2) <- prefix
        }
    }
    # Convert back to POSIXlt data type
    vector <- as.POSIXlt(vector)
    return(vector)
}

# Test: 
dateTimeTest <- fourDigitYear("20", dateTimeTest)
dateTimeTest

# NICE looks like it works. 


# ===== Summary of what I did to convert to 4digityear/m/d 24:hour time format: 
# Problem 1. Convert to R data data structure using strptime() 
camData$DateTime
dateTimeTest <- strptime(camData$DateTime, format="%d/%m/%Y %H:%M")
dateTimeTest

# Problem 2. Fix 2-digit year codes to 4-digit year codes. This requires input of the proper year prefix, which we can assume from the data collection 
dateTimeTest <- fourDigitYear("20", dateTimeTest)
dateTimeTest

# Problem 3: I think this is accurate...I'm not sure how to check further. None of the month or days look incorrect on first look 

# Problem 4: Average time 
# Overall: 
mean(dateTimeTest)
# Average date-time/season 
unique(camData$Season)
# Go by index for each season 
seasonDavgDateTime <- mean(dateTimeTest[which(camData$Season=="D")])
seasonWavgDateTime <- mean(dateTimeTest[which(camData$Season=="W")])

# By station: 
camData$Station
unique(camData$Station)
# Can do a lot of options here 

# By species: 
unique(camData$Species)

# Let's do average dateTime for Hippos during Wet and Dry seasons to compare, as an example: 
# For multiple, I am going to store the modified date/time in the dataframe: 
camData$DateTime <- dateTimeTest
# A long way to do this, using a chain of subsets: 
hippos <- subset(camData, Species=="Hippo")
dryHippos <- subset(hippos, Season=="D")
# In future, should really store D and W as factors ! 
wetHippos <- subset(hippos, Season=="W")

# Avg dateTime for wet v. dry hippos: 
mean(dryHippos$DateTime)
mean(wetHippos$DateTime)

# Can also just find avg times or average dates, alone: 
dateTimeTest[1]
# Convert to just date: 
as.Date(dateTimeTest[1])
# Convert to just time: 
test <- format(dateTimeTest[1], format="%H:%M:%S")

# Question: For average time, does this happen independent of average date or does this mean factor in both date and time?? How would I find AVERAGE TIME OF DAY across all dates? 

# Initial end time: 6:45pm Sat 


