# wartości rozpatrywancych parametrów: różne liczby sensorów i szczelin czasowych dla protokołu LMAC
network_sizes <- seq(10, 100, 10)
slots_nums <- seq(8, 64, 8)


# obliczenie statystyk z podziałem na rozmiary sieci
input_data_dir <- "data_sheets/NumSlotsLMAC/data/"
output_data_dir <- "data_sheets/NumSlotsLMAC/results/network_size_breakdown/"
file_name_prefix <- "NumSlotsLMAC_N"
stats_for_networks <- calculate_LMAC_slots_nums_stats_networks_set(
  network_sizes,
  slots_nums,
  input_data_dir,
  output_data_dir,
  file_name_prefix
)

# obliczenie statystyk z podziałem na liczby szczelin czasowych
output_data_dir <- "data_sheets/NumSlotsLMAC/results/slots_num_breakdown/"
file_name_prefix <- "NumSlotsLMAC_NS"
stats_for_slots_nums <- get_stats_for_all_slots_nums(
  slots_nums,
  network_sizes,
  stats_for_networks,
  output_data_dir,
  file_name_prefix
)

# wizualizacje statystyk
network_sizes_plots <- create_plots_objects_for_network_sizes(stats_for_networks, network_sizes)
display_plots(network_sizes_plots[[1]])
display_plots(network_sizes_plots[[2]])
display_plots(network_sizes_plots[[3]])
display_plots(network_sizes_plots[[4]])

slots_nums_plots <- create_plots_objects_for_slots_nums(stats_for_slots_nums, slots_nums)
display_plots(slots_nums_plots[[1]])
display_plots(slots_nums_plots[[2]])
display_plots(slots_nums_plots[[3]])
display_plots(slots_nums_plots[[4]])

#średnie statystyki
mean_stats_for_slots_nums <- calculate_mean_stats_for_slots_nums(stats_for_slots_nums, slots_nums)
mean_stats_plots <- create_plots_objects_of_mean_stats_for_slots_nums(mean_stats_for_slots_nums)
display_plots(mean_stats_plots)
# względnie najlepsze wyniki uzyskano dla 16 szczelin czasowych




