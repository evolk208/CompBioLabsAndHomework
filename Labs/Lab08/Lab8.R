# Implementing discrete-time logistic growth model
# Emily Volk 

# Details: 
# ====
# Recall: Discrete-time logistic growth 
# Equation: n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
# n[t] = abundance of the pop at time t
# n[t-1] = abundance of pop at previous time step 
# r = intrinsic growth rate of population 
# K = environmental carrying capacity for the pop 
# ====

# Make discrete-time logistic growth function: 

popGrowth <- function(growthRate, carryingCap, numberGens, initPopSize) {
    # Make a df to store abundances 
    abundances <- data.frame(generations=seq(1:numberGens), abundance=rep(0,numberGens))
    
    # Store initial population: 
    abundances$abundance[1] <- initPopSize 
    
    # Model, and store time and abundance in abundance df 
    for( i in 2:numberGens ){
        # Store previous abundance to use 
        prevPop <- abundances$abundance[i-1]
        abundances$abundance[i] <- prevPop + ( growthRate * prevPop * ( (carryingCap - prevPop) / K) ) 
    }
    
    # At end, plot abundances 
    plot(abundances)
    
    # Return abundances data frame
    return(abundances)
}

# Run the function with parameter values: 
# Growth rate: 
rate <- .7
# Carrying capacity: 
K <- 2500
# Number generations 
gens <- 10 
# Initial population size: 
initAbundance <- 500

# Run function using these values, store numeric output 
abundanceVals <- popGrowth(growthRate=rate, carryingCap=K, numberGens=gens , initPopSize=initAbundance)

# Write data to file 
write.csv(abundanceVals, "log_growth_abundances.csv")
