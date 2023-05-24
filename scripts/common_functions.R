# -----------------------------------------------------------------------------------------------
# funkcje operujące na plikach


# funkcja zwraca ramkę z danymi wczytanymi z pliku o podanej ścieżce
load_data <- function(input_file_path) {
  data_obj <- read.csv(input_file_path, sep=";")
  return(data_obj)
}

# funkcja wczytuje z plików dane dotyczące zapisanych w nich wektorów
load_vector_data <- function(vector_names,
                             input_data_dir, 
                             file_name_prefix, 
                             file_nums, 
                             file_name_suffix=".csv") {
  data_list <- list()
  for (i in 1:length(file_nums)) {
    file_path <- paste0(input_data_dir, file_name_prefix, file_nums[i], file_name_suffix)
    raw_data <- load_data(file_path)
    vector_data <- split_vector_data(raw_data, vector_names)
    data_list[[i]] <- vector_data
  }
  return(data_list)
}

# funkcja zapisuje dane z podanej ramki do pliku o podanej ścieżce
save_data <- function(data_obj, output_file_path) {
  write.csv2(data_obj, output_file_path, row.names=FALSE)
}

# funkcja zapisuje dane z podanej listy ramek do plików o podanych ścieżkach
save_data_list <- function(data_obj_list, output_file_path_vector) {
  for (i in 1:length(data_obj_list)) {
    save_data(data_obj_list[[i]], output_file_path_vector[i])
  }
}

# funkcja zapisuje do plików ramki danych z podanej listy
save_df_list <- function(dfs_list,
                         output_data_dir, 
                         file_name_prefix, 
                         file_nums, 
                         file_name_suffix=".csv") {
  for (i in 1:length(dfs_list)) {
    file_path <- paste0(output_data_dir, file_name_prefix, file_nums[i], file_name_suffix)
    save_data(dfs_list[[i]], file_path)
  }
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

# funkcja generuje wykres liniowy dla pojedynczej pary wektorów x i y
# funkcja przeznaczona dla długich wektorów - ograniczenie liczby etykiet na osi x
create_line_plot2 <- function(x_vector, y_vector, title="", x_label = "", y_label = "") {
  x_range <- max(x_vector) - min(x_vector)
  break_length <- round(x_range/10)
  breaks_vec <- seq(min(x_vector), max(x_vector), break_length)
  ggplot(data = data.frame(x = x_vector, y = y_vector), aes(x, y)) + 
    geom_line() + geom_point() +
    scale_x_continuous(breaks = breaks_vec) +
    labs(title = title, x = x_label, y = y_label)
}

# funkcja generuje wykres dla pojedynczej pary wektorów x i y
# funkcja przeznaczona dla długich wektorów - ograniczenie liczby etykiet na osi x
# dane wizualizowane są w postaci słupków
create_ts_plot_bar <- function(x_vector, y_vector, title="", x_label = "", y_label = "") {
  x_range <- max(x_vector) - min(x_vector)
  break_length <- round(x_range/10)
  breaks_vec <- seq(min(x_vector), max(x_vector), break_length)
  ggplot(data = data.frame(x = x_vector, y = y_vector), aes(x, y)) + 
    geom_bar(stat="identity", fill="#3da9fc") +
    scale_x_continuous(breaks = breaks_vec) +
    labs(title = title, x = x_label, y = y_label)
}

# funkcja generuje wykres dla pojedynczej pary wektorów x i y
# funkcja przeznaczona dla długich wektorów - ograniczenie liczby etykiet na osi x
# dane wizualizowane są w postaci segmentów (słupków)
create_ts_plot_segment <- function(x_vector, y_vector, title="", x_label = "", y_label = "") {
  x_range <- max(x_vector) - min(x_vector)
  break_length <- round(x_range/10)
  breaks_vec <- seq(min(x_vector), max(x_vector), break_length)
  ggplot(data = data.frame(x = x_vector, y = y_vector), aes(x)) + 
    geom_segment(aes(x=x_vector,
                     xend=x_vector,
                     y=0,
                     yend=y_vector),
                 colour="#3da9fc") +
    scale_x_continuous(breaks = breaks_vec) +
    labs(title = title, x = x_label, y = y_label)
}

# funkcja generuje wykres dla pojedynczej pary wektorów x i y
# funkcja przeznaczona dla długich wektorów - ograniczenie liczby etykiet na osi x
# funkcja generuje odpowiedni typ wykresy na podstawie wartości argumentu type
create_ts_plot <- function(x_vector, y_vector, type="line", 
                              title="", x_label = "", y_label = "") {
  x_range <- max(x_vector) - min(x_vector)
  break_length <- round(x_range/10)
  breaks_vec <- seq(min(x_vector), max(x_vector), break_length)
  breaks_vec[length(breaks_vec)+1] <- max(x_vector)
  plot_obj <- ggplot(data = data.frame(x = x_vector, y = y_vector), aes(x, y)) +
                  scale_x_continuous(breaks = breaks_vec) +
                  labs(title = title, x = x_label, y = y_label)
  if (type == "bar") {
    plot_obj <- plot_obj + geom_bar(stat="identity", fill="#3da9fc")
  }
  else if (type == "segment") {
    plot_obj <- plot_obj + geom_segment(aes(x=x_vector,
                                            xend=x_vector,
                                            y=0,
                                            yend=y_vector),
                                        colour="#3da9fc")
  }
  else {
    plot_obj <- plot_obj + geom_line() + geom_point()
  }
  return(plot_obj)
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
  df_long <- melt(df_with_x_and_ys, id = "x")
  ggplot(df_long, aes(x = x, y = value, color = variable)) + 
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = df_with_x_and_ys[[1]]) +
    labs(title = title, x = x_label, y = y_label, color = legend_label)
}

# funkcja zwraca obiekt wykresu tworzonego dla danych zawartych w przekazywanej jako argument
#   ramce danych
# funkcja przeznaczona do wizualizacji danych dla długich szeregów czasowych
create_multiple_ts_plot_from_df <- function(df_with_x_and_ys,
                                            type = "line",
                                            title = "", x_label = "", 
                                            y_label = "", legend_label = "") {
  reversed_data <- df_with_x_and_ys[, ncol(df_with_x_and_ys):2]
  new_df <- cbind(df_with_x_and_ys[1], reversed_data)
  col_names <- colnames(new_df)
  df_long <- melt(new_df, id = "x")
  min_x <- min(new_df[1])
  max_x <- max(new_df[1])
  x_range <- max_x - min_x
  break_length <- round(x_range/10)
  breaks_vec <- seq(min_x, max_x, break_length)
  breaks_vec[length(breaks_vec)+1] <- max_x
  plot_obj <- ggplot(df_long, aes(x = x, y = value, color = variable)) + 
                  scale_x_continuous(breaks = breaks_vec) +
                  labs(title = title, x = x_label, y = y_label, color = legend_label)
  if (type == "segment") {
    plot_obj <- plot_obj + geom_segment(aes(x=x,
                                            xend=x,
                                            y=0,
                                            yend=value))
  }
  else {
    plot_obj <- plot_obj + geom_line() + geom_point()
  }
  plot_obj <- plot_obj + guides(color = guide_legend(reverse = TRUE))
  return(plot_obj)
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

# funkcja zwraca numer pojedynczego testu na podstawie jego nazwy zapisanej w pliku wynikowym Omnet++
get_run_number <- function(run_name) {
  num_substr <- str_extract(run_name, "-(\\d+)-")
  num_substr_cleaned <- str_extract(num_substr, "\\d+")
  return(as.numeric(num_substr_cleaned))
}

# funkcja zwraca numery testów określane na podstawie ich nazw (funcka operuje na wektorach)
get_run_numbers <- function(run_names_vector) {
  run_numbers <- c()
  for (i in 1:length(run_names_vector)) {
    run_numbers[i] <- get_run_number(run_names_vector[i])
  }
  return(unique(run_numbers))
}

# funkcja zwraca przesunięcie numeru testu
# testy w pliku wynikowym Omnet++ są numerowane w sposób ciągły 
#   (numeracja nie jest zerowana przy przeprowadzania testów dla różnych rozmiarów sieci)
# wartość przesunięcia jest potrzebna do poprawnego przypisania wartości badanego parametru
#   do danego testu dla badanego aktualnie rozmiaru sieci
get_run_number_offset <- function(run_names_vector) {
  run_numbers <- get_run_numbers(run_names_vector)
  return(min(run_numbers))
}

# funkcja zwraca wartość parametru badaną w danym teście
translate_run_name_to_par_value <- function(run_name, parameter_values, run_number_offset=0) {
  run_number <- get_run_number(run_name) - run_number_offset
  return(parameter_values[run_number+1])
}

# funkcja zwraca wartości badanego parametru przypisane do podanych w wektorze numerów testów 
translate_run_names_to_par_values <- function(run_names_vector, parameter_values) {
  run_num_offset <- get_run_number_offset(run_names_vector)
  par_values_vec <- c()
  for (i in 1:length(run_names_vector)) {
    par_values_vec[i] <- translate_run_name_to_par_value(run_names_vector[i], parameter_values, run_num_offset)
  }
  return(par_values_vec)
}

# funkcja zwraca ramkę danych z wartościami skalarnymi zestawionymi z wartościami badanego parametru, 
#   dla których zostały uzyskane
get_all_scalars_for_par_values <- function(data_obj, par_values, par_name = "parameter_value") {
  scalars <- get_scalars(data_obj)
  scalars_mod <- data.frame(
    par_name = as.numeric(translate_run_names_to_par_values(scalars$run, par_values)),
    module = scalars$module,
    name = scalars$name,
    value = scalars$value
  )
  col_names <- c(par_name, "module", "name", "value")
  colnames(scalars_mod) <- col_names
  return(scalars_mod)
}

# funkcja zwraca ramkę danych z wartościami skalarnymi uzyskanymi dla pojedynczej wartości
#   badanego parametru
get_scalars_for_par_value <- function(scalars, par_value) {
  col_names_original <- colnames(scalars)
  col_names_copy <- col_names_original
  col_names_copy[[1]] <- "par_name"
  colnames(scalars) <- col_names_copy
  data_subset <- subset(scalars, (par_name == as.character(par_value)))
  colnames(data_subset) <- col_names_original
  return(data_subset)
}


# funkcja rozdziela podaną jako argument ramkę danych na wiele ramek względem numerów kolumn
# wynikowa lista zawiera ramki danych zawierające po dwie kolumny
# funkcja służy do utworzenia ramek danych z wektorami (szeregami czasowymi) na podstawie 
#       podanej ramki danych z wynikami symulacji w Omnet++
split_vector_data <- function(vector_data, data_names_vec) {
  vectors_list <- list()
  for(i in 1:length(data_names_vec)) {
    start_ind <- 2*i - 1
    end_ind <- start_ind + 1
    vectors_list[[i]] <- na.omit(vector_data[,start_ind:end_ind])
    colnames(vectors_list[[i]]) <- c("t", data_names_vec[i])
  }
  return(vectors_list)
}

# funkcja zwraca ramkę danych z wartościami szeregu czasowego z podanego przedziału czasu
get_ts_window <- function (ts_df, start_time, end_time) {
  ts_window <- subset(ts_df, (t >= start_time & t < end_time))
}

# funkcja zwraca wektor z wartościami szeregu czasowego z podanego przedziału czasu
get_ts_window_vector <- function (ts_df, start_time, end_time) {
  get_ts_window(ts_df, start_time, end_time)[[2]]
}

# funkcja zwraca ramkę danych zawierającą dwie kolumny: wektor czasu i danych
# zwracana ramka danych jest tworzona z odpowiednich kolumn podawanej jako argument ramki danych
create_ts_df <- function(data_df, time_index, data_index) {
  result_df <- data.frame(data_df[[time_index]], data_df[[data_index]])
  data_df_col_names <- colnames(data_df)
  result_col_names <- c("t", data_df_col_names[data_index])
  colnames(result_df) <- result_col_names
  return(result_df)
}


#funkcja tworzy szeregi czasowe liczb oraz sumarycznych rozmiarów pakietów zarejestrowanych 
#   w kolejnych oknach czasowych o podanej szerokości (s)
create_packet_received_ts_df <- function(packet_received_vector, time_vector, window_size = 1) {
  ts_df <- data.frame(time_vector, packet_received_vector)
  colnames(ts_df) <- c("t", "packet_received")
  windows_size <- as.numeric(window_size)
  windows_count <- ceil(max(time_vector)/window_size)
  packet_received_ts_df <- data.frame(matrix(ncol = 4, nrow = 0))
  for (window_num in 1:windows_count) {
    start_t <- (window_num - 1) * window_size
    end_t <- start_t + window_size
    ts_window <- get_ts_window(ts_df, start_t, end_t)
    packets_number <- length(ts_window$packet_received)
    packets_total_size <- sum(ts_window$packet_received)
    df_row <- data.frame(window_num, end_t, packets_number, packets_total_size)
    packet_received_ts_df <- rbind(packet_received_ts_df, df_row)
  }
  colnames(packet_received_ts_df) <- 
    c("window_number", "window_end_time", "packets_number", "total_packets_size")
  return(packet_received_ts_df)
}

#funkcja zwraca ramkę danych z wektorami czasów nadejścia kolejnych pakietów
create_packet_arrival_time_df <- function(time_vector) {
  packet_number_vec <- 1:length(time_vector)
  df <- data.frame(packet_number = packet_number_vec,
                   arrival_time = time_vector,
                   arrival_time_diff = c(NA, diff(time_vector)))
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


# funkcja zwraca ramkę danych z pojedynczym wierszem zawierającym statystyki obliczone
#     dla podanej wartości badanego parametru
calculate_stats_for_par_value <- function(all_scalars, par_value, par_name = "par_name") {
  scalars_subset <- get_scalars_for_par_value(all_scalars, par_value)
  subset_stats <- calculate_stats_single_row(scalars_subset)
  stats_with_par_value <- data.frame(par_value, subset_stats)
  col_names <- colnames(subset_stats)
  col_names <- c(par_name, col_names)
  colnames(stats_with_par_value) <- col_names
  return(stats_with_par_value)
}

# funkcja oblicza wartości statystyk dla danych zawartych w pojedynczym pliku
# zakłada ona, że plik zawiera dane dotyczące wielu wartości badanego parametru (więcej niż jednego testu)
calculate_stats_single_file <- function(input_file_path, par_values, par_name = "par_name") {
  data_obj <- load_data(input_file_path)
  scalars <- get_all_scalars_for_par_values(data_obj, par_values, par_name)
  statistics <- data.frame(matrix(nrow = 0, ncol = 6))
  col_names <- c(par_name, "total_packets_sent", "total_packets_received",
                 "packet_received_ratio", "total_energy_utilization",
                 "gateway_energy_utilization")
  colnames(statistics) <- col_names
  for (par_value in par_values) {
    df <- calculate_stats_for_par_value(scalars, par_value, par_name)
    statistics <- rbind(statistics, df)
  }
  return(statistics)
}

# funkcja oblicza wartości statystyk dla danych zawartych w wielu plikach
# zwraca listę z ramkami danych, w której pojedyncza ramka zawiera statystyki obliczone na podstawie
#     pojedynczego pliku
# zakłada ona, że każdy plik zawiera dane dotyczące wielu testów (wielu wartości parametrów)
# wyniki zapisywane są do plików o ścieżkach określanych na podstawie podanych parametrów
calculate_stats_multiple_files <- function(input_data_dir, 
                                           output_data_dir, 
                                           file_name_prefix,
                                           file_name_numbers_vec,
                                           par_values,
                                           par_name = "par_name",
                                           output_file_suffix=".csv",
                                           input_file_suffix=".csv") {
  stats_list <- list()
  for (i in 1:length(file_name_numbers_vec)) {
    input_data_path <- paste0(input_data_dir, 
                              file_name_prefix, 
                              file_name_numbers_vec[i], 
                              input_file_suffix)
    file_stats <- calculate_stats_single_file(input_data_path,
                                              par_values,
                                              par_name)
    output_file_path <- paste0(output_data_dir, 
                               file_name_prefix, 
                               file_name_numbers_vec[i],
                               "_results",
                               output_file_suffix)
    save_data(file_stats, output_file_path)
    stats_list[[i]] <- file_stats
  }
  return(stats_list)
}


# funkcja zwraca ramkę danych ze statystykami uzyskanymi dla podanej wartości parametru
# jako argument przyjmuje listę ze statystykami obliczonymi dla kolejnych rozmiarów sieci
get_stats_for_par_value <- function(stats_list, network_sizes, par_value) {
  stats_for_par_value <- data.frame(matrix(nrow = 0, ncol = 6))
  col_names <- c()
  for(i in 1:length(stats_list)) {
    df <- stats_list[[i]][stats_list[[i]][1] == as.character(par_value),]
    df <- data.frame(network_size = network_sizes[i],
                     df[, 2:6])
    if(i == length(stats_list)) {
      col_names <- colnames(df)
    }
    stats_for_par_value <- rbind(stats_for_par_value, df)
  }
  colnames(stats_for_par_value) <- col_names
  return(stats_for_par_value)
}


#funkcja zwraca listę ze statystykami uzyskanymi dla kolejnych wartości badanego parametru
get_stats_for_par_values <- function(stats_list, network_sizes, par_values, 
                                     output_files_dir, files_name_prefix, files_names_suffix = ".csv") {
  stats_for_pars_list <- list()
  for(i in 1:length(par_values)) {
    par_value_stats <- get_stats_for_par_value(stats_list, network_sizes, par_values[i])
    stats_for_pars_list[[i]] <- par_value_stats
    output_file_path <- paste0(output_files_dir, 
                               files_name_prefix, par_values[i], "_results", file_name_suffix)
    save_data(par_value_stats, output_file_path)
  }
  return(stats_for_pars_list)
}

# funkcja zwraca ramkę danych ze średnimi statystykami (średni procent poprawnie dostarczonych
#     pakietów oraz średnie zużycie energii) dla różnych wartości parametru
#  średnie liczone na podstawie wyników uzyskanych dla różnych rozmiarów - średni wynik dla 
#     wszystkich sieci
calculate_mean_stats_for_par_values <- function(stats_for_pars_list, par_values, par_name) {
  mean_stats <- data.frame(matrix(nrow = 0, ncol = 3))
  col_names <- c(par_name, "mean_packets_received_ratio", "mean_energy_utilization")
  for(i in 1:length(par_values)) {
    mean_stats_df <- data.frame(par_values[i], 
                                mean(stats_for_pars_list[[i]]$packet_received_ratio),
                                mean(stats_for_pars_list[[i]]$total_energy_utilization))
    mean_stats <- rbind(mean_stats, mean_stats_df)
  }
  colnames(mean_stats) <- col_names
  return(mean_stats)
}
