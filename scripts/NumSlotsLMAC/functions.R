# funkcja zwraca ramkę danych z wartościami skalarnymi zestawionymi z liczbami szczelin czasowych, 
#   dla których zostały uzyskane
# UOGÓLNIONA: get_all_scalars_for_par_values
get_all_scalars_for_slots_nums <- function(data_obj, num_slots_values) {
  scalars <- get_scalars(data_obj)
  scalars_mod <- data.frame(
    slots_number = translate_run_names_to_par_values(scalars$run, num_slots_values),
    module = scalars$module,
    name = scalars$name,
    value = scalars$value
  )
  return(scalars_mod)
}


# funkcja zwraca ramkę danych z wartościami skalarnymi uzyskanymi dla pojedynczej liczby szczelin
# UOGÓLNIONA: get_scalars_for_par_value
get_scalars_for_slots_num <- function(scalars, slots_num) {
  data_subset <- subset(scalars, (slots_number == slots_num))
  return(data_subset)
}


# funkcja oblicza statystyki uzyskiwane dla pojedynczej liczby szczelin
# UOGÓLNIONA: calculate_stats_single_row, calculate_stats_for_par_value
calculate_stats_for_slots_num <- function(scalars, slots_num) {
  scalars_for_slots_num <- get_scalars_for_slots_num(scalars, slots_num)
  packets_sent_values <- get_values(scalars_for_slots_num, "packetSent:count")
  packets_received_values <- get_values(scalars_for_slots_num, "packetReceived:count")
  energy_utilization_values <- get_values(scalars_for_slots_num, "residualEnergyCapacity:last")
  gate_energy_utilization_value <- get_module_data_value(scalars_for_slots_num,
                                                      "SimMAC.gateway.energyStorage",
                                                      "residualEnergyCapacity:last")
  packets_sent_total <- sum(packets_sent_values)
  packets_received_total <- sum(packets_received_values)
  energy_utilization_total <- -1*sum(energy_utilization_values)
  gate_energy_utilization <- -1*gate_energy_utilization_value[1]
  statistics <- data.frame(
    slots_number = slots_num,
    total_packets_sent = packets_sent_total,
    total_packets_received = packets_received_total,
    packet_received_ratio = packets_received_total/packets_sent_total,
    total_energy_utilization = energy_utilization_total,
    gateway_energy_utilization = gate_energy_utilization
  )
  return(statistics)
}

# funkcja zwraca ramkę danych ze statystykami uzyskanymi dla różnych liczb szczelin czasowych w pojedynczej sieci
# wyniki zapisywane są róWnież do pliku - ścieżka zapisu określna jest na podstawie podanych argumentóW
calculate_stats_for_slots_nums_single_network <- function(input_file_path, slots_nums, output_file_path) {
  num_slots_data <- load_data(input_file_path)
  scalars <- get_all_scalars_for_slots_nums(num_slots_data, slots_nums)
  results <- calculate_stats_for_slots_num(scalars, 8)
  for (slots_num in slots_nums[2:length(slots_nums)]) {
    stats <- calculate_stats_for_slots_num(scalars, slots_num)
    results <- rbind(results, stats)
  }
  save_data(results, output_file_path)
  return(results)
}

# funkcja zwraca listę z ramkami danych ze statystykami z podziałem na różne rozmiary sieci
calculate_LMAC_slots_nums_stats_networks_set <- function(network_sizes, 
                                                         slots_nums, 
                                                         input_data_dir, 
                                                         output_data_dir,
                                                         file_name_prefix) {
  results <- list()
  for(i in 1:length(network_sizes)) {
    input_file_path <- paste0(input_data_dir, file_name_prefix, network_sizes[i], ".csv")
    output_file_path <- paste0(output_data_dir, file_name_prefix, network_sizes[i], "_results.csv")
    results[[i]] <- calculate_stats_for_slots_nums_single_network(input_file_path, slots_nums, output_file_path)
  }
  return(results)
}

# funkcja zwraca ramkę danych ze statystykami uzyskanymi w sieciach o różnych rozmiarach 
#     dla pojedynczej liczby szczelin czasowych
# wyniki zapisywane są do pliku - ścieżka zapisu określna jest na podstawie podanych argumentóW
get_stats_for_slots_num <- function(stats_list, slots_num, network_sizes, output_file_path) {
  slots_num_stats <- data.frame(matrix(ncol = 6, nrow = 0))
  col_names <- c("sensors_number", "total_packets_sent", "total_packets_received", 
                 "packet_received_ratio", "total_energy_utilization",
                 "gateway_energy_utilization")
  colnames(slots_num_stats) <- col_names
  for (i in 1:length(stats_list)) {
    stats_subset <- subset(stats_list[[i]], (slots_number == as.character(slots_num)))
    df <- data.frame(
      sensors_number = network_sizes[i],
      total_packets_sent = stats_subset$total_packets_sent,
      total_packets_received = stats_subset$total_packets_received,
      packet_received_ratio = stats_subset$packet_received_ratio,
      total_energy_utilization = stats_subset$total_energy_utilization,
      gateway_energy_utilization = stats_subset$gateway_energy_utilization
    )
    slots_num_stats <- rbind(slots_num_stats, df)
  }
  save_data(slots_num_stats, output_file_path)
  return(slots_num_stats)
}

# funkcja zwraca listę z ramkami danych ze statystykami z podziałem na różne liczby szczelin czasowych
get_stats_for_all_slots_nums <- function(slots_nums, 
                                         network_sizes, 
                                         input_stats_list, 
                                         output_data_dir,
                                         file_name_prefix) {
  results <- list()
  for(i in 1:length(slots_nums)) {
    output_file_path <- paste0(output_data_dir, file_name_prefix, slots_nums[i], "_results.csv")
    results[[i]] <- get_stats_for_slots_num(input_stats_list, slots_nums[i], network_sizes, output_file_path)
  }
  return(results)
}


# funkcja tworząca obiekty wykresów dla statystyk z podziałem na rozmiary sieci
create_plots_objects_for_network_sizes <- function(stats_for_networks, network_sizes) {
  ratio_plots <- list()
  energy_plots <- list()
  gateway_energy_plots <- list()
  sensors_energy_plots <- list()
  for(i in 1:length(stats_for_networks)) {
    vec_x <- stats_for_networks[[i]]$slots_number
    vec_y1 <- stats_for_networks[[i]]$packet_received_ratio * 100
    x_label <- "liczba szczelin czasowych"
    y1_label <- "poprawnie dostarczone pakiety [%]"
    title1 <- paste0("Wykres liczby poprawnie dostarczonych pakietów dla N=", network_sizes[i])
    vec_y2 <- stats_for_networks[[i]]$total_energy_utilization
    y2_label <- "sumaryczne zużycie energii [J]"
    title2 <- paste0("Wykres sumarycznego zużycia energii dla N=", network_sizes[i])
    vec_y3 <- stats_for_networks[[i]]$gateway_energy_utilization
    y3_label <- "zużycie energii przez bramę główną [J]"
    title3 <- paste0("Wykres zużycia energii przez bramę główną dla N=", network_sizes[i])
    vec_y4 <- stats_for_networks[[i]]$total_energy_utilization - stats_for_networks[[i]]$gateway_energy_utilization
    y4_label <- "sumaryczne zużycie energii przez sensory [J]"
    title4 <- paste0("Wykres sumarycznego zużycia energii przez sensory dla N=", network_sizes[i])
    ratio_plots[[i]] <- create_line_plot(vec_x, vec_y1, title1, x_label, y1_label)
    energy_plots[[i]] <- create_line_plot(vec_x, vec_y2, title2, x_label, y2_label)
    gateway_energy_plots[[i]] <- create_line_plot(vec_x, vec_y3, title3, x_label, y3_label)
    sensors_energy_plots[[i]] <- create_line_plot(vec_x, vec_y4, title4, x_label, y4_label)
  }
  result_plots <- list(ratio_plots, energy_plots, gateway_energy_plots, sensors_energy_plots)
}

# funkcja tworząca obiekty wykresów dla statystyk z podziałem na liczby szczelin czasowych
create_plots_objects_for_slots_nums <- function(stats_for_slots_nums, slots_nums) {
  ratio_plots <- list()
  energy_plots <- list()
  gateway_energy_plots <- list()
  sensors_energy_plots <- list()
  for(i in 1:length(stats_for_slots_nums)) {
    vec_x <- stats_for_slots_nums[[i]]$sensors_number
    vec_y1 <- stats_for_slots_nums[[i]]$packet_received_ratio * 100
    x_label <- "liczba sensorów w sieci"
    y1_label <- "poprawnie dostarczone pakiety [%]"
    title1 <- paste0("Wykres liczby poprawnie dostarczonych pakietów dla NS=", slots_nums[i])
    vec_y2 <- stats_for_slots_nums[[i]]$total_energy_utilization
    y2_label <- "sumaryczne zużycie energii [J] "
    title2 <- paste0("Wykres sumarycznego zużycia energii dla NS=", slots_nums[i])
    vec_y3 <- stats_for_slots_nums[[i]]$gateway_energy_utilization
    y3_label <- "zużycie energii przez bramę główną [J]"
    title3 <- paste0("Wykres zużycia energii przez bramę główną dla NS=", slots_nums[i])
    vec_y4 <- stats_for_slots_nums[[i]]$total_energy_utilization - stats_for_slots_nums[[i]]$gateway_energy_utilization
    y4_label <- "sumaryczne zużycie energii przez sensory [J]"
    title4 <- paste0("Wykres sumarycznego zużycia energii przez sensory NS=", slots_nums[i])
    ratio_plots[[i]] <- create_line_plot(vec_x, vec_y1, title1, x_label, y1_label)
    energy_plots[[i]] <- create_line_plot(vec_x, vec_y2, title2, x_label, y2_label)
    gateway_energy_plots[[i]] <- create_line_plot(vec_x, vec_y3, title3, x_label, y3_label)
    sensors_energy_plots[[i]] <- create_line_plot(vec_x, vec_y4, title4, x_label, y4_label)
  }
  result_plots <- list(ratio_plots, energy_plots, gateway_energy_plots, sensors_energy_plots)
}

# funkcja oblicza średnie wartości statystyk (poprawnie dostarczone pakiety i zużycie energii)
#   dla różnych liczb szczelin czasowych
calculate_mean_stats_for_slots_nums <- function(stats_for_slots_nums, slots_nums) {
  slots_num_mean_stats <- data.frame(matrix(ncol = 3, nrow = 0))
  col_names <- c("slots_number", "mean_packets_received_ratio", "mean_total_energy_utilization")
  colnames(slots_num_mean_stats) <- col_names
  for (i in 1:length(stats_for_slots_nums)) {
    df = data.frame(
      slots_number = slots_nums[i],
      mean_packets_received_ratio = mean(stats_for_slots_nums[[i]]$packet_received_ratio),
      mean_total_energy_utilization = mean(stats_for_slots_nums[[i]]$total_energy_utilization)
    )
    slots_num_mean_stats <- rbind(slots_num_mean_stats, df)
  }
  return(slots_num_mean_stats)
}

# funkcja tworząca obiekty wykresów dla średnich wartości statystyk dla różnych liczb szczelin czasowych
create_plots_objects_of_mean_stats_for_slots_nums <- function(mean_stats_df) {
  plots <- list()
  vec_x <- mean_stats_df$slots_number
  x_label <- "liczba szczelin czasowych"
  vec_y1 <- mean_stats_df$mean_packets_received_ratio * 100
  y1_label <- "średni procent poprawnie dostarczonych pakietów [%]"
  vec_y2 <- mean_stats_df$mean_total_energy_utilization
  y2_label <- "średnie sumaryczne zużycie energii [J]"
  plots[[1]] <- create_line_plot(x_vector = vec_x, y_vector = vec_y1,
                                 x_label = x_label, y_label = y1_label)
  plots[[2]] <- create_line_plot(x_vector = vec_x, y_vector = vec_y2,
                                 x_label = x_label, y_label = y2_label)
  return(plots)
}

