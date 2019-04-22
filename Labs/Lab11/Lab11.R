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

# 3. Rename long desity column name 
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
denseFamilies <- tail(byFamilySort, 8)
denseFamilies

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

# Subset the data 
head(collapsedSpecies)

# Goal: Want to subset out the species from the most and lease dense families
library(tidyverse)

# Subset the species from the 8 MOST DENSE families: 
# collapsedSpecies$Family %in% denseFamilies$Family
mostDenseSpecies <- subset(collapsedSpecies, collapsedSpecies$Family %in% denseFamilies$Family)

# Check: 
unique(mostDenseSpecies$Family)
unique(mostDenseSpecies$Family) %in% denseFamilies$Family 
# Checked! 

# Subset the species from the 8 LEAST DENSE families: 
leastDenseSpecies <- subset(collapsedSpecies, collapsedSpecies$Family %in% leastDenseFamilies$Family)

# Check: 
unique(leastDenseSpecies$Family)
unique(leastDenseSpecies$Family) %in% leastDenseFamilies$Family 
# Checked! 

# Now that these are subsetted properly, plot (boxplots) by family 
# 7.1 Boxplots of most dense families: 
?ggplot()
ggplot(data = mostDenseSpecies, 
       mapping = aes(x = ))
mostDense.boxplots <- ggplot(data = denseFamilies, 
                             mapping = aes(x = ) )

# Horizontal boxplots to better compare 
names(leastDenseSpecies)
leastDenseSpec.p <- ggplot(data = leastDenseSpecies, 
aes(Family, Wood.Density.mean)) +
labs(x = "Family", y = "Density (g/cm^3)", title = "Families with lowest average densities") 


leastDenseSpec.p + geom_boxplot()
leastDenseSpec.p + geom_boxplot() + coord_flip() 
lds.H.boxplot <- leastDenseSpec.p + geom_boxplot() + coord_flip() 

# Great! 

mostDenseSpec.p <- ggplot(data = mostDenseSpecies, 
aes(Family, Wood.Density.mean)) +
labs(x = "Family", y = "Density (g/cm^3)", title = "Families with highest average densities")

mostDenseSpec.p + geom_boxplot()
mostDenseSpec.p + geom_boxplot() + coord_flip() 
mds.H.boxplot <- mostDenseSpec.p + geom_boxplot() + coord_flip()

# Plot together: 
quartz()
# Using gridExtra package for this 
install.packages("gridExtra")
library(gridExtra)

horizontalBoxplots <- grid.arrange(mds.H.boxplot, lds.H.boxplot, nrow = 2)

# Save plot: 
quartz.save("horizontal-density-boxplots", type="png")
# yay! 

#### Vertical boxplots version for each family: 
# Use facet_wrap() to divide up into individual plots by family 