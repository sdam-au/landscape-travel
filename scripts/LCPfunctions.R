calc.conductance <- function(raster){
  # get library
  library(gdistance)
  
  # calculate difference in elevation
  heightDiff <- function(x){x[2] - x[1]}
  
  # the difference is non-symetrical (going up is harder than going down)
  hd <- transition(raster,heightDiff,8,symm=FALSE)
  hd
  # calculate slope
  slope <- geoCorrection(hd, type = "r", scl=FALSE)
  slope
  
  # calculate adjacent cells
  adj <- adjacent(r, cells=1:ncell(r), pairs=TRUE, directions=8)
  # create a speed raster with Hiking function in meters per hour (meters are what the grids come in)
  speed <- slope
  speed[adj] <- 6 * 1000*  exp(-3.5 * abs(slope[adj] + 0.05)) # meters per hour as all rasters are in m units
  
  # Rectify the raster values on the basis of cell center distances
  conductance <- geoCorrection(speed, type="r", scl = FALSE)
  
  # Print result to pdf
  ifelse(!dir.exists(file.path(".", "outputs")), dir.create(file.path(".", "outputs")), FALSE)
  pdf(paste0("outputs/",names(srtm),"conductance.pdf"))
  plot(raster(conductance), main = paste0("Conductivity of", names(srtm), "surface in hours"))
  dev.off()
  
  #Save the result
  ifelse(!dir.exists(file.path(".", "output_data")), dir.create(file.path(".", "output_data")), FALSE)
  saveRDS(conductance, paste0("output_data/",names(srtm),"conductance.rds"))
  
}

# Travel to Town defined for conductance raster and cities object. Works!

pop = 5000

traveltotown <- function(cities, pop){
  library(sf)
  library(gdistance)
  if(!exists("cities")){print("Object 'cities' is missing")}
  else{
    local_citiesXk <- cities %>% 
    dplyr::select('Ancient Toponym', Province, Country, pop_est, "Longitude (X)", "Latitude (Y)" ) %>% 
    dplyr::filter(pop_est > pop) %>% 
    st_as_sf(coords = c("Longitude (X)", "Latitude (Y)"), 
             crs = 4326) %>%
    st_transform(crs = crs(r)) %>% 
    st_crop(r) 
    conductance=readRDS(paste0("output_data/",names(srtm),"conductance.rds"))
    if(dim(local_citiesXk)[1]==0){
      print("No cities within raster area, taking the nearest cities outside")
      local_citiesXk <- cities %>% 
        dplyr::filter(pop_est > pop) %>% 
        st_as_sf(coords = c("Longitude (X)", "Latitude (Y)"), 
                 crs = 4326) %>%
        st_transform(crs = crs(r))}  
    cost <- accCost(conductance, fromCoords = as(local_citiesXk, "Spatial"))
    
    ifelse(!dir.exists(file.path(".", "output_data")), dir.create(file.path(".", "output_data")), FALSE)
    saveRDS(cost, paste0("output_data/",names(srtm),"costtotown",pop,".rds"))
    pdf(paste0("outputs/",names(srtm),"costtotown_",pop,".pdf"))
    plot(cost, main = paste0("cost of travel in hours in ",names(srtm)," between towns of population >",pop));
    contour(cost, add =TRUE) # should be in hours?
    plot(local_citiesXk$geometry, add= TRUE)
    dev.off()
    }
}
