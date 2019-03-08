# Lab 8: Discrete-Time Logistic Growth Model 

## General Description 
The discrete-time logistic growth equation is used in many models of population abundance over time. This population model accounts for a carrying capacity (K) of a given environment. 

## Equation 
**Discrete-time logistic growth equation:**

    `n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )`

Where
* `n[t]` = abundance of the population at time `t`
* `n[t-1]` = abundance of pop at previous time step 
* `r` = intrinsic growth rate of population 
* `K` = environmental carrying capacity for the pop 

## Script
[This script]() contains a function for the discrete-time logistic growth model which takes four inputs: 

`popGrowth(growthRate, carryingCap, numberGens, initPopSize)`

This function outputs a data frame of dimensions 2 x numGens, whose fist column lists generations, and second column lists abundance at each generation. Script writes this data to a .csv file. Function also plots abundances along time stamps, though this is not currently saved to file automatically. 

### Example plot output: 
![Example plot output]()