library(deloRean)
library(opentimeseries)


## Example Step 1, Init Archive, once generated make sure
# the newly created archive is your working dir
# outcommented because by the time you read this in boilerplate.R
# you've already created the archive.
# archive_init("ch.kof.globalbaro", parent_dir = )
library(kofdata)
library(data.table)
library(tsbox)

baro <- kofdata::get_collection("baro_vintages_monthly")
# change this to index to represent new metadata changes
names(baro) <- rep("idx", length(baro))
class(baro) <- c(class(baro), "tslist")
release_dates <- rep(seq(as.Date("2014-04-10"),
  by = "1 month",
  length.out = length(baro)
), 2)

vintages_dt <- create_vintage_dt(release_dates, baro)
head(vintages_dt)

## Example Step 3, Import History to Archive
# getwd() prints NULL ?
setwd("~/KOF_Lab/opentsi/ch.kof.barometer")
archive_import_history(vintages_dt, repository_path = ".")


# write process data done (vignette 2)
# done

# write metadata (vignette 3)
# done
library(deloRean)
render_metadata()
meta <- read_meta(".")
validate_metadata(meta) # TRUE

devtools::load_all()
devtools::check()
devtools::install()

# finish archive_seal
checksum_input <- generate_checksum_input()
archive_seal(checksum_input)

# check handle data and process data
library(digest)
library(kofdata)
handle_update()
 
# automation
# done




