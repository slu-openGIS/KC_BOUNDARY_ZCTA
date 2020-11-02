# KC_BOUNDARY_ZCTA
## Motivation
Public health data are often released by ZIP code rather than Census tracts or similar geographies. This practice has well-established shortcomings, but remains common. One significant issue is that ZIP codes do not stop at county lines, yet much of our public health data does. In order to address this, this repository creates interpolated population estimates for modified ZCTA boundaries that are limited to the extent of specific counties.

## Contents
This repository contains two sets of data for Kansas City area ZCTAs:

  1. Geometric data for ZCTAs in `.geojson` format
  2. Estimated population data for ZCTAs in `.csv` format

These data are available for five specific counties as well as a single, regional data set.
