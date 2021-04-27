# Ease of Foot Travel Across the Roman Empire 
*ANALYSIS*

---

## Purpose
Code in this repository includes functions to download SRTM raster data covering the extent of the Roman Empire, mosaic it together and process the elevations to generate conductance matrix, useful for calculating travel time between point coordinates in the raster.  THe specific examples show travel time to and between cities with popultation greater than 1000 adn 5000 people respectively.  The conductance matrix (or matrices) can be used to calculate travel time and distance between any two or more arbitrary points.

---
## Authors
* Adela Sobotkova [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-4541-3963), SDAM project, admin@ancientsocialcomplexity.org
* [Name], [ORCID], [Institution], [email]
* [Name], [ORCID], [Institution], [email]
* [Name], [ORCID], [Institution], [email]

## License
CC-BY-SA 4.0, see attached License.md

## DOI
[Here will be DOI or some other identifier once we have it]

### References
[Here will go related articles or other sources we will publish/create]

---
# How to use this repository

## Sources and prerequisites
I created and successfuly ran the LeastCostRatser_General.Rmd on Ucloud, using a 192Gb RAM and unlimited storage. The final mosaiced raster has 158.4Mb and the conductance transition layer takes up 2.1 Gb of memory in R (928.9 Mb file storage). Choose an adequately resourced machine or descale or alter the computational tasks. One can reduce the spatial extent  - currently the southern boundary is deep in Sahara, which is counterproductive. One can also further aggregate the mosaiced raster by a factor of 10. 
Early example uses only 2 SRTM tiles and Italy. A loop is provided to repeat analysis at this scale to deliberate part of the region.


The scripts reply on R libraries of tidyverse, raster, sf, and gdistance. Depending on where the point data comes from, you may also need jsonlite and getPass or sdam library.

How to:



### Data
Anything else on data metadata and data used. Link to data repository or explanatory article. 

### Software
1. Software R, minimum version 4.03
1. Software R Studio, version 1.3.1073

---
## Instructions 
[Describe first steps, how to use the current repository by a typical user - the digital historian with limited technical skills]
1. First, work your way through LeastCostRaster_General.Rmd to follow the process step-by-step. 
2. Second, if you are ready to apply the batch-analysis to a region of your choice, you can run the LCPfunction.R with the calc.conductance and traveltotown functions and apply these functions to regions specified by lat/long directly. Beware that the traveltotown relies on localcity dataset to not be NULL.
3. Third, go to ...


## Screenshots
![Example screenshot](./img/screenshot.png)




