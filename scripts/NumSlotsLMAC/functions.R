get_data_of_run <- function(data, run_name) {
  data_subset <- subset(data, (run == run_name))
  return(data_subset)
}

get_scalars <- function(data) {
  scalar_data <- subset(data, (type == "scalar"))
  return(scalar_data)
}

get_scalars_of_run <- function(data, run_name) {
  data_subset <- get_data_of_run(data, run_name)
  scalar_data <- get_scalars(data_subset)
  return(scalar_data)
}

get_column_values <- function(scalar_data, column_name) {
  data <- subset(scalar_data, (name == column_name))
  values_vector <- c(data$values)
  return(values_vector)
}

calculate_stats_of_run <- function(data, name_of_run) {
  scalars <- get_scalars_of_run(data, name_of_run)
  packets_sent_values <- get_column_values(scalars, "packetSent:count")
  packets_received_values <- get_column_values(scalars, "packetReceived:count")
  energy_consumption_values <- get_column_values(scalars, "residualEnergyCapacity:last")
  packets_sent_total <- sum(packets_sent_values)
  packets_received_total <- sum(packets_received_values)
  energy_consumption_total <- sum(energy_consumption_values)
  statistics <- data.frame(
    run_name = name_of_run,
    total_packets_sent = packets_sent_total,
    total_packets_received = packets_received_total,
    total_energy_consumtion = energy_consumption_total,
    packet_received_ratio = packets_received_total/packets_sent_total
  )
  return(statistics)
}
