## Computational Biology, Spring 2019 - Final Project 

# Spatial Rendering of Colombian Zika Transmission Data 
## By Emily Volk 

## Introduction

Zika virus, or ZIKV, became a worldwide epidemic of concern a few years ago. Importantly, Zika is transmitted through vectors: mosquitos of species _Aedes aegypti_, which can also carry and transmit yellow fever and dengue virus. Because of ZIKV's transmission through live _Aedes aegypti_ vectors, ZIKV transmission to human populations can be heavily influenced by environmental conditions, such as temperature range, humidity, proximity to still water, etc., as these conditions all influence the behavior of ZIKV-carrying mosquitos. 

Mapping disease transmission in a spatiotemporal (regarding both space and time) manner, combined with spatiotemporal mapping of environmental factors, has become critical for effective understanding and mitigation of global epidemics. Importantly, during the Ebola outbreak of 2014-15, mathematical and statistical models using spatiotemporal data informed everything from medical resource allocation to locations of vaccine trials and proper interventions. ZIKV can benefit from similar mapping and visualization using spatial tools in R. 

### Driving question: 

__How do I visualize environmental and Zika transmission data for 2015-16 Colombia in an insightful, interactive way?__ 


## Summary of Data to be Analyzed

Importantly, Colombia began collecting nationwide data on ZIKV incidence in 2015, and data is accessible through the Colombian National Institute of Health for every week of this year for each of 1,122 municipalities. This nationally-collected data is one of the finest-resolution datasets on ZIKV transmission. For this project, I will use this fine-resolution dataset compiled with related environmental condition data, all synthesized by Siraj et al. (2018) to provide a comprehensive dataset for ZIKV transmission insight. I seek to generate a GIF showing changing transmission data and environmental data over time throughout every week of the data provided.

### Goals of original study that produced the data 

The original study sought to compile ZIKV incidence data from Colombia with environmental condition data in a manner that could be easily used for future epidemiological mapping and modeling. Colombia in 2014-15 compiled national ZIKV transmission data through the National Institute of Health, and Colombian ZIKV incidence data is some of the finest-resolution available, globally. ZIKV data is available on a weekly basis for the entire year of 2015, covering each of 1,122. This, paired with the variated environment, topography, and climatic conditions Colombia exhibits, makes this data a compelling resource for ZIKV transmission and mitigation insight. Through compiling this data in a standard way and standard Dryad repository, the authors hope to prevent redundancy of data compilation and organization for future ZIKV research. This both makes the data more accessible to a larger scientific base, and increases the fidelity of the insight through providing a standard dataset on which to perform various analyes. 

### Brief description of methodology that produced the data

Data was compiled from a variety of sources and synthesized in this comprehensive data package. Data collection and organization methodology is discussed in fine-detail for each type of data, in the [original publication](https://doi.org/10.1038/sdata.2018.73).

### Type of data in this dataset:  

Data includes:

Weekly...

- Mean temperature 
- Minimum temperature 
- Maximum temperature 
- Relative humidity
- Satellite data 
- Precipitation
- Aedes aegypti population
- Population 
- Births 
- Urban population 
- Travel time to nearest city center 
- Per capita product, as a proxy for income 
- Zika cases 

#### Format of data  

Data is in two formats: 
- .GRI format: R's format for raster data. The base data for Colombia is provided in .GRI raster files, which will operate as the base of my visual analysis. 
- .CSV format: Environmental and incidence data is primarily stored as .CSV files. These will correspond to .GRI data through names and cell numbers. .CSV incidence and environmental data corresponds to three different scales of resolution: municipality, department, and national. I will either select one or, time-allowing, multiple resolutions to show the data. 

#### Size of data (i.e., megabytes, lines, etc.)

Data varies from 15 MB to ~1 KB. Data files are large. Particular sizes can be found next to the associated data on the repository: [https://datadryad.org/resource/doi:10.5061/dryad.83nj1.2](https://datadryad.org/resource/doi:10.5061/dryad.83nj1.2)

#### Any inconsistencies in the data files?  Anything that looks problematic?  

- Data values, especially data from 2014, have a lot of NAs across cells 
- Data in .CSV format correspond to raster data through a cell ID, which I will have to figure out how to plot 
- Headers are in Spanish: this shouldn't be a problem, as I understand them, but the language should be conveyed through the data product. 
- Datasets are LARGE and I may need to subset the data to only plot some municipalities. 

## My Analysis 

### Introduction

This project is my first experience with spatial statistics in R. Overall, my goals of this analysis are to 1) gain experience and familiarity working with spatial analysis tools and data types in R, and 2) create a visually appealing and effective visualization combining plots of Zika transmission data with environmental data compiled in this dataset. 

I used some primary resources for my introduction to spatial statistics in R: 

#### Resources: 
General: [Spatial Analysis Lecture](https://soc.kuleuven.be/ceso/historischedemografie/resources/pdf/Spatial_analysis_CFaes_13012014.pdf)

Specific lesson: [RSpatial.org](https://www.rspatial.org/index.html)

As I gained familarity with the spatial package and tools in R, I began to approach my actual dataset with careful thought about the visualizations I wanted to produce. As I went through the data, I settled on a narrowed goal for this projecT. 

### Goal: 

__Visualize relative proportion of Aedes aegypti, the mosquito vector for Zika transmission, next to environmental data including mean temperature, relative humidity, and precipitation, throughout all weeks where all data is present.__

## Detailed approach 

### Data aquisition

__Importantly, the data I downloaded from the Dryad repository are too large to provide on GitHub, even in a compressed format. For this reason, to emulate or reproduce my analysis, data must be personally downloaded from the Dryad data repository, or, if you are Sam Flaxman, can be accessed as a .zip file in my Google Drive, [linked here](https://drive.google.com/open?id=13f2usd8zvpHN224QIwlax8IfYLpJ6HfB) (also sent to your email, Sam!)__ 

### Process 
I started my analysis by gaining familiarity with plotting the raster data for various variables provided in this dataset--namely, environmental variables provided in .GRD formats. This was much easier than I had anticipated with R's spatial tools, and I soon felt like this project was really going to work! After playing around with a lot of exploratory analysis and spatial tools applied to many of the datasets in the repository (this exploratory analysis is the "analysis.R" file in this folder), I started crystallizing my approach to my final data product. 

Importantly, I ran into a lot of trouble with the .CSV data. I couldn't figure out how to attach the .CSV variables to a spatial layer in order to plot these values as a raster visualization. Importantly, these data appear to be extracted from prior raster plots, so I hoped to reverse this process to be able to plot Zika incidence, particularly. However, even after accessing the SpatialPolygons for the municipalities of Colombia, using GADM, I could not attach the .CSV values to this layer. The names of the municipalities did not match, which was why I could not easily plot these .CSV values. In the original publication for this data, the authors reference a Colombian service from which they downloaded shapefiles for the departments and municipalities. However, even when I went to this reference, I could not find a feature service from which to download these referenced shapefiles. For this reason, I left the .CSV data out of my final analysis and visualizations. 

Since I could not quite figure out how to attach the parameters in the .CSV files to raster visualizations, I focused my final visualizations on four variables: Aedes aegypti population relative to human population, mean temperature, precipitation, and relative humidity. In this approach, Aedes aegypti population served as a stand-in for the Zika parameter of interest, and I focused my visualizations on providing an insightful approach to monitor how this parameter related to the other environmental factors. 

For my visualizations, I plotted a panel of four raster plots for every week of 2016 in which all of these variables had been recorded and provided. My visualizations span 38 weeks, from January 1st to October 25, 2016. The week is labeled in the title of the bottom right raster panel. I tried to match coloration of all of my plots to the most intuitive representation for each of the parameters shown. Through creating these visualizations, I hope to provide a fully reproducible way to generate insightful visualizations to guide pattern recognition and subsequent spatial analysis of variables relevant to Zika transmission in Colombia for 2016, and beyond.

#### Generate all of my plots using my code in a fully reproducible analysis, found as ["final_analysis.R"]()!

### Results and conclusions

Overall, I feel great about how this project came together. I learned a lot about spatial statistics in R, and I love it! I feel a lot more comfortable with spatial tools, renderings, and visualizations. Importantly, I'd love to dive into more spatial analysis in R, and view this as a great first step to doing this. 

My project was a visualization project, and sought to provide insightful visual data projects for future analysis. My code produces 38 combined plots of Zika vector (Aedes aegypti) and environmental data for Colombia--one for each week. In sum, these visualizations span the first through 38th weeks (January 1st through October 25th) of 2016 , the year for which the Zika incidence data for Colombia has greatest fidelity due to national recording efforts. I hope these plots, arranged and colored as I have chosen to visualize them, can provide a comprehensive and easily associated visual to assist in identifying patterns to guide spatial epidemiological inference using this dataset, and others. Overall, Colombia's Zika transmission and consolidated environmental dataset that this repository consolidates presents one of the most comprehensive case studies for examining a recent pandemic: Zika virus. Analysis presented here can additionally guide future work on pairing vector population and environmental data in accessible and insightful study of international pandemics. 

[ VISUAL ] 

## References 

Original publication: 

Siraj AS, Rodriguez-Barraquer I, Barker CM, Tejedor-Garavito N, Harding D, Lorton C, Lukacevic D, Oates G, Espana G, Kraemer MUG, Manore C, Johansson MA, Tatem AJ, Reiner RC, Perkins TA (2017) Spatiotemporal incidence of Zika and associated environmental drivers for the 2015-2016 epidemic in Colombia. Scientific Data 5: 180073. [https://doi.org/10.1038/sdata.2018.73](https://doi.org/10.1038/sdata.2018.73)

Dryad data package: 

Siraj AS, Rodriguez-Barraquer I, Barker CM, Tejedor-Garavito N, Harding D, Lorton C, Lukacevic D, Oates G, Espana G, Kraemer MUG, Manore C, Johansson MA, Tatem AJ, Reiner RC, Perkins TA (2018) Data from: Spatiotemporal incidence of Zika and associated environmental drivers for the 2015-2016 epidemic in Colombia. Dryad Digital Repository. [https://doi.org/10.5061/dryad.83nj1.2](https://doi.org/10.5061/dryad.83nj1.2)
