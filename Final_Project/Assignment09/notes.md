# Notes on Final Project 

## Start: 

- sp is the central package supporting spatial data analysis in R. Load this.

# Raster data start: Mean temp 
- .grd file has readable labels! 
- Note:  "Looking at the size of  the files, the .gri file contains the values 
and the .grd contains the meta-data. The raster() function doesn't 
care if you specify the .gri or the .grd, somehow it works out the 
file format and gets the info from both of them. However, as you say, 
its not reading in the labels..."
- Important note!!! Some of the GADM data seemed to be too much for RStudio to handle, so switched to analysis in R. 

# More resources! 
- https://datacarpentry.org/r-raster-vector-geospatial/11-vector-raster-integration/index.html
- https://www.gis-blog.com/r-raster-data-acquisition/
- GREAT!!! In GADM (should be), Colombia has three levels: level 0 = National, level 1 = Departmental, level 2 = Municipality!!! 
- ISO Country Codes!: http://kirste.userpage.fu-berlin.de/diverse/doc/ISO_3166.html




- Department shape file quote from paper: "Throughout, we generated output data at the national scale, for each of 33 departments, and for each of 1,122 municipalities, as defined by GIS shapefiles from the National Geographical Information System of Colombia"
