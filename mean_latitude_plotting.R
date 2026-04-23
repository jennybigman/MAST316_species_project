# mean latitude over time
  library(tidyverse)
  library(ggsidekick)
  
  # library(here)

  #### 1. set working directory to where your data is ####
  
  # here I have a folder on my desktop called MAST 316 data. My cleaned and sorted dataset is here. 
  setwd("~/Desktop/MAST 316 data/") # for MAC
  setwd("")
  
  #### 2. Load data ####
  
  dat <- read_csv("Pterois_volitans_time_depth_invasivestatus_sorted.csv")
  # dat <- read_csv("./knobbed whelks/busycon_carica_qualifiers_sorted_cleaned_humanobs.csv")
  
  # mean latitude over time
  
  mean_lat_plot <- 
    dat |>
    group_by(year) |>
    summarise(
      mean_lat = mean(Latitude, na.rm = TRUE),
      sd_lat = sd(Latitude, na.rm = TRUE),
      n_obs = n(),
      se_lat = sd_lat / sqrt(n_obs),
      .groups = "drop") |>
    ggplot(aes(x = year, y = mean_lat)) +
      geom_ribbon(aes(ymin = mean_lat - se_lat, ymax = mean_lat + se_lat),
                  alpha = 0.3) +
      geom_line() +
      ylab("Mean latitude") +
      xlab("Year") +
      ggsidekick::theme_sleek()
  

  # alexandria's plot
   ap_mean_lat_plot <- 
    dat |>
    filter(year > 2008) |>
    group_by(year) |>
    summarise(
      mean_lat = mean(Latitude, na.rm = TRUE),
      sd_lat = sd(Latitude, na.rm = TRUE),
      n_obs = n(),
      se_lat = sd_lat / sqrt(n_obs),
      .groups = "drop") |>
    ggplot(aes(x = year, y = mean_lat)) +
      geom_ribbon(aes(ymin = mean_lat - se_lat, ymax = mean_lat + se_lat),
                  alpha = 0.3) +
      geom_line() +
      ylab("Mean latitude") +
      xlab("Year") +
      ggsidekick::theme_sleek()
  
    ggsave(ap_mean_lat_plot, file = "./knobbed whelks/ap_mean_lat.png",
         height = 5, width = 10)
  