# nie działa jak należy:
load_num_slots_LMAC_data <- function() {
  data <- list()
  N <- seq(10, 100, 10)
  i <- 0
  for(n in N) {
    directory <- "data_sheets/NumSlotsLMAC/"
    file_name <- paste0("NumSlotsLMAC_N", n, ".csv")
    full_dir <- paste0(directory, file_name)
    data[i] <- read.csv(full_dir, sep=";")
    i <- i + 1
  }
  return(data)
}
