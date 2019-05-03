#### 
# Emily Volk
# Computational Biology, Spring 2019 
# Final Project: Visualization of Zika virus incidence and environmental factors in Colombia (2015-16)
# Data from: https://datadryad.org/resource/doi:10.5061/dryad.83nj1.1
#### 

# Important: sp is the central package for spatial data analysis in R. Load this. 
## Note: This will eventually be replaced by new "sf" package, but this is not in common use yet. 
install.packages("sp")
library(sp)

# Raster (gridded) data 
# Raster package: 
install.packages("raster")
library(raster)

# Read in data: 
#### ========= ENVIRONMENTAL VARIABLES ========
## MEAN TEMPERATURE raster at res of 2.5 arc-minutes 
# Descrip: Raster brick of weekly mean temp calculated as the average of the daily mean temp (a total of 143 wks between Jan 5, 2014 and Oct 1, 2016) in GRI format, at a res of 2.5 arc-minutes. Layer names ind. the date each week starts on. Ex: tmean_wk151025 = mean temp for the week that starts on Oct 25, 2015 (Yr Mon Day)
temp_file <- "data/mean_temperature/mean_temperature.grd"

tempRaster <- raster(temp_file)
tempRaster 
# Note: Band for each wk 
raster(temp_file, band = 2) 

## RELATIVE HUMIDITY raster at res of 2.5 arc-minutes 
# Descrip: Raster brick of weekly average relative humidity calculated as the average of the daily mean relative humidity (a total of 143 weeks between Jan 5, 2014 and Oct 1, 2016), in GRI format, at a resolution of 2.5 arc-minutes. Layer names indicate the date each week starts on. For example, the layer named rh_wk151025 has average relative humidity for the week that starts on October 25, 2015.
relhum_file <- "data/rel_humidity/rel_humidity.grd"

raster(relhum_file)
# Note: same date range as above

## PRECIPITATION raster at res of 2.5 arc-minutes 
# Descrip: Raster brick of weekly total precipitation calculated as the total of the daily precipitation (a total of 143 weeks between Jan 5, 2014 and Oct 1, 2016), in GRI format, at a resolution of 2.5 arc-minutes. Layer names indicate the date each week starts on. For example, the layer named precip_wk151025 has precipitation for the week that starts on October 25, 2015.
# Note: same date range as above, too!! 
precip_file <- "data/precipitation/precipitation.grd"

raster(precip_file)

#### ===== POPULATION VARIABLES ====== ####
## VECTOR POP - Aedes aegypti pop at res of 2.5 arc-minutes 
# Descrip: Raster brick of ratio of Aedes aegypti population to human population at each week of the year (a total of 52 weeks), in GRI format, at a resolution of 2.5 arc-minutes.
# Note: DIFF TIME SCALE FROM ABOVE 
# Hmmmmm ASSUMING this is from 2016??? 
aed_file <- "data/aegypti_population/aegypti_population.grd"

raster(aed_file)
### THIS VARIABLE will be a stand-in for transmission risk, looked at in correlation with environmental factors 

# Next: 
# Find date range to plot: Want to plot only the years that we have ZIKA/vector info for: So, that will be 2016 data - have all 52 weeks of this year, but will have to only go as far as the environmental data goes to (First week of 2016 - Oct 1, 2016)
## NOTE: Looking to just subset raster BRICK or BAND layers to dates that start with 16. 

brick(temp_file)
names(brick(temp_file)) # Great, now subset out ones that work 

# Filter: 
install.packages("dplyr")
library(dplyr)
library(stringr)

names(brick(temp_file))[1]

# How many weeks do I have for 2016 out of larger datasets? 
sum(str_detect(names(brick(temp_file)), "wk16"))
# Sweet, should do 39 weeks.

# Indices: Indices of wks of larger datasets for 2016
# Total of 39 weeks. 
indices.16 <- which(str_detect(names(brick(temp_file)), "wk16"))
indices.16

# Start: 
raster(temp_file, band=105)
# End: 
raster(temp_file, band=143) # Ends at Oct 25, 2016 (as it says above)
# Just going to assume these weeks match up with the aedes weeks, so I should take the first 39 bands of these 

#### ====== Plots! Yahooo! ======
# hmmmm how to do this with correct index for for loop...
# Aedes pop needs to go weeks 1:39 
# Environ data needs to go band 105:143
length(indices.16) # Hmmmm, getting creative 
indices.16[length(indices.16)] # Last index relevant to plot
indices.16[length(indices.16)-1] # Sweet, can count backwards...
# Soooo.... can go 1:length(indices.16), which will be 1:39, and can use this and various indexing to get everything I need

## DEMO with FIRST PLOT: 
# Have FOUR variables I want to show: 
# - Mean temp 
# - Rel humidity 
# - Precip 
# - Aedes aegypti pop
# *** Make sure to plot date/week in a relevant way, and have clear titles 
#par(mfrow=c(2,2), bty="n")

## Mean temp: 
#plot(raster(temp_file, band=indices.16[1]))
# Need to add country boundary for the temp_file data!!! 

# Get Colombia national boundary (level = 0) from GADM database. Country code = "COL" 
colombia.nat <- getData('GADM', country = "COL", level = 0)

# Add to mean temp plot: 
#plot(colombia.nat, add = TRUE) 

## Relative humidity: 
#plot(raster(relhum_file, band=indices.16[1])) 
# Add country boundary again: 
#plot(colombia.nat, add = TRUE) # Note: Takes a while to add country boundaries 

## Precip 
#plot(raster(precip_file, band=indices.16[1]), axes=FALSE)
#plot(colombia.nat, add = TRUE)  # Would do this again 

## Aedes Pop (Vector Pop)
#par(mfrow=c(2,2), mai = c(.01, 0.2, .2, 2), bty="n") # Suhweeeet, this looks good.

# Fix coloring to make more dramatic 
install.packages("RColorBrewer")
library(RColorBrewer)

# pal <- colorRampPalette(heat.colors(5))

# Now change coloring to be more intuitive: Heat map, or reverse his coloring 

# plot(raster(aed_file, band=1), col= terrain.colors(8)) # looks fine 

## Organize draft-final plots (not including overlay yet) 
# Set dimensions: 
par(mfrow=c(2,2), mai = c(.01, 0.4, 0.4, 2), bty="n")

# 1. Vector pop (main focus)
plot(raster(aed_file, band=1), axes=FALSE, main = "Vector (Aedes aegypti) Population")

# 2. Precip 
plot(raster(precip_file, band=indices.16[1]), axes = FALSE, col=brewer.pal(8, "Blues"), main = "Precipitation")

# 3. Mean temp 
plot(raster(temp_file, band=indices.16[1]), axes = FALSE, col=brewer.pal(8, "YlOrRd"), main = "Mean Temperature (Celcius)")

# 4. Relative humidity: 
plot(raster(relhum_file, band=indices.16[1]), axes = FALSE, col=brewer.pal(8, "RdPu"), main=paste("Relative Humidity, Week", 1))
# Just put the week on this plot, last...

 # ===== OKAY FINAL PLOTS ======= 
# Recall: # Aedes pop needs to go weeks 1:39 
# Environ data needs to go band 105:143
# length(indices.16) # Hmmmm, getting creative 
# indices.16[length(indices.16)] # Last index relevant to plot
# indices.16[length(indices.16)-1] # Sweet, can count backwards...
# Soooo.... can go 1:length(indices.16), which will be 1:39, and can use this and various indexing to get everything I need

# And order of plots (above)

# plot.name <- paste("plot-", 1, ".png", sep="")
# plot.name

# For loop! 
length(indices.16)
for( i in 1:2 ) {
	par(mfrow=c(2,2), mai = c(.01, 0.4, 0.4, 2), bty="n")
	# Note: i will go 1:39!! 
	plot.name <- paste("plot-", i, ".pdf", sep="")
	
	# 1. Vector pop (main focus)
	plot(raster(aed_file, band=i), axes=FALSE, main = "Vector (Aedes aegypti) Population")
	
	# 2. Precip 
	plot(raster(precip_file, band=indices.16[i]), axes = FALSE, col=brewer.pal(8, "Blues"), main = "Precipitation")
	# Add national boundary: 
	plot(colombia.nat, add = TRUE)
	
	# 3. Mean temp 
	plot(raster(temp_file, band=indices.16[i]), axes = FALSE, col=brewer.pal(8, "YlOrRd"), main = "Mean Temperature (Celcius)")
	# Add national boundary: 
	plot(colombia.nat, add = TRUE)
	
	# 4. Relative humidity: 
	plot(raster(relhum_file, band=indices.16[i]), axes = FALSE, col=brewer.pal(8, "RdPu"), main=paste("Relative Humidity, Week", i))
	# Just put the week on this plot, last...
	# Add national boundary: 
	plot(colombia.nat, add = TRUE)
	
	# Saving plot
	quartz.save(plot.name, type="pdf")
}


