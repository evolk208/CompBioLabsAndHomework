# Computational Biology, Spring 2019 
# Lab 5: Loops and Conditionals 
# Emily Volk 
# 
# Description: This lab will involve practice with loops and conditions, and use a loop to perform iterative (recursive) calculations of the type that are common in models of population biology. This lab will also include practice using vectorized operations, also with conditionals. 
# ==================================
# Part 1: Practice with conditionals 
# 1. 
x <- 3 
threshold <- 5 # storing threshold value to compare x to 

if ( x > threshold) {
    cat(paste("x is greater than", threshold))
} else {
    cat(paste("x is less than or equal to", threshold))
}

# 2. Obtain and import "Vector1.csv" from Sam's Github folder
# Checking working directory
getwd()
# Set wd to CompBio Lab05 folder 
setwd("~/Documents/SP19/CompBio/CompBioLabsAndHomework/Labs/Lab05")

# Load file and store 
vector1 <- read.csv("Vector1.csv")

# Note that this is structured as a column vector 
dim(vector1)

# Make into a vector to make following problems easier 
vector1 <- as.vector( t(vector1) )
# Note: Can also do this during import 

# 2a. Using a for loop, check each value of vector1 and replace negative values with NA
# Using summaries to check 
summary(vector1)
for ( i in 1:length(vector1) ) {
    if( vector1[i] < 0 ) {
        vector1[i] <- NA
    }
}
summary(vector1)

# 2b. Using vectorized code (no loop) that makes use of "logical" indexing, replace all NA values with NaN
vector1[is.na(vector1)] <- NaN

# 2c. using a which statement and integer indexing, replace NaN values with 0
# Which gives indexes that are NaN 
# Note: Don't actually need the which here 
vector1[which(is.nan(vector1))] <- 0

# 2d. Determine how many values fall in range between 50 and 100, incluse of endpoints 
l <- length(vector1[vector1 >= 50 & vector1 <= 100])
l 

# 2e. Using any method, create a new vector of data that has the values from the data that fall between 50 and 100. DO NOT dynamically grow the array. 
FiftyToOneHundred <- rep(0, l)
FiftyToOneHundred <- vector1[vector1 >= 50 & vector1 <= 100]

# 2f. Use write.csv to save vector to a file named "FiftyToOneHundred.csv". Use all default settings with write.csv
write.csv(FiftyToOneHundred, file="FiftyToOneHundred.csv")

# 3. Import the data on CO2 emissions from last week's lab ("CO2_data_cut_paste.csv" from Lab04). 
# Note: Do not need to use any loops for this problem. Use a combination of which(), logical operators, and/or indexing. 
co2dat <- read.csv("../Lab04/CO2_data_cut_paste.csv")

# 3a. What was the first year for which "Gas" emissions were non-zero? 
head(co2dat$Year[co2dat$Gas > 0], 1)

# 3b. During which years were "Total" emissions between 200 and 300 million metric tons of carbon? # Note, from metadata: All emissions estimates are expressed in million metric tons of carbon. 
co2dat$Year[co2dat$Total > 200 & co2dat$Total < 300]

# Part 2. Loops + conditionals + biology 
# Lotka-Volterra predatory-prey model: 
# n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
# p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])
# Variables: 
# n[t] = prey abundance at time t 
# p[t] = predator abundance at time t 
# r = intrinsic grotwh rate (prey)
# a = attack rate of predators on prey
# k = conversion constant of conversion of consumed prey into biomass of predators 
# m = intrinsic mortality rate 

# Write code for this model 

# Set up parameter values 
totalGenerations <- 1000
initPrey <- 100 	# initial prey abundance at time t = 1
initPred <- 10		# initial predator abundance at time t = 1
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators

# Create a "time" vector
time <- seq(totalGenerations)

# Vector to store the values of n (prey abundances) over time 
n <- c(initPrey, rep(0, length(time)-1))

# Cector to store the values of p (predator abundances) over time
p <- c(initPred, rep(0, length(time)-1))

# Write a loop that implements calculations for this model
# Note: Skipping first index because these are initial values
for( i in 2:totalGenerations ) {
    n[i] <- n[i-1] + (r * n[i-1]) - (a * n[i-1] * p[i-1])
    p[i] <- p[i-1] + (k * a * n[i-1] * p[i-1]) - (m * p[i-1])
    if ( n[i] < 0 ) {
        n[i] <- 0
    } 
    if( p[i] < 0 ) {
        p[i] <- 0
    }
}
# In this model it is possible that predators may kill off all the prey. Due to the discrete nature of how time is considered in this model, it is possible that the calculations as given can result in negative numbers. Add some if statements to your code to check for negative numbers at each generation, and set them to 0 (correction) (ABOVE)

# Plot values over time 
# Doing a stairstep plot here to give a balance between the discrete points of this model and the general trend line 
plot(time, n, col="blue", type="s", main="Lotka-Volterra Predator-Prey Model", xlab="Time (year)", ylab="Abundance")
points(time, p, col="brown3", type="s")
?legend()
legend("topright", legend=c("Prey", "Predator"), col=c("blue", "brown3"), lty=1)
