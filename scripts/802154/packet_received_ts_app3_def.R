# wczytanie danych związanych z wektorami z plików wynikowych Omnet++
input_data_dir <- "data_sheets/4_802154/data/original_vectors/app3/"
file_name_prefix <- "sim802154_app3_N"
file_nums <- seq(5, 20, 1)
vectors_names <- c("server_delay",
                   "gateway_data_rate",
                   "server_packet_received",
                   "server_throughput"
                   )

vector_data <- load_vector_data(vectors_names,
                                input_data_dir,
                                file_name_prefix,
                                file_nums)

# utworzenie ramek danych z wektorami dotyczącymi pakietów otrzymanych w czasie każdej sekundy
packet_received_app3_ts_dfs <- get_packet_received_ts_dfs(vector_data, 3, 1)

# zapisanie utworzonych szeregów do plików
packet_received_dir <- "data_sheets/4_802154/data/packet_received_vectors/app3/"
save_df_list(packet_received_app3_ts_dfs,
             packet_received_dir,
             file_name_prefix,
             file_nums,
             "packet_received.csv"
)

# wizualizacja liczb otrzymanych pakietów
network_sizes <- seq(5, 20, 1)

packet_received_plots <- create_packet_received_sizes_plots(packet_received_app3_ts_dfs,
                                                            network_sizes)

display_plots(packet_received_plots)

packet_received_comp_df <- create_comparison_df(packet_received_app3_ts_dfs,
                                                network_sizes,
                                                "total_packets_size")


packet_received_comp_range1 <- cbind(packet_received_comp_df[1],
                                     packet_received_comp_df[, 2:9])
packet_received_comp_range2 <- cbind(packet_received_comp_df[1],
                                     packet_received_comp_df[, 10:17])
comp_plots <- list()
comp_plots[[1]] <- create_multiple_ts_plot_from_df(packet_received_comp_df,
                                                   "segment",
                                                   "Zestawienie liczb otrzymywanych pakietów",
                                                   "czas [s]",
                                                   "liczba pakietów [B]",
                                                   "Liczba sensorów w sieci:")

comp_plots[[2]] <- create_multiple_ts_plot_from_df(packet_received_comp_range1,
                                                   "segment",
                                                   "Zestawienie liczb otrzymywanych pakietów",
                                                   "czas [s]",
                                                   "liczba pakietów [B]",
                                                   "Liczba sensorów w sieci:")

comp_plots[[3]] <- create_multiple_ts_plot_from_df(packet_received_comp_range2,
                                                   "segment",
                                                   "Zestawienie liczb otrzymywanych pakietów",
                                                   "czas [s]",
                                                   "liczba pakietów [B]",
                                                   "Liczba sensorów w sieci:")

display_plots(comp_plots)



# czyszczenie środowiska
rm(input_data_dir)
rm(file_name_prefix)
rm(file_nums)
rm(vectors_names)
rm(vector_data)
rm(packet_received_dir)
rm(network_sizes)
rm(packet_received_comp_range1)
rm(packet_received_comp_range2)



