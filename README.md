
# ch.kof.barometer

The ch.kof.barometer package provides versioned time series data
and their meta information for scientific research.
In addition, the package contains the
extract-transform-load (ETL) functionality that
sources the data from its original provider.

## Browse Time Series Data

## Basic Data Consumption via opentimeseries


```r
ts <- read_open_ts(
  "ch.kof.barometer",
  archive= "opentsi" # or your organisation
)

ts
```

## The ch.kof.barometer Data R Package


