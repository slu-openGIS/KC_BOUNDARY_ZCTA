# overview ####
# this creates the geometry and demographics for zip codes in parts of the
# Kasnas City metro area.

# Platte - 29165
# Clay - 29047
# Kansas City - 29511
# Jackson - 29095
# Wyandotte - 20209
# Johnson - 20091

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# dependencies ####

## packages
library(dplyr)
library(readr)
library(sf)
library(tigris)
library(tidycensus)

## functions
source("source/functions/get_zcta.R")
source("source/functions/create_zcta.R")
source("source/functions/estimate_zcta.R")

# download source data ####
## download
zips <- get_zcta()

## clean-up
rm(get_zcta)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build regional data ####
## define counties
focal_counties <- c("20091", "20209", "29047", "29095", "29165", "29511")

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/KC_ZCTA_Regional.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                      variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/STL_ZCTA_Regional_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                              variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/KC_ZCTA_Regional_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                              variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/KC_ZCTA_Regional_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build Johnson County data ####
## define counties
focal_counties <-"20091"

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/KC_ZCTA_Johnson_County.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                           variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/KC_ZCTA_Johnson_County_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs",  county = focal_counties,
                      variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/KC_ZCTA_Johnson_County_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                         variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/KC_ZCTA_Johnson_County_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build Wyandotte County data ####
## define counties
focal_counties <- "20209"

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/KC_ZCTA_Wyandotte_County.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                           variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/KC_ZCTA_Wyandotte_County_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                      variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/KC_ZCTA_Wyandotte_County_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                         variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/KC_ZCTA_Wyandotte_County_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build Clay County data ####
## define counties
focal_counties <- "29047"

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/KC_ZCTA_Clay_County.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                           variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/KC_ZCTA_Clay_County_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                      variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/KC_ZCTA_Clay_County_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", county = focal_counties,
                         variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/KC_ZCTA_Clay_County_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build St. Louis County data ####
## define counties
focal_counties <- "29095"

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, state = 29, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/STL_ZCTA_St_Louis_City.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                           variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/STL_ZCTA_St_Louis_City_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                      variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/STL_ZCTA_St_Louis_City_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                         variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/STL_ZCTA_St_Louis_City_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build Warren County data ####
## define counties
focal_counties <- "219"

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, state = 29, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/STL_ZCTA_Warren_County.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                           variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/STL_ZCTA_Warren_County_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                      variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/STL_ZCTA_Warren_County_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                         variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/STL_ZCTA_Warren_County_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build Franklin County data ####
## define counties
focal_counties <- "071"

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, state = 29, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/STL_ZCTA_Franklin_County.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                           variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/STL_ZCTA_Franklin_County_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                      variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/STL_ZCTA_Franklin_County_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                         variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/STL_ZCTA_Franklin_County_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# build Lincoln County data ####
## define counties
focal_counties <- "113"

## create ZCTA geometry
### create
geometry <- create_zcta(source = zips, state = 29, county = focal_counties)

### write geometric data
geometry$target %>%
  st_transform(crs = 4326) %>%
  st_write("data/geometries/STL_ZCTA_Lincoln_County.geojson", delete_dsn = TRUE)

## create total population estimates
### create
total_pop <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                           variable = "B01003_001", class = "tibble")

### calculate percentages
total_pop %>%
  mutate(total_pop = round(B01003_001E)) %>%
  select(GEOID_ZCTA, total_pop) -> total_pop

### write data
write_csv(total_pop, "data/demographics/STL_ZCTA_Lincoln_County_Total_Pop.csv")

### clean-up
rm(total_pop)

## create population race estimates
### create
race <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                      variable = c("B02001_001", "B02001_002", "B02001_003"), class = "tibble")

### calculate percentages
race %>%
  mutate(wht_pct = B02001_002E/B02001_001E*100) %>%
  mutate(blk_pct = B02001_003E/B02001_001E*100) %>%
  select(GEOID_ZCTA, wht_pct, blk_pct) -> race

### write data
write_csv(race, "data/demographics/STL_ZCTA_Lincoln_County_Race.csv")

### clean-up
rm(race)

## create population poverty estimates
### create
poverty <- estimate_zcta(input = geometry, year = 2018, dataset = "acs", state = 29, county = focal_counties,
                         variable = c("B17001_001", "B17001_002"), class = "tibble")

### calculate percentages
poverty %>%
  mutate(pvty_pct = B17001_002E/B17001_001E*100) %>%
  select(GEOID_ZCTA, pvty_pct) -> poverty

### write data
write_csv(poverty, "data/demographics/STL_ZCTA_Lincoln_County_Poverty.csv")

### clean-up
rm(poverty)

## clean-up
rm(geometry, focal_counties)

# === # === # === # === # === # === # === # === # === # === # === # === # === #

# final clean-up ####
rm(zips, create_zcta, estimate_zcta)
