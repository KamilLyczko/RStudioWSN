# wczytanie danych związanych z wektorami z plików wynikowych Omnet++
input_data_dir <- "data_sheets/4_802154/data/original_vectors/app1/"
file_name_prefix <- "sim802154_app1_N"
file_nums <- seq(5, 20, 1)
vectors_names <- c("server_throughput",
                   "server_packet_received",
                   "gateway_data_rate",
                   "server_delay")

vector_data <- load_vector_data(vectors_names,
                                input_data_dir,
                                file_name_prefix,
                                file_nums)

# utworzenie ramek danych z wektorami dotyczącymi szybkości transmisji danych (data rate)
network_sizes <- seq(5, 20, 1)
data_rate_ts_dfs <- get_vector_ts_dfs(vector_data, 3, network_sizes)

test_plot <- create_ts_plot(data_rate_ts_dfs[[1]]$t, data_rate_ts_dfs[[1]]$gateway_data_rate,
                            "segment")

plot(test_plot)


# czyszczenie środowiska
rm(input_data_dir)
rm(file_name_prefix)
rm(file_nums)
rm(vectors_names)
rm(vector_data)
rm(network_sizes)
rm(data_rate_ts_dfs)
rm(test_plot)

