#' Process KOF Barometer Data into idx.csv
#'
#' Fetches the most recent vintage of the KOF Barometer from the KOF Time
#' Series Database and writes it to \code{data-raw/csv/idx.csv}.
#'
#' @importFrom tsdbapi read_ts set_config
#' @param key API key for the KOF Time Series Database.
#'
#' @return Invisibly returns the output file path.
#' @export
process_data <- function(key) {
  tsdbapi::set_config(api_key = key)

  ts_key <- "ch.kof.barometer"
  tsl <- tsdbapi::read_ts(ts_key)
  ts_obj <- tsl[[ts_key]]

  # Convert ts object to data frame with time and value columns
  # Extract time index and values from the ts object
  values <- as.numeric(ts_obj)

  ts_time <- time(ts_obj)

  freq <- frequency(ts_obj)

  # For monthly data (freq = 12)
  if (freq == 12) {
    years  <- floor(ts_time)
    months <- round((ts_time - years) * 12) + 1
    ts_dates <- as.Date(sprintf("%d-%02d-01", years, months))
  } else {
    stop(sprintf("Unsupported frequency: %d", freq))
  }

  # Create data frame in the format of the input file
  ts_df <- data.frame(
    time = as.Date(ts_dates),
    value = values
  )

  # Create path to write file
  output_path <- file.path(".", "data-raw", "csv", "idx.csv")

  # Write to CSV without row names
  write.csv(ts_df, file = output_path, row.names = FALSE, quote = FALSE)
  message(sprintf("Written: %s", output_path))

  invisible(output_path)
}

# process_data(key = Sys.getenv("TSDBAPI"))
