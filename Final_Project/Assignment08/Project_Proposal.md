# Spatial Rendering of Zika Transmission

## Introduction

Zika virus, or ZIKV, became a worldwide epidemic of concern a few years ago. Importantly, Zika is transmitted through vectors: mosquitos of species _Aedes aegypti_, which can also carry and transmit yellow fever and dengue virus. Because of ZIKV's transmission through live _Aedes aegypti_ vectors, ZIKV transmission to human populations can be heavily influenced by environmental conditions, such as temperature range, humidity, proximity to still water, etc., as these conditions all influence the behavior of ZIKV-carrying mosquitos. 

Mapping disease transmission in a spatiotemporal (regarding both space and time) manner, combined with spatiotemporal mapping of environmental factors, has become critical for effective understanding and mitigation of global epidemics. Importantly, during the Ebola outbreak of 2014-15, mathematical and statistical models using spatiotemporal data informed everything from medical resource allocation to locations of vaccine trials and proper interventions. ZIKV can benefit from similar mapping and visualization using spatial tools in R. 

### Driving question: 

__How do I visualize environmental and Zika transmission data for 2015-16 Colombia in an insightful, interactive way?__ 

<hr>

## Summary of Data to be Analyzed

Importantly, Colombia began collecting nationwide data on ZIKV incidence in 2015, and data is accessible through the Colombian National Institute of Health for every week of this year for each of 1,122 municipalities. This nationally-collected data is one of the finest-resolution datasets on ZIKV transmission. For this project, I will use this fine-resolution dataset compiled with related environmental condition data, all synthesized by Siraj et al. (2018) to provide a comprehensive dataset for ZIKV transmission insight. I seek to generate a GIF showing changing transmission data and environmental data over time throughout every week of the data provided.

### Goals of original study that produced the data (~1 paragraph)

The original study sought to compile ZIKV incidence data from Colombia with environmental condition data in a manner that could be easily used for future epidemiological mapping and modeling. Colombia in 2014-15 compiled national ZIKV transmission data through the National Institute of Health, and Colombian ZIKV incidence data is some of the finest-resolution available, globally. ZIKV data is available on a weekly basis for the entire year of 2015, covering each of 1,122. This, paired with the variated environment, topography, and climatic conditions Colombia exhibits, makes this data a compelling resource for ZIKV transmission and mitigation insight. Through compiling this data in a standard way and standard Dryad repository, the authors hope to prevent redundancy of data compilation and organization for future ZIKV research. This both makes the data more accessible to a larger scientific base, and increases the fidelity of the insight through providing a standard dataset on which to perform various analyes. 

### Brief description of methodology that produced the data

Data was compiled from a variety of sources and synthesized in this comprehensive data package. Data collection and organization methodology is discussed in fine-detail for each type of data, in the [original publication](https://doi.org/10.1038/sdata.2018.73).

### Type of data in this data set:  

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

<hr>

## Detailed Description of Analysis to be Done and Challenges Involved

This project will be my first experience with spatial statistics, and will present many challenges as I take on a new type of analysis in R. So far, I am working with two great resources to learn how to deal with spatial tools and data types in R: 

### Resources 

General: [Spatial Analysis Lecture](https://soc.kuleuven.be/ceso/historischedemografie/resources/pdf/Spatial_analysis_CFaes_13012014.pdf)

Specific lesson: [RSpatial.org](https://www.rspatial.org/index.html)

### Goals/Order of analysis 

1. Upload raster data and plot in R 
2. Overlay country raster plots with environmental data 
    - Will only be selecting one parameter at a time to visualize
3. Overlay country raster plots with ZIKV transmission data 
4. Generate GIFs from plots for each week of the data provided, to show a sped-up time-based rendering of how conditions change throughout the year 2015. 
5. If possible, explore the opportunity of putting this online in an accessible way, such as through a Shiny App. 

<hr>

## References 

Original publication: 

Siraj AS, Rodriguez-Barraquer I, Barker CM, Tejedor-Garavito N, Harding D, Lorton C, Lukacevic D, Oates G, Espana G, Kraemer MUG, Manore C, Johansson MA, Tatem AJ, Reiner RC, Perkins TA (2017) Spatiotemporal incidence of Zika and associated environmental drivers for the 2015-2016 epidemic in Colombia. Scientific Data 5: 180073. [https://doi.org/10.1038/sdata.2018.73](https://doi.org/10.1038/sdata.2018.73)

Dryad data package: 

Siraj AS, Rodriguez-Barraquer I, Barker CM, Tejedor-Garavito N, Harding D, Lorton C, Lukacevic D, Oates G, Espana G, Kraemer MUG, Manore C, Johansson MA, Tatem AJ, Reiner RC, Perkins TA (2018) Data from: Spatiotemporal incidence of Zika and associated environmental drivers for the 2015-2016 epidemic in Colombia. Dryad Digital Repository. [https://doi.org/10.5061/dryad.83nj1.2](https://doi.org/10.5061/dryad.83nj1.2)




