# mapping locations

  # load libraries needed for mapping
  # if this is your first time loading the libraries, you have to install them first
  if (!requireNamespace("pak", quietly = TRUE)) 
      install.packages("pak")
      pak::pkg_install(c("tidyverse", "sf", "rnaturalearth", "maps"))

  library(tidyverse)
  library(sf)
  library(rnaturalearth)
  library(maps)

  #### 1. set working directory to where your data is ####
  
  # here I have a folder on my desktop called MAST 316 data. My cleaned and sorted dataset is here. 
  setwd("~/Desktop/MAST 316 data/")
  
  #### 2. Load data ####
  
  dat <- read_csv("Pterois_volitans_time_depth_invasivestatus_sorted.csv")

  #### 3. check data ####
  
  glimpse(dat)
      
  # if you need to separate your data in any way, do so now
  # e.g., into separate time periods
  # hint - if you need to do this, remove the #, which comments out code
      
  #dat_pre1960 <- dat |>
  #  filter(Year < 1960)
  #
  #dat_post1960 <- dat |>
  #  filter(Year >= 1960)
  
 #### 4. start mapping
  
  # map just the lat/longs
  ggplot(dat_sf) +
    geom_sf() 
  
  # add a map
  world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")

  # plot points + world map
  ggplot() +
    geom_sf(data = world) +
    geom_sf(data = dat_sf)
  
  # make points more transparent, change size
  # alpha is the transparency control, 0 is clear and 1 is fully opaque
  # color = black, but you can change it
  # size controls size of points
  
  ggplot() +
    geom_sf(data = world) +
    geom_sf(data = dat_sf, color = "black", alpha = 0.4, size = 0.5)
  
  # add a theme (controls overall look of plot)
  # see: https://ggplot2.tidyverse.org/reference/ggtheme.html
  # and: https://ggplot2-book.org/themes.html
  # I like theme_sleek in the ggsidekick package
  
  ggplot() +
    geom_sf(data = world) +
    geom_sf(data = dat_sf, color = "black", alpha = 0.6, size = 1) +
    ggsidekick::theme_sleek()
  
  # add x and y axis labels
   ggplot() +
    geom_sf(data = world) +
    geom_sf(data = dat_sf, color = "black", alpha = 0.6, size = 1) +
    xlab("Longitude") +
    ylab("Latitude") + 
    ggsidekick::theme_sleek()
 
   # if you want to change the map color, do so with this code:
  ggplot() +
    geom_sf(data = world, fill = "grey", color = "white") +
    geom_sf(data = dat_sf, color = "black", alpha = 0.6, size = 1) +
    xlab("Longitude") +
    ylab("Latitude") + 
    ggsidekick::theme_sleek()
  
  # if you need to trim to a region use coord_sf() and provide limits
  
   # e.g., coord_sf(xlim = c(40, 50), ylim = c(5, 15)) 
   # AI can help with this - ask for the min and max latitude and longitude for a region
  
  ggplot() +
    geom_sf(data = world, fill = "grey", color = "white") +
    geom_sf(data = dat_sf, color = "black", alpha = 0.6, size = 1) +
    coord_sf(xlim = c(40, 50), ylim = c(5, 15)) +
    xlab("Longitude") +
    ylab("Latitude") + 
    ggsidekick::theme_sleek()
  
  # save file
  
  # first, save your final plot as an object
  species_map <-  
    ggplot() +
      geom_sf(data = world, fill = "grey", color = "white") +
      geom_sf(data = dat_sf, color = "black", alpha = 0.6, size = 1) +
      xlab("Longitude") +
      ylab("Latitude") + 
      ggsidekick::theme_sleek()

  ggsave(species_map, file = "species_map.png",
         dpi = 300, height = 10, width = 20, units = "in")
  
  # after looking at saved map, we need to make our axis text bigger:
  species_map <-  
     ggplot() +
      geom_sf(data = world, fill = "grey", color = "white") +
      geom_sf(data = dat_sf, color = "black", alpha = 0.6, size = 1) +
      xlab("Longitude") +
      ylab("Latitude") + 
      ggsidekick::theme_sleek() +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 18))

  ggsave(species_map, file = "species_map.png",
         dpi = 300, height = 10, width = 20, units = "in")
 