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
# wartość przesunięcia jest potrzebna do poprawnego przypisania liczby szczelin czasowych do danego testu
#   dla badanego aktualnie rozmiaru sieci
get_run_number_offset <- function(run_names_vector) {
  run_numbers <- get_run_numbers(run_names_vector)
  return(min(run_numbers))
}

# funkcja zwraca liczbę szczelin czasowych rozpatrywanych w danym teście
translate_run_name_to_num_slots <- function(run_name, num_slots_values, run_number_offset=0) {
  run_number <- get_run_number(run_name) - run_number_offset
  return(num_slots_values[run_number+1])
}

# funkcja zwraca liczby szczelin czasowych przypisanych dla wielu testów
translate_run_names_to_slot_nums <- function(run_names_vector, num_slots_values) {
  run_num_offset <- get_run_number_offset(run_names_vector)
  slot_nums_vec <- c()
  for (i in 1:length(run_names_vector)) {
    slot_nums_vec[i] <- translate_run_name_to_num_slots(run_names_vector[i], num_slots_values, run_num_offset)
  }
  return(slot_nums_vec)
}

# funkcja zwraca dane związane z wartościami skalarnymi zapisanymi w podanym obiekcie danych
# obiekt danych zawiera dane wczytane z pliku wynikowego Omnet++
get_scalars <- function(data_obj) {
  scalar_data <- subset(data_obj, (type == "scalar"))
  return(scalar_data)
}

# funkcja zwraca ramkę danych z wartościami skalarnymi zestawionymi z liczbami szczelin czasowych, 
#   dla których zostały uzyskane
get_all_scalars_for_slots_nums <- function(data_obj, num_slots_values) {
  scalars <- get_scalars(data_obj)
  scalars_mod <- data.frame(
    slots_number = translate_run_names_to_slot_nums(scalars$run, num_slots_values),
    name = scalars$name,
    value = scalars$value
  )
  return(scalars_mod)
}

# funkcja zwraca ramkę danych z wartościami skalarnymi uzyskanymi dla pojedynczej liczby szczelin
get_scalars_for_slots_num <- function(scalars, slots_num) {
  data_subset <- subset(scalars, (slots_number == slots_num))
  return(data_subset)
}

# funkcja zwraca wektor z wartościami wielkości skalarnej o podanej nazwie
get_values <- function(scalar_data, data_name) {
  value_data <- subset(scalar_data, (name == data_name))
  values_vector <- c(value_data$value)
  return(values_vector)
}

# funkcja oblicza statystyki uzyskiwane dla pojedynczej liczby szczelin
calculate_stats_for_slots_num <- function(scalars, slots_num) {
  scalars_for_slots_num <- get_scalars_for_slots_num(scalars, slots_num)
  packets_sent_values <- get_values(scalars_for_slots_num, "packetSent:count")
  packets_received_values <- get_values(scalars_for_slots_num, "packetReceived:count")
  energy_utilization_values <- get_values(scalars_for_slots_num, "residualEnergyCapacity:last")
  packets_sent_total <- sum(packets_sent_values)
  packets_received_total <- sum(packets_received_values)
  energy_utilization_total <- -1*sum(energy_utilization_values)
  statistics <- data.frame(
    slots_number = slots_num,
    total_packets_sent = packets_sent_total,
    total_packets_received = packets_received_total,
    total_energy_utilization = energy_utilization_total,
    packet_received_ratio = packets_received_total/packets_sent_total
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
  slots_num_stats <- data.frame(matrix(ncol = 5, nrow = 0))
  col_names <- c("sensors_number", "total_packets_sent", "total_packets_received", 
                 "total_energy_utilization", "packet_received_ratio")
  colnames(slots_num_stats) <- col_names
  for (i in 1:length(stats_list)) {
    stats_subset <- subset(stats_list[[i]], (slots_number == slots_num))
    df <- data.frame(
      sensors_number = network_sizes[i],
      total_packets_sent = stats_subset$total_packets_sent,
      total_packets_received = stats_subset$total_packets_received,
      total_energy_utilization = stats_subset$total_energy_utilization,
      packet_received_ratio = stats_subset$packet_received_ratio
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







