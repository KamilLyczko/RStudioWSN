input_file_dir <- "data_sheets/3_SlotsDuration/data/BMAC/SlotDurationBMAC/"
output_file_dir <- "data_sheets/3_SlotsDuration/results/BMAC/SlotDurationBMAC/"
file_name_prefix <- "SlotDurationBMAC_N"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.05, 1, 0.05)

SlotDurationBMAC_stats <- calculate_stats_multiple_files(input_file_dir,
                                                         output_file_dir,
                                                         file_name_prefix,
                                                         network_sizes,
                                                         slot_durations,
                                                         "slot_duration")
