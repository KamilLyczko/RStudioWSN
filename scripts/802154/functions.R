# funkcja zwraca listę z ramkami danych dotyczącymi szeregów czasowych otrzymanych pakietów
#   wyznaczonych dla podanego okna czasowego
get_packet_received_ts_dfs <- function(vector_data_list, packet_rec_index, window_size) {
  packet_received_ts_list <- list()
  for (i in 1:length(vector_data_list)) {
    packet_received_vec <- vector_data_list[[i]][[packet_rec_index]]$server_packet_received
    time_vec <- vector_data_list[[i]][[packet_rec_index]]$t
    packet_received_ts_df <- create_packet_received_ts_df(packet_received_vec,
                                                          time_vec,
                                                          window_size)
    packet_received_ts_list[[i]] <- packet_received_ts_df
  }
  return(packet_received_ts_list)
}

# funkcja zwraca listę z ramkami danych wektorów o podanym numerze (w liście z wektorami)
get_vector_ts_dfs <- function(vector_data_list, vector_number, network_sizes) {
  ts_list <- list()
  for (i in 1:length(vector_data_list)) {
    data_vec <- vector_data_list[[i]][[vector_number]][2]
    time_vec <- vector_data_list[[i]][[vector_number]][1]
    ts_df <- cbind(time_vec, data_vec)
    ts_list[[i]] <- ts_df
  }
  return(ts_list)
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
                                     "liczba pakietów [B]")
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

# zwraca wartości współczynnka Hurst'a obliczone dla podanego szeregu wartości przez funkcję hurstexp
# wynik zwracany jest w postaci ramki danych
calculate_hurst_exponent <- function(ts, d = 64) {
  hurst_exp_list <- hurstexp(ts, d, display = FALSE)
  return(data.frame(hurst_exp_list))
}

# funkcja tworzy ramkę danych z wartościami współczynnika Hurst'a obliczonymi dla szeregów z listy
calculate_hurst_exponents_for_list <- function(packet_received_ts_dfs, network_sizes, d = 64) {
  hurst_df <- calculate_hurst_exponent(packet_received_ts_dfs[[1]]$total_packets_size, d)
  for (i in 2:length(packet_received_ts_dfs)) {
    df <- calculate_hurst_exponent(packet_received_ts_dfs[[i]]$total_packets_size, d)
    hurst_df <- rbind(hurst_df, df)
  }
  network_sizes_df <- data.frame(N = network_sizes)
  hurst_df <- cbind(network_sizes_df, hurst_df)
  return(hurst_df)
}

# funkcja tworzy ramkę danych z wartościami współczynnika Hurst'a obliczonymi dla szeregów z listy
# ramki danych w liście zawierają jedynie dwie kolumny
calculate_hurst_exponents_for_ts_list <- function(ts_dfs, network_sizes, d = 64) {
  hurst_df <- calculate_hurst_exponent(ts_dfs[[1]][[2]], d)
  for (i in 2:length(ts_dfs)) {
    df <- calculate_hurst_exponent(ts_dfs[[i]][[2]], d)
    hurst_df <- rbind(hurst_df, df)
  }
  network_sizes_df <- data.frame(N = network_sizes)
  hurst_df <- cbind(network_sizes_df, hurst_df)
  return(hurst_df)
}

#funkcja zwraca wartości empirycznych współczynników Hurst'a obliczonych przez funkcję hurstexp()
#   dla podanej listy szeregów czasowych dla różnych szerokości najmniejszych okien 
get_empirical_hurst_exps_for_ts_list <- function(ts_dfs, 
                                                network_sizes, 
                                                d = c(8, 16, 32, 64, 128, 256)) {
  hurst_df <- data.frame(matrix(ncol = length(d), nrow = 0))
  for (i in 1:length(network_sizes)) {
    emp_eps <- c()
    for (j in 1:length(d)) {
      emp_eps[j] <- calculate_hurst_exponent(ts_dfs[[i]][[2]], d[j])$He
    }
    hurst_df <- rbind(hurst_df, emp_eps)
  }
  colnames(hurst_df) <- d
  rownames(hurst_df) <- network_sizes
  return(hurst_df)
}

# funkcja zwraca ramkę danych ze średnimi wartoścami współczynnika Hurst'a 
#     (liczone z użyciem wartości w wierszach)
get_mean_hurst_exps <- function(emp_hurst_df) {
  network_sizes <- as.numeric(rownames(emp_hurst_df))
  mean_exps_df <- data.frame(matrix(ncol=2, nrow=0))
  for (i in 1:nrow(emp_hurst_df)) {
    mean_exp <- mean(as.numeric(as.vector(emp_hurst_df[i,])))
    mean_exps_df <- rbind(mean_exps_df, c(network_sizes[i], mean_exp))
  }
  mean_exps_df <- data.frame("network_size" = as.numeric(mean_exps_df[[1]]),
                             "mean_hurst" = as.numeric(mean_exps_df[[2]]))
  return(mean_exps_df)
}

# funkcja zwraca parametry widma multifraktalnego obliczone przez funkcję MFDFA() dla podanego
#       jednowymiarowego szeregu czasowego
get_multifractal_spectrum <- function(ts_values_vec) {
  mfdfa_obj <- MFDFA(ts_values_vec,
                     scale = c(8,16,32,64,128, 256, 512),
                     q=c(-9,-7,-5,-3,-1,1,3,5,7,9))
  spec <- data.frame(alpha = mfdfa_obj$spec$hq,
                         dimension = mfdfa_obj$spec$Dq)
  return(spec)
}

# funkcja zwraca listę z parametrami widm multifraktalnych obliczonych dla szeregów z podanej 
#       listy
get_multifractal_spectrums_for_list <- function(ts_dfs) {
  specs <- list()
  for (i in 1:length(ts_dfs)) {
    specs[[i]] <- get_multifractal_spectrum(ts_dfs[[i]][[2]])
  }
  return(specs)
}

# funkcja zwraca obiekt wykresu widma multifraktalnego
create_multifractal_spectrum_plot <- function(spec_df, title = "") {
  ggplot(data = spec_df, aes(alpha, dimension)) +
    geom_point() + geom_path() +
    labs(title = title, x = "α", y = "dim(α)")
}

# funkcja tworzy obiekt wykresu z wieloma widmami multifraktalnymi
create_multiple_multifractal_spectrum_plot <- function(spec_dfs_list, 
                                                       network_sizes, 
                                                       title = "") {
  long_df <- data.frame(matrix(ncol = 3, nrow = 0))
  for(i in 1:length(spec_dfs_list)) {
    long_df <- rbind(long_df, data.frame(rep(network_sizes[i], length(spec_dfs_list[[i]][[1]])),
                                         spec_dfs_list[[i]][[1]],
                                         spec_dfs_list[[i]][[2]]))
  }
  colnames(long_df) <- c("size", "x", "y")
  max_alfa <- round(max(long_df[[2]]), 1)
  min_alfa <- round(min(long_df[[2]]), 1)
  legend_colors <- c("blue", "blueviolet", "aquamarine", "green", "cornsilk", "deepskyblue",
                     "deeppink", "darkslategrey", "darkorange", "darkkhaki", "brown", "azure3",
                     "antiquewhite", "chartreuse4", "darkolivegreen1", "darksalmon")
  leg_colors <- legend_colors[1:length(spec_dfs_list)]
  plot_obj <- ggplot() +
    geom_path(data = long_df,
              aes(x = x, y = y, group = size, colour = factor(size)), size=1.3) +
    scale_color_discrete() +
    scale_x_continuous(breaks = seq(min_alfa,max_alfa,0.1)) +
    scale_color_manual(values = leg_colors) +
    labs(title = title, x = "α", y = "dim(α)", color = "Liczba sensorów:")
  return(plot_obj)
}

get_alpha_range <- function(spec_dfs_list, network_sizes) {
  ranges_df <- data.frame(matrix(ncol = 3, nrow = 0))
  for (i in 1:length(spec_dfs_list)) {
    min_alpha <- round(min(spec_dfs_list[[i]]$alpha), 2)
    max_alpha <- round(max(spec_dfs_list[[i]]$alpha), 2)
    difference <- max_alpha - min_alpha
    ranges_df <- rbind(ranges_df, c(network_sizes[i], min_alpha, max_alpha, difference))
  }
  colnames(ranges_df) <- c("network_size", "min_alpha", "max_alpha", "difference")
  return(ranges_df)
}