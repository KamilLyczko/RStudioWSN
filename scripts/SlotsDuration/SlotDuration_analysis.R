# ------------------------------------------------------------------------------------------------
# obliczenie statystyk z podziałem na rozmaiary sieci

# statystyki dla protokołu BMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.05 do 1s, krok 0.05s
input_file_dir <- "data_sheets/3_SlotsDuration/data/BMAC/SlotDurationBMAC/"
output_file_dir <- "data_sheets/3_SlotsDuration/results/BMAC/SlotDurationBMAC/network_size_breakdown/"
file_name_prefix <- "SlotDurationBMAC_N"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.05, 1, 0.05)

SlotDurationBMAC_stats <- calculate_stats_multiple_files(input_file_dir,
                                                         output_file_dir,
                                                         file_name_prefix,
                                                         network_sizes,
                                                         slot_durations,
                                                         "slot_duration")


# statystyki dla protokołu XMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.05 do 1s, krok 0.05s
input_file_dir <- "data_sheets/3_SlotsDuration/data/XMAC/SlotDurationXMAC/"
output_file_dir <- "data_sheets/3_SlotsDuration/results/XMAC/SlotDurationXMAC/network_size_breakdown/"
file_name_prefix <- "SlotDurationXMAC_N"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.05, 1, 0.05)

SlotDurationXMAC_stats <- calculate_stats_multiple_files(input_file_dir,
                                                         output_file_dir,
                                                         file_name_prefix,
                                                         network_sizes,
                                                         slot_durations,
                                                         "slot_duration")


# statystyki dla protokołu LMAC:
# sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.05 do 1s, krok 0.05s
input_file_dir <- "data_sheets/3_SlotsDuration/data/LMAC/3_differentNS/SlotDurationLMAC_differentNS/"
output_file_dir <- "data_sheets/3_SlotsDuration/results/LMAC/differentNS/SlotDurationLMAC/network_size_breakdown/"
file_name_prefix <- "SlotDurationLMAC_differentNS_N"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.05, 1, 0.05)

SlotDurationLMAC_stats <- calculate_stats_multiple_files(input_file_dir,
                                                         output_file_dir,
                                                         file_name_prefix,
                                                         network_sizes,
                                                         slot_durations,
                                                         "slot_duration")


# statystyki dla protokołu BMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.01 do 0.3s, krok 0.01s
input_file_dir <- "data_sheets/3_SlotsDuration/data/BMAC/SlotDurationBMAC_short/"
output_file_dir <- "data_sheets/3_SlotsDuration/results/BMAC/SlotDurationBMAC_short/network_size_breakdown/"
file_name_prefix <- "SlotDurationBMAC_N"
file_name_suffix <- "_short.csv"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.01, 0.3, 0.01)

SlotDurationBMAC_short_stats <- calculate_stats_multiple_files(input_file_dir,
                                                         output_file_dir,
                                                         file_name_prefix,
                                                         network_sizes,
                                                         slot_durations,
                                                         "slot_duration",
                                                         file_name_suffix,
                                                         file_name_suffix)
# statystyki dla protokołu XMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.01 do 0.3s, krok 0.01s
input_file_dir <- "data_sheets/3_SlotsDuration/data/XMAC/SlotDurationXMAC_short/"
output_file_dir <- "data_sheets/3_SlotsDuration/results/XMAC/SlotDurationXMAC_short/network_size_breakdown/"
file_name_prefix <- "SlotDurationXMAC_N"
file_name_suffix <- "_short.csv"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.01, 0.3, 0.01)

SlotDurationXMAC_short_stats <- calculate_stats_multiple_files(input_file_dir,
                                                               output_file_dir,
                                                               file_name_prefix,
                                                               network_sizes,
                                                               slot_durations,
                                                               "slot_duration",
                                                               file_name_suffix,
                                                               file_name_suffix)

# statystyki dla protokołu LMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.05 do 0.3s, krok 0.01s
input_file_dir <- "data_sheets/3_SlotsDuration/data/LMAC/3_differentNS/SlotDurationLMAC_differentNS_short/"
output_file_dir <- "data_sheets/3_SlotsDuration/results/LMAC/differentNS/SlotDurationLMAC_short/network_size_breakdown/"
file_name_prefix <- "SlotDurationLMAC_differentNS_N"
file_name_suffix <- "_short.csv"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.05, 0.3, 0.01)

SlotDurationLMAC_short_stats <- calculate_stats_multiple_files(input_file_dir,
                                                               output_file_dir,
                                                               file_name_prefix,
                                                               network_sizes,
                                                               slot_durations,
                                                               "slot_duration",
                                                               file_name_suffix,
                                                               file_name_suffix)

# ------------------------------------------------------------------------------------------------
# obliczenie statystyk z podziałem na wartości parametru (długość szczeliny czasowej)

# statystyki dla protokołu BMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.01 do 0.3s, krok 0.01s
output_file_dir <- "data_sheets/3_SlotsDuration/results/BMAC/SlotDurationBMAC_short/slot_duration_breakdown/"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.01, 0.3, 0.01)

file_name_prefix <- "SlotDurationBMAC_SD"
file_name_suffix <- "_short.csv"

SlotDurationBMAC_short_stats_for_SD <- get_stats_for_par_values(SlotDurationBMAC_short_stats,
                                                                network_sizes,
                                                                slot_durations,
                                                                output_file_dir,
                                                                file_name_prefix,
                                                                file_names_suffix)

# statystyki dla protokołu XMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.01 do 0.3s, krok 0.01s
output_file_dir <- "data_sheets/3_SlotsDuration/results/XMAC/SlotDurationXMAC_short/slot_duration_breakdown/"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.01, 0.3, 0.01)

file_name_prefix <- "SlotDurationXMAC_SD"
file_name_suffix <- "_short.csv"

SlotDurationXMAC_short_stats_for_SD <- get_stats_for_par_values(SlotDurationBMAC_short_stats,
                                                                network_sizes,
                                                                slot_durations,
                                                                output_file_dir,
                                                                file_name_prefix,
                                                                file_names_suffix)


# statystyki dla protokołu LMAC:
# liczba sensoróW w sieci: od 5 do 50, krok 5
# długość szczeliny: od 0.05 do 0.3s, krok 0.01s
output_file_dir <- "data_sheets/3_SlotsDuration/results/LMAC/differentNS/SlotDurationLMAC_short/slot_duration_breakdown/"
network_sizes <- seq(5, 50, 5)
slot_durations <- seq(0.05, 0.3, 0.01)

file_name_prefix <- "SlotDurationLMAC_SD"
file_name_suffix <- "_short.csv"

SlotDurationLMAC_short_stats_for_SD <- get_stats_for_par_values(SlotDurationBMAC_short_stats,
                                                                network_sizes,
                                                                slot_durations,
                                                                output_file_dir,
                                                                file_name_prefix,
                                                                file_names_suffix)
