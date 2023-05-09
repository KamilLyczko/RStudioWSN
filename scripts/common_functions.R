# -----------------------------------------------------------------------------------------------
# funkcje operujące na plikach


# funkcja zwraca ramkę z danymi wczytanymi z pliku o podanej ścieżce
load_data <- function(input_file_path) {
  data_obj <- read.csv(input_file_path, sep=";")
  return(data_obj)
}

# funkcja zapisuje dane z podanej ramki do pliku o podanej ścieżce
save_data <- function(data_obj, output_file_path) {
  write.csv2(data_obj, output_file_path, row.names=FALSE)
}



# -----------------------------------------------------------------------------------------------
# funkcje generujące wykresy


# funkcja generuje wykres liniowy dla pojedynczej pary wektorów x i y
create_line_plot <- function(x_vector, y_vector, title="", x_label = "", y_label = "") {
  ggplot(data = data.frame(x = x_vector, y = y_vector), aes(x, y)) + 
    geom_line() + geom_point() +
    scale_x_continuous(breaks = x_vector) +
    labs(title = title, x = x_label, y = y_label)
}

# funkcja wyświetlająca wykresy
display_plots <- function(plots_list) {
  for (plot_object in plots_list) {
    plot(plot_object)
  }
}

# funkcja generująca wykres stosunku poprawnie dostarczonych pakietów
create_packets_received_ratio_plot <- function(x_vector, 
                                               y_vector,
                                               x_label = "liczba sensorów w sieci",
                                               title_suffix = "") {
  y_label <- "poprawnie dostarczone pakiety [%]"
  title <- paste0("Wykres liczby poprawnie dostarczonych pakietów ", title_suffix)
  create_line_plot(x_vector, y_vector*100, title, x_label, y_label)
}

# funkcja generująca wykres sumarycznego zużycia energii w sieci
create_total_energy_utilization_plot <- function(x_vector, 
                                               y_vector,
                                               x_label = "liczba sensorów w sieci",
                                               title_suffix = "") {
  y_label <- "sumaryczne zużycie energii [J]"
  title <- paste0("Wykres sumarycznego zużycia energii ", title_suffix)
  create_line_plot(x_vector, y_vector, title, x_label, y_label)
}

# funkcja tworząca obiekty wykresów procentu poprawnie dostarczonych pakietów oraz zużycia energii
create_stats_visualizations <- function(stats_df, 
                                        plot_title_suffix = "", 
                                        x_label = "liczba sensorów w sieci") {
  plots_list <- list()
  plots_list[[1]] <- create_packets_received_ratio_plot(stats_df[[1]],
                                                        stats_df$packet_received_ratio,
                                                        x_label,
                                                        plot_title_suffix)
  plots_list[[2]] <- create_total_energy_utilization_plot(stats_df[[1]],
                                                        stats_df$total_energy_utilization,
                                                        x_label,
                                                        plot_title_suffix)
  return(plots_list)
}

# funkcja zwraca obiekt wykresu tworzonego dla danych zawartych w przekazywanej jako argument
#   ramce danych
create_multiple_line_plot_from_df <- function(df_with_x_and_ys,
                                      title = "", x_label = "", 
                                      y_label = "", legend_label = "") {
  col_names <- colnames(df_with_x_and_ys)
  df_long <- melt(df_with_x_and_ys, id = "x")
  ggplot(df_long, aes(x = x, y = value, color = variable)) + 
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = df_with_x_and_ys[[1]]) +
    labs(title = title, x = x_label, y = y_label, color = legend_label)
}

# ----------------------------------------------------------------------------------------------
# funkcje operujące na danych


# funkcja zwraca dane związane z wartościami skalarnymi zapisanymi w podanym obiekcie danych
# obiekt danych zawiera dane wczytane z pliku wynikowego Omnet++
get_scalars <- function(data_obj) {
  scalar_data <- subset(data_obj, (type == "scalar"))
  return(scalar_data)
}

# funkcja zwraca wektor z wartościami wielkości skalarnej o podanej nazwie
get_values <- function(scalar_data, data_name) {
  value_data <- subset(scalar_data, (name == data_name))
  values_vector <- c(value_data$value)
  return(values_vector)
}

# funkcja zwraca wektor z wartością wielkości skalarnej o podanej nazwie dla podanego modułu
#   w pliku wynikowym Omnet++
get_module_data_value <- function(scalar_data, module_name, data_name) {
  value_data <- subset(scalar_data, (module == module_name & name == data_name))
  values_vector <- c(value_data$value)
  return(values_vector)
}


# ----------------------------------------------------------------------------------------------
# funkcje obliczające statystyki


# funkcja oblicza wartości statystyk dla pojedycznego zbioru wartości skalarnych
# zwraca ramkę danych zawierającą jeden wiersz
calculate_stats_single_row <- function(scalars) {
  packets_sent_values <- get_values(scalars, "packetSent:count")
  packets_received_values <- get_values(scalars, "packetReceived:count")
  energy_utilization_values <- get_values(scalars, "residualEnergyCapacity:last")
  gate_energy_utilization_value <- get_module_data_value(scalars,
                                                         "SimMAC.gateway.energyStorage",
                                                         "residualEnergyCapacity:last")
  packets_sent_total <- sum(packets_sent_values)
  packets_received_total <- sum(packets_received_values)
  energy_utilization_total <- -1*sum(energy_utilization_values)
  gate_energy_utilization <- -1*gate_energy_utilization_value[1]
  statistics <- data.frame(
    total_packets_sent = packets_sent_total,
    total_packets_received = packets_received_total,
    packet_received_ratio = packets_received_total/packets_sent_total,
    total_energy_utilization = energy_utilization_total,
    gateway_energy_utilization = gate_energy_utilization
  )
  return(statistics)
}

# funkcja oblicza wartości statystyk dla danych zawartych w pojedynczym pliku
# zakłada ona, że plik zawiera dane dotyczące pojedynczej wartości badanego parametru (jednego testu)
calculate_stats_single_file_simple <- function(input_file_path) {
  data_obj <- load_data(input_file_path)
  scalars <- get_scalars(data_obj)
  statistics <- calculate_stats_single_row(scalars)
  return(statistics)
}

# funkcja oblicza wartości statystyk dla danych zawartych w wielu plikach
# zwraca ramkę danych, w której pojedynczy wiersz zawiera statystyki obliczone na podstawie
#     pojedynczego pliku
# zakłada ona, że każdy plik zawiera jedynie dane dotyczące pojedynczego testu
# wyniki zapisywane są do pliku o podanej ścieżce
calculate_stats_multiple_files_simple <- function(input_data_dir, 
                                                  output_data_path, 
                                                  file_name_prefix,
                                                  file_name_numbers_vec,
                                                  file_number_header="N",
                                                  output_file_suffix=".csv",
                                                  input_file_suffix="") {
  collective_stats <- data.frame(matrix(ncol = 6, nrow = 0))
  for(file_number in file_name_numbers_vec) {
    input_file_path <- paste0(input_data_dir, 
                              file_name_prefix, 
                              file_number, 
                              input_file_suffix,
                              ".csv")
    single_stats <- calculate_stats_single_file_simple(input_file_path)
    df <- data.frame(file_number, single_stats)
    collective_stats <- rbind(collective_stats, df)
  }
  col_names <- c(file_number_header, "total_packets_sent", "total_packets_received", 
                 "packet_received_ratio", "total_energy_utilization",
                 "gateway_energy_utilization")
  colnames(collective_stats) <- col_names
  save_data(collective_stats, output_data_path)
  return(collective_stats)
}
