library(deloRean)
library(opentimeseries)


## Example Step 1, Init Archive, once generated make sure
# the newly created archive is your working dir
# outcommented because by the time you read this in boilerplate.R
# you've already created the archive.
# archive_init("ch.kof.globalbaro", parent_dir = )



## Example Step 2, Generate History

library(kofdata)
library(data.table)
library(tsbox)

baro <- kofdata::get_collection("baro_vintages_monthly")
names(baro) <- rep("barometer", length(baro))
class(baro) <- c(class(baro), "tslist")
release_dates <- rep(seq(as.Date("2014-04-10"),
                     by = "1 month",
                     length.out = length(baro)),2)
vintages_dt <- create_vintage_dt(release_dates, baro)
head(vintages_dt)


## Example Step 3, Import History to Archive
library(deloRean)

vintages_dt <- create_vintage_dt(release_dates, baro)
head(vintages_dt)

# getwd() prints NULL ?
# setwd("~/KOF_Lab/opentsi/ch.kof.barometer")
archive_import_history(vintages_dt, repository_path = ".")

# write process data done (vignette 2)
# done 

# write metadata (vignette 3)
# done 

#  automation (vignette 4)
# for this, handle_update needs to be written -> here use checksum functions from opentimeseries

# after this, load devtools, load_all(), check(), then install()

