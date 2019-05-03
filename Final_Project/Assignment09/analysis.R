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

#### First: MEAN TEMPERATURE raster at res of 2.5 arc-minutes 
# Raster (gridded) data 
# Raster package: 
install.packages("raster")
library(raster)

# Read in data: 
temp_file <- "data/mean_temperature/mean_temperature.grd"
tempRaster <- raster(temp_file)
tempRaster
# Great 

# Note: Can request different bands: 
raster(temp_file, band=2)

# All layers in a single object aquired with brick function 
tempBrick <- brick(temp_file)
tempBrick
plot(tempBrick, 100:110) # So fast, so lovely 
# First band: 
plot(raster(temp_file, band=1))
# NOTE: THIS is the top of South America. Subset out Colombia, or just overlap country boundary onto the map 

# Later bands: Short ex of how time series render will go 
plot(raster(temp_file, band=34))
plot(raster(temp_file, band=75))
plot(raster(temp_file, band=125))
plot(raster(temp_file, band=140))

###### AEDES AEGYPTI POPULATION 
aedes_file <- "data/aegypti_population/aegypti_population.grd"

# Raster: 
raster(aedes_file) 
# Note: 52 bands for this one - one for each week of the year 
plot(raster(aedes_file, band=1)) 
# Great, this one is subsetted to Colombia! 

# Brief series: 
quartz()
plot(raster(aedes_file, band=1))
plot(raster(aedes_file, band=10))
plot(raster(aedes_file, band=20))
plot(raster(aedes_file, band=30))
plot(raster(aedes_file, band=40))
plot(raster(aedes_file, band=50))
# Cool! 

#### ZIKA CASES: Note: CSV point data! 
zikaCases.Dept <- read.csv("data/weekly_zika_cases/dept_cases_weekly.csv")
summary(zikaCases.Dept)
names(zikaCases.Dept)
145 - 107 # 38 w
145-55
head(zikaCases.Dept, 2)
# HM - need to find a way to tie the ID_ESPACIA to a map version 

### Departmental csv aggregation of precipitation 
dept.Precip <- read.csv("data/spatial_aggregates_dept/dept_precip_weekly.csv")

dept.Precip$DEPTID
# Hmmm okay, all of these go by ID 


# Hm trying this: 

# Convert points to raster within "r" extent using specified field 
subset.dept.Precip <- dept.Precip[,c(1,3)]
plot(DEPTID~X01.05.14, data = subset.dept.Precip)
?rasterize()
rp <- rasterize(dept.Precip, r, field="DEPTID", background=NA)

ncell(r)

r$spatial.polygon


## Maps??? Are these already in the Raster package?? 
library(sp)
library(raster)
france<-getData('GADM', country='FRA', level=1) 
plot(france)

colombia.nat <- getData('GADM', country = "COL", level = 0)
plot(colombia.nat) # Yay, worked 

colombia.1 <- getData('GADM', country = "COL", level = 1)
plot(colombia.1) # HECK YEAH! Looks awesome!!!! 

colombia.2 <- getData('GADM', country = "COL", level = 2)
# Will take awhile to plot 
plot(colombia.2)
# Heck yeah 
colombia.2 

#  Note: GREAT! 
# - This GADM data has names!!!! Can match with .csv data, hopefully, for raster display of these variables!!! 

# Try some overlays...
plot(raster(aedes_file, band=1))
plot(colombia.1, add=TRUE)
# YIP YIP YIPPPEEE I'M SO EXCITED TO BE WORKING WITH THIS!!!!!! 

plot(raster(aedes_file, band=1), add=TRUE)
plot(colombia.nat, add=TRUE, border="white") # Increase thickness 

# Temp overlays 
par(mfrow=c(1,1))
plot(raster(temp_file, band=1))
add.nat.overlay <- plot(colombia.nat, add=TRUE)

## Generate plots for each band of some data: 
#### First: MEAN TEMPERATURE raster at res of 2.5 arc-minutes 
# Raster (gridded) data 
# Raster package: 
install.packages("raster")
library(raster)

# Read in data: 
temp_file <- "data/mean_temperature/mean_temperature.grd"
tempRaster <- raster(temp_file)
tempRaster
# Great 

# Note: Can request different bands: 
raster(temp_file, band=2)

# All layers in a single object aquired with brick function 
tempBrick <- brick(temp_file)
tempBrick
# First band: 
plot(raster(temp_file, band=1))
# NOTE: THIS is the top of South America. Subset out Colombia, or just overlap country boundary onto the map 

# Doing this, then...
mean.temp.r <- raster(temp_file) # 143 bands total 
# Finding number of bands for this 
nbands(mean.temp.r)

# Generate a subset of these plots...
test.n <- 3
for( i in 1:test.n) { 
	quartz()
	plot(raster(temp_file, band = i))
	plot(colombia.nat, add = TRUE)
	dev.off()
}

# Opt 2: Rowed plot 
par(mfrow = c(2,2))
plot(raster(temp_file, band = 1))
plot(colombia.nat, add = TRUE)

# Eval 
raster(temp_file)

plot(raster(aedes_file, band=1), box=FALSE, axes = FALSE) 

raster(aedes_file, band=1)
raster(aedes_file, band=2)
layer(colombia.nat)

dept.Precip <- read.csv("data/spatial_aggregates_dept/dept_precip_weekly.csv")
names(dept.Precip)

colombia.1@data

names(raster(aedes_file))
raster(aedes_file)
shapefile(temp_file)
names(colombia.nat) 
 
names(dept.Precip)
dept.Precip$DEPARTMENT 
colombia.nat.attr <- merge(colombia.nat, dept.Precip, by.x="DEPTID", by.y=)

# Dept precip 
#NOTE: Start of aggregate data = 01.05.14 
# End = 09.25.16
# Zika incidence 
data names(zikaCases.Dept)
# Start = 01.05.14
# End = 09.25.16  
dept.ae<- read.csv("data/spatial_aggregates_dept/dept_Ae_aegypti_weeks.csv")
names(dept.ae)

muni.ae <- read.csv("data/spatial_aggregates_municip/municip_Ae_aegypti_weeks.csv")
names(muni.ae)

muni.precip <- read.csv("data/spatial_aggregates_municip/municip_precip_weekly.csv")
names(muni.precip)
