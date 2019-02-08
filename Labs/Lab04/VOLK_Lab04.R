# Lab 04: For Loops 
# Computational Biology, Spring 2019 
# Emily Volk 
# ================
# For this Lab, keep in mind best practices, including:
# - Spacing around operators 
# - Storing all parameters as easily referenced variables (+ no magic numbers)
# - Specific commenting throughout 
# * Note: I'm separating problems with ==== to be able to collapse them to more easily navigate my code 
# ================
# ===================================
# Part 1: Practicing writing for loops
# ====================================
# 1. Write a for loop that prints the word "hi" to console 10 times 
# ====
for(i in 1:10){
    print("hi")
}
# ====
# 2. Tim currently has $10 in his piggy bank. Each week, he gets an allowance of $5. Each week he also buys 2 packs of gum, which each cost $1.34. How much money will Tim have in total 8 weeks from now? Write a for loop that prints his total amt of money EACH WEEK for the next 8 weeks. 
# ====
# Initial parameters: 
initialFunds <- 10 # Tim starts with $10 
allowance <- 5 # Weekly allowance 
gumPerWeek <- 2 # Num gum packets Tim buys/week
costGum <- 1.34 # Cost of one gum pack 
# Weeks for model 
weeks <- 8 

# Write for loop - prints Tim's money each week for specified number of weeks (above)
# Creating var funds to store funds each week through loop. Starts at value of initialFunds
funds <- initialFunds 
for(i in 1:weeks) {
    funds <- funds + allowance - (gumPerWeek*costGum)
    print(paste("Week", i, ":", funds))
}
# ====
# 3. A conservation biologist estimates that under current conditions a population she is studying will shrink by 5%/year. Current pop size is 2000 individuals. What is expected pop size each year for the next seven year? Write a for loop. 
# ====
# Store parameters 
initialPop <- 2000 # individuals 
ratePop <- -.05 # Population will shrink by 5% a year
years <- 7 # Calculating for this number of years 

# Creating variable to store expected population for each year. This will start as the same as initialPop 
expectedPop <- initialPop 
for(i in 1:years) { 
    expectedPop <- expectedPop + (ratePop * expectedPop)
    print(paste("Year:", expectedPop, "individuals"))
}
# ====
# 4. Discrete-time logistic growth 
# Equation: n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
# n[t] = abundance of the pop at time t
# n[t-1] = abundance of pop at previous time step 
# r = intrinsic growth rate of population 
# K = environmental carrying capacity for the pop 
# ====
# Store initial parameters: 
t <- 1 # time step. Current time is also 1
initialAbundance <- 2500 # abundance of population at time 1 
K <- 10000 # Carrying capacity for population 
growthRate <- .8 # intrinsic growth rate

# Using these values, what do you predict for the value of n[12]? 
# Using a for loop 
findTime <- 12 # Time step to find population of 
abundance <- initialAbundance
for(i in 1:findTime) {
    abundance <- abundance + (growthRate * abundance * ( (K - abundance) / K))
    print(paste("Population at time", i, ":", abundance))
}
# ====
# ============================
# Part 2: Practicing for loops and storing the data produced in arrays 
# =============================
# 5. Practice some basics of array indexing using for loops 
# ====
# 5a. Use the rep command to make a vector of 18 zeros 
vec5 <- rep(0, 18)
vec5

# 5b. Modify given for loop to store 3 times the ith value of the iterator variable in the ith spot of the vector you created in part a. 
for( i in seq(1,18) ) {
    vec5[i] <- i*3
}
vec5

# 5c. Repeat part a to make a new vector of zeros. Then, make the first entry of that vector have a value of 1. 
vec5_2 <- rep(0, 18)
vec5_2[1] <- 1

# 5d. Write a for loop so that starting with the second entry of the vector created in part c, the value stored in that position in the vector is equal to 1 + (2 * previous entry)
for(i in 2:length(vec5_2)){
    vec5_2[i] <- 1 + (2 * vec5_2[i-1])
}
vec5_2
# ====
# 6. Fibonacci sequence. 
# Using the information given on the Fibonnaci sequence, and using a for loop, write code that makes a vector of the first 20 Fibonacci numbers, where the first number is 0. 
# Note formula: Every number after the first two is the sum of the two preceeding ones 
# ====
# Preallocating a vector to store a number of values of the Fibonacci sequence: 
values <- 20 
fibonacci <- rep(0, values)
# Store 1 as second element 
fibonacci[2] <- 1

# Use a for loop to store first 20 values of the Fibonacci sequence in this vector, keeping 0 as the first element 
for (i in 3:values) {
    fibonacci[i] <- fibonacci[i-1] + fibonacci[i-2]
}
fibonacci
# ====
# 7. Redo question 4 from part 1 above, but now store all the data. Make two vectors, one called "time" that stores the time steps (1:12), and one called "abundance" that stores the data on population abundances predicted from the discrete-time logistic equation. Then, make a plot of the results (plot(time, abundance))
# ====
# Copying over equation from question 4 from part 1
# Make a vector of time steps (1:findTime)
time <- seq(1:findTime)

# Convert abundance into a vector 
abundance <- rep(0, findTime)
# Store initialAbundance at first time.
abundance[1] <- initialAbundance

# Store values from for loop 
for(i in 2:findTime) {
    abundance[i] <- abundance[i-1] + (growthRate * abundance[i-1] * ( (K - abundance[i-1]) / K))
}

# Plot the results
plot(time, abundance)
# ====
