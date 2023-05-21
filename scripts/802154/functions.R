# funkcja zwraca listę z ramkami danych dotyczących szeregów czasowych otrzymanych pakietów
#   wyznaczonych dla podanego okna czasowego
get_packet_received_ts_dfs <- function(vector_data_list, window_size) {
  packet_received_ts_list <- list()
  for (i in 1:length(vector_data_list)) {
    packet_received_vec <- vector_data_list[[i]][[2]]$server_packet_received
    time_vec <- vector_data_list[[i]][[2]]$t
    packet_received_ts_df <- create_packet_received_ts_df(packet_received_vec,
                                                          time_vec,
                                                          window_size)
    packet_received_ts_list[[i]] <- packet_received_ts_df
  }
  return(packet_received_ts_list)
}

# funkcja zwraca listę z obiektami wykresów liczb otrzymanych pakietów
create_packet_received_sizes_plots <- function(dfs_list,
                                               network_sizes) {
  plot_list <- list()
  for (i in 1:length(dfs_list)) {
    title <- paste0("Wykres liczb pakietów otrzymywanych w czasie 1 s - liczba sensorów: ",
                    network_sizes[i])
    plot_list[[i]] <- create_ts_plot(dfs_list[[i]]$window_end_time,
                                     dfs_list[[i]]$total_packets_size,
                                     "segment",
                                     title,
                                     "czas [s]",
                                     "liczba pakietów [b]")
  }
  return(plot_list)
}

# funkcja tworzy ramkę danych zestawiająca kolumny o podanej nazwie z ramek danych z podanej listy
create_comparison_df <- function(df_list, df_y_labels, colum_name) {
  comp_df <- data.frame(df_list[[1]][1])
  for (i in 1:length(df_list)) {
    comp_df <- cbind(comp_df, df_list[[i]][, colum_name])
  }
  col_names <- c("x", df_y_labels)
  colnames(comp_df) <- col_names
  return(comp_df)
}