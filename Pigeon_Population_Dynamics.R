
########################################################################################################
#                                                                                                      #
#                                   Administrative Stuff                                               #
#                                                                                                      #
########################################################################################################

#Setting Working Directory
setwd("/Users/daisy/Documents/Thesis stuff/Data for R")

#Installing Packages
install.packages("sf")
install.packages("raster")
install.packages("mapview")
install.packages("terra")
install.packages("car")
install.packages("weathermetrics")
install.packages("ggpubr")
install.packages("ggfittext")
install.packages("ggspatial")
install.packages("devtools")
install.packages("ggmap")
install.packages("dplyr")
install.packages("tidycensus")
install.packages("tidyverse")

#Loading Libraries
library(ggplot2)
library(sf)
library(raster)
library(maptools)
library(tidyr)
library(mapview)
library(terra)
library(car)
library(weathermetrics)
library(ggpubr)
library(gridExtra)
library(ggfittext)
library(ggspatial)
#library(ggsn)
library(cowplot)
library(ggmap)
library(dplyr)
#library(gdalUtils)
library(tidycensus)
library(tidyverse)

#Installing archived package, need it to customize scale bars
devtools::load_all("/Users/daisy/Documents/Thesis stuff/ggsn")



########################################################################################################
#                                                                                                      #
#                                    Preparing Data                                                    #
#                                                                                                      #
########################################################################################################

#Loading Raw Data from CSV file
madEnv<-read.csv("Raw Thesis Data Madrid - Environmental Factors.csv")
madPig<-read.csv("Raw Thesis Data Madrid - Pigeon Tracking.csv")
stlEnv<-read.csv("Raw Thesis Data St. Louis - Environmental Factors.csv")
stlPig<-read.csv("Raw Thesis Data St. Louis - Pigeon Tracking.csv")

#Fixing all NAs in the data set
madEnv[madEnv == "N/A"] <- NA 
madPig[madPig == "N/A"] <- NA 
stlEnv[stlEnv == "N/A"] <- NA 
#stlEnv[stlPig == "N/A"] <- NA  #no N/A's in the data set


#Giving each data point a unique code
madEnv<- mutate(madEnv, Site.Id = paste0(Transect, "-", Time.of.Day, "-", Track.Number))
madPig <- mutate(madPig, Site.Id = paste0(Transect, "-", Time.of.Day, "-", Track.Number))
stlEnv<- mutate(stlEnv, Site.Id = paste0(Transect, "-", Time.of.Day, "-", Track.Number))
stlPig <- mutate(stlPig, Site.Id = paste0(Transect, "-", Time.of.Day, "-", Track.Number))


##########
# Madrid #
##########

#Fixing variable types
#Madrid Pigeon Data
str(madPig)
madPig$Transect <- as.factor(madPig$Transect) 
madPig$Date <- as.factor(madPig$Date) 
madPig$Time.of.Day <- as.factor(madPig$Time.of.Day) 
madPig$Number.of.Pigeons <- as.factor(madPig$Number.of.Pigeons) 
madPig$Where.is.it <- as.factor(madPig$Where.is.it) 

#Madrid Environmental Data 
str(madEnv)
madEnv$Transect <- as.factor(madEnv$Transect) 
madEnv$Date <- as.factor(madEnv$Date) 
madEnv$Water.Source <- as.factor(madEnv$Water.Source)
madEnv$Time.of.Day <- as.factor(madEnv$Time.of.Day) 
madEnv$Wind <- as.factor(madEnv$Wind) 
madEnv$Number.of.People <- as.factor(madEnv$Number.of.People) 
madEnv$Number.of.Birds <- as.factor(madEnv$Number.of.Birds) 
madEnv$Other.Bird.Species <- as.factor(madEnv$Other.Bird.Species) 
madEnv$Litter <- as.factor(madEnv$Litter) 
madEnv$Tables <- as.numeric(madEnv$Tables)
madEnv$Restaurant.with.outdoor.seating <- as.factor(madEnv$Restaurant.with.outdoor.seating)
madEnv$Temp.F. <- as.numeric(madEnv$Temp.F.) 
madEnv$Cloud.Cover <- as.numeric(madEnv$Cloud.Cover) 
madEnv$Waste.Disposal <- as.factor(madEnv$Waste.Disposal)
madEnv$Waste.Disposal..mini <- as.numeric(madEnv$Waste.Disposal..mini)
madEnv$Waste.disposal..dumpster <- as.numeric(madEnv$Waste.disposal..dumpster)
madEnv$Waste.Disposal..trash.can <- as.numeric(madEnv$Waste.Disposal..trash.can)
madEnv$Waste.Disposal..Little <- as.numeric(madEnv$Waste.Disposal..Little)
madEnv$Waste.disposal..compost.cans <- as.numeric(madEnv$Waste.disposal..compost.cans)
madEnv$People <- as.integer(madEnv$People)




#############
# St. Louis #
#############

#Fixing Variable Types
#St. Louis Pigeon Data
str(stlPig)
stlPig$Transect <- as.factor(stlPig$Transect) 
stlPig$Date <- as.factor(stlPig$Date) 
stlPig$Time.of.Day <- as.factor(stlPig$Time.of.Day) 
stlPig$Number.of.Pigeons <- as.factor(stlPig$Number.of.Pigeons) 
stlPig$Where.is.it <- as.factor(stlPig$Where.is.it) 

#St. Louis Environmental Data
str(stlEnv$Water.Source)
stlEnv$Transect <- as.factor(stlEnv$Transect) 
stlEnv$Date <- as.factor(stlEnv$Date) 
stlEnv$Water.Source <- as.factor(stlEnv$Water.Source)
stlEnv$Time.of.Day <- as.factor(stlEnv$Time.of.Day) 
stlEnv$Wind <- as.factor(stlEnv$Wind) 
stlEnv$Number.of.People <- as.factor(stlEnv$Number.of.People) 
stlEnv$Number.of.Birds <- as.factor(stlEnv$Number.of.Birds) 
stlEnv$Other.Bird.Species <- as.factor(stlEnv$Other.Bird.Species) 
stlEnv$Litter <- as.factor(stlEnv$Litter) 
stlEnv$Tables <- as.numeric(stlEnv$Tables)
stlEnv$Restaurant.with.outdoor.seating <- as.factor(stlEnv$Restaurant.with.outdoor.seating)
stlEnv$Temp.F. <- as.numeric(stlEnv$Temp.F.) 
stlEnv$Cloud.Cover <- as.numeric(stlEnv$Cloud.Cover) 
stlEnv$Waste.Disposal <- as.factor(stlEnv$Waste.Disposal) #IS THIS RIGHT 
stlEnv$Waste.Disposal..mini <- as.numeric(stlEnv$Waste.Disposal..mini)
stlEnv$Waste.disposal..dumpster <- as.numeric(stlEnv$Waste.disposal..dumpster)
stlEnv$Waste.Disposal..trash.can <- as.numeric(stlEnv$Waste.Disposal..trash.can)
stlEnv$Waste.Disposal..Little <- as.numeric(stlEnv$Waste.Disposal..Little)
stlEnv$Waste.disposal..compost.cans <- as.numeric(stlEnv$Waste.disposal..compost.cans)








########################################################################################################
#                                                                                                      #
#                                 Preparing Reference Maps                                             #
#                                                                                                      #
########################################################################################################


#downloading and preparing reference shapefiles



#########################################################
#               Administrative boundaries               #
#########################################################


##########
# Madrid #
##########

#Madrid Municipality Shapefile downloaded from https://gestiona.comunidad.madrid/nomecalles/DescargaBDTCorte.icm
madrid_shapefile <-  st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/maps from nome calles/Partidos Judiciales/200001381.shp")
#Clipping shapefile to the city boundary from the comunidad boundary
madrid_shapefile <- madrid_shapefile[11,]
#Transforming shape file to the correct crs
madrid_shapefile<-st_transform(madrid_shapefile, crs=4326)


#############
# St. Louis #
#############

#St. Louis City Shape file downloaded from https://www.stlouis-mo.gov/data/formats/format.cfm?id=21 
stl_shapefile <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/stl_boundary/stl_boundary.shp")
#Transforming shape file to the correct crs
stl_shapefile<-st_transform(stl_shapefile, crs=4326)





#########################################################
#                     Other Factors                     #
#########################################################

#Sourcing and preparing data for other environmental factors to be included in the model 

##########
# Madrid #
##########

#Populations sourced from https://www.ine.es/ 
madrid_population <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/Population/Madrid census track.csv")
#Keeping only the city of Madrid
madrid_population <- madrid_population %>%
  filter(str_starts(Track, "28079"))
madrid_population$Track <- as.numeric(madrid_population$Track)
madrid_population$Population <- as.numeric(madrid_population$Population)
#Reading in census track shapefile from https://datos.comunidad.madrid/dataset/secciones_censales 
madrid_shapefile_population <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/census tracks/Seccionado_2019.shp")
#Transforming to correct crs
madrid_shapefile_population<-st_transform(madrid_shapefile_population, crs=4326)
#Renaming columns, cleaning data, removing unnessecary columns
madrid_shapefile_population <- madrid_shapefile_population %>%
  mutate(
    Track = paste0("28", CDTSECCION)
  ) %>%
  mutate(
    Area_sq_ft = Area_k2 * 10763910.4,
  ) %>%
  select(Track, Area_sq_ft, geometry) %>%
  filter(str_starts(Track, "28079"))
madrid_shapefile_population$Track <- as.numeric(madrid_shapefile_population$Track)
#Joining population data to shapefile
madrid_shapefile_population <- madrid_shapefile_population %>%
  left_join(madrid_population, by = c("Track" = "Track"))
madrid_shapefile_population$Population <- as.numeric(madrid_shapefile_population$Population)


#Natural landscapes of Comunidad de Madrid shapefile downloaded from http://download.geofabrik.de/europe/spain/madrid.html
madrid_shapefile_parques <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/parks/natural.shp")
#Selecting only parks form the landscapes
madrid_shapefile_parques <- madrid_shapefile_parques[madrid_shapefile_parques$type == "park",]
#Removing parks that fall along the boundary of the Comunidad, they are causing issues with making the buffers 
#and lie outside of the city limits so are not needed: 26565298, 27921331, 28440581, 28440584
madrid_shapefile_parques <- madrid_shapefile_parques[-which(madrid_shapefile_parques$osm_id %in% c(26565298, 27921331, 28440581, 28440584)), ]
#Making valid
madrid_shapefile_parques <-st_make_valid(madrid_shapefile_parques)
#Transforming the shapefile to the correct crs
madrid_shapefile_parques <- st_transform(madrid_shapefile_parques, crs=4326)
#Clipping only parks within the city of Madrid
madrid_shapefile_parques <- madrid_shapefile_parques %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)
#Code needed to identify which parks along the Comunidad boundary are causing issues
#clip_madrid <- st_intersection(madrid_shapefile_parques, madrid_shapefile)
#for(i in 1725:nrow(madrid_shapefile_parques)) {
#  st_intersection(madrid_shapefile_parques[i, ], madrid_shapefile)
#  print(i)
#}
#mapview::mapView(madrid_shapefile %>% 
#filter(osm_id == 23784056))

#Shapefiles of streets that lie in Comunidad de Madrid downloaded from http://download.geofabrik.de/europe/spain/madrid.html
madrid_shapefile_streets <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/spain-roads-shape/roads.shp")
#Transform to correct crs
madrid_shapefile_streets<-st_transform(madrid_shapefile_streets, crs=4326)
#Clipping shapefile to only include streets that lie within the city
madrid_shapefile_streets <- madrid_shapefile_streets %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)


#Landuse for Comunidad de Madrid TIFFS provided by Dr. Pacheco
madrid_shapefile_landuse <- terra::rast("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/LUSE_MADRID/LUSE2009.tif")
#Transforming to the correct crs
madrid_shapefile_landuse <- terra::project(madrid_shapefile_landuse, "EPSG:4326")
#Converting to data.frame
madrid_shapefile_landuse <- as.data.frame(madrid_shapefile_landuse, xy = T)
#Converting back to Shapefile 
madrid_shapefile_landuse <- st_as_sf(madrid_shapefile_landuse, coords = c("x","y"), crs=4326)
#Clipping to Madrid
#madrid_shapefile_landuse <- madrid_shapefile_landuse %>%
#  st_filter(y = madrid_shapefile, .predicate = st_within)
#mapview::mapview(test)

#Impervious surfaces for Comunidad de Madrid downloaded from https://land.copernicus.eu/pan-european/high-resolution-layers/imperviousness/status-maps 
madrid_shapefile_impervious <- terra::rast("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/impervious surface/Madrid.tif")
#Determining crs of impervious surface file
impervious_proj <- terra::crs(madrid_shapefile_impervious)
#Transforming crs of Madrid boundary shapfile to that of the impervious surface
madrid_shapefile <- st_transform(madrid_shapefile, crs = impervious_proj)
#Turning the shapefiles into a SpatVector so they can be cropped
impervious_vect <- terra::vect(madrid_shapefile)
#Clipping to city of Madrid
madrid_shapefile_impervious <- terra::crop(madrid_shapefile_impervious, impervious_vect, mask = TRUE)
#Changing projection
madrid_shapefile_impervious <- terra::project(madrid_shapefile_impervious, "EPSG:4326")
#Converting to data.frame
madrid_shapefile_impervious <- as.data.frame(madrid_shapefile_impervious, xy=TRUE)
#Converting from data.frame to shapefile 
madrid_shapefile_impervious <- st_as_sf(madrid_shapefile_impervious, coords = c("x","y"), crs = 4326)
#Changing back to crs chosen for all shapefiles
madrid_shapefile<-st_transform(madrid_shapefile, crs=4326)
#When the tiff was converted to a shapefile they were converted to point geometry so adding a column to assign each point the value of one
#so the points that lie within buffers can be totaled and assigned to the buffer
madrid_shapefile_impervious$imperviousSurface <- 1

#Bus stop locations downloaded from https://data-crtm.opendata.arcgis.com/maps/8ef563f232c244ca9b3a5d2d6a3dc19b/about 
madrid_shapefile_bus <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/M6_Estaciones/M6_Estaciones.shp")
#Transforming to correct crs
madrid_shapefile_bus<-st_transform(madrid_shapefile_bus, crs=4326)
#Adding another column so points that lie within buffer can be totaled and assigned to the buffer
madrid_shapefile_bus$numBusStops <- 1

#Colegios (high schools)
madrid_shapefile_colegios <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/maps from nome calles/Educación_ Colegios mayores/colegiosmayores.shp")
#Clip to city of Madrid boundary
madrid_shapefile_colegios <- madrid_shapefile_colegios[ madrid_shapefile_colegios$MUNICIPIO == "Madrid",]
#Transforming to correct crs
madrid_shapefile_colegios<-st_transform(madrid_shapefile_colegios, crs=4326)
#Adding another column so points that lie within buffer can be totaled and assigned to the buffer
madrid_shapefile_colegios$numSchools <- 1


#PREDATORS sightings downloaded from ebird.com 
#Black Winged Kite
madrid_shapefile_blackWingedKite <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_black_winged_kite.csv")
#Transforming data into shapefiles
madrid_shapefile_blackWingedKite <- st_as_sf(madrid_shapefile_blackWingedKite, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_blackWingedKite <- madrid_shapefile_blackWingedKite %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)
#making right factor
madrid_shapefile_blackWingedKite$OBSERVATION.COUNT <- as.integer(madrid_shapefile_blackWingedKite$OBSERVATION.COUNT)

#Bonellis Eagle
madrid_shapefile_bonellisEagle <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_bonellis_eagle.csv")
#Transforming data into shapefiles
madrid_shapefile_bonellisEagle <- st_as_sf(madrid_shapefile_bonellisEagle, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_bonellisEagle <- madrid_shapefile_bonellisEagle %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Booted Eagle
madrid_shapefile_bootedEagle <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_booted_eagle.csv")
#Transforming data into shapefiles
madrid_shapefile_bootedEagle <- st_as_sf(madrid_shapefile_bootedEagle, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_bootedEagle <- madrid_shapefile_bootedEagle %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Common Buzzard
madrid_shapefile_commonBuzzard <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_common_buzzard.csv")
#Transforming data into shapefiles
madrid_shapefile_commonBuzzard <- st_as_sf(madrid_shapefile_commonBuzzard, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_commonBuzzard <- madrid_shapefile_commonBuzzard %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Eleonoras Falcon
madrid_shapefile_eleonorasFalcon <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_eleonoras_falcon.csv")
#Transforming data into shapefiles
madrid_shapefile_eleonorasFalcon <- st_as_sf(madrid_shapefile_eleonorasFalcon, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_eleonorasFalcon <- madrid_shapefile_eleonorasFalcon %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Eurasian Kestrel
madrid_shapefile_eurasianKestrel <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_eurasian_kestrel.csv")
#Transforming data into shapefiles
madrid_shapefile_eurasianKestrel <- st_as_sf(madrid_shapefile_eurasianKestrel, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_eurasianKestrel <- madrid_shapefile_eurasianKestrel %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Eurasian Marsh Harrier
madrid_shapefile_eurasianMarshHarrier <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_eurasian_marsh_harrier.csv")
#Transforming data into shapefiles
madrid_shapefile_eurasianMarshHarrier <- st_as_sf(madrid_shapefile_eurasianMarshHarrier, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_eurasianMarshHarrier <- madrid_shapefile_eurasianMarshHarrier %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)
#making right factor
madrid_shapefile_eurasianMarshHarrier$OBSERVATION.COUNT <- as.integer(madrid_shapefile_eurasianMarshHarrier$OBSERVATION.COUNT)

#Eurasian Sparrow Hawk
madrid_shapefile_eurasianSparrowHawk <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_eurasian_sparrowhawk.csv")
#Transforming data into shapefiles
madrid_shapefile_eurasianSparrowHawk <- st_as_sf(madrid_shapefile_eurasianSparrowHawk, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_eurasianSparrowHawk <- madrid_shapefile_eurasianSparrowHawk %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Golden Eagle
madrid_shapefile_goldenEagle <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_golden_eagle.csv")
#Transforming data into shapefiles
madrid_shapefile_goldenEagle <- st_as_sf(madrid_shapefile_goldenEagle, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_goldenEagle <- madrid_shapefile_goldenEagle %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Northern Goshawk
madrid_shapefile_northernGoshawk <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_northern_goshawk.csv")
#Transforming data into shapefiles
madrid_shapefile_northernGoshawk <- st_as_sf(madrid_shapefile_northernGoshawk, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_northernGoshawk <- madrid_shapefile_northernGoshawk %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)

#Peregrine Falcon
madrid_shapefile_peregrineFalcoln <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_peregrine_falcon.csv")
#Transforming data into shapefiles
madrid_shapefile_peregrineFalcoln <- st_as_sf(madrid_shapefile_peregrineFalcoln, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_peregrineFalcoln <- madrid_shapefile_peregrineFalcoln %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)
#making right factor
madrid_shapefile_peregrineFalcoln$OBSERVATION.COUNT <- as.integer(madrid_shapefile_peregrineFalcoln$OBSERVATION.COUNT)

#Red Kite
madrid_shapefile_redKite <- read.csv("/Users/daisy/Documents/Thesis stuff/Shape Files/other madrid factors/MAD_predators/MAD_red_kite.csv")
#Transforming data into shapefiles
madrid_shapefile_redKite <- st_as_sf(madrid_shapefile_redKite, coords = c("LONGITUDE", "LATITUDE"), crs=4326)
#Clip to city of Madrid boundary
madrid_shapefile_redKite <- madrid_shapefile_redKite %>%
  st_filter(y = madrid_shapefile, .predicate = st_within)


#############
# St. Louis #
#############

#Populations sourced from tidycensus package
#Census API 8f712ce800115a5d11f5fc0beee8080a92f00da8
stl_shapefile_pop <- get_acs(
  geography = "block group",
  variables = "B01003_001", # Total population estimate
  state = "MO",
  county = "St. Louis city",
  year = 2020,
  geometry = TRUE
)
#Transform to match buffer CRS
stl_shapefile_pop <- st_transform(stl_shapefile_pop, crs = 4326)
#Calculate area and density for each block group
stl_shapefile_pop <- stl_shapefile_pop %>%
  mutate(
    area_sqft = as.numeric(st_area(geometry)) * 10.7639,  # Convert m² to ft²
    density = estimate / area_sqft * 250000  # People per 250m buffer area
  )

#City parks downloaded from https://www.stlouis-mo.gov/data/formats/format.cfm?id=21
stl_shapefile_parks <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/parks/parks.shp")
#Transforming to correct crs
stl_shapefile_parks<-st_transform(stl_shapefile_parks, crs=4326)

#City streets downloaded from https://www.stlouis-mo.gov/data/formats/format.cfm?id=21
stl_shapefile_streets <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/streets/tgr_str_cl.shp")
#Transforming to correct crs
stl_shapefile_streets<-st_transform(stl_shapefile_streets, crs=4326)

#Schools
stl_shapefile_schools <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/MO_Public_Schools/MO_Public_Schools.shp")
#Clip to city of St. Louis boundary
stl_shapefile_schools <- stl_shapefile_schools[ stl_shapefile_schools$County == "St. Louis City",]
#Transforming to correct crs
stl_shapefile_schools<-st_transform(stl_shapefile_schools, crs=4326)
#Adding another column so points that lie within buffer can be totaled and assigned to the buffer
stl_shapefile_schools$numSchools <- 1

#impervious surfaces of the city downloaded from https://s3-us-west-2.amazonaws.com/mrlc/nlcd_2019_impervious_l48_20210604.zip 
stl_shapefile_impervious <- terra::rast("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/impervious/nlcd_2019_impervious_l48_20210604.img")
impervious_proj <- terra::crs(stl_shapefile_impervious)
#Transforming crs of St. Louis boundary shapefile to that of the impervious surface file
stl_shapefile <- st_transform(stl_shapefile, crs = impervious_proj)
#Clipping to St. Louis city 
impervious_vect <- terra::vect(stl_shapefile)
#Cropping and Masking
stl_shapefile_impervious <- terra::crop(stl_shapefile_impervious, impervious_vect, mask = TRUE)
#Changing to correct projection
stl_shapefile_impervious <- terra::project(stl_shapefile_impervious, "EPSG:4326")
#Converting to data.frame
stl_shapefile_impervious <- as.data.frame(stl_shapefile_impervious, xy=TRUE)
#Converting to shapefile
stl_shapefile_impervious <- st_as_sf(stl_shapefile_impervious, coords = c("x","y"), crs = 4326)
#Transforming to correct crs
stl_shapefile<-st_transform(stl_shapefile, crs=4326)

#Bus stops for St. Louis city downloaded from https://rdx.stldata.org/dataset/current-metrobus-metrolink-stops-and-routes/resource/543661cf-b89e-4adb-9794-a54f48ab350e
stl_shapefile_bus <- st_read("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/Metro_St._Louis_MetroBus_Stops_By_Line/Metro_St._Louis_MetroBus_Stops_By_Line.shp")
#Clipping to St. Louis city 
stl_shapefile_bus <- stl_shapefile_bus[ stl_shapefile_bus$Juris == "ST LOUIS CITY",]
#Transforming to correct crs
stl_shapefile_bus<-st_transform(stl_shapefile_bus, crs=4326)
#Adding another column so points that lie within buffer can be totaled and assigned to the buffer
stl_shapefile_bus$numBusStops <- 1

#PREDATORS sightings in St. Louis city downloaded from ebird
#Bald Eagle
stl_shapefile_baldEagle <- read.table("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/STL_predators/STL_bald_eagle.txt", header = T)
#Transforming data into shapefile
stl_shapefile_baldEagle <- st_as_sf(stl_shapefile_baldEagle, coords = c("OBSERVATION.1","LONGITUDE"), crs=4326)

#Coopers Hawk
stl_shapefile_coopersHawk <- read.table("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/STL_predators/STL_coopers_hawk.txt", header = T)
#Transforming data into shapefile
stl_shapefile_coopersHawk <- st_as_sf(stl_shapefile_coopersHawk, coords = c("OBSERVATION.1","LONGITUDE"), crs=4326)

#Peregrine Falcon
stl_shapefile_peregrineFalcon <- read.table("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/STL_predators/STL_peregrin_falcon.txt", header = T)
#Transforming data into shapefile
stl_shapefile_peregrineFalcon <- st_as_sf(stl_shapefile_peregrineFalcon, coords = c("OBSERVATION.1","LONGITUDE"), crs=4326)

#Red Shoulder Hawk
stl_shapefile_redShoulderedHawk <- read.table("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/STL_predators/STL_red_shoulder_hawk.txt", header = T)
#Transforming data into shapefile
stl_shapefile_redShoulderedHawk <- st_as_sf(stl_shapefile_redShoulderedHawk, coords = c("OBSERVATION.1","LONGITUDE"), crs=4326)

#Red Tailed Hawk
stl_shapefile_redTailedHawk <- read.table("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/STL_predators/STL_red_tailed_hawk.txt", header = T)
#Transforming data into shapefile
stl_shapefile_redTailedHawk <- st_as_sf(stl_shapefile_redTailedHawk, coords = c("OBSERVATION.1","LONGITUDE"), crs=4326)

#Sharp Shinned Hawk
stl_shapefile_sharpShinnedHawk <- read.table("/Users/daisy/Documents/Thesis stuff/Shape Files/stl factor maps/STL_predators/STL_sharp_shinned_hawk.txt", header = T)
#Transforming data into shapefile
stl_shapefile_sharpShinnedHawk <- st_as_sf(stl_shapefile_sharpShinnedHawk, coords = c("OBSERVATION.1","LONGITUDE"), crs=4326)



########################################################################################################
#                                                                                                      #
#                                        Making Buffers                                                #
#                                                                                                      #
########################################################################################################


#using techniques sourced from https://crd150.github.io/buffers.html to create buffers centered on each environmental survey


#########################################################
#               Environmental Buffer                    #
#########################################################

#Making enviornmental buffers

##########
# Madrid #
##########

#Transforming data in shapefile
madEnvSf <- st_as_sf(madEnv, coords = c("EW.Coordinates","NS.Coordinates"), crs=4326) #turning my data into shapefile
madPigSf <- st_as_sf(madPig, coords = c("EW.Coordinates","NS.Coordinates"), crs=4326) #turning my data into shapefile

#Creating environmental buffers of 125m 
madEnvBuff <- st_buffer(madEnvSf, 125) 

#Mapping Buffer
madBufferMap <- ggplot() +
  geom_sf(data=madrid_shapefile) +
  geom_sf(data=madEnvBuff) +
  #geom_sf(data=madrid_shapefile_bonellisEagle) +
  coord_sf()

#EDITED ONE
#madPigEditSf <- st_as_sf(madPigEdit, coords = c("EW.Coordinates","NS.Coordinates"), crs=4326)


#############
# St. Louis #
#############

#Transforming data in shapefile
stlEnvSf <- st_as_sf(stlEnv, coords = c("EW.Coord","NS.Coord"), crs=4326) #turning my data into shapefile
stlPigSf <- st_as_sf(stlPig, coords = c("EW.Coord","NS.Coord"), crs=4326) #turning my data into shapefile

#Creating environmental buffers of 125m
stlEnvBuff <- st_buffer(stlEnvSf, 125)

#mapping Buffer
stlBufferMap <- ggplot() +
  geom_sf(data=stl_shapefile) +
  geom_sf(data=stlEnvBuff) +
  coord_sf()





#########################################################
#                Pigeons in Buffer                      #
#########################################################

#Identifying number of pigeons in each buffer

##########
# Madrid #
##########

#Intersecting pigeon data points with the environmental buffers to select the pigeons found within the buffer
subset.int <- st_intersects(madPigSf, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- filter(madPigSf, subset.int.log)
madIntersects <- madPigSf[subset.int.log, ]

#Low pigeon estimate dataset
#Summing pigeons found in each buffer
lowPigEst<-aggregate(madIntersects["Low.Estimate"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Joining number of pigeons in environmental buffer to the buffer
madEnvBuff <- madEnvBuff %>% 
  st_join(lowPigEst, join=st_equals, left=FALSE) 

#Mid pigeon estimate dataset
#Summing pigeons found in each buffer
midPigEst<-aggregate(madIntersects["Mid.Estimate"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Joining number of pigeons in environmental buffer to the buffer
madEnvBuff <- madEnvBuff %>% 
  st_join(midPigEst, join=st_equals, left=FALSE) 

#High pigeon estimate dataset
#Summing pigeons found in each buffer
highPigEst <-aggregate(madIntersects["High.Estimate"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Joining number of pigeons in environmental buffer to the buffer
madEnvBuff <- madEnvBuff %>% 
  st_join(highPigEst, join=st_equals, left=FALSE) 

#mapping intersect
madIntersectMap <- ggplot() +
  geom_sf(data=madrid_shapefile) +
  geom_sf(data=lowPigEst) +
  coord_sf()


#############
# St. Louis #
#############

#Intersecting pigeon data points with the environmental buffers to select the pigeons found within the buffer
subset.int <- st_intersects(stlPigSf, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- filter(stlPigSf, subset.int.log)
stlIntersects <- stlPigSf[subset.int.log, ]

#Low pigeon estimate dataset
#Summing pigeons found in each buffer
lowPigEst <-aggregate(stlIntersects["Low.Estimate"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Joining number of pigeons in environmental buffer to the buffer
stlEnvBuff <- stlEnvBuff %>% 
  st_join(lowPigEst, join=st_equals, left=FALSE) 

#Mid estimate dataset
#Summing pigeons found in each buffer
midPigEst<-aggregate(stlIntersects["Mid.Estimate"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Joining number of pigeons in environmental buffer to the buffer
stlEnvBuff <- stlEnvBuff %>% 
  st_join(midPigEst, join=st_equals, left=FALSE) 

#High estimate dataset
#Summing pigeons found in each buffer
highPigEst <-aggregate(stlIntersects["High.Estimate"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Joining number of pigeons in environmental buffer to the buffer
stlEnvBuff <- stlEnvBuff %>% 
  st_join(highPigEst, join=st_equals, left=FALSE) 






#########################################################
#      Other environmental features in Buffer           #
#########################################################

#using techniques sourced from https://tmieno2.github.io/R-as-GIS-for-Economists/spatial-intersection-cropping-join.html 

##########
# Madrid #
##########

#Population Density
#Intersecting population density with the environmental buffers to find area of census tracks located in the buffers
subset.int <- st_intersection(madrid_shapefile_population, madEnvBuff) %>%
  mutate(
    #Calculate the proportion of each section that falls within each buffer
    section_area = as.numeric(st_area(.)),
    original_section_area = as.numeric(st_area(madrid_shapefile_population[match(Track, madrid_shapefile_population$Track),])),
    area_proportion = section_area / original_section_area,
    #Estimate population in the intersection based on area proportion
    estimated_population = Population * area_proportion
  )
#sum up estimated population in each buffer
findIntersection <- subset.int %>%
  group_by(Site.Id) %>%
  summarize(
    total_population = sum(estimated_population, na.rm = TRUE)
  )
#Convert to regular dataframe and join with buffer data
addIntersection <- findIntersection %>%
  st_drop_geometry()
#Merging the new found population into master data array
madEnvBuff <- madEnvBuff %>% 
  left_join(addIntersection, by = "Site.Id") %>%
  replace(is.na(.), 0)

#Parques (Parks)
#Intersecting parques locations with the environmental buffers to find area of parks located in the buffers
subset.int <- st_intersection(madrid_shapefile_parques, madEnvBuff)
#park.int.log = lengths(park.int) > 0
findIntersection <- subset.int %>% 
  mutate(area_sqft_parks = as.numeric(st_area(.)))
#Creating new column to aggregate the square feet of park within the buffer
addIntersection <-aggregate(findIntersection["area_sqft_parks"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found park area into master data array
madEnvBuff <- madEnvBuff %>% 
  st_join(addIntersection, join=st_equals, left=FALSE) 
#Removing the duplicates introduced to the data
madEnvBuff <- madEnvBuff[!duplicated(madEnvBuff$Site.Id), ]

#Density of roads
#Data downloaded from https://tmieno2.github.io/R-as-GIS-for-Economists/demo4.html#demo4 
#Intersecting map of roads location with the environmental buffers to find roads located in the buffers
subset.int <- st_intersection(madrid_shapefile_streets, madEnvBuff)
findIntersection <- subset.int %>% 
  mutate(length_in_m = as.numeric(st_length(.))) 
#Creating new column to aggregate the meters of streets within the buffer 
addIntersection <-aggregate(findIntersection["length_in_m"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found road length into master data array
madEnvBuff <- madEnvBuff %>% 
  st_join(addIntersection, join=st_equals, left=FALSE) 

#Impervious Surface
#Intersecting map of impervious surface with the environmental buffers to find impervious surfaces located in the buffers
subset.int <- st_intersects(madrid_shapefile_impervious, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_impervious[subset.int.log, ]
#Creating new column to sum the points of impervious surface found in the buffer
addAspect <-aggregate(madIntersects["imperviousSurface"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found impervious surface data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 

#Bus Stops
#Intersecting map of Bus stops with the environmental buffers to find the stops located in the buffers
subset.int <- st_intersects(madrid_shapefile_bus, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_bus[subset.int.log, ]
#Creating new column to sum the stops found in the buffer
addAspect<-aggregate(madIntersects["numBusStops"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found metro stops data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 


#Colegios (Schools)
#Intersecting map of colegios with the environmental buffers to find the schools located in the buffers
subset.int <- st_intersects(madrid_shapefile_colegios, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_colegios[subset.int.log, ]
#Creating new column to sum the schools found in the buffer
addAspect <- aggregate(madIntersects["numSchools"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found schools data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE)


#PREDATORS
#Peregrine Falcon
#Intersecting map of peregrine falcons with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_peregrineFalcoln, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_peregrineFalcoln[subset.int.log, ]
#Creating new column to sum the peregrine falcons seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found peregrine falcons data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numPeregrineFalcon"

#Booted Eagle
#Intersecting map of booted eagles with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_bootedEagle, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_bootedEagle[subset.int.log, ]
#Creating new column to sum the booted eagles seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found booted eagles data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numBootedEagle"

#Common Buzzard
#Intersecting map of Common Buzzards with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_commonBuzzard, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_commonBuzzard[subset.int.log, ]
#Creating new column to sum the common buzzards seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found coomon buzzards data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numCommonBuzzard"

#Eurasian Kestrel
#Intersecting map of Eurasian Kestrels with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_eurasianKestrel, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_eurasianKestrel[subset.int.log, ]
#Creating new column to sum the Eurasian kestrels seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found Eurasian kestrels data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numEurasianKestrel"

#Eurasian Marsh Harrier
#Intersecting map of Eurasian Marsh Harriers with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_eurasianMarshHarrier, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_eurasianMarshHarrier[subset.int.log, ]
#Creating new column to sum the Eurasian Marsh Harriers seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found Eurasian Marsh Harriers data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numEurasianMarshHarrier"

#Eurasian Sparrow Hawk
#Intersecting map of Eurasian Sparrow Hawks with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_eurasianSparrowHawk, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_eurasianSparrowHawk[subset.int.log, ]
#Creating new column to sum the Eurasian Sparrow Hawks seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found Eurasian Sparrow Hawks data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numEurasianSparrowHawk"

#Golden Eagle
#Intersecting map of Golden Eagles with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_goldenEagle, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_goldenEagle[subset.int.log, ]
#Creating new column to sum the Golden Eagles seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found Golden Eagles data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numGoldenEagle"

#Red Kite
#Intersecting map of Red Kites with the environmental buffers to find the sightings located in the buffers
subset.int <- st_intersects(madrid_shapefile_redKite, madEnvBuff)
subset.int.log = lengths(subset.int) > 0
madIntersects <- madrid_shapefile_redKite[subset.int.log, ]
#Creating new column to sum the Red Kites seen in the buffer
addAspect<-aggregate(madIntersects["OBSERVATION.COUNT"], madEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found Red Kites data into master array
madEnvBuff <- madEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(madEnvBuff)[colnames(madEnvBuff) == "OBSERVATION.COUNT"] <- "numRedKite"


#Combining all raptor sighting into a new predators variable
madEnvBuff <- mutate(madEnvBuff, numPredators = numBootedEagle + numCommonBuzzard + numEurasianKestrel + numEurasianMarshHarrier + numEurasianSparrowHawk + numGoldenEagle)
madEnvBuff <- mutate(madEnvBuff, PredatorYN = 1)
madEnvBuff$LitterYN[madEnvBuff$numPredators == 0 ] <- 0

#Combining all public transportation sites to create a a public transportation variable
#madEnvBuff <- mutate(madEnvBuff, numTransport = numCercaniaStops + numMetroStops)


#For observations where there were no restaurants with outdoor seating, changing number of tables from NA to 0 so I can include number tables in the Model
madEnvBuff$Tables[is.na(madEnvBuff$Tables)] <- 0


#Turning Litter variable into a yes or no to make binary for models
madEnvBuff <- mutate(madEnvBuff, LitterYN = 1)
madEnvBuff$LitterYN[madEnvBuff$Litter == "None"] <- 0
madEnvBuff$LitterYN <- as.numeric(madEnvBuff$LitterYN)



#############
# St. Louis #
#############

#Population Density
#Intersecting population with the environmental buffers to find area of census tracks located in the buffers
subset.int <- st_intersection(stl_shapefile_pop, stlEnvBuff) %>%
  mutate(
    #Calculate the proportion of each section that falls within each buffer
    section_area = as.numeric(st_area(.)),
    original_section_area = as.numeric(st_area(stl_shapefile_pop[match(GEOID, stl_shapefile_pop$GEOID),])),
    area_proportion = section_area / original_section_area,
    #Estimate population in the intersection based on area proportion
    estimated_population = estimate * area_proportion
  )
#Sum up estimated population in each buffer
findIntersection <- subset.int %>%
  group_by(Site.Id) %>%
  summarize(
    total_population = sum(estimated_population, na.rm = TRUE)
  )
#Convert to regular dataframe and join with buffer data
addIntersection <- findIntersection %>%
  st_drop_geometry()
#Merging the new found population into master data array
stlEnvBuff <- stlEnvBuff %>% 
  left_join(addIntersection, by = "Site.Id") 


#Parks
#Intersecting locations of parks with the environmental buffers to find area of parks located in the buffers
subset.int <- st_intersection(stl_shapefile_parks, stlEnvBuff)
#park.int.log = lengths(park.int) > 0
#stlIntersects <- filter(stl_shapefile_parks, park.int)
findIntersection <- subset.int %>% 
  mutate(area_sqft_parks = as.numeric(st_area(.)))
#Creating new column to aggregate the square feet of park within the buffer
addIntersection <-aggregate(findIntersection["area_sqft_parks"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found park area into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addIntersection, join=st_equals, left=FALSE) 
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Density of Roads
#Intersecting locations of roads with the environmental buffers to find length of roads located in the buffers
subset.int <- st_intersection(stl_shapefile_streets, stlEnvBuff)
findIntersection <- subset.int %>% 
  mutate(length_in_m = as.numeric(st_length(.))) 
#Creating new column to aggregate the meters of roads within the buffer
addIntersection <-aggregate(findIntersection["length_in_m"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found road length into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addIntersection, join=st_equals, left=FALSE) 
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Impervious Surface
#Intersecting locations of impervious surfaces with the environmental buffers to find area of impervious surfaces located in the buffers
subset.int <- st_intersects(stl_shapefile_impervious, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_impervious[subset.int.log, ]
#Creating new column to aggregate the area of impervious surfaces within the buffer
stlIntersects$Layer_1 <- as.numeric(stlIntersects$Layer_1) #data type needs to be changed to numeric
addAspect<-aggregate(stlIntersects["Layer_1"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found impervious surface area into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE)
#Changing name to indicate type of environmental aspect
colnames(stlEnvBuff)[colnames(stlEnvBuff) == "Layer_1"] <- "imperviousSurface"
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Bus Stops
#Intersecting locations of bus stops with the environmental buffers to find stops located in the buffers
subset.int <- st_intersects(stl_shapefile_bus, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_bus[subset.int.log, ]
#Creating new column to aggregate the number of bus stops within the buffer
addAspect<-aggregate(stlIntersects["numBusStops"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found bus stops data into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE)
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Schools
#Intersecting map of schools with the environmental buffers to find the schools located in the buffers
subset.int <- st_intersects(stl_shapefile_schools, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_schools[subset.int.log, ]
#Creating new column to sum the schools found in the buffer
addAspect <- aggregate(stlIntersects["numSchools"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found schools data into master array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE)

#PREDATORS
#Bald Eagle
#Intersecting locations of Bald Eagle sightings with the environmental buffers to find sightings within the buffers
subset.int <- st_intersects(stl_shapefile_baldEagle, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_baldEagle[subset.int.log, ]
#Creating new column to aggregate the sightings within the buffer
addAspect<-aggregate(stlIntersects["OBSERVATION"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found bus stops data into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(stlEnvBuff)[colnames(stlEnvBuff) == "OBSERVATION"] <- "numBaldEagle"
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Coopers Hawk
#Intersecting locations of Coopers Hawk sightings with the environmental buffers to find sightings within the buffers
subset.int <- st_intersects(stl_shapefile_coopersHawk, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_coopersHawk[subset.int.log, ]
#Creating new column to aggregate the sightings within the buffer
addAspect<-aggregate(stlIntersects["OBSERVATION"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found bus stops data into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(stlEnvBuff)[colnames(stlEnvBuff) == "OBSERVATION"] <- "numCoopersHawk"
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Peregrine Falcon
#Intersecting locations of Peregrine Falcon sightings with the environmental buffers to find sightings within the buffers
subset.int <- st_intersects(stl_shapefile_peregrineFalcon, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_peregrineFalcon[subset.int.log, ]
#Creating new column to aggregate the sightings within the buffer
addAspect<-aggregate(stlIntersects["OBSERVATION"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found bus stops data into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(stlEnvBuff)[colnames(stlEnvBuff) == "OBSERVATION"] <- "numPeregrineFalcon"
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Sharp Shinned Hawk
#Intersecting locations of Bald Eagle sightings with the environmental buffers to find sightings within the buffers
subset.int <- st_intersects(stl_shapefile_sharpShinnedHawk, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_sharpShinnedHawk[subset.int.log, ]
#Creating new column to aggregate the sightings within the buffer
addAspect<-aggregate(stlIntersects["OBSERVATION"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found bus stops data into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(stlEnvBuff)[colnames(stlEnvBuff) == "OBSERVATION"] <- "numSharpShinnedHawk"
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Red Shouldered Hawk
#Intersecting locations of Red Shouldered Hawk sightings with the environmental buffers to find sightings within the buffers
subset.int <- st_intersects(stl_shapefile_redShoulderedHawk, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_redShoulderedHawk[subset.int.log, ]
#Creating new column to aggregate the sightings within the buffer
addAspect<-aggregate(stlIntersects["OBSERVATION"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found bus stops data into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(stlEnvBuff)[colnames(stlEnvBuff) == "OBSERVATION"] <- "numRedShoulderedHawk"
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Red Tailed Hawk
#Intersecting locations of Red Tailed Hawk sightings with the environmental buffers to find sightings within the buffers
subset.int <- st_intersects(stl_shapefile_redTailedHawk, stlEnvBuff)
subset.int.log = lengths(subset.int) > 0
stlIntersects <- stl_shapefile_redTailedHawk[subset.int.log, ]
#Creating new column to aggregate the sightings within the buffer
addAspect<-aggregate(stlIntersects["OBSERVATION"], stlEnvBuff, sum) %>%
  replace(is.na(.), 0)
#Merging the new found bus stops data into master data array
stlEnvBuff <- stlEnvBuff %>% 
  st_join(addAspect, join=st_equals, left=FALSE) 
#Changing name to indicate type of predator
colnames(stlEnvBuff)[colnames(stlEnvBuff) == "OBSERVATION"] <- "numRedTailedHawk"
#Removing the many duplicates introduced into the data
stlEnvBuff <- stlEnvBuff[!duplicated(stlEnvBuff$Site.Id), ]

#Combining all raptor sighting into a new variable, numPredatorm, and a predator presence/absence vairable
stlEnvBuff <- mutate(stlEnvBuff, numPredators = numRedTailedHawk + numCoopersHawk + numBaldEagle + numPeregrineFalcon + numSharpShinnedHawk + numRedShoulderedHawk + numRedTailedHawk)
stlEnvBuff <- mutate(stlEnvBuff, PredatorYN = 1)
stlEnvBuff$predatorYN[stlEnvBuff$numPredators == 0] <- 0

#Turning Litter variable into a yes or no
stlEnvBuff <- mutate(stlEnvBuff, LitterYN = 1)
stlEnvBuff$LitterYN[stlEnvBuff$Litter == "None"] <- 0
stlEnvBuff$LitterYN <- as.numeric(stlEnvBuff$LitterYN)


#For observations where there were no restaurants with outdoor seating, changing number of tables from NA to 0 so I can include number  of tables in the Model
stlEnvBuff$Tables[is.na(stlEnvBuff$Tables)] <- 0




########################################################################################################
#                                                                                                      #
#                            Linear Modelling for Pigeon Density                                       #
#                                                                                                      #
########################################################################################################



#########################################################
#          Determine Significant Covariates             #
#########################################################

#using linear regression models to identify potential covariates in the dataset so these can be 
#removed from our backwards step wise regression models to improve the model accuracy and avoid
#any potentially confounding variables


##########
# Madrid #
##########

#Calculating covariates for model with the low estimate of pigeon density
madLowCovariates <- lm(Low.Estimate ~ Date.Value + Time.Value + Temp.F. + Wind + Cloud.Cover + Time.of.Day, data = madEnvBuff)
summary(madLowCovariates)
#covariates identified are temperature (t < 0.1) and cloud cover (t < 0.05)

#Calculating covariates for model with the mid estimate of pigeon density
madMidCovariates <- lm(Low.Estimate ~ Date.Value + Time.Value + Temp.F. + Wind + Cloud.Cover + Time.of.Day, data = madEnvBuff)
summary(madMidCovariates)
#covariates identified are temperature (t < 0.1) and cloud cover (t < 0.05)

#Calculating covariates for model with the high estimate of pigeon density
madHighCovariates <- lm(Low.Estimate ~ Date.Value + Time.Value + Temp.F. + Wind + Cloud.Cover + Time.of.Day, data = madEnvBuff)
summary(madHighCovariates)
#covariates identified are temperature (t < 0.1) and cloud cover (t < 0.05)


#beta is estimated standard error
#t(degrees of freedom) 

#############
# St. Louis #
#############

#Calculating covariates for model with the low pigeon estimate model
stlLowCovariates <- lm(Low.Estimate ~ Date.Value + Time.Value + Temp.F. + Wind + Cloud.Cover + Time.of.Day, data = stlEnvBuff)
summary(stlLowCovariates)
#no covariates identified

#Calculating covariates for model with the mid pigeon estimate model
stlMidCovariates <- lm(Low.Estimate ~ Date.Value + Time.Value + Temp.F. + Wind + Cloud.Cover + Time.of.Day, data = stlEnvBuff)
summary(stlMidCovariates)
#no covariates identified

#Calculating covariates for model with the high pigeon estimate model
stlHighCovariates <- lm(Low.Estimate ~ Date.Value + Time.Value + Temp.F. + Wind + Cloud.Cover + Time.of.Day, data = stlEnvBuff)
summary(stlHighCovariates)
#no covariates identified



#########################################################
#           Testing for Multicollinearity               #
#########################################################

#Calculating variance inflation factors to assess the degree of multicollinearity to determine
#whether any covariates should be removed from our model

##########
# Madrid #
##########

#calculating vif for the low pigeon estimate model
vif(madLowCovariates)

#calculating vif for the mid pigeon estimate model
vif(madMidCovariates)

#calculating vif for the high pigeon estimate model
vif(madHighCovariates)



#############
# St. Louis #
#############

#calculating vif for the low pigeon estimate model
vif(stlLowCovariates)

#calculating vif for the mid pigeon estimate model
vif(stlMidCovariates)

#calculating vif for the high pigeon estimate model
vif(stlHighCovariates)



#########################################################
#                 Build Linear Models                   #
#########################################################

#building a backwards stepwise linear regression model to identify the environmental variables
#that are most predictive of greater pigeon density


##########
# Madrid #
##########


#pigeon low
#Error in the regress
#madEnvBuff %>% drop_na(People)

#Building model for low pigeon estimate 
madPigLowVars <- step(lm(Low.Estimate ~  Cloud.Cover + 
                           Restaurant.with.outdoor.seating + Waste.Disposal + Water.Source + LitterYN + 
                           People + Other.Bird.Species + total_population + PredatorYN + numPredators +
                           numBusStops + numSchools + imperviousSurface + area_sqft_parks + length_in_m,
                         data = madEnvBuff, direction = "backwards", trace = T,
                         scope = list(lower= ~ Cloud.Cover)))
summary(madPigLowVars)


#Building model for mid pigeon estimate 
madPigMidVars <- step(lm(Mid.Estimate ~ Cloud.Cover + 
                           Restaurant.with.outdoor.seating + Waste.Disposal + Water.Source + LitterYN + 
                           People + Other.Bird.Species + total_population + PredatorYN + numPredators +
                           numBusStops + numSchools + imperviousSurface + area_sqft_parks + length_in_m,
                         data = madEnvBuff, direction = "backwards", trace = T,
                         scope = list(lower= ~ Cloud.Cover)))
summary(madPigMidVars)


#Building model for high pigeon estimate 
madPigHighVars <- step(lm(High.Estimate ~ Cloud.Cover + 
                          Restaurant.with.outdoor.seating + Waste.Disposal + Water.Source + LitterYN + 
                          People + Other.Bird.Species + total_population + PredatorYN + numPredators +
                          numBusStops + numSchools + imperviousSurface + area_sqft_parks + length_in_m,
                         data = madEnvBuff, direction = "backwards", trace = T,
                         scope = list(lower= ~ Cloud.Cover)))
summary(madPigHighVars)



#############
# St. Louis #
#############


#Building model for low pigeon estimate 
stlPigLowVars <- step(lm(Low.Estimate ~ 
                           Restaurant.with.outdoor.seating + Waste.Disposal + Water.Source + LitterYN + 
                           People + Other.Bird.Species + total_population + PredatorYN + numPredators +
                           numBusStops + numSchools + imperviousSurface + area_sqft_parks + length_in_m,
                         data = stlEnvBuff, direction = "backwards", trace = T,))
summary(stlPigLowVars)


#Building model for mid pigeon estimate 
stlPigMidVars <- step(lm(Mid.Estimate ~ Temp.F. + Cloud.Cover + 
                           Restaurant.with.outdoor.seating + Waste.Disposal + Water.Source + LitterYN + 
                           People + Other.Bird.Species + total_population + PredatorYN + numPredators +
                           numBusStops + numSchools + imperviousSurface + area_sqft_parks + length_in_m,
                         data = stlEnvBuff, direction = "backwards", trace = T,))
summary(stlPigMidVars)


#Building model for high pigeon estimate 
stlPigHighVars <- step(lm(High.Estimate ~ Temp.F. + Cloud.Cover + 
                            Restaurant.with.outdoor.seating + Waste.Disposal + Water.Source + LitterYN + 
                            People + Other.Bird.Species + total_population + PredatorYN + numPredators +
                            numBusStops + numSchools + imperviousSurface + area_sqft_parks + length_in_m,
                          data = stlEnvBuff, direction = "backwards", trace = T,))
summary(stlPigHighVars)


#############
#   Both    #
#############

#Building a combined model to see whether number of environmental survey points changes the result
#Combine datasets
combined_data <- rbind(
  transform(madEnvBuff[c("Mid.Estimate", "Cloud.Cover", 
                       "Restaurant.with.outdoor.seating", "Waste.Disposal",
                       "Water.Source", "LitterYN", "People",
                       "Other.Bird.Species", "total_population",
                       "PredatorYN", "numPredators", "numBusStops",
                       "numSchools", 
                       "imperviousSurface", "area_sqft_parks", "length_in_m")],
            City = "Madrid"),
  transform(stlEnvBuff[c("Mid.Estimate", "Cloud.Cover", 
                       "Restaurant.with.outdoor.seating", "Waste.Disposal",
                       "Water.Source", "LitterYN", "People",
                       "Other.Bird.Species", "total_population",
                       "PredatorYN", "numPredators", "numBusStops",
                       "numSchools",
                       "imperviousSurface", "area_sqft_parks", "length_in_m")],
            City = "StLouis")
)

#Run combined model
combinedModel <- step(lm(Mid.Estimate ~ Cloud.Cover + 
                           Restaurant.with.outdoor.seating + Waste.Disposal + 
                           Water.Source + LitterYN + People + 
                           Other.Bird.Species + total_population +
                           PredatorYN + numPredators + numBusStops +
                           numSchools +
                           imperviousSurface + area_sqft_parks + 
                           length_in_m + City,
                         data = combined_data,
                         direction = "backwards",
                         trace = TRUE,
                         scope = list(lower = ~ Cloud.Cover + City)))

summary(combinedModel)


########################################################################################################
#                                                                                                      #
#                                    Calculations by Category                                          #
#                                                                                                      #
########################################################################################################


##########
# Madrid #
##########

#Summing totals for all levels of pigeon estimate
sum(madEnvBuff$Low.Estimate)
sum(madEnvBuff$Mid.Estimate) 
sum(madEnvBuff$High.Estimate)

#Determining average group size of pigeons in sightings
sum(madEnvBuff$Low.Estimate) / length(madPig$Site.Id)
sum(madEnvBuff$Mid.Estimate) / length(madPig$Site.Id)
sum(madEnvBuff$High.Estimate) / length(madPig$Site.Id)

#############
# St. Louis #
#############

#Summing totals for all levels of pigeon estimate
sum(stlEnvBuff$Low.Estimate)
sum(stlEnvBuff$Mid.Estimate) 
sum(stlEnvBuff$High.Estimate)

#Determining average group size of pigeons in sightings
sum(stlEnvBuff$Low.Estimate) / length(stlPig$Site.Id)
sum(stlEnvBuff$Mid.Estimate) / length(stlPig$Site.Id)
sum(stlEnvBuff$High.Estimate) / length(stlPig$Site.Id)


#############
#    Both   #
#############

#T-test testing to see if there is a significant difference between pigeon estimates from Madrid and St. Louis
pigDif <- t.test(madPig$Mid.Estimate, stlPig$Mid.Estimate, alternative = "greater", paired = F, conf.level = 0.95)


#########################################################
#                       Litter                         #
#########################################################

##########
# Madrid #
##########

sum(madEnvBuff$LitterYN == 1)
sum(madEnvBuff$Litter == "Much")


#############
# St. Louis #
#############

sum(stlEnvBuff$Litter != "None")
sum(stlEnvBuff$Litter == "Much")


#########################################################
#                       Parks                           #
#########################################################

##########
# Madrid #
##########

sum(madEnvBuff$area_sqft_parks)


#############
# St. Louis #
#############

sum(stlEnvBuff$area_sqft_parks)


#########################################################
#                  Night vs. Day                        #
#########################################################


##########
# Madrid #
##########

#summing
sum(madEnvBuff$Time.of.Day == "Night")
sum(madEnvBuff$Time.of.Day == "Day")
sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night"])
sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day"])



#t.test 
#NS-1
madPigNight <- c(sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "NS-1"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "NS-2"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "NS-3"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "NS-4"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "NS-5"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "EW-6"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "EW-7"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "EW-8"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "EW-9"]),
                 sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Night" & madEnvBuff$Transect == "EW-10"]))
madPigDay <- c(sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "NS-1"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "NS-2"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "NS-3"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "NS-4"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "NS-5"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "EW-6"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "EW-7"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "EW-8"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "EW-9"]),
               sum(madEnvBuff$Mid.Estimate[madEnvBuff$Time.of.Day == "Day" & madEnvBuff$Transect == "EW-10"]))

#Plotting the findings
barplot(c(sum(madPigNight), sum(madPigDay)), col = c("orange", "red"), names.arg = c("Evening", "Day"))

#making t test
madTimeDay <- t.test(madPigNight, madPigDay, alternative = "greater", paired = F, conf.level = 0.95)



#############
# St. Louis #
#############

#summing
sum(stlEnvBuff$Time.of.Day == "Night")
sum(stlEnvBuff$Time.of.Day == "Day")
sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night"])
sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day"])


#plotting
barplot(c(sum(stlPigNight), sum(stlPigDay)), col = c("orange", "red"), names.arg = c("Evening", "Day"))

#t.test 
#NS-1
stlPigNight <- c(sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "NS-1"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "NS-2"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "NS-3"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "NS-4"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "NS-5"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "EW-6"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "EW-7"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "EW-8"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "EW-9"]),
                 sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Night" & stlEnvBuff$Transect == "EW-10"]))
stlPigDay <- c(sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "NS-1"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "NS-2"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "NS-3"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "NS-4"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "NS-5"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "EW-6"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "EW-7"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "EW-8"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "EW-9"]),
               sum(stlEnvBuff$Mid.Estimate[stlEnvBuff$Time.of.Day == "Day" & stlEnvBuff$Transect == "EW-10"]))

#making t test
stlTimeDay <- t.test(stlPigNight, stlPigDay, alternative = "greater", paired = F, conf.level = 0.95)

#posthoc analysis
TukeyHSD(stlTimeDay, conf.level = 0.95)



#########################################################
#                   Habitat use                         #
#########################################################


##########
# Madrid #
##########

#indexing data
madPigBuilding <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Building"])
madPigStatue <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Statue"])
madPigStreetLight <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Street Light"])
madPigGround <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Ground"])
madPigPhoneLine <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Phone Line"])
madPigFlyOverHead <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Fly Over Head"])
madPigFlyCloserToGround <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Flying closer to ground"])
madPigCar <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Car"])
madPigVariousStructures <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Various smaller structures"])
madPigTree <- sum(madPig$Mid.Estimate[madPig$Where.is.it == "Tree"])

#Combining 'Statues' and 'Various other Structures' into one 'Other' category
madPigOther <- madPigStatue + madPigVariousStructures + madPigCar

#Calculating percent of total
madPigGround / sum(madPig$Mid.Estimaste)
madPigBuilding / sum(madPig$Mid.Estimate)
madPigStreetLight / sum(madPig$Mid.Estimate)
madPigPhoneLine / sum(madPig$Mid.Estimate)
madPigFlyOverHead / sum(madPig$Mid.Estimate)
madPigFlyCloserToGround / sum(madPig$Mid.Estimate)
madPigOther / sum(madPig$Mid.Estimate)
madPigTree / sum(madPig$Mid.Estimate)

#Checking percents for accuracy 
madPigGround + madPigBuilding + madPigStreetLight + madPigPhoneLine + madPigFlyOverHead + madPigFlyCloserToGround + madPigOther + madPigUnrecorded + madPigTree
sum(madPig$Mid.Estimate)
length(unique(madPig$Where.is.it))


#Examining grouping tendencies
sum(madPig$Mid.Estimate == 1) + sum(madPig$Mid.Estimate == 2)
(sum(madPig$Mid.Estimate == 1) + sum(madPig$Mid.Estimate == 2)) / length(madPig$Mid.Estimate)
sum(madPig$Mid.Estimate >= 11) / length(madPig$Mid.Estimate)

length(madPig$Mid.Estimate)

barplot(c(sum(madPig$Mid.Estimate == 1), sum(madPig$Mid.Estimate == 2), sum(madPig$Mid.Estimate == 3), sum(madPig$Mid.Estimate == 4),
          sum(madPig$Mid.Estimate == 5), sum(madPig$Mid.Estimate == 6), sum(madPig$Mid.Estimate == 7), sum(madPig$Mid.Estimate == 8),
          sum(madPig$Mid.Estimate == 9), sum(madPig$Mid.Estimate == 10), sum(madPig$Mid.Estimate >= 11)))



#############
# St. Louis #
#############

#indexing data
stlPigGround <- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Ground"])
stlPigBuilding <- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Building"])
stlPigStreetLight <- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Street Light"])
stlPigPhoneLine <- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Phone Line"])
stlPigFlyOverHead <- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Fly Over Head"])
stlPigFlyCloserToGround <- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Flying closer to ground"])
stlPigOther <- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Bridge"])
stlPigTree<- sum(stlPig$Mid.Estimate[stlPig$Where.is.it == "Tree"])

#Calculating percent of total
stlPigGround / sum(stlPig$Mid.Estimate)
stlPigBuilding / sum(stlPig$Mid.Estimate)
stlPigStreetLight / sum(stlPig$Mid.Estimate)
stlPigFlyOverHead / sum(stlPig$Mid.Estimate)
stlPigFlyCloserToGround / sum(stlPig$Mid.Estimate)
stlPigPhoneLine / sum(stlPig$Mid.Estimate)
stlPigTree / sum(stlPig$Mid.Estimate)


#Checking percents for accuracy
stlPigGround + stlPigBuilding + stlPigStreetLight + stlPigFlyOverHead + stlPigFlyCloserToGround + stlPigPhoneLine
sum(stlPig$Mid.Estimate)
length(unique(stlPig$Where.is.it))


#Examining grouping tendencies
sum(stlPig$Mid.Estimate == 1) + sum(stlPig$Mid.Estimate == 2)
sum(stlPig$Mid.Estimate == 2) / length(stlPig$Mid.Estimate)
sum(stlPig$Mid.Estimate >= 11) / length(stlPig$Mid.Estimate)
sum(stlPig$Mid.Estimate >= 11 & stlPig$Where.is.it == "Building")
sum(stlPig$Mid.Estimate >= 11 & stlPig$Where.is.it == "Phone Line")
sum(stlPig$Mid.Estimate >= 11 & stlPig$Where.is.it == "Fly Over Head")
sum(stlPig$Mid.Estimate >= 11 & stlPig$Where.is.it == "Flying closer to ground")
sum(stlPig$Mid.Estimate >= 11 & stlPig$Where.is.it == "Street Light")

barplot(c(sum(stlPig$Mid.Estimate == 1), sum(stlPig$Mid.Estimate == 2), sum(stlPig$Mid.Estimate == 3), sum(stlPig$Mid.Estimate == 4),
          sum(stlPig$Mid.Estimate == 5), sum(stlPig$Mid.Estimate == 6), sum(stlPig$Mid.Estimate == 7), sum(stlPig$Mid.Estimate == 8),
          sum(stlPig$Mid.Estimate == 9), sum(stlPig$Mid.Estimate == 10), sum(stlPig$Mid.Estimate >= 11)))



#########################################################
#          Restaurants w/ Outdoor Seating               #
#########################################################


##########
# Madrid #
##########

#sum
sum(madEnvBuff$Restaurant.with.outdoor.seating == "Yes")
sum(madEnvBuff$Restaurant.with.outdoor.seating == "No")

#tables
sum(!is.na(madEnvBuff$Tables) & madEnvBuff$Tables != 0)


#############
# St. Louis #
#############

sum(stlEnvBuff$Restaurant.with.outdoor.seating == "Yes")
sum(stlEnvBuff$Restaurant.with.outdoor.seating == "No")

sum(!is.na(stlEnvBuff$Tables) & stlEnvBuff$Tables != 0)


#########################################################
#                       Weather                         #
#########################################################


##########
# Madrid #
##########

#temp
fahrenheit.to.celsius(mean(madEnvBuff$Temp.F.))
fahrenheit.to.celsius(range(madEnvBuff$Temp.F.))

#cloud cover
mean(madEnvBuff$Cloud.Cover)


#############
# St. Louis #
#############

#temp
fahrenheit.to.celsius(mean(stlEnvBuff$Temp.F.))
fahrenheit.to.celsius(range(stlEnvBuff$Temp.F.))

#cloud cover
mean(stlEnvBuff$Cloud.Cover)





#########################################################
#                     Road Density                      #
#########################################################


##########
# Madrid #
##########

#road density
sum(madEnvBuff$length_in_m)

#############
# St. Louis #
#############

#road density
sum(stlEnvBuff$length_in_m)



#########################################################
#                       People                          #
#########################################################


##########
# Madrid #
##########

#Summing amount of pedestrians observed in Madrid
addAspect <- madEnvBuff %>% drop_na(People) #removing NAs and using a changable variable because I do not want to further clutter environment
sum(addAspect$People)

#Summing total population in Madrid
sum(madEnvBuff$total_population)

#Calculating rate of pedestrians to population
madRate <- sum(addAspect$People)/sum(madEnvBuff$total_population)

#night
addAspect <- madEnvBuff %>% drop_na(People)
addAspect <- addAspect[addAspect$Time.of.Day == "Night",]
sum(addAspect$People)

#day
addAspect <- madEnvBuff %>% drop_na(People)
addAspect <- addAspect[addAspect$Time.of.Day == "Day",]
sum(addAspect$People)

#############
# St. Louis #
#############

#Summing amount of pedestrians observed in St. Louis
sum(stlEnvBuff$People)

#Summing total population in St. Louis
sum(stlEnvBuff$total_population)

#Calculating rate of pedestrians to population
stlRate <- sum(stlEnvBuff$People)/sum(stlEnvBuff$total_population)


t.test(madEnvBuff$People, stlEnvBuff$People, alternative = "greater", paired = F, conf.level = 0.95)



#########################################################
#                   Water Source                        #
#########################################################


##########
# Madrid #
##########

sum(madEnvBuff$Water.Source == "Yes")

#############
# St. Louis #
#############

sum(stlEnvBuff$Water.Source == "Yes")


#############
#    Both   #
#############

#Madrid
#15 are fountains or water features, so not temporary 
#75%

#St. Louis
#5 out of 8 are fountains
#62.5%




#########################################################
#                     Predators                         #
#########################################################


##########
# Madrid #
##########

#predator
sum(madEnvBuff$numPredators)

#peregrine falcoln
sum(madEnvBuff$numPeregrineFalcon)


#############
# St. Louis #
#############

#predator
sum(stlEnvBuff$numPredators)

#peregrine falcoln
sum(stlEnvBuff$numPeregrineFalcon)


