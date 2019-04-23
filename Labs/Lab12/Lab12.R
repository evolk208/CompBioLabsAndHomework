#### 
# Emily Volk
# Computational Biology, Spring 2012 
# April 22, 2019 
# Lab 12: Adjusting some ggplot2 barplot examples 
#### 

library(ggplot2)

## Problem 1: A bar plot in ggplot() 
# Code using ggplot() that makes the following plot based upon the Cusack et al. data, which you likely already downloaded for lab 09.

d <- read.csv("data/Cusack_et_al/Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv")

# Inspect data 
names(d)
str(d)
summary(d)

# Generate vertical (to start) barplot of species counts, with species on the x-axis
barplot1 <- ggplot(d, aes(x=Species)) + geom_bar()

barplot1

## Problem 2: Rotate the axis tick labels 
# Rotate x-axis labels for clarity 
barplot1 <- barplot1 + theme(axis.text.x = element_text(angle=90, hjust=1, vjust = .5))

barplot1
# Great! 

## Problem 3: A different orientation, scaling, and sorting 
# Suppose you decided that you'd like to flip the axes, sort the species from least to most abundant in the plot, and also transform the count axis to be logarithmic so that you can see the smaller count values more easily. In other words, figure out how to make the following plot:
install.packages("RColorBrewer")
library(RColorBrewer)
quartz()
ggplot(d, aes(x=reorder(Species, -table(Species)[Species])), fill=Species) + 
    geom_bar() + 
    theme(legend.position="none") + 
    labs(y = "Count") + 
    coord_flip() + 
    scale_y_log10() 

# Order from greatest to least: 
ggplot(d, aes(x=reorder(Species, table(Species)[Species]))) + 
    geom_bar() + 
    theme(legend.position="none") + 
    labs(y = "Count") + 
    coord_flip() + 
    scale_y_log10()

    