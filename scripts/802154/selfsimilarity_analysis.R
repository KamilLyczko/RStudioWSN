input_data_dir <- "data_sheets/4_802154/data/original_vectors/"
file_name <- "test_vectors_N5.csv"
file_name_nh <- "test_vectors_no_headers_N5.csv"
full_path <- paste0(input_data_dir, file_name)
full_path_nh <- paste0(input_data_dir, file_name_nh)
N5_data <- load_data(full_path)

vectors_names <- c("gateway_data_rate",
                   "server_packet_received",
                   "server_throughput",
                   "server_delay")

ts_data <- split_vector_data(N5_data, vectors_names)
#test_window <- get_ts_window(ts_data[[4]], 0, 100)



