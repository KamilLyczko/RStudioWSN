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

packet_received_ts_dfs <- create_packet_received_ts_dfs(ts_data[[2]]$server_packet_received,
                                                        ts_data[[2]]$t, 1)

packet_nums_plot <-create_ts_plot(packet_received_ts_dfs[[1]]$window_end_time,
                                  packet_received_ts_dfs[[1]]$packets_number,
                                  "bar")

packet_sizes_plot <- create_ts_plot(packet_received_ts_dfs[[2]]$window_end_time,
                                    packet_received_ts_dfs[[2]]$total_packets_size,
                                    "bar")

plot(packet_nums_plot)
plot(packet_sizes_plot)

arrival_time_df <- create_packet_arrival_time_df(ts_data[[2]]$t)
arrival_time_plot <- create_line_plot2(arrival_time_df$packet_number,
                                       arrival_time_df$arrival_time)
arrival_time_diff_plot <- create_line_plot2(arrival_time_df$packet_number,
                                            arrival_time_df$arrival_time_diff)
plot(arrival_time_plot)
plot(arrival_time_diff_plot)



