####################
# Computational Biology, Spring 2019 
# Lab 7 - Functions 
# Emily Volk
####################
# Note: Follow best practices (no magic numbers; label parts; use ample comments).

########  

## Problem 1: Area of a triangle when given base and height 

# The area of a triangle can be calculated as 0.5 * base * height. Write a function named triangleArea that calculates and returns the area of a triangle when given two arguments (base and height).

triangleArea <- function(b, h) {
    # b = base; h = height 
    area <- 0.5 * b * h
    return(area) 
}

# Demonstrate that your function works by calling it for an imaginary triangle that has a base of 10 units and a height of 9 units.
base <- 10
height <- 9

triangleArea(base, height)
# Arithmetic chech: 
# .5*10*9

######## 

## Problem 2: Absolute values 

# R has a built in function called abs() that returns the absolute value of a number, or the absolute value of each number in a numeric vector. Imagine that the abs() function did NOT exist. Write a function named myAbs() that calculates and returns absolute values. 
# Hint: Your function will almost certainly need to make use of some kind of conditional test.
myAbs <- function(input) {
    for ( i in 1:length(input) ) { 
        if(input[i] < 0) {
            input[i] <- -input[i]
        }
    }
    return(input)
}

# Show that your function works by using it on the following test cases:
# 1. the number 5
myAbs(5)

# 2. the number -2.3
myAbs(-2.3)

# 3. the vector c(1.1, 2, 0, -4.3, 9, -12)
testVec <- c(1.1, 2, 0, -4.3, 9, -12)

myAbs(testVec)

########

## Problem 3: Fibonacci Seq continued...

# Write a function that returns a vector of the first n Fibonacci numbers, where n is any integer >= 3. Your function should take two arguments: the user's desired value of n and the user's desired starting number (either 0 or 1 as explained in the quote above).

nFibonacci <- function(startingNum, vectorLength) {
    # Initiate output vector where Fibonacci values will be stored. 
    fib <- rep(0, vectorLength)
    
    # First value is startingNum 
    if( startingNum == 0 ){
        fib[2] <- 1
    } else {
        fib[1:2] <- startingNum
    }
    # Calculate Fibonacci sequence from starting num 
    for( i in 3:vectorLength) {
        fib[i] <- fib[i-1]+fib[i-2]
    }
    return(fib)
}

# Testing function: 
# Length 
n <- 10
# Starting with 0
startVal <- 0

nFibonacci(startVal, n)

# Starting with 1
startVal <- 1 

nFibonacci(startVal, n)

# Bonus 3a (optional): make your function work for n = 1 and n = 2. (Hint: add conditionals)

nFibonacci <- function(startingNum, vectorLength) {
    # Initiate output vector where Fibonacci values will be stored. 
    fib <- rep(0, vectorLength)
    
    # First value is startingNum 
    if( startingNum == 0 ){
        fib[2] <- 1
    } else {
        fib[1:2] <- startingNum
    }
    # Calculate Fibonacci sequence from starting num 
    if(vectorLength > 2) {
        for( i in 3:vectorLength) {
            fib[i] <- fib[i-1]+fib[i-2]
        }
    }
    return(fib[1:vectorLength])
}

# Testing 
nFibonacci(startVal, 1)
nFibonacci(startVal, 2)
nFibonacci(startVal, 10)

# Bonus 3b (optional): make your function check user input, e.g., if a user enters zero, or a negative number, or a non-integer number, the function should check that and give an appropriate error/warning message. (Hint: more conditionals)

nFibonacci <- function(startingNum, vectorLength) {
    # Initiate output vector where Fibonacci values will be stored. 
    if( startingNum > 0 && (as.integer(startingNum)/startingNum) == 1 ) {
    fib <- rep(0, vectorLength)
    
    # First value is startingNum 
    if( startingNum == 0 ){
        fib[2] <- 1
    } else {
        fib[1:2] <- startingNum
    }
    # Calculate Fibonacci sequence from starting num 
    if(vectorLength > 2) {
        for( i in 3:vectorLength) {
            fib[i] <- fib[i-1]+fib[i-2]
        }
    }
    return(fib[1:vectorLength])
    } else { 
        return("Please enter a positive integer to start")
    }
}

# Testing 
n <- 10 
nFibonacci(-1, n)
nFibonacci(0, n)
nFibonacci(3, n)

########

## Problem 4: 

# Part 4a. Write a function that takes two numbers as its arguments and returns the square of the difference between them. In other words, for any two numbers x and y your function should calculate and return the quantity (x - y) ^ 2.
sqrDiff <- function(x, y) { 
    return((x-y)^2)
}

# Demonstrate that your function works by calling it with the numbers 3 and 5. (your function should return the number 4).
n1 <- 3 
n2 <- 5

sqrDiff(n1, n2)
# Checked 

# Call your function where the first argument is the vector c(2, 4, 6) and the second argument is the number 4. Your function should return the vector 4 0 4. This is a demonstration of R's abilities to vectorize operations.
vec1 <- c(2, 4, 6)
n2 <- 4 

sqrDiff(vec1, n2)
# Checked 

# Part 4b. Imagine that R did NOT have a function to calculate the average (i.e., arithmetic mean) of a vector of numbers. Write a function of your own that calculates the average of a vector of numbers. In other words, your function should take a vector of numbers as its argument, and it should return the average, but you can NOT use the mean() function. Hint: you will probably want to make use of the sum() function for efficiency.
myMean <- function(vec) {
    return( ( sum(vec) / length(vec) ) )
}

# Demonstrate that your function works by calling it with the vector c(5, 15, 10)
testVec <-  c(5, 15, 10)

myMean(testVec)

# Demonstrate that your function works by calling it with the data you will find in the "DataForLab07.csv" file found in Sam's Lab07 directory. Remember: importing this data will, by default, create a data frame (not a vector). If your function works properly, the answer it returns will be approximately 108.9457.
getwd()

# Read in data and convert to vector 
d <- read.csv("DataForLab07.csv")
d <- d[,1]

# Run through myMean function 
myMean(d)

# Part 4c. A very common quantity in a number of statistical analyses is some form of a "sum of squares." In technical terms, the sum of squares can be calculated as the sum of the squared deviations from the mean. In other words, for a given data set, one calculates the mean. Then, for each data point, the mean is subtracted from the data point, and the resulting difference is squared. All of these squared differences are then summed. For a different explanation, see this Wikipedia page on "Total Sum of Squares". Write a function that calculates and returns the sum of squares as defined here. Your function should take a vector of numeric data as its argument. Note: please write your sum of squares function so that it makes use of the functions written for the previous two parts of this problem. In other words, find a useful way to call those functions from within your sum of squares function.

mySS <- function(vec) {
    # Calculate squared differences from mean for each value in the vector, then sum
    return(sum(sqrDiff(vec, myMean(vec))))
}

# Demonstrate that your sum of squares function works by calling it with the data provided in the file "DataForLab07.csv". If your function works properly, the answer it returns will be approximately 179442.4.
mySS(d)

# Yay! Checked! All checked! 