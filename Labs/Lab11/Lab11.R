######## 
# Lab 11 - Data analysis and ggplot 
# Emily Volk
# Computational Biology, SP19 
# 3/5/19
########
###### 
# Data: 
# data published as: "Data from: Towards a worldwide wood economics spectrum". 

# Full citation: Zanne AE, Lopez-Gonzalez G, Coomes DA, Ilic J, Jansen S, Lewis SL, Miller RB, Swenson NG, Wiemann MC, Chave J (2009) Data from: Towards a worldwide wood economics spectrum. Dryad Digital Repository. https://doi.org/10.5061/dryad.234

# archived at Dryad in association with the following publication:Chave J, Coomes DA, Jansen S, Lewis SL, Swenson NG, Zanne AE (2009) Towards a worldwide wood economics spectrum. Ecology Letters 12(4): 351-366. https://doi.org/10.1111/j.1461-0248.2009.01285.x

# Some variable description: 
# -Wood density is bounded by 0 and 1.5g/cm−3

######
# 1. Load data: 
woodD <- read.csv("data/GlobalWoodDensityDatabase.csv", stringsAsFactors = F)

# 2. Inspect data 
head(woodD)
str(woodD)
summary(woodD)
names(woodD)

# 3. Rename long desnity column name 
# Store just to be safe? 
origDensityName <- colnames(woodD)[4]
# Rename: 
colnames(woodD)[4] <- "Wood.Density"
# Check: 
colnames(woodD) # nice! 

## Part II: Working with density data
# 4. Remove rows with missing data 

# 4a. Find row with missing data 
# 1 input has missing data: 
sum(is.na(woodD))

# list rows of data that have missing values 
woodD[!complete.cases(woodD),]
# Index of row with missing density data: 
missingRow <- which(!complete.cases(woodD))

# 4b. Remove this row from the data frame
nrow(woodD)
woodD <- woodD[-missingRow,]
nrow(woodD)

# 5. One kind of pseudo-replication
# The species' scientific names are given in the variable (column) in the data frame named Binomial. Some of the species in this database appear multiple times. For certain kinds of analyses, it might be advantageous to collapse each species into a single point. One way to do this could be to find the mean (average) of each species' density measurements. Starting with your result from problem 4b, create a new data frame that:
    
# - has each species listed only once,
# - has the Family and Binomial information for each species, and
# - has the mean of the Density measurements for each species

# *Using doBy package and summaryBy() function for this: 
install.packages("doBy")
library("doBy")

?summaryBy
names(woodD)
head(summaryBy(Wood.Density ~ Binomial + Family, data=woodD))

# Storing into new, collapsed data frame 
collapsedSpecies <- summaryBy(Wood.Density ~ Binomial + Family, data=woodD)
# Check with number of rows: 
nrow(collapsedSpecies) # checked! 

# 5Bonus. Try a different way! 

# 6. Contrasting most and least dense FAMILIES:
# The goal of this problem is to figure out which families of trees have the greatest and least densities.

# 6a. Make a new data frame that has the average density for each FAMILY 
# Using doBy summaryBy again: 
byFamily <- summaryBy(Wood.Density ~ Family, data=woodD)
head(byFamily)
# Check: 
nrow(byFamily) == length(unique(woodD$Family)) # checked! 

# 6b. Sort the result of problem 6a by mean density (and store the sorted result in a data frame)
# Try using dplyr arrange()
install.packages("dplyr")
library("dplyr")

?arrange
byFamilySort <- arrange(byFamily, Wood.Density.mean)
# Great! Helpful! Reorders rows, unlike order() in base R! 

# 6c. Using your results from problem 6b:
# What are the 8 families with the highest average densities?
densestFamilies <- tail(byFamilySort, 8)
densestFamilies

# What are the 8 families with the lowest average densities?
leastDenseFamilies <- head(byFamilySort, 8)
leastDenseFamilies 

# Part III. Plotting    
library("ggplot2")

# 7. Plotting densities of most and least dense families with facets
# The goal of this part is to make two figures using ggplot combined with the results of multiple previous problems.
# Want to make BOXPLOTS for each species: 
# - Each individual point comes from one species (not a family mean), so you want to plot some of the data obtained from problem 5
# - You need to plot a subset of the data, corresponding to the species from the families with the highest or lowest densities, which is information you gained from problem 6.
# - Hint for subsetting: if you have a vector of family names that you want to use as the criteria for subsetting, the %in% operator can be very helpful (check out line 108 of Sam's code for some of the Cusack et al. dataset problems for an example).

