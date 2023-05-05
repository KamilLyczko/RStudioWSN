get_run_number <- function(run_name) {
  num_substr <- str_extract(run_name, "-(\\d+)-")
  num_substr_cleaned <- str_extract(num_substr, "\\d+")
  return(as.numeric(num_substr_cleaned))
}

translate_run_name_to_num_slots <- function(run_name, num_slots_values) {
  run_number <- get_run_number(run_name)
  return(num_slots_values[run_number+1])
}

translate_run_names_to_slot_nums <- function(run_names_vector, num_slots_values) {
  for (i in 1:length(run_names_vector)) {
    run_names_vector[i] <- translate_run_name_to_num_slots(run_names_vector[i], num_slots_values)
  }
  return(run_names_vector)
}

get_scalars <- function(data_obj) {
  scalar_data <- subset(data_obj, (type == "scalar"))
  return(scalar_data)
}

get_all_scalars_for_slots_nums <- function(data_obj, num_slots_values) {
  scalars <- get_scalars(data_obj)
  scalars_mod <- data.frame(
    slots_number = translate_run_names_to_slot_nums(scalars$run, num_slots_values),
    name = scalars$name,
    value = scalars$value
  )
}

get_scalars_for_slots_num <- function(scalars, slots_num) {
  data_subset <- subset(scalars, (slots_number == slots_num))
  return(data_subset)
}

get_values <- function(scalar_data, data_name) {
  value_data <- subset(scalar_data, (name == data_name))
  values_vector <- c(value_data$value)
  return(values_vector)
}

calculate_stats_for_slots_num <- function(scalars, slots_num) {
  scalars_for_slots_num <- get_scalars_for_slots_num(scalars, slots_num)
  packets_sent_values <- get_values(scalars_for_slots_num, "packetSent:count")
  packets_received_values <- get_values(scalars_for_slots_num, "packetReceived:count")
  energy_consumption_values <- get_values(scalars_for_slots_num, "residualEnergyCapacity:last")
  packets_sent_total <- sum(packets_sent_values)
  packets_received_total <- sum(packets_received_values)
  energy_consumption_total <- -1*sum(energy_consumption_values)
  statistics <- data.frame(
    slots_number = slots_num,
    total_packets_sent = packets_sent_total,
    total_packets_received = packets_received_total,
    total_energy_consumtion = energy_consumption_total,
    packet_received_ratio = packets_received_total/packets_sent_total
  )
  return(statistics)
}

calculate_stats_for_slots_nums <- function(input_file_path, slots_nums, output_file_path) {
  num_slots_data <- read.csv(input_file_path, sep=";")
  scalars <- get_all_scalars_for_slots_nums(num_slots_data, slots_nums)
  results <- calculate_stats_for_slots_num(scalars, 8)
  for (slots_num in slots_nums[2:length(slots_nums)]) {
    stats <- calculate_stats_for_slots_num(scalars, slots_num)
    results <- rbind(results, stats)
  }
  write.csv2(results, output_file_path, row.names=FALSE)
  return(results)
}



