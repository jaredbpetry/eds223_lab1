#Great packages that help you with geospatial data analysis!
#---- we will use a preloaded dataset about new zealand
library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)
library(tmap)

tm_shape(nz) +    #--- this will return nothing, just telling tmap about the 'nz' map
  tm_fill()       #--- this will display the shape 'filled'

tm_shape(nz) +
  tm_borders() +    #--- can also add the borders here 
  tm_fill()

map_nz <- tm_shape(nz) +
  tm_polygons()    #---- this is a shortcut for fill + borders
class(map_nz)

#--- nz_elev is elevation raster data for new zealand
map_nz1 <- map_nz + 
  tm_shape(nz_elev) +
  tm_raster(alpha = 0.7)  #---- alpha refers to the transparency
  
map_nz1 +
  tm_shape(nz_height) + 
  tm_dots()

#--- If you want to make the fill or borders a certain color you can do something like this
#--- lwd means line width and lty means line type
tm_shape(nz) +
  tm_borders(lwd = 3, col = 'blue', lty = 4) +
  tm_fill(col = "red")

#--- let's change the title
legend_title <- expression("Area (km"^2*")")
tm_shape(nz) +
  tm_fill(col = "Land_area", title = legend_title)

#--- let's mess around with the 'bins' for the legend 
#--- style = equal will make all the bins of equal size ... see tmap documentation
#--- style = pretty is the default 
tm_shape(nz) + 
  tm_polygons(col = "Median_income", style = "quantile")

#--- or we can manually store breaks for the bins 
breaks <- c(0, 3, 4, 5)*1000
tm_shape(nz) + 
  tm_polygons(col = "Median_income", breaks = breaks)

#--- change the style to 'cont' meaning continuous
map_nz + 
  tm_shape(nz_elev) +
  tm_raster(alpha = 0.7, 
            style = 'cont')

#--- this says color the polygons by Island 
map_nz + 
  tm_shape(nz) +
  tm_polygons(col = 'Island', 
              style ='cat')

#--- let's add a compass 
map_nz +
  tm_compass(type = '4star', position = c('left', 'top')) +
  tm_scale_bar(breaks = c(0, 100, 200))

#--- add lat and long markings
map_nz +
  tm_graticules() + 
  tm_layout(bg.color = 'lightblue')

#--- AWESOME - MAKE IT INTERACTIVE!

tmap_mode('view')
map_nz
  
tmap_mode('plot')
map_nz
