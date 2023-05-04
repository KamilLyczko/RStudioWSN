num_slots_LMAC_N10_data <- read.csv("data_sheets/NumSlotsLMAC/NumSlotsLMAC_N10.csv", sep=";")
run_name <- "NumSlotsLMAC-2-20230503-19:12:14-15424"
N10_run3_stats <- calculate_stats_of_run(num_slots_LMAC_N10_data, run_name)
scalars <- get_scalars_of_run(num_slots_LMAC_N10_data, run_name) # działa
packet_sent <- get_column_values(scalars, "packetSent:count") # nie działa


